//
//  NavActionSlotView.m
//  NavKit
//
//  Created by Steve Dekorte on 5/21/14.
//  Copyright (c) 2014 voluntary.net. All rights reserved.
//

#import "NavActionSlotView.h"
#import "NSView+sizing.h"

@implementation NavActionSlotView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _button = [[NavRoundButtonView alloc] initWithFrame:NSMakeRect(0, 0, 350, 30)];
        [_button setCornerRadius:6];
        [self addSubview:_button];
        [_button setTarget:self];
        [_button setAction:@selector(sendAction)];
    
        _button.title = @"default";
        //[_button setTitleAttributes:[NavTheme.sharedNavTheme attributesDictForPath:@"sell/button"]];
    }

    return self;
}

- (void)setSlot:(NavSlot *)aSlot
{
    [self setActionSlot:(NavActionSlot *)aSlot];
}

- (void)setActionSlot:(NavActionSlot *)actionSlot
{
    _actionSlot = actionSlot;
    [self syncFromSlot];
}

- (void)syncFromSlot
{
    _button.title = _actionSlot.visibleName;
    
    BOOL enabled = _actionSlot.isActive;
    [_button setEnabled:enabled];
    
    if (enabled)
    {
        [_button setTitleAttributes:[NavTheme.sharedNavTheme attributesDictForPath:@"sell/button"]];
    }
    else
    {
        [_button setTitleAttributes:[NavTheme.sharedNavTheme attributesDictForPath:@"sell/button-disabled"]];
    }
}

- (void)syncToSlot
{
}

- (void)layout
{
    [super layout];
    [_button setFrame:NSMakeRect(0, 0, self.width, self.height)];
}

- (void)sendAction
{
    [self.actionSlot sendAction];
}

@end
