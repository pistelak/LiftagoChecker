//
//  GaugeViewController.m
//  GaugeView
//
//  Created by Radek Pistelak on 11/02/2018.
//  Copyright © 2018 ran. All rights reserved.
//

#import "GaugeViewController.h"
#import "WMGaugeView.h"
#import "WMGaugeViewStyleFlatThin.h"

@interface GaugeViewController ()

@property (nonatomic, strong) WMGaugeView *view;

@property (nonatomic, assign) float maxValue;
@property (nonatomic, assign) NSUInteger scaleDivision;
@property (nonatomic, assign) NSUInteger scaleSubdivision;

@end

@implementation GaugeViewController

@dynamic view;

- (instancetype)initWithMaxValue:(float)maxValue scaleDivision:(NSUInteger)scaleDivision scaleSubdivision:(NSUInteger)scaleSubdivision {
    self = [super init];
    if (self) {
        _maxValue = maxValue;
        _scaleDivision = scaleDivision;
        _scaleSubdivision = scaleSubdivision;
    }
    return self;
}

- (void)viewDidLoad {
    
    self.view = [[WMGaugeView alloc] init];
    self.view.style = [WMGaugeViewStyleFlatThin new];
    self.view.maxValue = _maxValue;
    self.view.scaleDivisions = _scaleDivision;
    self.view.scaleSubdivisions = _scaleSubdivision;
    self.view.scaleStartAngle = 30;
    self.view.scaleEndAngle = 330;
    self.view.showScaleShadow = NO;
    self.view.scaleFont = [UIFont fontWithName:@"AvenirNext-UltraLight" size:0.065];
    self.view.scalesubdivisionsAligment = WMGaugeViewSubdivisionsAlignmentCenter;
    self.view.scaleSubdivisionsWidth = 0.002;
    self.view.scaleSubdivisionsLength = 0.04;
    self.view.scaleDivisionsWidth = 0.007;
    self.view.scaleDivisionsLength = 0.07;
}

- (void)setValue:(float)value animated:(BOOL)animated {
    [self.view setValue:value animated:animated];
}

- (void)setValue:(float)value animated:(BOOL)animated completion:(void (^)(BOOL finished))completion {
    [self.view setValue:value animated:animated completion:completion];
}

- (void)setValue:(float)value animated:(BOOL)animated duration:(NSTimeInterval)duration {
    [self.view setValue:value animated:animated duration:duration];
}

- (void)setValue:(float)value animated:(BOOL)animated duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion {
    [self.view setValue:value animated:animated duration:duration completion:completion];
}

@end
