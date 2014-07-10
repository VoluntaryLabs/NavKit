//
//  NavMirrorView.m
//  Bitmessage
//
//  Created by Steve Dekorte on 2/21/14.
//  Copyright (c) 2014 Bitmarkets.org. All rights reserved.
//

#import "NavMirrorView.h"
#import "NSView+sizing.h"

@implementation NavMirrorView

- (id)initWithFrame:(NSRect)frame
{
    frame.size.width = 400;
    
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self setAutoresizesSubviews:NO];
        [self setAutoresizingMask:NSViewHeightSizable | NSViewWidthSizable];

        _group = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, self.width, 350)];
        //[_group setBackgroundColor:[NSColor colorWithCalibratedWhite:.5 alpha:1.0]];
        //[_group setBackgroundColor:[NSColor clearColor]];
        [self addSubview:_group];        
    }
    
    return self;
}

- (void)layout
{
    CGFloat margin = 25.0;
    [_group setAllSubviewToWidth:400.0];
    [_group stackSubviewsBottomToTopWithMargin:margin];
    [_group sizeAndRepositionSubviewsToFit];
    [_group stackSubviewsTopToBottomWithMargin:margin];
    [_group centerXInSuperview];
    [_group centerYInSuperview];
    [_group setY:_group.y + 30];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setFrame:(NSRect)frameRect
{
    [super setFrame:frameRect];
    [self layout];
}

/*
- (NavNode *)node
{
    return self.mirror.node;
}

- (void)setMirror:(NavMirror *)aMirror
{
    _mirror = aMirror;
    [self setNode:node];
}
*/

- (void)setNode:(NavNode *)node
{
    if (_node != node)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:_node];
        
        _node = node;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(nodeChanged:)
                                                     name:nil
                                                   object:_node];
        [self syncFromNode];
        
        // should move to mirror returning view instead?
        if (node.navMirror)
        {
            node.navMirror.mirrorView = self;
        }
    }
}

- (void)nodeChanged:(NSNotification *)note
{
    [self syncFromNode];
}

// sync

- (void)syncFromNode
{
    [_group removeAllSubviews];
    
    {
        NavDataSlot *lastDataSlot = self.node.navMirror.dataSlots.lastObject;
        NavDataSlotView *lastSlotView = (id)lastDataSlot.slotView;
        NavDataSlotView *slotView = nil;
        
        for (NavDataSlot *dataSlot in self.node.navMirror.dataSlots)
        {
            slotView = (NavDataSlotView *)dataSlot.slotView;
            
            if (slotView)
            {
                [slotView setWidth:self.width];
                [slotView.labelText setThemePath:@"address/label"];
                [slotView.valueText setEditedThemePath:@"address/line"];
                [slotView.valueText setSuffix:dataSlot.valueSuffix];
                [_group addSubview:slotView];
            }
            
            [lastSlotView setNextKeySlotView:slotView];
            lastSlotView = slotView;
        }
        
        NavDataSlot *firstDataSlot = self.node.navMirror.dataSlots.firstObject;
        [lastSlotView setNextKeySlotView:(NavDataSlotView *)firstDataSlot.slotView];
    }
    
    for (NavActionSlot *actionSlot in self.node.navMirror.actionSlots)
    {
        NavActionSlotView *slotView = (NavActionSlotView *)actionSlot.slotView;
        
        if (slotView)
        {
            //[slotView setWidth:self.width];
            [_group addSubview:slotView];
        }
        
        [slotView syncFromSlot];
    }
    
    [self layout];
    
    [self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
    [[NSColor whiteColor] set];
    NSRectFill(dirtyRect);
}


// -- sync ----

- (void)selectFirstResponder
{
    //[self.window makeFirstResponder:self.labelField];
    //[self.labelField selectAll:nil];
    //[labelField becomeFirstResponder];
}

// actions


- (BOOL)handlesNodeActions
{
    return YES;
}

// --- text -------------------------------------------

- (void)updateActions
{
    
}

- (void)syncToNode
{
    
}

// --- delegate ---

/*

- (BOOL)shouldPerformActionSlot:(NavActionSlot *)navActionSlot
{
    if (_delegate && [_delegate respondsToSelector:@selector(shouldPerformActionSlot:)])
    {
        return [_delegate shouldPerformActionSlot:navActionSlot];
    }
    
    return YES;
}

- (void)didPerformActionSlot:(NavActionSlot *)navActionSlot
{
    if (_delegate && [_delegate respondsToSelector:@selector(didPerformActionSlot:)])
    {
        return [_delegate didPerformActionSlot:navActionSlot];
    }
}
*/

@end
