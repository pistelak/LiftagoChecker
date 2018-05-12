//
//  LiftagoSnippetMessageParser.h
//  LiftagoChecker
//
//  Created by Radek Pistelak on 09/09/2017.
//  Copyright © 2017 Radek Pistelak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BillEntry.h"

@interface LiftagoSnippetMessageParser : NSObject

- (NSArray<BillEntry *> *)entriesFromMassages:(NSArray<NSString *> *)snippets;

@end
