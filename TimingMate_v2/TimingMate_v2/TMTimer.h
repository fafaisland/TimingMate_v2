//
//  TMTimer.h
//  TimingMate_v2
//
//  Created by easonfafa on 6/30/13.
//  Copyright (c) 2013 fafa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMTimer : NSObject
{
    NSTimer *timer;
}
+ (TMTimer *)timer;
@end
