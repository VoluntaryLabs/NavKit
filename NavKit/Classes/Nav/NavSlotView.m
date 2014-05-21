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
        _labelText = [[NavTextView alloc] initWithFrame:NSMakeRect(0, 0, 100, 30)];
        //[_labelText setThemePath:@""];
        [self addSubview:_labelText];
        [_labelText setEditable:NO];
        
        
        _valueText = [[NavAdvTextView alloc] initWithFrame:NSMakeRect(0, 0, 100, 30)];
        [self addSubview:_valueText];
        _valueText.endsOnReturn = YES;
        [_valueText setDelegate:self];
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
    [_valueText setX:0];
    [_valueText setY:0];
    [_valueText setWidth:self.width];
    
    [_labelText setWidth:self.width];
    [_labelText placeYAbove:_labelText margin:10.0];
    [self setHeight:_labelText.maxY];
}

// text delegate

- (void)updateActions
{
    
}

- (void)syncToSlot
{
    
}

- (void)textDidChange:(NSNotification *)aNotification
{
    NSTextView *aTextView = [aNotification object];
    
    if ([aTextView respondsToSelector:@selector(textDidChange)])
    {
        [(NavAdvTextView *)aTextView textDidChange];
    }
    
    [self updateActions];
    [self syncToSlot]; // to show on table cell
    [self layout];
}

- (BOOL)control:(NSControl *)control textShouldEndEditing:(NSText *)aTextView
{
    if ([aTextView respondsToSelector:@selector(textDidBeginEditing)])
    {
        [(NavAdvTextView *)aTextView textShouldBeginEditing];
    }
    
    return YES;
}

- (void)textDidBeginEditing:(NSText *)aTextView
{
    if ([aTextView respondsToSelector:@selector(textDidBeginEditing)])
    {
        [(NavAdvTextView *)aTextView textDidBeginEditing];
    }
}

- (void)textDidEndEditing:(NSNotification *)aNotification
{
    NSTextView *aTextView = [aNotification object];
    
    if ([aTextView respondsToSelector:@selector(textDidEndEditing)])
    {
        [(NavAdvTextView *)aTextView textDidEndEditing];
    }
    
    [[aNotification object] endEditing];
    [self syncToSlot];
    [self updateActions];
}

@end
