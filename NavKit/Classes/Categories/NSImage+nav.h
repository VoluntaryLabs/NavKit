//
//  NSImage+nav.h
//  NavKit
//
//  Created by Steve Dekorte on 5/20/14.
//  Copyright (c) 2014 voluntary.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSImage (nav)

- (NSData *)jpegImageData;
- (NSData *)jpegImageDataUnderKb:(NSUInteger)maxKb;

@end
