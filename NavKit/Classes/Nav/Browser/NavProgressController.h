//
//  NavProgressController.h
//  NavKit
//
//  Created by Steve Dekorte on 2/21/14.
//  Copyright (c) 2014 Bitmarkets.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NavProgressController : NSObject

@property (strong, nonatomic) IBOutlet NSProgressIndicator *progress;
@property (assign, nonatomic) NSInteger pushCount;
@property (assign, nonatomic) NSInteger useCount;
@property (assign, nonatomic) NSInteger startUseCount;
@property (strong, nonatomic) NSView *targetView;
@property (assign, nonatomic) CGFloat onscreenX;
@property (assign, atomic) BOOL isAnimating;

@end
