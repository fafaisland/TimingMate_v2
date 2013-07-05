//
//  TMTaskStore.h
//  TimingMate_v2
//
//  Created by easonfafa on 6/28/13.
//  Copyright (c) 2013 fafa. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TMTask;
@class TMListItem;

@interface TMTaskStore:NSObject
{
    NSMutableArray *allTasks;
}

+ (TMTaskStore *)sharedStore;
- (NSArray *)returnAllTasks;
- (TMTask *)createTaskWithTitle:(NSString *)taskTitle list:(TMListItem *)list allowedTime:(double)allowedTime;
- (NSString *)taskArchivePath;
- (BOOL)saveChanges;
@end
