//
//  NavWindow.h
//  NavKit
//
//  Created by Steve Dekorte on 4/16/14.
//  Copyright (c) 2014 voluntary.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NavView.h"
#import "NavColoredView.h"
#import "NavProgressController.h"

@interface NavWindow : NSWindow

@property (strong, nonatomic) NSView *splashView;
@property (strong, nonatomic) NSScrollView *scrollView;
@property (strong, nonatomic) NavColoredView *backgroundView;
@property (strong, nonatomic) NavView *navView;
@property (strong, nonatomic) NSProgressIndicator *progressIndicator;
@property (strong, nonatomic) NavProgressController *progressController;

+ (NavWindow *)newWindow;

- (void)showSplashView;
- (void)hideSplashView;

@end
