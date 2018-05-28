
#import "AppDelegate.h"

@import CoreData;

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self.persistentContainer loadPersistentStoresWithCompletionHandler:
     ^(NSPersistentStoreDescription *description, NSError *error) {
         NSAssert(error == nil, @"Something went terribly wrong!");
    }];
    
    [self.window setRootViewController:self.rootViewController];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
