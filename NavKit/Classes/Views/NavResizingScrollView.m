//
//  NavResizingScrollView.m
//  Bitmarket
//
//  Created by Steve Dekorte on 2/6/14.
//  Copyright (c) 2014 voluntary.net. All rights reserved.
//

#import "NavResizingScrollView.h"
#import "NSView+sizing.h"

@implementation NavResizingScrollView

- (void)viewWillStartLiveResize
{
    
}

- (void)viewDidEndLiveResize
{
    [self.documentView setWidth:self.width];
}

- (void)setFrame:(NSRect)frameRect
{
    [super setFrame:frameRect];
    [self.documentView setWidth:self.width];
}

@end
