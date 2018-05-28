//
//  GMailMessageFetcher.m
//  LiftagoChecker
//
//  Created by Radek Pistelak on 09/09/2017.
//  Copyright © 2017 Radek Pistelak. All rights reserved.
//

#import "GMailMessageFetcher.h"
#import "GMailFilterQuery.h"
#import <GoogleAPIClientForREST/GTLRGmail.h>

static NSString * const kUserID = @"me";

@interface GMailMessageFetcher()

@property (nonatomic, strong) GTLRGmailService *service;

@end

@implementation GMailMessageFetcher

- (instancetype)init {
    self = [super init];
    if (self) {
        _service = [[GTLRGmailService alloc] init];
    }
    return self;
}

- (void)setAuthorization:(id<GTMFetcherAuthorizationProtocol>)authorization {
    _authorization = authorization;
    _service.authorizer = authorization;
}

#define GUARD(error) \
if (error && failureHandler) { \
    failureHandler(error); \
    return; \
} \

#define PERFORM_BLOCK(block, arg) \
if (block != nil) { \
    block(arg); \
} \

- (void)fetchMessagesWithFilterQuery:(id<GMailFilterQuery>)filterQuery
                             success:(void (^)(NSArray *))successHandler
                             failure:(void (^)(NSError *))failureHandler {
    
    GTLRGmailQuery_UsersMessagesList *apiQuery = [GTLRGmailQuery_UsersMessagesList queryWithUserId:kUserID];
    apiQuery.q = [filterQuery description] ?: @"";
    
    __weak typeof(self) welf = self;
    
    [self.service executeQuery:apiQuery completionHandler:^(GTLRServiceTicket *callbackTicket, GTLRGmail_Message *object, NSError *callbackError)
     {
         GUARD(callbackError)
         
         [welf fetchMesssagesWithIDs:[object valueForKeyPath:@"messages.identifier"]
                             success:successHandler
                             failure:failureHandler];
     }];
}

- (void)fetchMesssagesWithIDs:(NSArray *)messageIDs
                      success:(void (^)(NSArray *))successHandler
                      failure:(void (^)(NSError *))failureHandler {
    
    dispatch_group_t serviceGroup = dispatch_group_create();
    
    __block NSError *error = nil;
    __block NSMutableArray *messages = [[NSMutableArray alloc] init];
    
    for (NSString *messageID in messageIDs) {
        
        [self fetchMessageWithID:messageID dispatchGroup:serviceGroup success:^(GTLRGmail_ListMessagesResponse *object) {
            [messages addObject:object];
        } failure:^(NSError *callbackError) {
            error = callbackError ?: error;
        }];
    }
    
    dispatch_group_notify(serviceGroup, dispatch_get_main_queue(),^{
        GUARD(error);
        PERFORM_BLOCK(successHandler, messages);
    });
}

- (void)fetchMessageWithID:(NSString *)messageID
             dispatchGroup:(dispatch_group_t)dispatchGroup
                   success:(void (^)(GTLRGmail_ListMessagesResponse *))successHandler
                   failure:(void (^)(NSError *))failureHandler {
    
    dispatch_group_enter(dispatchGroup);
    
    [self.service executeQuery:[GTLRGmailQuery_UsersMessagesGet queryWithUserId:kUserID identifier:messageID]
             completionHandler:^(GTLRServiceTicket *callbackTicket, GTLRGmail_ListMessagesResponse *object, NSError *callbackError)
    {
        GUARD(callbackError);
        PERFORM_BLOCK(successHandler, object);
        dispatch_group_leave(dispatchGroup);
    }];
}

#undef GUARD
#undef PERFORM_BLOCK

@end
