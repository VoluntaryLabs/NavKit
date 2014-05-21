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

@interface NavSlotView : NSView <NSTextViewDelegate>

@property (assign, nonatomic) NavSlot *slot;

@property (strong, nonatomic) NavTextView    *labelText;
@property (strong, nonatomic) NavAdvTextView *valueText;


@end
