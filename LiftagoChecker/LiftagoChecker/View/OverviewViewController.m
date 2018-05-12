//
//  OverviewViewController.m
//  LiftagoChecker
//
//  Created by Radek Pistelak on 09/09/2017.
//  Copyright © 2017 Radek Pistelak. All rights reserved.
//

#import "OverviewViewController.h"
#import "UIViewController+Alerts.h"
#import "Bill.h"
#import "OverviewView.h"

@import GaugeView;
@import FoundationUtils;

const NSTimeInterval kAnimationLength = 1.0;

@interface OverviewViewController () <OverviewViewModelDelegate>

@property (nonatomic, strong) OverviewView *view;
@property (nonatomic, strong) GaugeViewController *gaugeViewController;

@property (nonatomic, strong, readonly) OverviewViewModel *viewModel;

@end

@implementation OverviewViewController

@dynamic view;

- (instancetype)initWithViewModel:(OverviewViewModel *)viewModel {
    self = [super init];
    if (self) {
        _viewModel = viewModel;
        _viewModel.delegate = self;
    }
    return self;
}

#pragma mark - View lifecycle

- (void)loadView {
    self.view = [[OverviewView alloc] init];

    self.gaugeViewController = [[GaugeViewController alloc] initWithMaxValue:3500 scaleDivision:7 scaleSubdivision:5];
    [self addChildViewController:self.gaugeViewController];
    [self.view setContainedView:self.gaugeViewController.view];
    [self.gaugeViewController didMoveToParentViewController:self];
    
    [self.view.loginControl addTarget:self.viewModel action:@selector(logIn) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self setupKVOForViewModel];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.viewModel onFinish];
}

- (void)dealloc {
    [self removeKVOForViewModel];
}

#pragma mark - Updating view

static void * const OverviewViewModelKVOContext = (void*)&OverviewViewModelKVOContext;

- (NSArray *)observedKeyPathsOnViewModel {
    return @[@"isLoading", @"isLoggedIn", @"bill"];
}

// ReactiveCocoa?
- (void)setupKVOForViewModel {

    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew;
    
    for (id keyPath in [self observedKeyPathsOnViewModel]) {
        [self.viewModel addObserver:self forKeyPath:keyPath options:options context:OverviewViewModelKVOContext];
    }
}

- (void)removeKVOForViewModel {
    
    for (id keyPath in [self observedKeyPathsOnViewModel]) {
        [self.viewModel removeObserver:self forKeyPath:keyPath context:OverviewViewModelKVOContext];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

    if (context == OverviewViewModelKVOContext)  {

        id newValue = [change valueForKey:@"new"];
        
        if ([keyPath isEqualToString:@"isLoading"] && [newValue isKindOfClass:[NSNumber class]]) {
            [newValue boolValue] ? [self.view.indicator startAnimating] : [self.view.indicator stopAnimating];
        }
        
        if ([keyPath isEqualToString:@"isLoggedIn"] && [newValue isKindOfClass:[NSNumber class]]) {
            [self.view.loginControl setHidden:[newValue boolValue]];
        }
        
        if ([keyPath isEqualToString:@"bill"] && [newValue isKindOfClass:[Bill class]]) {
            [self performSelector:@selector(animateSettingTotalValue:) withObject:newValue debounceInterval:kAnimationLength];
        }
    
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - OverviewViewModelDelegate

- (void)overviewViewModel:(OverviewViewModel *)viewModel needsDisplayError:(NSError *)error {
    [self showAlertWithTitle:[error localizedDescription] message:[error localizedFailureReason]];
}

#pragma mark - Private

- (void)animateSettingTotalValue:(Bill *)bill {
    
    [self.gaugeViewController setValue:[bill.total.amount floatValue]
                              animated:YES
                              duration:kAnimationLength];
    
    [self.view.priceLabel performSelector:@selector(setText:)
                               withObject:bill.total.formattedValue
                               afterDelay:kAnimationLength];
}

@end
