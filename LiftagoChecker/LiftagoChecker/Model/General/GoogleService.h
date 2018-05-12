//
//  GoogleService.h
//  LiftagoChecker
//
//  Created by Radek Pistelak on 03/03/2018.
//  Copyright © 2018 Radek Pistelak. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoogleService;
@protocol GMailFilterQuery;

@protocol GoogleServiceDelegate <NSObject>

- (void)googleServiceDidLogIn:(GoogleService *)service;
- (void)googleService:(GoogleService *)service logInDidFailWithError:(NSError *)error;

- (void)googleService:(GoogleService *)service didFetchMessages:(NSArray *)messages;
- (void)googleService:(GoogleService *)service fetchingMessagesDidFailWithError:(NSError *)error;

@optional

- (void)googleServiceDidLogOut:(GoogleService *)service;
- (void)googleService:(GoogleService *)service logOutDidFailWithError:(NSError *)error;

@end

@interface GoogleService : NSObject

@property (nonatomic, assign, readonly) BOOL isLoggedIn;

@property (nonatomic, weak) id<GoogleServiceDelegate> delegate;
@property (nonatomic, weak) UIViewController *UIDelegate;

- (void)logIn;
- (BOOL)logInSilentlyIfPossible;
- (BOOL)handleURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

- (void)logOut;

- (void)fetchMessagesWithFilterQuery:(id<GMailFilterQuery>)filterQuery;

@end
