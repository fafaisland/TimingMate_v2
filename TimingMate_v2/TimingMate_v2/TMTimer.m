//
//  TMTimer.m
//  TimingMate_v2
//
//  Created by easonfafa on 6/30/13.
//  Copyright (c) 2013 fafa. All rights reserved.
//

#import "TMTimer.h"

@implementation TMTimer


#pragma mark - static functions
+ (TMTimer *)timer
{
    static TMTimer *timer = nil;
    if (!timer) {
        timer = [[super allocWithZone:nil] init];
    }
    return timer;
}
+ (id)allocWithZone:(NSZone *)zone
{
    return [self timer];
}

@end
