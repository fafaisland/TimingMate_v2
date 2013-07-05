//
//  TMTask.m
//  TimingMate_v2
//
//  Created by easonfafa on 6/28/13.
//  Copyright (c) 2013 fafa. All rights reserved.
//

#import "TMTask.h"
#import "TMListItem.h"

@implementation TMTask
@synthesize title;
@synthesize list;
@synthesize allowedCompletionTime;
@synthesize totalUsedTime;
@synthesize creationTime;

- (id)initWithTitle:(NSString *)taskTitle list:(TMListItem *)list allowedTime:(double)allowedTime
{
    self = [super init];
    if (self){
        self.title = taskTitle;
        self.list = list;
        self.allowedCompletionTime =allowedTime;
        self.totalUsedTime = 0.0;
        self.creationTime = [NSDate date];
    }
    NSLog(@"New Task Created, Task name: %@",taskTitle);
    return self;
}
#pragma archiving NSCode functions
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:title forKey:@"title"];
    [aCoder encodeObject:list forKey:@"list"];
    [aCoder encodeDouble:allowedCompletionTime forKey:@"allowedCompletionTime"];
    [aCoder encodeDouble:totalUsedTime forKey:@"totalUsedTime"];
    [aCoder encodeObject:creationTime forKey:@"creattionTime"];
    NSLog(@"aCoder encoded title: %@ list: %@",title,list.title);
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self){
        [self setTitle:[aDecoder decodeObjectForKey:@"title"]];
        [self setList:[aDecoder decodeObjectForKey:@"list"]];
        [self setAllowedCompletionTime:[aDecoder decodeDoubleForKey:@"allowedCompletionTime"]];
        [self setTotalUsedTime:[aDecoder decodeDoubleForKey:@"totalUsedTime"]];
        [self setCreationTime:[aDecoder decodeObjectForKey:@"creationTime"]];
    }
    return self;
}

@end
