//
//  NavVerticalScrollView.m
//  NavKit
//
//  Created by Steve Dekorte on 7/25/14.
//  Copyright (c) 2014 voluntary.net. All rights reserved.
//

#import "NavVerticalScrollView.h"

@implementation NavVerticalScrollView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self setHasVerticalScroller:YES];
        [self setHasHorizontalScroller:NO];
    }
    
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
