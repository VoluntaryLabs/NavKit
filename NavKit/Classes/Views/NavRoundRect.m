//
//  NavRoundRect.m
//  NavKit
//
//  Created by Steve Dekorte on 3/30/14.
//  Copyright (c) 2014 Bitmarkets.org. All rights reserved.
//

#import "NavRoundRect.h"

@implementation NavRoundRect

- (id)init
{
    self = [super init];
    
    _frame = NSMakeRect(0, 0, 100, 100);
    
    _backgroundColor = [NSColor blackColor];
    _outlineColor    = [NSColor blackColor];
    
    _cornerRadius = 6;
    _outlineWidth = 1;
    
    return self;
}

- (void)setSize:(NSSize)aSize
{
    _frame.size = aSize;
}

- (void)draw
{
    CGContextRef ctx = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
    
	CGPathRef roundedRectPath = [self newPathForRoundedRect:_frame radius:_cornerRadius];
    
	[self.backgroundColor set];
    
	CGContextAddPath(ctx, roundedRectPath);
    
    if (self.isOutlined)
    {
        CGContextSetLineWidth(ctx, self.outlineWidth);
        CGContextDrawPath(ctx, kCGPathStroke);
    }
    
    if (self.isFilled)
    {
        CGContextFillPath(ctx);
    }
    
	CGPathRelease(roundedRectPath);
}

- (CGPathRef)newPathForRoundedRect:(CGRect)rect radius:(CGFloat)radius
{
	CGMutablePathRef retPath = CGPathCreateMutable();
    
	CGRect innerRect = CGRectInset(rect, radius, radius);
    
	CGFloat inside_right   = innerRect.origin.x + innerRect.size.width;
	CGFloat outside_right  = rect.origin.x + rect.size.width;
	CGFloat inside_bottom  = innerRect.origin.y + innerRect.size.height;
	CGFloat outside_bottom = rect.origin.y + rect.size.height;
    
	CGFloat inside_top   = innerRect.origin.y;
	CGFloat outside_top  = rect.origin.y;
	CGFloat outside_left = rect.origin.x;
    
	CGPathMoveToPoint(retPath, NULL, innerRect.origin.x, outside_top);
    
	CGPathAddLineToPoint(retPath, NULL, inside_right, outside_top);
	CGPathAddArcToPoint(retPath,  NULL, outside_right, outside_top, outside_right, inside_top, radius);
	CGPathAddLineToPoint(retPath, NULL, outside_right, inside_bottom);
	CGPathAddArcToPoint(retPath,  NULL, outside_right, outside_bottom, inside_right, outside_bottom, radius);
    
	CGPathAddLineToPoint(retPath, NULL, innerRect.origin.x, outside_bottom);
	CGPathAddArcToPoint(retPath,  NULL, outside_left, outside_bottom, outside_left, inside_bottom, radius);
	CGPathAddLineToPoint(retPath, NULL, outside_left, inside_top);
	CGPathAddArcToPoint(retPath,  NULL, outside_left, outside_top, innerRect.origin.x, outside_top, radius);
    
	CGPathCloseSubpath(retPath);
    
	return retPath;
}

@end
