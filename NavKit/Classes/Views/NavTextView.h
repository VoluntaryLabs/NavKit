//
//  NavTextView.h
//  Bitmessage
//
//  Created by Steve Dekorte on 3/4/14.
//  Copyright (c) 2014 voluntary.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NavTextView : NSTextView

- (void)setupForEditing;
- (void)setupForDisplay;


- (void)setFontSize:(CGFloat)pointSize;
- (NSSize)textSize;

@end
