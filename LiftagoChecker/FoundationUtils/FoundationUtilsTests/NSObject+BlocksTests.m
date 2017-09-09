//
//  NSObject+BlocksTests.m
//  FoundationUtils
//
//  Created by Radek Pistelak on 09/09/2017.
//  Copyright © 2017 Radek Pistelak. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSObject+Blocks.h"

@interface NSObject_BlocksTests : XCTestCase

@end

@implementation NSObject_BlocksTests

- (void)test_performBlock {
    [self performBlock:^{}];
}

- (void)test_performBlock_NilAsArgument {
    [self performBlock:nil];
}

@end
