
#import "LiftagoCzechSnippetMessageParser.h"

@implementation LiftagoCzechSnippetMessageParser

- (NSArray *)components {
    // 244 Kč DĚKUJEME ZA VAŠI JÍZDU NA BUSINESS+ PROFI
    return [self.snippet componentsSeparatedByString:@" "];
}

- (NSString *)parsedAmount {
    return [[self components] objectAtIndex:0];
}

- (NSString *)currency {
    return [[self components] objectAtIndex:1];
}

- (BOOL)isSuccessfullyParsed {
    return YES;
}

@end
