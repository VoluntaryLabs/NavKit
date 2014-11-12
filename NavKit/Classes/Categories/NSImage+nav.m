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
    
    while (data.length/1024 > maxKb && (size.height * size.width > 1))
    {
        size.width *= .75;
        size.height *= .75;
        
        image = self.copy;
        image.size = size;
        data = image.jpegImageData;
    }
    
    return data;
}


- (NSData *)jpegImageData
{
    NSImage *image = self;
    
    if (!image)
    {
        return nil;
    }
    
    
    NSImageRep *imageRep = [image bitmapImageRepresentation];
    
    //NSRect frame = NSMakeRect(0, 0, image.size.width, image.size.height);
    NSImage *targetImage = [[NSImage alloc] initWithSize:image.size];
    
    [targetImage lockFocus];
    [imageRep drawInRect:NSMakeRect(0, 0, image.size.width, image.size.height)];
    [targetImage unlockFocus];
    
    imageRep = [targetImage bitmapImageRepresentation];
    
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

- (NSBitmapImageRep *)bitmapImageRepresentation
{
    NSBitmapImageRep *ret = (NSBitmapImageRep *)[self representations];
    
    if(![ret isKindOfClass:[NSBitmapImageRep class]])
    {
        ret = nil;
        for(NSBitmapImageRep *rep in [self representations])
            if([rep isKindOfClass:[NSBitmapImageRep class]])
            {
                ret = rep;
                break;
            }
    }
    
    if(ret == nil)
    {
        NSSize size = [self size];
        
        size_t width         = size.width;
        size_t height        = size.height;
        size_t bitsPerComp   = 32;
        size_t bytesPerPixel = (bitsPerComp / CHAR_BIT) * 4;
        size_t bytesPerRow   = bytesPerPixel * width;
        size_t totalBytes    = height * bytesPerRow;
        
        NSMutableData *data = [NSMutableData dataWithBytesNoCopy:calloc(totalBytes, 1) length:totalBytes freeWhenDone:YES];
        
        CGColorSpaceRef space = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
        
        CGContextRef ctx = CGBitmapContextCreate([data mutableBytes], width, height, bitsPerComp, bytesPerRow, CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB), kCGBitmapFloatComponents | kCGImageAlphaPremultipliedLast);
        
        if(ctx != NULL)
        {
            [NSGraphicsContext saveGraphicsState];
            [NSGraphicsContext setCurrentContext:[NSGraphicsContext graphicsContextWithGraphicsPort:ctx flipped:[self isFlipped]]];
            
            [self drawAtPoint:NSZeroPoint fromRect:NSZeroRect operation:NSCompositeCopy fraction:1.0];
            
            [NSGraphicsContext restoreGraphicsState];
            
            CGImageRef img = CGBitmapContextCreateImage(ctx);
            
            ret = [[NSBitmapImageRep alloc] initWithCGImage:img];
            [self addRepresentation:ret];
            
            CFRelease(img);
            CFRelease(space);
            
            CGContextRelease(ctx);
        }
    }
    
    
    return ret;
}

@end
