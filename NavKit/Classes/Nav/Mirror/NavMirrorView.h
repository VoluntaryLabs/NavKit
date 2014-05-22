//
//  NavMirrorView.h
//  Bitmessage
//
//  Created by Steve Dekorte on 2/21/14.
//  Copyright (c) 2014 Bitmarkets.org. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <NavKit/NavKit.h>

@interface NavMirrorView : NSView <NSTextViewDelegate>

@property (assign, nonatomic) NavView *navView;
@property (assign, nonatomic) NavNode *node;

@property (strong, nonatomic) NSView *group;

- (void)prepareToDisplay;
- (void)selectFirstResponder;

- (BOOL)handlesNodeActions;

@end
