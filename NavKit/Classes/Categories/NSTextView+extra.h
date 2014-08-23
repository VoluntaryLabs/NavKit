//
//  NSTextView+extra.h
//  Bitmessage
//
//  Created by Steve Dekorte on 2/21/14.
//  Copyright (c) 2014 voluntary.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSTextView (extra)

- (void)endEditing;

- (BOOL)didTab;
- (void)removeTabs;

- (BOOL)endEditingOnReturn;
- (void)removeReturns;

- (BOOL)gotoNext;

@end