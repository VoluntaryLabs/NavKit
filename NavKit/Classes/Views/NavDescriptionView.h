//
//  NavDescriptionView.h
//  NavKit
//
//  Created by Steve Dekorte on 6/4/14.
//  Copyright (c) 2014 voluntary.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NavView.h"
#import "NavTextView.h"
#import <NavNodeKit/NavNodeKit.h>

@protocol NavDescriptionViewProtocol <NSObject>
- (id)descriptionJSONObject;
@end

@interface NavDescriptionView : NSView

@property (assign, nonatomic) NavView *navView;
@property (assign, nonatomic) NavNode *node;

@property (strong, nonatomic) NavTextView *textView;

@end
