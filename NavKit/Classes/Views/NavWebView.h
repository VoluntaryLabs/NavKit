//
//  NavWebView.h
//  NavKit
//
//  Created by Steve Dekorte on 12/13/14.
//  Copyright (c) 2014 voluntary.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <NavKit/NavKit.h>
#import <WebKit/WebKit.h>

@interface NavWebView : NavColoredView

@property (assign, nonatomic) id navView;
@property (strong, nonatomic) NavNode *node; // node keeps a ref to us?

//@property (strong, nonatomic) NSScrollView *scrollView;
@property (strong, nonatomic) WebView *webView;
@property (assign, nonatomic) CGFloat leftMargin;

@end
