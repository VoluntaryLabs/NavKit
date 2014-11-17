//
//  NavColoredView.m
//  Bitmarket
//
//  Created by Steve Dekorte on 2/9/14.
//  Copyright (c) 2014 voluntary.net. All rights reserved.
//

#import "NavColoredView.h"

@implementation NavColoredView

- (BOOL)isOpaque
{
    return NO;
    //return self.alphaValue != 1.0;
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [NSColor blueColor];
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    if (self.backgroundColor)
    {
        [self.backgroundColor setFill];
    }
    
    //NSRectFill(self.frame);
    NSRectFill(dirtyRect);
}

@end
