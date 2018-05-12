//
//  GoogleService.m
//  LiftagoChecker
//
//  Created by Radek Pistelak on 03/03/2018.
//  Copyright © 2018 Radek Pistelak. All rights reserved.
//

#import "GoogleService.h"
#import <GMailService/GMailService.h>
#import <Google/SignIn.h>

@interface GoogleService() <GIDSignInDelegate, GMailServiceDelegate>

@property (nonatomic, strong) GIDSignIn *loginManager;
@property (nonatomic, strong) GMailService *gmailService;

@end

@implementation GoogleService

#pragma mark - Inits

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configureGoogleServices];
    }
    
    return self;
}

- (void)configureGoogleServices {
    NSError* configureError;
    [[GGLContext sharedInstance] configureWithError: &configureError];
    NSAssert(!configureError, @"Error configuring Google services: %@", configureError);
}

#pragma mark - Properties

- (GMailService *)gmailService {
    
    if ([self isLoggedIn] == NO) {
        return nil;
    }
    
    if (_gmailService != nil) {
        return _gmailService;
    }
    
    _gmailService = [[GMailService alloc] initWithAuthorizer:self.loginManager.currentUser.authentication.fetcherAuthorizer];
    _gmailService.delegate = self;
    
    return _gmailService;
}

- (GIDSignIn *)loginManager {
    
    if (!_loginManager) {
        _loginManager = [GIDSignIn sharedInstance];
        _loginManager.delegate = self;
        _loginManager.scopes = @[ @"https://www.googleapis.com/auth/gmail.readonly" ];
    }
    return _loginManager;
}

- (void)setUIDelegate:(UIViewController *)UIDelegate {
    [self.loginManager setUiDelegate:(id<GIDSignInUIDelegate>)UIDelegate];
}

#pragma mark - LogIn/SignOut

- (void)logIn {
    [self.loginManager signIn];
}

- (BOOL)logInSilentlyIfPossible {
    
    if ([self.loginManager hasAuthInKeychain] == NO) {
        return NO;
    }
    
    [self.loginManager signInSilently];
    
    return YES;
}

- (BOOL)isLoggedIn {
    return [self.loginManager currentUser] != nil;
}

- (void)logOut {
    [self.loginManager signOut];
}

- (BOOL)handleURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [self.loginManager handleURL:url sourceApplication:sourceApplication annotation:annotation];
}

- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    
    if (error || [self isLoggedIn] == NO) {
        [self.delegate googleService:self logInDidFailWithError:error];
    } else {
        [self.delegate googleServiceDidLogIn:self];
    }
}

- (void)signIn:(GIDSignIn *)signIn didDisconnectWithUser:(GIDGoogleUser *)user withError:(NSError *)error {
    
    if (error) {
        
        if ([self.delegate respondsToSelector:@selector(googleService:logOutDidFailWithError:)]) {
            [self.delegate googleService:self logOutDidFailWithError:error];
        }
        
    } else {
        
        if ([self.delegate respondsToSelector:@selector(googleServiceDidLogOut:)]) {
            [self.delegate googleServiceDidLogOut:self];
        }
    }
}

#pragma mark - GMail

- (void)fetchMessagesWithFilterQuery:(id<GMailFilterQuery>)filterQuery {
    [self.gmailService fetchMessagesWithFilterQuery:filterQuery];
}

- (void)gmailService:(GMailService *)service didFailWithError:(NSError *)error {
    [self.delegate googleService:self fetchingMessagesDidFailWithError:error];
}

- (void)gmailService:(GMailService *)service didFetchMessages:(NSArray *)messages {
    [self.delegate googleService:self didFetchMessages:messages];
}

@end
