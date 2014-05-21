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

@implementation NavSlotView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}


- (NavTextView *)newLabel
{
    NavTextView *label = [[NavTextView alloc] initWithFrame:NSMakeRect(0, 0, 350, 24)];
    [label setThemePath:@"address/label"];
    //[label setThemePath:@"address/line"];
    //[label setDelegate:self];
    [label setEditable:NO];
    return label;
}

- (NavAdvTextView *)newLine
{
    NavAdvTextView *line = [[NavAdvTextView alloc] initWithFrame:NSMakeRect(0, 0, 350, 24)];
    //line.uneditedTextString = @"";
    [line setEditedThemePath:@"address/line"];
    //[line setDelegate:self];
    line.endsOnReturn = YES;
    return line;
}

@end
