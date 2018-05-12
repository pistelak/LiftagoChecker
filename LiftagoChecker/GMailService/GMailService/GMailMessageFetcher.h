//
//  GMailMessageFetcher.h
//  LiftagoChecker
//
//  Created by Radek Pistelak on 09/09/2017.
//  Copyright © 2017 Radek Pistelak. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GTLRGmailService;

@interface GMailMessageFetcher : NSObject

- (instancetype)initWithService:(GTLRGmailService *)service;

///
/// SEL - (NSArray<GTLRGmail_Message *> *, NSError *)
///
- (void)fetchMesssagesWithIDs:(NSArray *)messageIDs withDelegate:(id)delegate didFinishSelector:(SEL)selector;

@end
