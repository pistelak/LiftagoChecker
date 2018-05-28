//
//  LoginView.m
//  LiftagoChecker
//
//  Created by Radek Pistelak on 05/07/2018.
//  Copyright © 2018 Radek Pistelak. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:0.48 green:0.77 blue:0.87 alpha:1.00];
        
        self.loginButton = [[UIButton alloc] init];
        [self.loginButton setBackgroundColor:[self backgroundColor]];
        [self.loginButton setTitle:@"Login" forState:UIControlStateNormal];
        [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.loginButton setTitleColor:[UIColor lightTextColor] forState:UIControlStateHighlighted];
        [self.loginButton setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [self.loginButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [self addSubview:self.loginButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.loginButton.frame = self.bounds;
}

@end
