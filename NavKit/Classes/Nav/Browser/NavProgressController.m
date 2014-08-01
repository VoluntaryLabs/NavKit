//
//  NavProgressController.m
//  NavKit
//
//  Created by Steve Dekorte on 2/21/14.
//  Copyright (c) 2014 Bitmarkets.org. All rights reserved.
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(progressPush:)
                                                 name:@"ProgressPush"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(progressPop:)
                                                 name:@"ProgressPop"
                                               object:nil];
    
    [self performSelectorInBackground:@selector(updateFromAnimationThread)
                           withObject:nil];
}

- (void)dealloc
{
    // terminate the animation thread
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    //[_progressIndicator setHidden:NO];
    //[_progressIndicator startAnimation:nil];
    
    //[self.progress setDisplayedWhenStopped:NO];
    //[self.progress startAnimation:nil];
    _onscreenX = _progress.x;
}

- (void)update
{
    /*
    if (self.pushCount)
    {
        [self incrementAnimation];
        
        if (!self.isAnimating)
        {
            self.isAnimating = YES;

        }
    }
    */
}

- (void)updateFromAnimationThread
{
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


@end
