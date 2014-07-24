//
//  NSCell+extra.h
//  NavKit
//
//  Created by Steve Dekorte on 7/23/14.
//  Copyright (c) 2014 voluntary.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSCell (extra)

- (void)drawVerticalLineAtX:(CGFloat)x inRect:(NSRect)aRect;
- (void)drawHorizontalLineAtY:(CGFloat)y inRect:(NSRect)aRect;

@end
