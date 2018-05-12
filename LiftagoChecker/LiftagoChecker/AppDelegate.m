//
//  AppDelegate.m
//  LiftagoChecker
//
//  Created by Radek Pistelak on 09/09/2017.
//  Copyright © 2017 Radek Pistelak. All rights reserved.
//

#import "AppDelegate.h"
#import "OverviewViewController.h"
#import "OverviewViewModel.h"
#import "GoogleService.h"
#import "BillStore.h"

@interface AppDelegate ()

@property (nonatomic, strong) UIViewController *rootViewController;

@property (nonatomic, strong, readonly) GoogleService *googleService;
@property (nonatomic, strong, readonly) OverviewViewModel *viewModel;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    _googleService = [[GoogleService alloc] init];
    _viewModel = [[OverviewViewModel alloc] initWithGoogleService:self.googleService store:[BillStore store]];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    _rootViewController = [[OverviewViewController alloc] initWithViewModel:self.viewModel];
    
    [self.window setRootViewController:self.rootViewController];
    [self.window makeKeyAndVisible];
   
    [self.googleService setUIDelegate:self.rootViewController];
    
    [self.viewModel onStart];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [self.googleService handleURL:url sourceApplication:sourceApplication annotation:annotation];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [self.viewModel onStart];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self.viewModel onFinish];
}

@end
