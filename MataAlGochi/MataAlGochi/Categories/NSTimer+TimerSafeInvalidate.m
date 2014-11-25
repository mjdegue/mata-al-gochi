//
//  NSTimer+TimerSafeInvalidate.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/25/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "NSTimer+TimerSafeInvalidate.h"

@implementation NSTimer (NSTimerSafeInvalidate)

- (void) safeInvalidate
{
    if([self isValid])
    {
        [self invalidate];
    }
}

@end
