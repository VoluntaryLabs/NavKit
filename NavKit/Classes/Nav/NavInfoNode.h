//
//  NavInfoNode.h
//  Bitmessage
//
//  Created by Steve Dekorte on 4/17/14.
//  Copyright (c) 2014 Bitmarkets.org. All rights reserved.
//

#import <NavNodeKit/NavNodeKit.h>

@interface NavInfoNode : NavNode

@property (strong, nonatomic) NSString *nodeTitle;
@property (strong, nonatomic) NSString *nodeSubtitle;
@property (strong, nonatomic) NSString *nodeNote;
@property (assign, nonatomic) CGFloat nodeSuggestedWidth;

@end
