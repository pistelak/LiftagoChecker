//
//  UIViewController+Containment.m
//  LiftagoChecker
//
//  Created by Radek Pistelak on 05/07/2018.
//  Copyright © 2018 Radek Pistelak. All rights reserved.
//

#import "UIViewController+Containment.h"

@implementation UIViewController (Containment)

- (void)addContentViewController:(UIViewController *)viewController viewSelectorForContentView:(SEL)targetView {
    [self addChildViewController:viewController];

    id oldTargetView = [self.view valueForKey:NSStringFromSelector(targetView)];
    [oldTargetView removeFromSuperview];
    [self.view setValue:viewController.view forKey:NSStringFromSelector(targetView)];
    [self.view addSubview:viewController.view];

    [viewController didMoveToParentViewController:self];
}

- (void)removeContentViewController:(UIViewController *)viewController {
    [viewController willMoveToParentViewController:nil];
    [viewController.view removeFromSuperview];
    [viewController removeFromParentViewController];
}

@end
