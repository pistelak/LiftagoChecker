
#import "LiftagoSnippetMessageParser.h"
#import "LiftagoCzechSnippetMessageParser.h"
#import "LiftagoEnglishSnippetMessageParser.h"

@implementation LiftagoSnippetMessageParser

- (instancetype)initWithSnippet:(NSString *)snippet {
    self = [super init];
    if (self) {
        _snippet = snippet;
    }
    return self;
}

- (NSString *)parsedAmount {
    return @"";
}

- (NSNumber *)amount {
    return [NSNumber numberWithInteger:[[self parsedAmount] integerValue]];
}

- (NSString *)currency {
    return @"unknown";
}

- (BOOL)isSuccessfullyParsed {
    return NO;
}

@end

@implementation LiftagoSnippetMessageParserFactory

+ (LiftagoSnippetMessageParser *)parserForSnippet:(NSString *)snippet {
    
    if ([snippet localizedStandardContainsString:@"THANK YOU FOR YOUR BUSINESS+ RIDE"]) {
        return [[LiftagoEnglishSnippetMessageParser alloc] initWithSnippet:snippet];
    } else if ([snippet localizedStandardContainsString:@"DĚKUJEME ZA VAŠI JÍZDU NA BUSINESS+ PROFIL"]) {
        return [[LiftagoCzechSnippetMessageParser alloc] initWithSnippet:snippet];
    } else {
        return [[LiftagoSnippetMessageParser alloc] initWithSnippet:snippet];
    }
}

@end
