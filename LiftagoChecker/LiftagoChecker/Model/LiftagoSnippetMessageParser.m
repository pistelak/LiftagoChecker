//
//  LiftagoSnippetMessageParser.m
//  LiftagoChecker
//
//  Created by Radek Pistelak on 09/09/2017.
//  Copyright © 2017 Radek Pistelak. All rights reserved.
//

#import "LiftagoSnippetMessageParser.h"

@interface LiftagoCzechSnippetMessageParser:   LiftagoSnippetMessageParser; @end
@interface LiftagoEnglishSnippetMessageParser: LiftagoSnippetMessageParser; @end
@interface LiftagoUnknownSnippetMessageParser: LiftagoSnippetMessageParser; @end

@implementation LiftagoSnippetMessageParser

- (NSArray<BillEntry *> *)entriesFromMassages:(NSArray<NSString *> *)snippets {
    
    NSMutableArray *entries = [[NSMutableArray alloc] init];
    
    for (NSString *snippet in snippets) {
        [entries addObject:[self entryFromMessage:snippet]];
    }
    
    return entries;
}

- (BillEntry *)entryFromMessage:(NSString *)snippet {
    return [[self parserForMessage:snippet] entryFromMessage:snippet];
}

- (LiftagoSnippetMessageParser *)parserForMessage:(NSString *)snippet {
    
    if ([snippet localizedStandardContainsString:@"THANK YOU FOR YOUR BUSINESS+ RIDE"]) {
        return [[LiftagoEnglishSnippetMessageParser alloc] init];
    } else if ([snippet localizedStandardContainsString:@"DĚKUJEME ZA VAŠI JÍZDU NA BUSINESS+ PROFIL"]) {
        return [[LiftagoCzechSnippetMessageParser alloc] init];
    } else {
        return [[LiftagoUnknownSnippetMessageParser alloc] init];
    }
}

@end

@implementation LiftagoCzechSnippetMessageParser

- (BillEntry *)entryFromMessage:(NSString *)snippet {
    
    // 244 Kč DĚKUJEME ZA VAŠI JÍZDU NA BUSINESS+ PROFI
    NSArray *components = [snippet componentsSeparatedByString:@" "];
    
    NSString *price = [components objectAtIndex:0];
    NSString *currency = [components objectAtIndex:1];
    
    return [[BillEntry alloc] initWithAmount:price currency:currency];
}

@end

@implementation LiftagoEnglishSnippetMessageParser

- (BillEntry *)entryFromMessage:(NSString *)snippet {
    
    // CZK199.00 THANK YOU FOR YOUR BUSINESS+ RIDE
    NSString *priceWithCurrency = [[snippet componentsSeparatedByString:@" "] firstObject];
    
    NSString *price = [priceWithCurrency substringWithRange:NSMakeRange(3, [priceWithCurrency length] - 3)];
    NSString *currency = [priceWithCurrency substringWithRange:NSMakeRange(0, 3)];
    
    return [[BillEntry alloc] initWithAmount:price currency:currency];
}

@end

@implementation LiftagoUnknownSnippetMessageParser

- (BillEntry *)entryFromMessage:(NSString *)snippet {
    return [[BillEntry alloc] initWithAmount:@(NSIntegerMax) currency:@"Invalid currency"];
}

@end
