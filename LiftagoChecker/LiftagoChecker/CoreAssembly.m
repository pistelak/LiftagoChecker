//
//  CoreAssembly.m
//  LiftagoChecker
//
//  Created by Radek Pistelak on 06/07/2018.
//  Copyright © 2018 Radek Pistelak. All rights reserved.
//

#import "CoreAssembly.h"
#import "AppDelegate.h"
#import "AppCoordinator.h"
#import "LoginViewController.h"
#import "NetworkController.h"
#import "OverviewViewController.h"
#import "CoreAssembly.h"
#import "GMailFilterQueryProvider.h"
#import <CoreData/CoreData.h>
#import <Google/SignIn.h>

@import GMailService;

@implementation CoreAssembly

- (AppDelegate *)appDelegate {
    return [TyphoonDefinition withClass:[AppDelegate class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(window) with:[self mainWindow]];
        [definition injectProperty:@selector(rootViewController) with:[self loginViewController]];
        [definition injectProperty:@selector(appCoordinator) with:[self appCoordinator]];
        [definition injectProperty:@selector(persistentContainer) with:[self persistentContainer]];
    }];
}

- (UIWindow *)mainWindow {
    return [TyphoonDefinition withClass:[UIWindow class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithFrame:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[NSValue valueWithCGRect:[[UIScreen mainScreen] bounds]]];
        }];
        definition.scope = TyphoonScopeSingleton;
    }];
}

- (LoginViewController *)loginViewController {
    return [TyphoonDefinition withClass:[LoginViewController class]];
}

- (AppCoordinator *)appCoordinator {
    return [TyphoonDefinition withClass:[AppCoordinator class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithWindow:rootViewController:signInService:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self mainWindow]];
            [initializer injectParameterWith:[self loginViewController]];
            [initializer injectParameterWith:[self signInService]];
        }];
        [definition injectProperty:@selector(overviewViewController) with:[self overviewViewController]];
    }];
}

- (GIDSignIn *)signInService {
    
    /// TODO: CGLContext has to be configured before creating instance of GIDSignIn and I'm not sure
    /// where this code should live...
    NSError *configureError;
    [[GGLContext sharedInstance] configureWithError:&configureError];
    NSAssert(!configureError, @"Error configuring Google services: %@", configureError);
    
    return [TyphoonDefinition withClass:[GIDSignIn class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(sharedInstance)];
        [definition injectProperty:@selector(scopes) with:@[ @"https://www.googleapis.com/auth/gmail.readonly" ]];
    }];
}

#pragma mark - CoreData

- (NSPersistentContainer *)persistentContainer {
    
    static NSString * const kModelName = @"CoreDataModel";
    
    return [TyphoonDefinition withClass:[NSPersistentContainer class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(persistentContainerWithName:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:kModelName];
        }];
    }];
}

#pragma mark - Overview

- (GMailMessageFetcher *)messageFetcher {
    return [TyphoonDefinition withClass:[GMailMessageFetcher class]];
}

- (id<GMailFilterQueryProvider>)bussinesRidesInCurrentMonthGMailFilterQueryProvider {
    return [TyphoonDefinition withClass:[BussinesRidesInCurrentMonthGMailFilterQueryProvider class]];
}

- (NetworkController *)networkController {
    
    return [TyphoonDefinition withClass:[NetworkController class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithSignInService:messageFetcher:persistentContainer:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self signInService]];
            [initializer injectParameterWith:[self messageFetcher]];
            [initializer injectParameterWith:[self persistentContainer]];
        }];
        [definition
         injectProperty:@selector(filterQueryProvider)
         with:[self bussinesRidesInCurrentMonthGMailFilterQueryProvider]];
    }];
}

- (OverviewViewController *)overviewViewController {
    return [TyphoonDefinition withClass:[OverviewViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(networkController) with:[self networkController]];
    }];
}
@end
