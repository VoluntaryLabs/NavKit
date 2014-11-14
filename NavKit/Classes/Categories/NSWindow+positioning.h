//
//  NSWindow+positioning.h
//  Bitmessage
//
//  Created by Steve Dekorte on 2/18/14.
//  Copyright (c) 2014 voluntary.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSWindow (positioning)

- (void)setCenterPoint:(NSPoint)newCenter;
- (NSPoint)centerPoint;

- (void)centerInFrontOfWindow:(NSWindow *)aWindow;
- (void)centerInMainWindow;

// --- width & height ---

- (void)setWidth:(CGFloat)w;
- (void)setHeight:(CGFloat)h;

- (void)setMinWidth:(CGFloat)w;
- (void)setMinHeight:(CGFloat)h;

@end
