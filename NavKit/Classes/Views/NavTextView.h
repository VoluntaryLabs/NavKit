//
//  NavTextView.h
//  Bitmessage
//
//  Created by Steve Dekorte on 3/4/14.
//  Copyright (c) 2014 Bitmarkets.org. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NavTextView : NSTextView

- (void)setupForEditing;
- (void)setupForDisplay;


- (void)setFontSize:(CGFloat)pointSize;
- (NSSize)textSize;

@end
