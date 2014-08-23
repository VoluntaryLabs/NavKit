//
//  NavRoundButtonView.h
//  Bitmessage
//
//  Created by Steve Dekorte on 3/30/14.
//  Copyright (c) 2014 voluntary.net. All rights reserved.
//

#import "NavButton.h"
#import "NavRoundRect.h"

@interface NavRoundButtonView : NavButton

//@property (strong, nonatomic) NavRoundRect *roundRect;

@property (strong, nonatomic) NSColor *backgroundColor;
@property (assign, nonatomic) CGFloat cornerRadius;
@property (strong, nonatomic) NSDictionary *titleAttributes;

@end
