//
//  NavRoundButtonView.h
//  Bitmessage
//
//  Created by Steve Dekorte on 3/30/14.
//  Copyright (c) 2014 Bitmarkets.org. All rights reserved.
//

#import "NavButton.h"

@interface NavRoundButtonView : NavButton

@property (strong, nonatomic) NSColor *backgroundColor;
@property (assign, nonatomic) CGFloat cornerRadius;
@property (strong, nonatomic) NSDictionary *titleAttributes;

@end
