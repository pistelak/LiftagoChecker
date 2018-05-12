//
//  OverviewView.m
//  LiftagoChecker
//
//  Created by Radek Pistelak on 16/09/2017.
//  Copyright © 2017 Radek Pistelak. All rights reserved.
//

#import "OverviewView.h"

@implementation OverviewView

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:24];
        self.titleLabel.textColor = [UIColor colorWithRed:0.33 green:0.36 blue:0.40 alpha:1.00];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.text = @"Liftago";
        [self addSubview:self.titleLabel];
        
        self.falseBackground = [[UIView alloc] init];
        self.falseBackground.backgroundColor = [UIColor colorWithRed:0.48 green:0.77 blue:0.87 alpha:1.00];
        [self addSubview:self.falseBackground];
        
        self.spentLabel = [[UILabel alloc] init];
        self.spentLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:16];
        self.spentLabel.textColor = [UIColor whiteColor];
        self.spentLabel.textAlignment = NSTextAlignmentCenter;
        self.spentLabel.text = @"Spent";
        [self.falseBackground addSubview:self.spentLabel];
        
        self.priceLabel = [[UILabel alloc] init];
        self.priceLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:28];
        self.priceLabel.textColor = [UIColor whiteColor];
        self.priceLabel.textAlignment = NSTextAlignmentCenter;
        self.priceLabel.text = @"- Kč";
        [self.falseBackground addSubview:self.priceLabel];
        
        self.loginControl = [[UIButton alloc] init];
        [self.loginControl setTitle:@"Login" forState:UIControlStateNormal];
        [self addSubview:self.loginControl];
        
        self.indicator = [[UIActivityIndicatorView alloc] init];
        [self.indicator setHidesWhenStopped:YES];
        [self addSubview:self.indicator];
    }
    
    return self;
}

- (void)setContainedView:(UIView *)containedView {
    [_containedView removeFromSuperview];
    _containedView = containedView;
    _containedView.backgroundColor = self.backgroundColor;
    [self addSubview:_containedView];
    [self layoutIfNeeded];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    const CGFloat kPadding = 20;
    const CGFloat kMaxWidth = CGRectGetWidth(self.frame) - 2 * kPadding;
    
    [self.titleLabel sizeToFit];
    [self.priceLabel sizeToFit];
    [self.loginControl sizeToFit];
    [self.containedView sizeToFit];
    [self.spentLabel sizeToFit];
    
    self.titleLabel.frame = CGRectMake(
        kPadding,
        2 * kPadding,
        kMaxWidth,
        CGRectGetHeight(self.titleLabel.frame)
    );
    
    self.containedView.frame = CGRectMake(
        self.center.x - kMaxWidth/2,
        0.18 * CGRectGetHeight(self.frame),
        kMaxWidth,
        kMaxWidth
    );
    
    self.falseBackground.frame = CGRectMake(
        0,
        0.75 * CGRectGetHeight(self.frame),
        CGRectGetWidth(self.frame),
        0.25 * CGRectGetHeight(self.frame)
    );
    
    self.spentLabel.frame = CGRectMake(
       kPadding,
       kPadding,
       kMaxWidth,
       CGRectGetHeight(self.spentLabel.frame)
    );
    
    self.priceLabel.frame = CGRectMake(
        kPadding,
        CGRectGetMaxY(self.spentLabel.frame),
        kMaxWidth,
        CGRectGetHeight(self.priceLabel.frame)
    );
    
    self.loginControl.frame = CGRectMake(
        kPadding,
        CGRectGetHeight(self.frame) - kPadding - CGRectGetHeight(self.loginControl.frame),
        kMaxWidth,
        CGRectGetHeight(self.loginControl.frame)
    );
    
    self.indicator.center = self.loginControl.center;
}

@end
