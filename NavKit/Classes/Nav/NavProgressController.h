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
@property (assign, nonatomic) NSInteger progressCount;
@property (assign, nonatomic) NSInteger useCount;
@property (assign, nonatomic) NSInteger startUseCount;

@end
