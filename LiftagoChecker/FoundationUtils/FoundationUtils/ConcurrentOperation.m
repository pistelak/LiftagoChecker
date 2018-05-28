//
//  ConcurrentOperation.m
//  LiftagoChecker
//
//  Created by Radek Pistelak on 29/05/2018.
//  Copyright © 2018 Radek Pistelak. All rights reserved.
//

#import "ConcurrentOperation.h"

@implementation ConcurrentOperation {
    BOOL executing;
    BOOL finished;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        executing = NO;
        finished = NO;
    }
    return self;
}

- (BOOL)isAsynchronous {
    return YES;
}

- (BOOL)isExecuting {
    return executing;
}

- (BOOL)isFinished {
    return finished;
}

- (void)start {
    
    // Always check for cancellation before launching the task.
    if ([self isCancelled]) {
        // Must move the operation to the finished state if it is canceled.
        [self willChangeValueForKey:@"isFinished"];
        finished = YES;
        [self didChangeValueForKey:@"isFinished"];
    } else {
        // If the operation is not canceled, begin executing the task.
        [self willChangeValueForKey:@"isExecuting"];
        [self main];
        executing = YES;
        [self didChangeValueForKey:@"isExecuting"];
    }
}

- (void)completeExecutingOperation {
    
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    
    executing = NO;
    finished = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

@end
