//
//  NSError+GIDSignIn.m
//  LiftagoChecker
//
//  Created by Radek Pistelak on 05/07/2018.
//  Copyright © 2018 Radek Pistelak. All rights reserved.
//

#import "NSError+GIDSignIn.h"

@implementation NSError (GIDSignIn)

- (BOOL)signInCancelledByUser {
    return [self code] == -5;
}

@end
