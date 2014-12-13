//
//  NavResourceView.h
//  Bitmarket
//
//  Created by Steve Dekorte on 2/5/14.
//  Copyright (c) 2014 voluntary.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <NavKit/NavKit.h>

@interface NavResourceView : NavColoredView //<NSTextViewDelegate>

@property (assign, nonatomic) id navView;
@property (strong, nonatomic) NavNode * node; // node keeps a ref to us?

@property (strong, nonatomic) NSScrollView *scrollView;
@property (strong, nonatomic) NSTextView *textView;

- (NSString *)selectedContent;

@end
