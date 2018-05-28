
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AppDependencyContainer, GIDSignIn, LoginViewController, OverviewViewController;

@interface AppCoordinator : NSObject

- (instancetype)initWithWindow:(UIWindow *)window
            rootViewController:(LoginViewController *)rootViewController
                 signInService:(GIDSignIn *)signInService;

@property (nonatomic, strong) LoginViewController *loginViewController;
@property (nonatomic, strong) OverviewViewController *overviewViewController;

@end

NS_ASSUME_NONNULL_END
