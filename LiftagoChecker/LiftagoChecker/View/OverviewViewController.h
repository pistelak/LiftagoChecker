//
//  OverviewViewController.h
//  LiftagoChecker
//
//  Created by Radek Pistelak on 09/09/2017.
//  Copyright © 2017 Radek Pistelak. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OverviewViewModel.h"

@interface OverviewViewController : UIViewController

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithViewModel:(OverviewViewModel *)viewModel;

@end
