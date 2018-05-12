//
//  GMailMessageListFetcher.m
//  LiftagoChecker
//
//  Created by Radek Pistelak on 16/09/2017.
//  Copyright © 2017 Radek Pistelak. All rights reserved.
//

#import "GMailMessageListFetcher.h"

#import <GoogleAPIClientForREST/GTLRGmail.h>

@interface GMailMessageListFetcher()

@property (nonatomic, strong) GTLRGmailService *service;

@end

@implementation GMailMessageListFetcher

- (instancetype)initWithService:(GTLRGmailService *)service {
    self = [super init];
    if (self) {
        _service = service;
    }
    
    return self;
}

- (void)fetchListOfMesssagesWithFilterQuery:(NSString *)filterQuery withDelegate:(id)delegate didFinishSelector:(SEL)selector {
    
    GTLRGmailQuery_UsersMessagesList *apiQuery = [GTLRGmailQuery_UsersMessagesList queryWithUserId:@"me"];
    apiQuery.q = filterQuery ?: @"";
    
    [self.service executeQuery:apiQuery completionHandler:^(GTLRServiceTicket *callbackTicket, GTLRGmail_Message *object, NSError * callbackError)
    {
        if (delegate && selector) {
            NSMethodSignature *sig = [delegate methodSignatureForSelector:selector];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];
            [invocation setSelector:(SEL)selector];
            [invocation setTarget:delegate];
            [invocation setArgument:&object atIndex:2];
            [invocation setArgument:&callbackError atIndex:3];
            [invocation invoke];
        }
    }];
}

@end
