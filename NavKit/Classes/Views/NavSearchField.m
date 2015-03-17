//
//  NavSearchField.m
//  Bitmessage
//
//  Created by Steve Dekorte on 2/19/14.
//  Copyright (c) 2014 voluntary.net. All rights reserved.
//

#import "NavSearchField.h"
#import "NSView+sizing.h"

@interface NSSearchField (undocumented)
- (NSRect)searchTextRectForBounds:(NSRect)rect; // hack
@end


@implementation NavSearchField

- (void)setupCollapsed
{
    _isExpanded = NO;
    [self setBordered:NO];
    [self setFocusRingType:NSFocusRingTypeNone];
    [self setEditable:NO];
    [self setSelectable:NO];
    [self setDrawsBackground:NO];
    [self setWidth:self.minWidth];
    [self setNeedsDisplay];
}

- (void)setupExpanded
{
    _isExpanded = YES;

    NSSearchFieldCell *cell = self.cell;
    cell.cancelButtonCell = nil;
    
    [self setBordered:YES];
    [self setFocusRingType:NSFocusRingTypeExterior];
    [self setEditable:YES];
    [self setSelectable:YES];
    [self setBackgroundColor:[NSColor colorWithCalibratedWhite:.5 alpha:1.0]];
    [self setBezeled:YES];
    [self setBezelStyle:NSTextFieldRoundedBezel];
    [self setDrawsBackground:YES];
    [self setWidth:self.maxWidth];
    [self setNeedsDisplay];
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self setupCollapsed];
        
        _minWidth = 30.0;
        _maxWidth = 120.0;
        [self setHeight:20];
        [self setDelegate:self];
    }
    
    return self;
}

- (NSRect)cancelButtonRectForBounds:(NSRect)rect
{
    return NSMakeRect(0, 0, 0, 0);
}

- (NSRect)searchTextRectForBounds:(NSRect)rect
{
    if (self.isExpanded)
    {
        return [super searchTextRectForBounds:rect];
    }
    
    return NSMakeRect(0, 0, 0, 0);
}

/*
- (void)connectCancelButton
{
    [[[self cell] cancelButtonCell] setAction:@selector(clearSearchField:)];
    [[[self cell] cancelButtonCell] setTarget:self];
}
*/

- (void)clearSearchField:sender
{
    //[self selectAll:self];
    //[self deleteToEndOfLine:self];
    [self setStringValue:@""];
    //[self toggle];
    //[self controlTextDidChange:nil];
}

- (void)mouseDown:(NSEvent *)event
{
    // only get's this if the magnifying glass icon was clicked
    NSPoint p = [self convertPoint:[event locationInWindow] fromView:nil];
    //NSLog(@"mouse position %i, %i", (int)p.x, (int)p.y);
    [super mouseDown:event];

    if ((p.x < 20) && ([event type] == NSLeftMouseDown))
    //if ([event type] == NSLeftMouseDown)
    {
        [self toggle];
        //[self setNeedsDisplay:YES];
    }
}

- (void)toggle
{
    BOOL shouldAnimate = YES;
    
    if (self.isExpanded)
    {
        [self setStringValue:@""];
        [self controlTextDidChange:nil];
        //[self.window makeFirstResponder:self.superview];
    }
    
    self.isExpanded = !self.isExpanded;
    
    if (shouldAnimate)
    {
        if (YES)
        {
            [self setup];
            [self stackViews];
            
            /*
            _animationValue = 1.0;
            [self layoutAmination];
            */
            
            if (self.isExpanded)
            {
                //[self.window makeFirstResponder:self];
                [self selectText:self];
            }
        }
        /*
        else
        {
            //_animationValue = 0.0;
            [self setup];
            [self setAnimationValue:1.0]; // skip animation
            [self timer:nil];
        }
        */
    }
    /*
    else
    {
        if (self.isExpanded)
        {
            [self setupExpanded];
        }
        else
        {
            [self setupCollapsed];
        }
    }
    */
}

- (void)setup
{
    if (self.isExpanded)
    {
        [self setupExpanded];
    }
    else
    {
        [self setupCollapsed];
    }
}

- (void)completeSetup
{
    if (self.isExpanded)
    {
        //[self setupExpanded];
        [self.window makeFirstResponder:self];
    }
    else
    {
        [self setupCollapsed];
        //[[[self cell] cancelButtonCell] setEnabled:NO];
        //[[[self cell] cancelButtonCell] setTarget:nil];
    }
}

- (void)timer:anObject
{
    CGFloat timerPeriod = 1.0;
    NSInteger totalFrames = 1.0;
    CGFloat v = self.animationValue + timerPeriod/totalFrames;

    if (v >= 1.0)
    {
        v = 1.0;
        [self setAnimationValue:v];
        [self.timer invalidate];
        self.timer = nil;
        [self completeSetup];
    }
    else if (!self.timer)
    {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0 //timerPeriod/60.0
                                                  target:self
                                                selector:@selector(timer:)
                                                userInfo:nil
                                                 repeats:YES];
    }
    else
    {
        self.animationValue = v;
    }
}

- (void)setAnimationValue:(float)animationValue
{
    _animationValue = animationValue;
    [self layoutAmination];
}

- (void)layoutAmination
{
    CGFloat v = 0.0;
    
    if (!self.isExpanded)
    {
        v = 1.0 - self.animationValue;
    }
    else
    {
        v = self.animationValue;
    }
    
    [self setWidth:self.minWidth + (self.maxWidth - self.minWidth)*v];
    [self stackViews];
}

- (void)stackViews
{
    [self.superview stackSubviewsRightToLeftWithMargin:10.0]; // hack
    [self.superview centerSubviewsY]; // hack
    [self setNeedsDisplay:YES];
}

- (BOOL)control:(NSControl *)control textShouldBeginEditing:(NSText *)fieldEditor
{
    //NSLog(@"textShouldBeginEditing");
    return YES;
}

- (void)controlTextDidChange:(NSNotification *)aNotification
{
    //NSLog(@"controlTextDidChange '%@'", self.stringValue);
    
    if (_searchDelegate && !self.searchOnReturn)
    {
        [_searchDelegate searchForString:self.stringValue];
    }
    
}

- (BOOL)control:(NSControl *)control textShouldEndEditing:(NSText *)fieldEditor
{
    //NSLog(@"textShouldEndEditing");
    
    if (self.searchOnReturn)
    {
        [_searchDelegate searchForString:self.stringValue];
    }
    
    return YES;
}

@end
