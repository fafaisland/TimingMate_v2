//
//  TMListStore.h
//  TimingMate_v2
//
//  Created by easonfafa on 6/27/13.
//  Copyright (c) 2013 fafa. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TMListItem;
@class TMTask;

@interface TMListStore : NSObject
{
    NSMutableArray *allLists;
}
+ (TMListStore *)sharedStore;
- (NSArray *)returnAllLists;
- (TMListItem *)createItem;
- (BOOL)saveChanges;
- (NSString *)listArchivePath;
- (TMListItem *)createListWithTitle:(NSString *)title;
- (TMListItem *)listsByTitle:(NSString *)title;
- (void)addTask:(TMTask *)task toList:(NSString *)listName;
- (NSMutableArray *)getAllTasksFromList:(NSString *)listName;
@end
