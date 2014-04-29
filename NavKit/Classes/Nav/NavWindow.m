//
//  NavWindow.m
//  NavKit
//
//  Created by Steve Dekorte on 4/16/14.
//  Copyright (c) 2014 voluntary.net. All rights reserved.
//

#import "NavWindow.h"
#import "NSView+sizing.h"

@implementation NavWindow

+ (NavWindow *)newWindow
{
    NavWindow *instance = [[NavWindow alloc]
                           initWithContentRect:NSMakeRect(0, 0, 1800, 700)
                           styleMask:  NSTitledWindowMask |
                                       NSClosableWindowMask |
                                       NSMiniaturizableWindowMask |
                                       NSResizableWindowMask |
                                       NSTexturedBackgroundWindowMask
                           backing:NSBackingStoreBuffered
                           defer:NO];
    
    return instance;
    
}

- (id)initWithContentRect:(NSRect)contentRect
                styleMask:(NSUInteger)windowStyle
                  backing:(NSBackingStoreType)bufferingType
                    defer:(BOOL)deferCreation
{
    self = [super initWithContentRect:contentRect
                            styleMask:windowStyle
                              backing:bufferingType
                                defer:deferCreation];
    
    
    _navView = [[NavView alloc] initWithFrame:contentRect];
    [self.contentView addSubview:_navView];
    
    _progressIndicator = [[NSProgressIndicator alloc] initWithFrame:NSMakeRect(5, ((NSView *)self.contentView).height - 22, 16, 16)];
    [self.contentView addSubview:_progressIndicator];
    [_progressIndicator setUsesThreadedAnimation:YES];
    [_progressIndicator setIndeterminate:YES];
    [_progressIndicator setBezeled:NO];
    [_progressIndicator setDisplayedWhenStopped:NO];
    [_progressIndicator setStyle:NSProgressIndicatorSpinningStyle];
    
    return self;
}

@end
