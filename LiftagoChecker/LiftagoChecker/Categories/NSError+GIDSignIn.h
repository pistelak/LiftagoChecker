//
//  NSError+GIDSignIn.h
//  LiftagoChecker
//
//  Created by Radek Pistelak on 05/07/2018.
//  Copyright © 2018 Radek Pistelak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (GIDSignIn)

- (BOOL)signInCancelledByUser;

@end
