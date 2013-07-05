//
//  TMViewControllerStore.m
//  TimingMate_v2
//
//  Created by easonfafa on 6/29/13.
//  Copyright (c) 2013 fafa. All rights reserved.
//

#import "TMViewControllerStore.h"
#import "TMTaskViewController.h"
#import "TMListViewController.h"
#import "DDMenuController.h"
#import "TMTaskStatusViewController.h"
#import "TMTimeDetailViewController.h"

@implementation TMViewControllerStore
- (id)init
{
    self = [super init];
    if (self){
        if (!tmtvc){
            tmtvc = [[TMTaskViewController alloc] init];
        }
        if (!menuController){
            menuController = [[DDMenuController alloc] initWithRootViewController:tmtvc];
        }
        if (!tmlvc){
            tmlvc = [[TMListViewController alloc] init];
        }
        if (!tmtsvc){
            tmtsvc = [[TMTaskStatusViewController alloc] init];
        }
        if (!tmtdvc){
            tmtdvc = [[TMTimeDetailViewController alloc] init];
        }
        menuController.leftViewController = tmlvc;
    }
    return self;
}
- (TMTaskViewController *)returnTMtvc
{
    return tmtvc;
}
- (TMListViewController *)returnTMlvc
{
    return tmlvc;
}
- (DDMenuController *)returnMenuController
{
    return menuController;
}
- (TMTaskStatusViewController *)returnTaskStatusController
{
    return tmtsvc;
}
- (TMTimeDetailViewController *)returnTimeDetailController
{
    return tmtdvc;
}
#pragma mark - static functions
+ (TMViewControllerStore *)sharedStore{
    static TMViewControllerStore *sharedStore = nil;
    if (nil == sharedStore){
        sharedStore = [[super allocWithZone:nil] init];
    
    }
    return sharedStore;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}
@end
