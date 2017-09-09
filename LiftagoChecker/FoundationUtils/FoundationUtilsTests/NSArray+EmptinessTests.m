//
//  NSArray+EmptinessTests.m
//  FoundationUtils
//
//  Created by Radek Pistelak on 09/09/2017.
//  Copyright © 2017 Radek Pistelak. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSArray+Emptiness.h"

@interface NSArray_EmptinessTests : XCTestCase

@end

@implementation NSArray_EmptinessTests

- (void)test_isEmpty_ShouldReturnTrue_WhenNumberOfItemsIsZero {
    
    XCTAssertTrue([@[] isEmpty]);
}

- (void)test_isEmpty_ShouldReturnFalse_WhenNumberOfItemsIsGreaterThanZero {
    
    XCTAssertFalse([@[@"Hello, World!"] isEmpty]);
}

- (void)test_isNonEmpty_ShouldReturnTrue_WhenNumberOfItemsIsGreaterThanZero {
    
    XCTAssertTrue([@[@"Hello, World!"] isNonEmpty]);
}

- (void)test_isNonEmpty_ShouldReturnFalse_WhenNumberOfItemsIsZero {
    
    XCTAssertFalse([@[] isNonEmpty]);
}

@end
