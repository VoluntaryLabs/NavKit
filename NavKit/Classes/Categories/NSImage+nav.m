//
//  NSImage+nav.m
//  NavKit
//
//  Created by Steve Dekorte on 5/20/14.
//  Copyright (c) 2014 voluntary.net. All rights reserved.
//

#import "NSImage+nav.h"

@implementation NSImage (nav)

- (NSData *)jpegImageDataUnderKb:(NSUInteger)maxKb
{
    NSSize size = self.size;
    NSImage *image = self;
    NSData *data = image.jpegImageData;
    
    while (data.length/1024 > maxKb && size.height > 300 && size.width > 600)
    {
        size.width *= .9;
        size.height *= .9;
        
        image = self.copy;
        image.size = size;
        data = image.jpegImageData;
    }
    
    return data;
}


- (NSData *)jpegImageData // yeah, move this to an NSImage category
{
    NSImage *image = self;
    
    if (!image)
    {
        return nil;
    }
    
    NSImageRep *imageRep = [image bestRepresentationForRect:NSMakeRect(0, 0, image.size.width, image.size.height)
                                                    context:nil
                                                      hints:nil];
    
    if (![imageRep isKindOfClass:[NSBitmapImageRep class]])
    {
        /*
         NSRunAlertPanel( @"Non-bitmap image",
         @"Image's representation isn't an NSBitmapImageRep",
         @"Cancel", nil, nil );
         */
        return nil;
    }
    
    NSDictionary *repProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [NSNumber numberWithFloat:0.9], NSImageCompressionFactor,
                                   nil];
    
    NSData *jpegData = [(NSBitmapImageRep*)imageRep
                        representationUsingType:NSJPEGFileType
                        properties:repProperties];
    
    return jpegData;
    
}

@end
