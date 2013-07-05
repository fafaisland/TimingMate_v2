//
//  TMTaskStore.m
//  TimingMate_v2
//
//  Created by easonfafa on 6/28/13.
//  Copyright (c) 2013 fafa. All rights reserved.
//

#import "TMTaskStore.h"
#import "TMTask.h"
#import "TMListItem.h"

@implementation TMTaskStore
- (id)init
{
    self = [super init];
    if (self){
        NSString *path = [self taskArchivePath];
        allTasks = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        if(!allTasks)
        {
            allTasks = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

- (NSArray *)returnAllTasks{
    return allTasks;
}
- (TMTask *)createTaskWithTitle:(NSString *)taskTitle list:(TMListItem *)list allowedTime:(double)allowedTime
{
    TMTask *t = [[TMTask alloc] initWithTitle:taskTitle list:list allowedTime:allowedTime];
    [allTasks addObject:t];
    [self saveChanges];
    NSLog(@"Created a task with list %@", list.title);
    return t;
}
- (NSString *)taskArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"tasks.archive"];
}
- (BOOL)saveChanges
{
    NSString *path = [self taskArchivePath];
    return [NSKeyedArchiver archiveRootObject:allTasks toFile:path];
}


+ (TMTaskStore *)sharedStore
{
    static TMTaskStore *sharedStore = nil;
    if (!sharedStore){
        sharedStore = [[super allocWithZone:nil] init];
    }
    return sharedStore;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}
@end
