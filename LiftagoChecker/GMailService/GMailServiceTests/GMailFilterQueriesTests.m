//
//  GMailFilterQueriesTests.m
//  GMailServiceTests
//
//  Created by Radek Pistelak on 11/02/2018.
//  Copyright © 2018 Radek Pistelak. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "GMailFilterQuery.h"

@interface GMailFilterQueriesTests : XCTestCase
@end

@implementation GMailFilterQueriesTests

- (void)testFrom {
    NSString *reference = @"from:xxx.xx@xxx.xx";
    NSString *actual = [[[GMailFromFilterQuery alloc] initWithSender:@"xxx.xx@xxx.xx"] description];
    
    XCTAssertEqualObjects(reference, actual);
}

- (void)testSubject {
    NSString *reference = @"subject:\"test\"";
    NSString *actual = [[[GMailSubjectFilterQuery alloc] initWithSubject:@"\"test\""] description];
    
    XCTAssertEqualObjects(reference, actual);
}

- (void)testJanuar {
    NSString *reference = @"after:2018/01/01 before:2018/01/31";
    NSString *actual = [[[GMailMonthFilterQuery alloc] initWithMonthIndex:1] description];
    
    XCTAssertEqualObjects(reference, actual);
}

- (void)testFebruar {
    NSString *reference = @"after:2018/02/01 before:2018/02/28";
    NSString *actual = [[[GMailMonthFilterQuery alloc] initWithMonthIndex:2] description];
    
    XCTAssertEqualObjects(reference, actual);
}

- (void)testCompound {
    
    NSString *reference = @"from:xxx.xx@xxx.xx subject:\"test\" after:2018/12/01 before:2018/12/31";
    
    NSArray *queries = @[
        [[GMailFromFilterQuery alloc] initWithSender:@"xxx.xx@xxx.xx"],
        [[GMailSubjectFilterQuery alloc] initWithSubject:@"\"test\""],
        [[GMailMonthFilterQuery alloc] initWithMonthIndex:12],
    ];
    
    XCTAssertEqualObjects(reference, [[[GMailCompoundFilterQuery alloc] initWithQueries:queries] description]);
}

@end
