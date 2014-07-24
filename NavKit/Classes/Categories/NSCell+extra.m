//
//  NSCell+extra.m
//  NavKit
//
//  Created by Steve Dekorte on 7/23/14.
//  Copyright (c) 2014 voluntary.net. All rights reserved.
//

#import "NSCell+extra.h"

@implementation NSCell (extra)

- (void)drawVerticalLineAtX:(CGFloat)x inRect:(NSRect)aRect
{
    NSBezierPath *aPath = [NSBezierPath bezierPath];
    [aPath setLineCapStyle:NSSquareLineCapStyle];
    [aPath setLineWidth:1.0];
    [aPath moveToPoint:NSMakePoint((int)(aRect.origin.x + x), (int)(aRect.origin.y))];
    [aPath lineToPoint:NSMakePoint((int)(aRect.origin.x + x), (int)(aRect.origin.y + aRect.size.height))];
    [aPath stroke];
}

- (void)drawHorizontalLineAtY:(CGFloat)y inRect:(NSRect)aRect
{
    //[[NSColor colorWithCalibratedWhite:.7 alpha:1.0] set];
    
    NSBezierPath *aPath = [NSBezierPath bezierPath];
    [aPath setLineCapStyle:NSSquareLineCapStyle];
    [aPath setLineWidth:1.0];
    [aPath moveToPoint:NSMakePoint((int)(aRect.origin.x), (int)(aRect.origin.y + y))];
    [aPath lineToPoint:NSMakePoint((int)(aRect.origin.x + aRect.size.width), (int)(aRect.origin.y + y))];
    [aPath stroke];
}

@end
