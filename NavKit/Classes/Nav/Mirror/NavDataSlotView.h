//
//  NavDataSlotView.h
//  NavKit
//
//  Created by Steve Dekorte on 5/21/14.
//  Copyright (c) 2014 voluntary.net. All rights reserved.
//

#import "NavSlotView.h"
#import "NavTextView.h"
#import "NavAdvTextView.h"

@interface NavDataSlotView : NavSlotView <NSTextViewDelegate>

@property (assign, nonatomic) NavDataSlot *dataSlot;

@property (strong, nonatomic) NavTextView    *labelText;
@property (strong, nonatomic) NavAdvTextView *valueText;
@property (assign, nonatomic) CGFloat labelMaxX;
@property (assign, nonatomic) CGFloat horizonalSeparatorWidth;

- (void)setNextKeySlotView:(NavDataSlotView *)nextView;

- (void)syncToSlot;

- (CGFloat)labelWidth;

- (void)sizeForLineCount;

@end
