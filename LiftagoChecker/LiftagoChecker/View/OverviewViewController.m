
#import "OverviewViewController.h"
#import "BaseLayoutView.h"
#import "GaugeViewController+FactoryMethod.h"
#import "BillViewController.h"
#import "LoadingViewController.h"
#import "UIViewController+Containment.h"
#import "UIViewController+Alerts.h"
#import "NetworkController.h"
#import "Bill+CoreDataClass.h"

@import FoundationUtils.NSObject_Throttling;
@import GaugeView;
@import CoreData;

const NSTimeInterval kAnimationLength = 1.0;

@interface OverviewViewController()<NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) BaseLayoutView *view;

@property (nonatomic, strong) GaugeViewController *gaugeViewController;

@property (nonatomic, weak) UIViewController *stateViewController;
@property (nonatomic, strong) BillViewController *billViewController;
@property (nonatomic, strong) LoadingViewController *loadingViewController;

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultController;

@end

@implementation OverviewViewController

@dynamic view;

- (instancetype)init {
    self = [super init];
    if (self) {
        self.gaugeViewController = [GaugeViewController liftagoGaugeViewController];
        self.billViewController = [[BillViewController alloc] init];
        self.loadingViewController = [[LoadingViewController alloc] init];
    }
    return self;
}

#pragma mark - View lifecycle

- (void)loadView {
    self.view = [[BaseLayoutView alloc] init];

    [self addContentViewController:self.gaugeViewController viewSelectorForContentView:@selector(overview)];
    [self setStateViewController:self.loadingViewController];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(loadData)
     name:UIApplicationWillEnterForegroundNotification
     object:nil];
    
    [self loadData];
}

#pragma mark - Setters

- (void)setStateViewController:(UIViewController *)stateViewController {
    if (_stateViewController != stateViewController) {
        [self removeContentViewController:_stateViewController];
        _stateViewController = stateViewController;
        [self addContentViewController:stateViewController viewSelectorForContentView:@selector(stateView)];
    }
}

- (void)setFetchedResultController:(NSFetchedResultsController *)controller {
    _fetchedResultController = controller;
    _fetchedResultController.delegate = self;
    [_fetchedResultController performFetch:nil];
}

#pragma mark - Data loading

- (void)loadData {
    [self setStateViewController:self.loadingViewController];
    
    __weak typeof(self) welf = self;

    self.fetchedResultController = [_networkController loadBillWithCompletionHandler:^(NSError *error) {

        if (error) {
            [welf presentAlertWithTitle:[error localizedDescription] message:[error localizedFailureReason]];
        }
    }];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    Bill *bill = [controller.fetchedObjects firstObject];
    [self performSelector:@selector(animateSettingTotalValue:) withObject:bill debounceInterval:kAnimationLength];
    [self performSelector:@selector(displayBill:) withObject:bill afterDelay:kAnimationLength];
}

#pragma mark - Private

- (void)animateSettingTotalValue:(Bill *)bill {
    [self.gaugeViewController setValue:[[bill totalAmount] floatValue] animated:YES duration:kAnimationLength];
}

- (void)displayBill:(Bill *)bill {
    [self setStateViewController:self.billViewController];
    [self.billViewController displayBill:bill];
}

@end
