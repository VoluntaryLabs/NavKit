//
//  NSWindow+positioning.m
//  Bitmessage
//
//  Created by Steve Dekorte on 2/18/14.
//  Copyright (c) 2014 voluntary.net. All rights reserved.
//

#import "NSWindow+positioning.h"

@implementation NSWindow (positioning)

- (void)setCenterPoint:(NSPoint)newCenter
{
    NSRect f = self.frame;
    CGFloat w = f.size.width;
    CGFloat h = f.size.height;
    
    NSRect newFrame = NSMakeRect(newCenter.x - w/2, newCenter.y - h/2, w, h);
    [self setFrame:newFrame display:YES];
}

- (NSPoint)centerPoint
{
    NSRect f = [self frame];
    return NSMakePoint(f.origin.x + f.size.width/2, f.origin.y + f.size.height/2);
}

- (void)centerInFrontOfWindow:(NSWindow *)aWindow
{
    [self setCenterPoint:[aWindow centerPoint]];
}

- (void)centerInMainWindow
{
    [self centerInFrontOfWindow:[[NSApplication sharedApplication] mainWindow]];
}

// --- width & height ---

- (void)setWidth:(CGFloat)w
{
    CGRect f = self.frame;
    f.size.width = w;
    [self setFrame:f display:YES];
}

- (void)setHeight:(CGFloat)h
{
    CGRect f = self.frame;
    f.size.height = h;
    [self setFrame:f display:YES];
}

// --- min width & min height ---


- (void)setMinWidth:(CGFloat)w
{
    CGSize s = self.minSize;
    s.width = w;
    [self setMinSize:s];
}

- (void)setMinHeight:(CGFloat)h
{
    CGSize s = self.minSize;
    s.height = h;
    [self setMinSize:s];
}


@end
