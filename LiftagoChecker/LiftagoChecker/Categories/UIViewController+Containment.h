//
//  UIViewController+Containment.h
//  LiftagoChecker
//
//  Created by Radek Pistelak on 05/07/2018.
//  Copyright © 2018 Radek Pistelak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Containment)

- (void)addContentViewController:(UIViewController *)viewController viewSelectorForContentView:(SEL)targetView;

- (void)removeContentViewController:(UIViewController *)viewController;

@end
