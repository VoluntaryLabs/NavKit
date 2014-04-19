//
//  NavThemeDictionary .m
//  Bitmessage
//
//  Created by Steve Dekorte on 3/14/14.
//  Copyright (c) 2014 Bitmarkets.org. All rights reserved.
//

#import "NavThemeDictionary.h"
#import "NSColor+array.h"
#import "NSColor+Hex.h"
#import <FoundationCategoriesKit/FoundationCategoriesKit.h>

@implementation NavThemeDictionary 

+ (NavThemeDictionary  *)withDict:(NSDictionary *)dict;
{
    NavThemeDictionary  *t = [[NavThemeDictionary  alloc] init];
    t.dict = dict;
    return t;
}

- (NSColor *)colorForKey:(NSString *)k
{
    id value = [self.dict objectForKey:k];
    return [NSColor colorWithObject:value];
}

// background

- (NSColor *)selectedBgColor
{
    return [self colorForKey:@"selectedBgColor"];
}

- (NSColor *)unselectedBgColor
{
    return [self colorForKey:@"unselectedBgColor"];
}

@end
