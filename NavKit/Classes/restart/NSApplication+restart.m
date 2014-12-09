//
//  NSApplication+extra.m
//  NavKit
//
//  Created by Steve Dekorte on 12/8/14.
//  Copyright (c) 2014 voluntary.net. All rights reserved.
//

#import "NSApplication+restart.h"
#import "NavMirrorView.h"

@implementation NSApplication (restart)

- (void)restart
{
    NSProcessInfo *info = [NSProcessInfo processInfo];
    NSString *processId = [NSString stringWithFormat:@"%i", [info processIdentifier]];
    NSString *appPath = [info arguments].firstObject;
    
    NSBundle *bundle = [NSBundle bundleForClass:NavMirrorView.class];
    NSString *restartScriptPath = [bundle pathForResource:@"restart" ofType:nil]; // hack
    
    NSTask *restartTask = [[NSTask alloc] init];
    [restartTask setLaunchPath:restartScriptPath];
    [restartTask setArguments:@[processId]];
    [restartTask launch];
    
    [self terminate:self];
}

@end
