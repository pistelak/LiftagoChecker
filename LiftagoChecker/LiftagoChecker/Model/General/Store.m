//
//  Store.m
//  LiftagoChecker
//
//  Created by Radek Pistelak on 03/03/2018.
//  Copyright © 2018 Radek Pistelak. All rights reserved.
//

#import "Store.h"

@interface Store()

@property (nonatomic, strong, readonly) NSUserDefaults *userDefaults;
@property (nonatomic, copy, readonly) NSString *identifier;

@end

@implementation Store

- (instancetype)initWithIdentifier:(NSString *)identifier {
    return [self initWithUserDefaults:[NSUserDefaults standardUserDefaults] identifier:identifier];
}

- (instancetype)initWithUserDefaults:(NSUserDefaults *)userDefaults identifier:(NSString *)identifier {
    self = [super init];
    if (self) {
        _userDefaults = userDefaults;
        _identifier = identifier;
    }
    return self;
}

- (void)storeItem:(NSObject<NSCoding> *)anItem {
    
    NSParameterAssert([anItem conformsToProtocol:@protocol(NSCoding)]);
    
    @try {
        [self.userDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:anItem] forKey:self.identifier];
    } @catch (NSException *ex) {
        [self.userDefaults removeObjectForKey:self.identifier];
    } 
}

- (NSObject<NSCoding> *)retrieveItem {
    
    id anObject = nil;
    
    @try {
        anObject = [NSKeyedUnarchiver unarchiveObjectWithData:[self.userDefaults objectForKey:self.identifier]];
    } @catch (NSException *ex) {
        anObject = nil;
    } @finally {
        return anObject;
    }
}

@end
