//
//  GMailMessageListFetcher.h
//  LiftagoChecker
//
//  Created by Radek Pistelak on 16/09/2017.
//  Copyright © 2017 Radek Pistelak. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GTLRGmailService, GTLRGmailQuery_UsersMessagesList, GTLRGmailService;

@interface GMailMessageListFetcher : NSObject

- (instancetype)initWithService:(GTLRGmailService *)service;

///
/// SEL - (GTLRGmail_ListMessagesResponse *, NSError *)
///
- (void)fetchListOfMesssagesWithFilterQuery:(NSString *)filterQuery withDelegate:(id)delegate didFinishSelector:(SEL)selector;

@end
