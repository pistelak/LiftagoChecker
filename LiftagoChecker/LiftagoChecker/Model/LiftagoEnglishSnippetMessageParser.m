
#import "LiftagoEnglishSnippetMessageParser.h"

@implementation LiftagoEnglishSnippetMessageParser

- (NSString *)substringWithCurrencyAndAmount {
    // CZK199.00 THANK YOU FOR YOUR BUSINESS+ RIDE
    return [[self.snippet componentsSeparatedByString:@" "] firstObject];
}

- (NSString *)parsedAmount {
    return [[self substringWithCurrencyAndAmount] substringFromIndex:3];
}

- (NSString *)currency {
    return [[self substringWithCurrencyAndAmount] substringToIndex:3];
}

- (BOOL)isSuccessfullyParsed {
    return YES;
}

@end

