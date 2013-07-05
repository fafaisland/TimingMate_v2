//
//  TMListItem.h
//  TimingMate_v2
//
//  Created by easonfafa on 6/27/13.
//  Copyright (c) 2013 fafa. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TMTask;

@interface TMListItem : NSObject <NSCoding>

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSMutableSet *tasks;

//+ (id)randomList;
- (id)initWithTitle:(NSString *)listTitle;
- (void)addTask:(TMTask *)task;
@end
