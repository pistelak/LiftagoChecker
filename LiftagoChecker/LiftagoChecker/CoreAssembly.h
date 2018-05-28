//
//  CoreAssembly.h
//  LiftagoChecker
//
//  Created by Radek Pistelak on 06/07/2018.
//  Copyright © 2018 Radek Pistelak. All rights reserved.
//

#import "TyphoonAssembly.h"

@class AppDelegate, NSPersistentContainer, NetworkController, GIDSignIn;

@interface CoreAssembly : TyphoonAssembly

- (AppDelegate *)appDelegate;
- (GIDSignIn *)signInService;

@end
