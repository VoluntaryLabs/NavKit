//
//  NavWebView.m
//  NavKit
//
//  Created by Steve Dekorte on 12/13/14.
//  Copyright (c) 2014 voluntary.net. All rights reserved.
//

#import "NavWebView.h"

@implementation NavWebView

- (id)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];
    [self setThemePath:@"message/body"];
    [self setAutoresizesSubviews:YES];
    [self setAutoresizingMask:NSViewHeightSizable | NSViewWidthSizable];
    [self setupBody];
    self.backgroundColor = [NSColor colorWithCalibratedWhite:0.15 alpha:1.0];
    self.leftMargin = 1;
    return self;
}

- (void)dealloc
{
}

- (void)load
{
    NSString *resource = [(NavInfoNode *)_node nodeResourceName];
    
    if ([resource hasPrefix:@"http://"])
    {
        NSURL *url = [NSURL URLWithString:resource];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView.mainFrame loadRequest:request];
    }
}

- (void)setNode:(NavNode *)node
{
    if (_node != node)
    {
        _node = node;
        
        [self load];
        [self.webView setFrame:self.webViewFrame];
    }
}

- (NSRect)webViewFrame
{
    NSRect bounds = self.bounds;
    bounds.origin.x += self.leftMargin;
    bounds.size.width -= self.leftMargin;
    return bounds;
}

- (void)setupBody
{
    self.webView = [[WebView alloc] initWithFrame:self.webViewFrame];
    [self.webView setAutoresizingMask:NSViewHeightSizable | NSViewWidthSizable];
    [self addSubview:self.webView];
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    [self.backgroundColor set];
    NSRectFill(dirtyRect);
}

- (void)prepareToDisplay
{
}

@end
