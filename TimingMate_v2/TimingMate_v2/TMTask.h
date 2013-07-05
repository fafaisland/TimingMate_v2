//
//  TMTask.h
//  TimingMate_v2
//
//  Created by easonfafa on 6/28/13.
//  Copyright (c) 2013 fafa. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TMListItem;

@interface TMTask : NSObject <NSCoding>

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) TMListItem *list;
@property (nonatomic) double allowedCompletionTime;
@property (nonatomic) double totalUsedTime;
@property (nonatomic, retain) NSDate * creationTime;

- (id)initWithTitle:(NSString *)taskTitle list:(TMListItem *)list allowedTime:(double)allowedTime;
@end
