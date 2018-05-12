//
//  GMailMessageFetcher.m
//  LiftagoChecker
//
//  Created by Radek Pistelak on 09/09/2017.
//  Copyright © 2017 Radek Pistelak. All rights reserved.
//

#import "GMailMessageFetcher.h"

#import <GoogleAPIClientForREST/GTLRGmail.h>

@interface GMailMessageFetcher()

@property (nonatomic, strong) GTLRGmailService *service;

@end

@implementation GMailMessageFetcher

- (instancetype)initWithService:(GTLRGmailService *)service {
    self = [super init];
    if (self) {
        _service = service;
    }
    
    return self;
}

- (void)fetchMesssagesWithIDs:(NSArray *)messageIDs withDelegate:(id)delegate didFinishSelector:(SEL)selector {
    
    dispatch_group_t serviceGroup = dispatch_group_create();
    
    __block NSError *error = nil;
    __block NSMutableArray *messages = [[NSMutableArray alloc] init];
    
    for (NSString *messageID in messageIDs) {
        
        dispatch_group_enter(serviceGroup);
        
        [self.service executeQuery:[GTLRGmailQuery_UsersMessagesGet queryWithUserId:@"me" identifier:messageID]
                 completionHandler:^(GTLRServiceTicket *callbackTicket, GTLRGmail_ListMessagesResponse *object, NSError *callbackError)
        {
            error = callbackError ?: error;
            
            if (error == nil) { // TODO: ifExists
                [messages addObject:object];
            }
            
            dispatch_group_leave(serviceGroup);
        }];
    }
    
    dispatch_group_notify(serviceGroup, dispatch_get_main_queue(),^{
        
        if (delegate && selector) {
            NSMethodSignature *sig = [delegate methodSignatureForSelector:selector];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];
            [invocation setSelector:(SEL)selector];
            [invocation setTarget:delegate];
            [invocation setArgument:&messages atIndex:2];
            [invocation setArgument:&error atIndex:3];
            [invocation invoke];
        }
    });
}

@end
