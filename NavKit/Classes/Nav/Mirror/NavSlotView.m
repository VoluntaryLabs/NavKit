//
//  NavSlotView.m
//  NavKit
//
//  Created by Steve Dekorte on 5/21/14.
//  Copyright (c) 2014 voluntary.net. All rights reserved.
//

#import "NavSlotView.h"
#import "NavTextView.h"
#import "NavAdvTextView.h"
#import "NavTheme.h"
#import "NSView+sizing.h"

@implementation NavSlotView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {

    }
    
    return self;
}

- (void)setFrame:(NSRect)frameRect
{
    [super setFrame:frameRect];
    [self layout];
}

- (void)layout
{

}

- (void)syncFromSlot
{
    
}

// sync

- (void)syncToSlot
{
    //[self updateActions];
    [self layout];
}

- (void)setSlot:(NavSlot *)aSlot
{
    [NSException raise:@"subclasses should override" format:@""];
}


@end
