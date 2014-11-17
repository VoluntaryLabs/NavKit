//
//  NavButton.m
//  Bitmessage
//
//  Created by Steve Dekorte on 3/4/14.
//  Copyright (c) 2014 voluntary.net. All rights reserved.
//

#import "NavButton.h"
#import "NSView+sizing.h"
#import "NavTheme.h"

@implementation NavButton

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
        [self setButtonType:NSMomentaryChangeButton];
        [self setBordered:NO];
        [self setFont:[NSFont fontWithName:[NavTheme.sharedNavTheme lightFontName] size:14.0]];
        [self setAutoresizingMask: NSViewMinXMargin | NSViewMaxYMargin];
        self.textColor = [NavTheme.sharedNavTheme formText1Color];
        [self setAlignment:NSCenterTextAlignment];
    }
    return self;
}

- (void)setFontSize:(CGFloat)pointSize
{
    self.font = [NSFont fontWithName:[NavTheme.sharedNavTheme lightFontName] size:pointSize];
}

- (void)setActionTitle:(NSString *)anAction
{
    [super setTitle:anAction];
    /*
    NSString *imageName = [NSString stringWithFormat:@"%@_active", anAction];
    NSImage *image = nil; //[NSImage imageNamed:imageName];
    
    if (image)
    {
        [self setImage:image];
        [self setWidth:image.size.width*3];
    }
    else
    */
    {
        [self updateTitle];
    }
}

- (void)sizeWidthToFit
{
    CGFloat width = [[self attributedTitle] size].width;
    [self setWidth:width + 10];
}

- (void)setTextColor:(NSColor *)aColor
{
    _textColor = aColor;
    [self updateTitle];
}

- (void)updateTitle
{
    NSMutableParagraphStyle *indented = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    
    [indented setAlignment:NSCenterTextAlignment];
    
    NSMutableAttributedString *coloredTitle = [[NSMutableAttributedString alloc] initWithAttributedString:[self attributedTitle]];
    
    [coloredTitle addAttribute:NSForegroundColorAttributeName
                       value:self.textColor
                       range:NSMakeRange(0, [coloredTitle length])];
    
    [coloredTitle addAttribute:NSFontAttributeName
                         value:[self font]
                         range:NSMakeRange(0, [coloredTitle length])];

    [coloredTitle addAttribute:NSParagraphStyleAttributeName
                          value:indented
                          range:NSMakeRange(0, [coloredTitle length])];
    
    [self setAttributedTitle:coloredTitle];
    [self sizeWidthToFit];
}

@end
