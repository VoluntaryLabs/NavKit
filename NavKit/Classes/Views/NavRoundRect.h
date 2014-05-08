//
//  NavRoundRect.h
//  NavKit
//
//  Created by Steve Dekorte on 3/30/14.
//  Copyright (c) 2014 Bitmarkets.org. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NavRoundRect : NSObject

@property (assign, nonatomic) NSRect frame;

@property (strong, nonatomic) NSColor *backgroundColor;
@property (assign, nonatomic) CGFloat cornerRadius;

@property (assign, nonatomic) BOOL isOutlined;
@property (assign, nonatomic) CGFloat outlineWidth;
@property (strong, nonatomic) NSColor *outlineColor;

- (void)setSize:(NSSize)aSize;

- (void)draw;

@end
