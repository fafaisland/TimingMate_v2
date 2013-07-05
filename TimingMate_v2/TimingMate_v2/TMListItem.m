//
//  TMListItem.m
//  TimingMate_v2
//
//  Created by easonfafa on 6/27/13.
//  Copyright (c) 2013 fafa. All rights reserved.
//

#import "TMListItem.h"
#import "TMTask.h"
@implementation TMListItem

@synthesize title;
@synthesize tasks;

- (id)initWithTitle:(NSString *)listTitle
{
    self = [super init];
    if (self){
        self.title = listTitle;
        tasks = [[NSMutableSet alloc] init];
    }
    return self;
}
- (void)addTask:(TMTask *)task
{
    [tasks addObject:task];
    NSLog(@"Add task %@ to list %@",task.title,title);
}
#pragma archiving NSCode functions
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:title forKey:@"title"];
    [aCoder encodeObject:tasks forKey:@"tasks"];
    NSLog(@"list aCoder encoded: %@",title);
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self){
        [self setTitle:[aDecoder decodeObjectForKey:@"title"]];
        [self setTasks:[aDecoder decodeObjectForKey:@"tasks"]];
    }
    return self;
}

#pragma static functions
/*
+ (id)randomList{
    TMListItem *newList = [[self alloc] initWithTitle:@"Random List"];
    return newList;
}
 */
@end
