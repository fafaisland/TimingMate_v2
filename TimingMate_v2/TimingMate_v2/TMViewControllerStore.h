//
//  TMViewControllerStore.h
//  TimingMate_v2
//
//  Created by easonfafa on 6/29/13.
//  Copyright (c) 2013 fafa. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TMTaskViewController, TMListViewController, DDMenuController,TMTaskStatusViewController, TMTimeDetailViewController;

@interface TMViewControllerStore : NSObject
{
    TMTaskViewController *tmtvc;
    DDMenuController *menuController;
    TMListViewController *tmlvc;
    TMTaskStatusViewController *tmtsvc;
    TMTimeDetailViewController *tmtdvc;
    
}
+ (TMViewControllerStore *)sharedStore;
- (TMTaskViewController *)returnTMtvc;
- (TMListViewController *)returnTMlvc;
- (DDMenuController *)returnMenuController;
- (TMTaskStatusViewController *)returnTaskStatusController;
- (TMTimeDetailViewController *)returnTimeDetailController;
@end
