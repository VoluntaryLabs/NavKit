//
//  NavProgressController.h
//  NavKit
//
//  Created by Steve Dekorte on 2/21/14.
//  Copyright (c) 2014 voluntary.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NavProgressController : NSObject

@property (strong, nonatomic) IBOutlet NSProgressIndicator *progress;
@property (assign, nonatomic) NSInteger pushCount;
@property (strong, nonatomic) NSView *targetView;

@end
