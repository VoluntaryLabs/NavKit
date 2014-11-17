//
//  NavActionSlotView.m
//  NavKit
//
//  Created by Steve Dekorte on 5/21/14.
//  Copyright (c) 2014 voluntary.net. All rights reserved.
//

#import "NavMirrorView.h"
#import "NavActionSlotView.h"
#import "NSView+sizing.h"

@implementation NavActionSlotView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _button = [[NavRoundButtonView alloc] initWithFrame:NSMakeRect(0, 0, 350, 40)];
        [_button setCornerRadius:3];
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

- (void)dealloc
{
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)setActionSlot:(NavActionSlot *)actionSlot
{
    _actionSlot = actionSlot;
    
    [NSNotificationCenter.defaultCenter addObserver:self
                                             selector:@selector(slotChanged:)
                                                 name:nil
                                               object:actionSlot];
    
    [self syncFromSlot];
}

- (void)slotChanged:(NSNotification *)aNote
{
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
    /*
    NavMirrorView *mirrorView =  (NavMirrorView *)self.actionSlot.mirror.node.nodeView;
    
    if (mirrorView && [mirrorView respondsToSelector:@selector(shouldPerformActionSlot:)])
    {
        if ([mirrorView shouldPerformActionSlot:self.actionSlot])
        {
            [self.actionSlot sendAction];
        }
    }
    else
    {
        [self.actionSlot sendAction];
    }
    */
    
    if (_actionSlot.verifyMessage)
    {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert addButtonWithTitle:[_actionSlot.visibleName capitalizedString]];
        [alert addButtonWithTitle:@"Cancel"];
        //[alert setMessageText:[NSString stringWithFormat:@"%@ for \"%@\"?", _actionSlot.visibleName, _actionSlot.mirror.nodeTitle]];
        
        [alert setMessageText:@"Warning"];
        [alert setInformativeText:_actionSlot.verifyMessage];
        [alert setAlertStyle:NSWarningAlertStyle];
        
        [alert beginSheetModalForWindow:self.window
                           modalDelegate:self
                          didEndSelector:@selector(actionAlertDidEnd:returnCode:contextInfo:)
                             contextInfo:nil];
        
    }
    else
    {
        [self justSendAction];
    }
}

- (void)actionAlertDidEnd:(NSAlert *)alert
            returnCode:(NSInteger)returnCode
           contextInfo:(void *)contextInfo
{
    if (returnCode == 1000)
    {
        [self justSendAction];
    }
    
}

- (void)justSendAction
{
    [self.actionSlot sendAction];
}

@end
