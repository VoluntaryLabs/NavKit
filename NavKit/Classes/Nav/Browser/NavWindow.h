//
//  NavWindow.h
//  NavKit
//
//  Created by Steve Dekorte on 4/16/14.
//  Copyright (c) 2014 voluntary.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NavView.h"

@interface NavWindow : NSWindow

@property (strong, nonatomic) NSView *splashView;
@property (strong, nonatomic) NavView *navView;
@property (strong, nonatomic) NSProgressIndicator *progressIndicator;

+ (NavWindow *)newWindow;

- (void)showSplashView;
- (void)hideSplashView;


@end
