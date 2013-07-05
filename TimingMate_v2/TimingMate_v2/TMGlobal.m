//
//  TMGlobal.m
//  TimingMate_v2
//
//  Created by easonfafa on 6/29/13.
//  Copyright (c) 2013 fafa. All rights reserved.
//

#import "TMGlobal.h"

NSString * TMTimerStringFromSeconds(int seconds)
{
    int hours = seconds / 3600;
    int secondsLeft = seconds % 3600;
    
    int minutes = secondsLeft / 60;
    secondsLeft = secondsLeft % 60;
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, secondsLeft];
}