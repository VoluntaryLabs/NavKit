//
//  restart.m
//  NavKit
//
//  Created by Steve Dekorte on 12/8/14.
//  Copyright (c) 2014 voluntary.net. All rights reserved.

#import <Cocoa/Cocoa.h>

void waitForProccessToDie(pid_t pid)
{
    ProcessSerialNumber processSerialNumber;
    
    while (GetProcessForPID(pid, &processSerialNumber) != procNotFound)
    {
        sleep(1);
    }
}

int main(int argc, char *argv[])
{
	waitForProccessToDie((pid_t)atoi(argv[2]));

	NSString *exePath = [NSString stringWithCString:argv[1]
                                           encoding:NSUTF8StringEncoding];
    
    [NSWorkspace.sharedWorkspace
        openFile:[exePath stringByExpandingTildeInPath]];

	return 0;
}
