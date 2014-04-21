//
//  NavInfoNode.h
//  Bitmessage
//
//  Created by Steve Dekorte on 4/17/14.
//  Copyright (c) 2014 Bitmarkets.org. All rights reserved.
//

#import <NavNodeKit/NavNodeKit.h>

@interface NavInfoNode : NavNode

@property (strong) NSString *nodeTitle;
@property (strong) NSString *nodeSubtitle;
@property (strong) NSString *nodeNote;
@property (assign) CGFloat nodeSuggestedWidth;

@end
