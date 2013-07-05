//
//  TMListStore.m
//  TimingMate_v2
//
//  Created by easonfafa on 6/27/13.
//  Copyright (c) 2013 fafa. All rights reserved.
//

#import "TMListStore.h"
#import "TMListItem.h"
#import "TMTaskStore.h"
#import "TMtask.h"

@implementation TMListStore
- (id)init
{
    self = [super init];
    if (self){
        NSString *path = [self listArchivePath];
        allLists = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        if(!allLists)
        {
            allLists = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

- (NSArray *)returnAllLists
{
    return allLists;
}
#pragma mark - helper
- (TMListItem *)createListWithTitle:(NSString *)title
{
    TMListItem *l = [[TMListItem alloc] initWithTitle:title];
    [allLists addObject:l];
    return l;
}
- (TMListItem *)listsByTitle:(NSString *)title
{
    for (TMListItem *list in allLists){
        if ([list.title localizedCompare:title] == NSOrderedSame){
            return list;
        }
    }
    return nil;
}
- (void)addTask:(TMTask *)task toList:(NSString *)listName
{
    TMListItem *l = [self listsByTitle:listName];
    [l addTask:task];
    for (TMTask *t in l.tasks){
        NSLog(@"tasks in list: %@",t.title);
    }
    [self saveChanges];
}

- (NSMutableArray *)getAllTasksFromList:(NSString *)listName
{
    TMListItem *l = [self listsByTitle:listName];
    NSMutableArray *tasks = [[NSMutableArray alloc] init];
    for (TMTask *t in l.tasks)
    {
        [tasks addObject:t];
    }
    NSLog(@"tasks' count: %d",[tasks count]);
    return tasks;
}

#pragma Archiving Functions
- (NSString *)listArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"lists.archive"];
}

- (BOOL)saveChanges
{
    NSString *path = [self listArchivePath];
    return [NSKeyedArchiver archiveRootObject:allLists toFile:path];
}
#pragma static functions
+ (TMListStore *)sharedStore{
    static TMListStore *sharedStore = nil;
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
