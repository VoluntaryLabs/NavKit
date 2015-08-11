//
//  NavVerticalScrollView.m
//  NavKit
//
//  Created by Steve Dekorte on 7/25/14.
//  Copyright (c) 2014 voluntary.net. All rights reserved.
//

#import "NavVerticalScrollView.h"


// --- this is a hack to force the scroll bars to match the style we want
// --- without this, the system prefs or pluggin in a mouse can change the style

@implementation NSScroller (StyleOverride)

- (NSScrollerStyle)scrollerStyle
{
    return NSScrollerStyleOverlay;
}

@end

@implementation NSScrollView (StyleOverride)

- (BOOL)autohidesScrollers
{
    return YES;
}

@end

// -------------------------------------------------


@implementation NavVerticalScrollView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self setHasVerticalScroller:YES];
        [self setHasHorizontalScroller:NO];
    }
    
    [self setScrollerStyle:NSScrollerStyleOverlay];
    
    return self;
}

/*
- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}
*/

- (void)scrollWheel:(NSEvent *)theEvent
{
    //NSLog(@"%@", theEvent);
    
    if(theEvent.deltaY == 0 && self.shouldDelegateHorizontalScroll)
    {
        [[self nextResponder] scrollWheel:theEvent];
    }
    else
    {
        [super scrollWheel:theEvent];
    }
    
}

@end
