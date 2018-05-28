
#import "UIViewController+Alerts.h"

@implementation UIViewController (Alerts)

- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message {
    
    id alert = [UIAlertController
                alertControllerWithTitle:title
                message:message
                preferredStyle:UIAlertControllerStyleAlert];
    
    id ok = [UIAlertAction
             actionWithTitle:@"OK"
             style:UIAlertActionStyleDefault
             handler:^(UIAlertAction * action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)presentAlertWithError:(NSError *)error cancelAction:(void (^)(void))cancel retryAction:(void (^)(void))retry {

    id alert = [UIAlertController
                alertControllerWithTitle:[error localizedDescription]
                message:[error localizedFailureReason]
                preferredStyle:UIAlertControllerStyleAlert];
    
    id cancelAction = [UIAlertAction
                       actionWithTitle:@"Cancel"
                       style:UIAlertActionStyleCancel
                       handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
        if (cancel != nil) cancel();
    }];
    
    id retryAction = [UIAlertAction
                      actionWithTitle:@"Retry"
                      style:UIAlertActionStyleDefault
                      handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
        if (retry != nil) retry();
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:retryAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
