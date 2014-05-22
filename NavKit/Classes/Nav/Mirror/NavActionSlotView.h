//
//  NavActionSlotView.h
//  NavKit
//
//  Created by Steve Dekorte on 5/21/14.
//  Copyright (c) 2014 voluntary.net. All rights reserved.
//

#import "NavSlotView.h"
#import "NavRoundButtonView.h"

@interface NavActionSlotView : NavSlotView

@property (assign, nonatomic) NavActionSlot *actionSlot;

@property (strong, nonatomic) NavRoundButtonView *button;

- (void)syncFromSlot;
- (void)syncToSlot;

@end
