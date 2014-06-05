//
//  NavDescriptionView.m
//  NavKit
//
//  Created by Steve Dekorte on 6/4/14.
//  Copyright (c) 2014 voluntary.net. All rights reserved.
//

#import "NavDescriptionView.h"
#import "NSView+sizing.h"

@implementation NavDescriptionView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self setAutoresizesSubviews:YES];
        [self setAutoresizingMask:NSViewHeightSizable | NSViewWidthSizable];
        
        _textView = [[NavTextView alloc] initWithFrame:NSMakeRect(0, 0, self.width, self.height)];
        [self addSubview:_textView];
        [_textView setThemePath:@"code"];
        //_textView.textColor = [NSColor whiteColor];
       // _textView.backgroundColor = [NSColor colorWithCalibratedWhite:.5 alpha:1.0];
        //self.backgroundColor = [NSColor whiteColor];
        
        //[_textView setDelegate:self];
        //_textView.endsOnReturn = YES;
        //@property (strong) IBOutlet NSTextView *quantity;
    }
    
    return self;
}

- (void)setNode:(NavNode *)node
{
    _node = node;
    
    [self syncFromNode];
}

- (void)setFrame:(NSRect)frameRect
{
    [super setFrame:frameRect];
    [self layout];
    [self layout];
}

- (void)syncFromNode
{
    if ([_node respondsToSelector:@selector(descriptionJSONObject)])
    {
        id anObject = ((id <NavDescriptionViewProtocol>)_node).descriptionJSONObject;
        
        NSError *error;
        NSData *data = [NSJSONSerialization dataWithJSONObject:anObject
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];

        if (error)
        {
            NSString *errorString = [[error userInfo] objectForKey:@"NSDebugDescription"];
            _textView.string = errorString;
            // change color?
        }
        else
        {
            _textView.string = [NSString stringWithUTF8String:[data bytes]];
        }
    }
    else
    {
        _textView.string = _node.description;
    }
    
    [_textView setNeedsDisplay:YES];
    
    //[self layout];
}

/*
- (void)prepareToDisplay
{
    [self layout];
    [self layout];
}
*/

- (void)layout
{
    /*
    if (self.superview)
    {
        [self setWidth:self.superview.width];
        [self setHeight:self.superview.height];
    }
    */

    CGFloat margin = 30;
    
    [_textView setX:margin];
    [_textView setY:margin];
    
    [_textView setWidth:self.width   - margin * 2];
    [_textView setHeight:self.height - margin * 2];
}


@end
