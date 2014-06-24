//
//  NavMirrorView.h
//  Bitmessage
//
//  Created by Steve Dekorte on 2/21/14.
//  Copyright (c) 2014 Bitmarkets.org. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <NavKit/NavKit.h>

/*
@protocol NavMirrorViewDelegate <NSObject>
- (BOOL)shouldPerformActionSlot:(NavActionSlot *)navActionSlot; // optional
- (void)didPerformActionSlot:(NavActionSlot *)navActionSlot; // optional
@end
*/

@interface NavMirrorView : NSView <NSTextViewDelegate>

@property (assign, nonatomic) NavView *navView;
@property (assign, nonatomic) NavNode *node;
//@property (assign, nonatomic) NavMirror *mirror;

@property (strong, nonatomic) NSView *group;
//@property (assign, nonatomic) id <NavMirrorViewDelegate> delegate;

//- (NavNode *)node;

- (void)prepareToDisplay;
- (void)selectFirstResponder;

- (BOOL)handlesNodeActions;

/*
// passes these to delegate

- (BOOL)shouldPerformActionSlot:(NavActionSlot *)navActionSlot;
- (void)didPerformActionSlot:(NavActionSlot *)navActionSlot;
*/

@end
