//
//  OverviewView.h
//  LiftagoChecker
//
//  Created by Radek Pistelak on 16/09/2017.
//  Copyright © 2017 Radek Pistelak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OverviewView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *spentLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIView *falseBackground;

@property (nonatomic, strong) UIView *containedView;

@property (nonatomic, strong) UIButton *loginControl;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;

@end
