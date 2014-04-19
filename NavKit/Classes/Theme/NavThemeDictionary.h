//
//  NavThemeDictionary.h
//  Bitmessage
//
//  Created by Steve Dekorte on 3/14/14.
//  Copyright (c) 2014 Bitmarkets.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NavThemeDictionary  : NSObject

@property (strong) NSDictionary *dict;

+ (NavThemeDictionary  *)withDict:(NSDictionary *)dict;

- (NSColor *)selectedBgColor;
- (NSColor *)unselectedBgColor;

@end
