//
//  LoadingViewController.m
//  LiftagoChecker
//
//  Created by Radek Pistelak on 05/07/2018.
//  Copyright © 2018 Radek Pistelak. All rights reserved.
//

#import "LoadingViewController.h"

@interface LoadingViewController()
@property (nonatomic, strong) UIActivityIndicatorView *view;
@end

@implementation LoadingViewController

@dynamic view;

- (void)loadView {
    self.view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];;
    [self.view startAnimating];
}

@end
