//
//  NavSlotView.h
//  NavKit
//
//  Created by Steve Dekorte on 5/21/14.
//  Copyright (c) 2014 voluntary.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NavAdvTextView.h"
#import <NavNodeKit/NavNodeKit.h>


@protocol NavSlotViewDelegate <NSObject>
- (void)slotViewChanged:(id)aNavSlotView;
@end


@interface NavSlotView : NSView 

//@property (strong, nonatomic) NavSlot *slot;
@property (assign, nonatomic) id delegate;

- (void)syncFromSlot;
- (void)syncToSlot;

- (void)setSlot:(NavSlot *)aSlot;

@end
