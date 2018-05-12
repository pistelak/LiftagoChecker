//
//  Store.h
//  LiftagoChecker
//
//  Created by Radek Pistelak on 03/03/2018.
//  Copyright © 2018 Radek Pistelak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Store : NSObject

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithIdentifier:(NSString *)identfier;

- (instancetype)initWithUserDefaults:(NSUserDefaults *)userDefaults
                          identifier:(NSString *)identifier NS_DESIGNATED_INITIALIZER;

- (void)storeItem:(NSObject<NSCoding> *)anItem;

- (NSObject<NSCoding> *)retrieveItem;

@end
