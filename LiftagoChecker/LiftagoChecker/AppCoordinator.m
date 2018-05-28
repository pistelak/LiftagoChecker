
#import "AppCoordinator.h"
#import "UIViewController+Alerts.h"
#import "OverviewViewController.h"
#import "LoginViewController.h"
#import "NSError+GIDSignIn.h"

#import <Google/SignIn.h>

@interface AppCoordinator() <GIDSignInDelegate, GIDSignInUIDelegate, LoginViewControllerDelegate>

@property (nonatomic, strong) GIDSignIn *signInService;

@end

@implementation AppCoordinator

- (instancetype)initWithWindow:(UIWindow *)window
            rootViewController:(LoginViewController *)rootViewController
                 signInService:(nonnull GIDSignIn *)signInService {
    self = [super init];
    if (self) {
        _signInService = signInService;
        _loginViewController = rootViewController;
        _loginViewController.delegate = self;
        [self start];
    }
    return self;
}

#pragma mark - Flow

- (void)start {
    [self login];
}

- (void)login {
    
    [self.signInService setDelegate:self];
    [self.signInService setUiDelegate:self];
    
    const BOOL isPossibleToSignInSilenly = [self.signInService hasAuthInKeychain];
    
    if (isPossibleToSignInSilenly) {
        [self.signInService signInSilently];
    }
    
    if (isPossibleToSignInSilenly == NO) {
        [self.signInService signIn];
    }
}

#pragma mark - LoginViewControllerDelegate

- (void)loginViewControllerDidSelectLogin:(LoginViewController *)viewController {
    [self login];
}

#pragma mark - GIDSignInDelegate

- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    
    if (error) {
        [self handleSignInError:error];
    } else {
        [self presentOverviewViewController];
    }
}

#pragma mark - Flow

- (void)handleSignInError:(NSError *)error {
    
    if ([error signInCancelledByUser]) { return; }

    __weak typeof(self) welf = self;
    
    [self.loginViewController presentAlertWithError:error cancelAction:nil retryAction:^{
        [welf login];
    }];
}

- (void)presentOverviewViewController {
    
    [self.loginViewController presentViewController:[self overviewViewController]
                                      animated:NO
                                    completion:nil];
}

#pragma mark - GIDSignInUIDelegate (Google garbage) // TODO: think about it

- (void)signIn:(GIDSignIn *)signIn presentViewController:(UIViewController *)viewController { }

- (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController { }

@end
