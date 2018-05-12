//
//  NSObject+Throttling.m
//  FoundationUtilsTests
//
//  Created by Radek Pistelak on 01/04/2018.
//  Copyright © 2018 Radek Pistelak. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSObject+Throttling.h"

@interface MessageInfo: NSObject

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSDate *timeOfSettingDate;

@end

@implementation MessageInfo
@end

@interface Receiver: NSObject

@property (nonatomic, strong) NSDate *date;

@property (nonatomic, strong) NSMutableArray *allMessages;

@end

@implementation Receiver

- (instancetype)init {
    self = [super init];
    self.allMessages = [[NSMutableArray alloc] init];
    return self;
}

- (void)setDate:(NSDate *)date {
    _date = date;
    
    MessageInfo *messageInfo = [[MessageInfo alloc] init];
    messageInfo.date = date;
    messageInfo.timeOfSettingDate = [NSDate date];
    [self.allMessages addObject:messageInfo];
}

@end

@interface NSObject_Throttling : XCTestCase

@property (nonatomic, strong) Receiver *receiver;

@end

@implementation NSObject_Throttling

- (void)setUp {
    [super setUp];
    self.receiver = [[Receiver alloc] init];
}

- (void)tearDown {
    self.receiver = [[Receiver alloc] init];
    [super tearDown];
}

- (void)test_throttling {
    
    const NSTimeInterval kThrottleInterval = 1;
    const NSTimeInterval kDelayStep = 0.1;
    const NSInteger kNumberOfSteps = 8;
    
    NSDate *t0 = [NSDate date];
    
    [self.receiver performSelector:@selector(setDate:) withObject:t0 throttleInterval:kThrottleInterval];
    
    for (NSTimeInterval delay = kDelayStep; delay <= kDelayStep * kNumberOfSteps; delay += kDelayStep) {

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.receiver performSelector:@selector(setDate:) withObject:[NSDate date] throttleInterval:kThrottleInterval];
        });
    }
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"test_throttling"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * kThrottleInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // first date should be stored
        XCTAssertEqualWithAccuracy([self.receiver.date timeIntervalSinceDate:t0], 0, 0.01);
        // date should be stored immidietelly
        XCTAssertEqualWithAccuracy([[self.receiver.allMessages.lastObject timeOfSettingDate] timeIntervalSinceDate:t0], 0, 0.01);
        // only the first message should be delivered
        XCTAssertEqual([self.receiver.allMessages count], 1);
        
        [expectation fulfill];
    });
    
    [self waitForExpectationsWithTimeout:3 * kThrottleInterval handler:nil];
}

- (void)test_throttling_performLast {

    const NSTimeInterval kThrottleInterval = 1;
    const NSTimeInterval kDelayStep = 0.1;
    const NSInteger kNumberOfSteps = 8;
    
    NSDate *t0 = [NSDate date];
    
    [self.receiver performSelector:@selector(setDate:) withObject:t0 throttleInterval:kThrottleInterval];
    
    for (NSTimeInterval delay = kDelayStep; delay <= kDelayStep * kNumberOfSteps; delay += kDelayStep) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.receiver performSelector:@selector(setDate:) withObject:[NSDate date] throttleInterval:kThrottleInterval];
        });
    }
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"test_throttling"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * kThrottleInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // first date should be stored
        XCTAssertEqualWithAccuracy([self.receiver.date timeIntervalSinceDate:t0], 0, 0.01);
        // date should be stored immidietelly
        XCTAssertEqualWithAccuracy([[self.receiver.allMessages.lastObject timeOfSettingDate] timeIntervalSinceDate:t0], 0, 0.01);
        // only the first message should be delivered
        XCTAssertEqual([self.receiver.allMessages count], 1);
        
        [expectation fulfill];
    });
    
    [self waitForExpectationsWithTimeout:3 * kThrottleInterval handler:nil];
}


@end
