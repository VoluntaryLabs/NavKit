//
//  NavInfoNode.m
//  Bitmessage
//
//  Created by Steve Dekorte on 4/17/14.
//  Copyright (c) 2014 Bitmarkets.org. All rights reserved.
//

#import "NavInfoNode.h"

@implementation NavInfoNode

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.nodeSuggestedWidth = 300;
    }
    
    return self;
}

- (NSView *)nodeView
{
    NSView *view = [super nodeView];
    return view;
}

- (NSString *)nodeNote
{
    if (!_nodeNote)
    {
        return [super nodeNote];
    }
    
    return _nodeNote;
}

- (void)composeChildrenFromPropertyNames:(NSArray *)names
{
    NSMutableArray *children = [NSMutableArray array];
    
    for (NSString *name in names)
    {
        SEL sel = NSSelectorFromString(name);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        NSObject *value = [self performSelector:sel withObject:nil];
#pragma clang diagnostic pop
        NavInfoNode *childNode = [[NavInfoNode alloc] init];
        childNode.nodeTitle = name.capitalizedString;
        childNode.nodeSubtitle = value.description;
        [children addObject:childNode];
    }
    
    [self setChildren:children];
}

@end
