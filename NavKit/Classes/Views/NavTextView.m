//
//  NavTextView.m
//  Bitmessage
//
//  Created by Steve Dekorte on 3/4/14.
//  Copyright (c) 2014 voluntary.net. All rights reserved.
//

#import "NavTextView.h"
#import "NavTheme.h"

@implementation NavTextView

- (BOOL)isOpaque
{
    return NO;
}

/*
- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
    }

    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
}
 */

- (void)setFontSize:(CGFloat)pointSize
{
    self.font = [NSFont fontWithName:[NavTheme.sharedNavTheme lightFontName] size:pointSize];
}

- (void)setupForDisplay
{
    self.font = [NSFont fontWithName:[NavTheme.sharedNavTheme lightFontName] size:16.0];
    self.textColor = [NavTheme.sharedNavTheme formText3Color];
    self.editable = NO;
    [self setAlignment:NSCenterTextAlignment];
    [self setRichText:NO];
    //[self setDrawsBackground:NO];
    [self setDrawsBackground:NO];
    
    [self setSelectable:NO];
    [self setFocusRingType:NSFocusRingTypeNone];
    [self setAutoresizingMask: NSViewWidthSizable | NSViewMinYMargin | NSViewMaxYMargin];
}

- (NSSize)textSize
{
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    [att setObject:self.font forKey:NSFontAttributeName];
    
    CGSize size = [[[NSAttributedString alloc] initWithString:self.string attributes:att] size];
    return size;
}

- (void)setupForEditing
{
    self.font = [NSFont fontWithName:[NavTheme.sharedNavTheme lightFontName] size:24.0];
    self.textColor = [NavTheme.sharedNavTheme formText1Color];
    self.editable = YES;
    [self setRichText:NO];
    //[self setDrawsBackground:NO];
    [self setDrawsBackground:NO];
    [self setFocusRingType:NSFocusRingTypeNone];
    
    [self setAutoresizingMask: NSViewWidthSizable | NSViewMinYMargin | NSViewMaxYMargin];
    [self setAlignment:NSCenterTextAlignment];
    [self setRichText:NO];
    [self setInsertionPointColor:[NavTheme.sharedNavTheme formTextCursorColor]];
    
    [self setSelectedTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [NavTheme.sharedNavTheme formTextSelectedBgColor], NSBackgroundColorAttributeName,
      [NavTheme.sharedNavTheme formText1Color], NSForegroundColorAttributeName,
      nil]];
}

@end
