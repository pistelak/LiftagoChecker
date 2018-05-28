
#import <UIKit/UIKit.h>

@class LoginViewController;

@protocol LoginViewControllerDelegate <NSObject>

- (void)loginViewControllerDidSelectLogin:(LoginViewController *)viewController;

@end

@interface LoginViewController: UIViewController

@property (nonatomic, weak) id<LoginViewControllerDelegate> delegate;

@end
