//
//  OverviewViewModel.h
//  LiftagoChecker
//
//  Created by Radek Pistelak on 03/03/2018.
//  Copyright © 2018 Radek Pistelak. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GoogleService, OverviewViewModel, BillStore, Bill;

@protocol OverviewViewModelDelegate <NSObject>

- (void)overviewViewModel:(OverviewViewModel *)viewModel needsDisplayError:(NSError *)error;

@end

@interface OverviewViewModel : NSObject

- (instancetype)initWithGoogleService:(GoogleService *)googleService store:(BillStore *)store;

@property (nonatomic, assign, readonly) BOOL isLoading;
@property (nonatomic, assign, readonly) BOOL isLoggedIn;

@property (nonatomic, strong, readonly) Bill *bill;

@property (nonatomic, weak) id<OverviewViewModelDelegate> delegate;

- (void)logIn;
- (void)updateBill;

- (void)onStart;
- (void)onFinish;

@end
