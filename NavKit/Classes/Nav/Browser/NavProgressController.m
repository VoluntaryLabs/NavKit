//
//  NavProgressController.m
//  NavKit
//
//  Created by Steve Dekorte on 2/21/14.
//  Copyright (c) 2014 voluntary.net. All rights reserved.
//

#import "NavProgressController.h"
#import <NavKit/NavKit.h>

@implementation NavProgressController

- (id)init
{
    self = [super init];
    [self listen];
    return self;
}

- (void)listen
{
    // eventually switch to holding a list of object/action/count we are waiting on?
    
    [NSNotificationCenter.defaultCenter addObserver:self
                                             selector:@selector(progressPush:)
                                                 name:ProgressPushNotification
                                               object:nil];
    
    [NSNotificationCenter.defaultCenter addObserver:self
                                             selector:@selector(progressPop:)
                                                 name:ProgressPopNotification
                                               object:nil];
}

- (void)dealloc
{
    // terminate the animation thread
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)progressPush:(NSNotification *)note
{
    self.pushCount ++;
    //NSLog(@"push %i", (int)self.pushCount);
    [self update];
}

- (void)progressPop:(NSNotification *)note
{
    if (self.pushCount > 0)
    {
        self.pushCount --;
        //NSLog(@"pop %i", (int)self.pushCount);
        [self update];
    }
}

- (void)setProgress:(NSProgressIndicator *)progress
{
    _progress = progress;
    
    [_progress setIndeterminate:YES];
    [_progress setStyle:NSProgressIndicatorSpinningStyle];
    [_progress setUsesThreadedAnimation:NO];
    [_progress setBezeled:NO];
    [_progress setDisplayedWhenStopped:YES];
    [_progress setHidden:YES];
    //[_progressIndicator setHidden:NO];
    //[_progressIndicator startAnimation:nil];
    
    //[self.progress setDisplayedWhenStopped:NO];
    //[self.progress startAnimation:nil];
}

- (void)update
{
    /*
    if (self.pushCount && !threadIsRunning)
    {
        [self performSelectorInBackground:@selector(updateFromAnimationThread)
                               withObject:nil];

    }
    */
    
    /*
    BOOL hide = self.pushCount == 0;
    [self.progress setHidden:hide];
    [self.progress setNeedsDisplay:YES];
    [self.progress.window display];
     */
}

static BOOL threadIsRunning = NO;

- (void)updateFromAnimationThread
{
    NSInteger fps = 30;
    NSInteger timeoutPeriod = fps/2;
    NSInteger timeout = timeoutPeriod;
    NSInteger timein = timeoutPeriod;

    [NSThread setThreadPriority:0.0];

    if (threadIsRunning)
    {
        return;
    }
    
    threadIsRunning = YES;
    
    [_progress setHidden:NO];
    
    while (timein > 0)
    {
        [NSThread sleepForTimeInterval:1.0/30.0];
        timein --;
    }

    while (self.pushCount && timeout > 0)
    {
        _progress.frameCenterRotation = _progress.frameCenterRotation - 360.0/16.0;
        [_progress setNeedsDisplay:YES];
        [_progress.window display];

        [NSThread sleepForTimeInterval:1.0/30.0];
        
        if (!self.pushCount)
        {
            timeout --;
        }
        else
        {
            timeout = timeoutPeriod;
        }
    }
    
    [_progress setHidden:YES];
    threadIsRunning = NO;
}

/*
 - (void)updateFromAnimationThread
 {
 static BOOL isRunning = NO;
 
 while (YES)
 {
 if (self.pushCount)
 {
 _progress.frameCenterRotation = _progress.frameCenterRotation - 360.0/16.0;
 [_progress setNeedsDisplay:YES];
 [_progress.window display];
 }
 
 [_progress setHidden:self.pushCount == 0];
 
 [NSThread sleepForTimeInterval:1.0/30.0];
 [NSThread setThreadPriority:0.0];
 }
 }
*/


@end
