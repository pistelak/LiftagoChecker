//
//  GMailService.m
//  LiftagoChecker
//
//  Created by Radek Pistelak on 09/09/2017.
//  Copyright © 2017 Radek Pistelak. All rights reserved.
//
#import "GMailService.h"
#import "GMailMessageListFetcher.h"
#import "GMailMessageFetcher.h"

#import <GoogleAPIClientForREST/GTLRGmail.h>

@interface GMailService()

@property (nonatomic, strong) GTLRGmailService *service;
@property (nonatomic, strong) GMailMessageListFetcher *listFetcher;
@property (nonatomic, strong) GMailMessageFetcher *messageFetcher;

@end

@implementation GMailService

- (instancetype)initWithAuthorizer:(id<GTMFetcherAuthorizationProtocol>)authorizer  {
    self = [super init];
    if (self) {
        _service = [[GTLRGmailService alloc] init];
        _service.authorizer = authorizer;
        
        _listFetcher = [[GMailMessageListFetcher alloc] initWithService:_service];
        _messageFetcher = [[GMailMessageFetcher alloc] initWithService:_service];
    }
    
    return self;
}

- (void)fetchMessages {
    [self fetchMessagesWithFilterQuery:nil];
}

- (void)fetchMessagesWithFilterQuery:(id<GMailFilterQuery>)filterQuery {
    
    [[self listFetcher] fetchListOfMesssagesWithFilterQuery:[filterQuery description]
                                               withDelegate:self
                                          didFinishSelector:@selector(didFetchListOfMessagesWithResponse:error:)];
}

#pragma mark - Callbacks 

#define GUARD(error) \
if (error) { \
    [[self delegate] gmailService:self didFailWithError:error]; \
    return; \
} \

- (void)didFetchListOfMessagesWithResponse:(GTLRGmail_ListMessagesResponse *)response error:(NSError *)error {
    
    GUARD(error);
    
    [[self messageFetcher] fetchMesssagesWithIDs:[response.messages valueForKey:@"identifier"]
                                    withDelegate:self
                               didFinishSelector:@selector(didFetchMessagesWithResponse:error:)];
}

- (void)didFetchMessagesWithResponse:(NSArray<GTLRGmail_Message *> *)messages error:(NSError *)error {
    
    GUARD(error);
    
    [[self delegate] gmailService:self didFetchMessages:messages];
}

#undef GUARD

@end
