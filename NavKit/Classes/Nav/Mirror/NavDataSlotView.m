//
//  NavDataSlotView.m
//  NavKit
//
//  Created by Steve Dekorte on 5/21/14.
//  Copyright (c) 2014 voluntary.net. All rights reserved.
//

#import "NavDataSlotView.h"
#import "NSView+sizing.h"

@implementation NavDataSlotView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    
    self.labelMaxX = frame.size.width/3;
    self.horizonalSeparatorWidth = 10;
    
    if (self)
    {
        _labelText = [[NavTextView alloc] initWithFrame:NSMakeRect(0, 0, 100, 20)];
        //[_labelText setThemePath:@""];
        [self addSubview:_labelText];
        [_labelText setEditable:NO];
        [_labelText setSelectable:NO];
        
        _valueText = [[NavAdvTextView alloc] initWithFrame:NSMakeRect(0, 0, 100, 20)];
        [self addSubview:_valueText];
        _valueText.endsOnReturn = YES;
        [_valueText setDelegate:self];
    }
    
    [self layout];
    [self setHeight:_labelText.maxY];
    
    return self;
}

- (void)setSlot:(NavSlot *)aSlot
{
    [self setDataSlot:(NavDataSlot *)aSlot];
}

- (void)setDataSlot:(NavDataSlot *)dataSlot
{
    _dataSlot = dataSlot;
    [self syncFromSlot];
}

- (void)layout
{
    [super layout];
    [self sizeForLineCount];
    [self layoutHorizontally];
}

- (CGFloat)labelWidth
{
    return _labelText.textSize.width;
}

- (void)layoutHorizontally
{
    [super layout];

    [_labelText setAlignment:NSRightTextAlignment];
    [_labelText setX:0];
    [_labelText setY:self.height - _labelText.height];
    [_labelText setWidth:self.labelMaxX];
    //[_labelText setHeight:self.height];
    
    [_valueText setAlignment:NSLeftTextAlignment];
    [_valueText setX:self.labelMaxX + self.horizonalSeparatorWidth];
    [_valueText setY:0];
    [_valueText setWidth:self.width - self.labelMaxX - self.horizonalSeparatorWidth];
    [_valueText setHeight:self.height];
}

- (void)layoutVeritcally
{
    [super layout];
    
    [_valueText setX:0];
    [_valueText setY:0];
    [_valueText setWidth:self.width];
    
    [_labelText setWidth:self.width];
    [_labelText placeYAbove:_valueText margin:3.0];
    //    [self setHeight:_labelText.maxY];
}

- (void)syncFromSlot
{
    _valueText.string = _dataSlot.value;
    _valueText.uneditedTextString = _dataSlot.uneditedValue;
    [_valueText useUneditedTextStringIfNeeded];
    
    _labelText.string = self.dataSlot.visibleName;
}

- (void)syncToSlot
{
    self.dataSlot.value = _valueText.string;
}

- (void)afterEdit
{
    [_valueText useUneditedTextStringIfNeeded];
    
    
    if (self.dataSlot.syncsWhileEditing)
    {
        [self syncToSlot];
        
        if (self.dataSlot.canValidate)
        {
            self.valueText.isValid = [self.dataSlot isValid];
        }
    }
}

// text editing

- (void)textDidChange:(NSNotification *)aNotification
{
    NSTextView *aTextView = [aNotification object];
    
    if ([aTextView respondsToSelector:@selector(textDidChange)])
    {
        [(NavAdvTextView *)aTextView textDidChange];
    }
    
    [self afterEdit]; // to show on table cell
}

- (BOOL)textView:(NSTextView *)aTextView
shouldChangeTextInRange:(NSRange)affectedCharRange
replacementString:(NSString *)replacementString
{
    if (aTextView == self.valueText && self.dataSlot.canFormat)
    {
        NSString *newString = [aTextView.string stringByReplacingCharactersInRange:affectedCharRange
                                                                    withString:replacementString];
        
        NSString *errorDescription;
        id objectValue;
        BOOL success = [self.dataSlot.formatter
                        getObjectValue:&objectValue
                        forString:newString
                        errorDescription:&errorDescription];
        
        if (success)
        {
            return YES;
        }
        
        return NO;
    }
    
    return YES;
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
    [self afterEdit];
    [self syncToSlot];
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
    [[NSColor colorWithCalibratedWhite:.97 alpha:1.0] set];
    //NSRectFill(dirtyRect);
}

- (void)setNextKeySlotView:(NavDataSlotView *)nextView
{
    self.valueText.nextKeyView = nextView.valueText;
}

- (void)sizeForLineCount
{
    NSNumber *lineCount = self.dataSlot.lineCount;
    
    /*
    if (!lineCount)
    {
        lineCount = @1;
    }
    */
    
    if (lineCount)
    {
        [self setHeight:lineCount.doubleValue * (_labelText.font.pointSize * 1.2)];
    }
}


@end
