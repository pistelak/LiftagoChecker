
#import <UIKit/UIKit.h>

@class AppCoordinator, NSPersistentContainer;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIViewController *rootViewController;

@property (strong, nonatomic) AppCoordinator *appCoordinator;
@property (strong, nonatomic) NSPersistentContainer *persistentContainer;

@end

