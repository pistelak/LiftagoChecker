
#import <UIKit/UIKit.h>

@interface UIViewController (Alerts)

/**
 Present an informative alert (one action with the "OK" title).
 The alert is automatically dismissed after performing an action.
 */
- (void)presentAlertWithTitle:(nonnull NSString *)title
                      message:(nonnull NSString *)message;

/**
 Present an alert with two actions. The action titles are "Cancel" and "Retry".
 The alert is automatically dismissed after performing an action.
 */
- (void)presentAlertWithError:(nonnull NSError *)error
                 cancelAction:(void (^ _Nullable)(void))cancel
                  retryAction:(void (^ _Nullable)(void))retry;

@end
