//
//  TMListViewController.h
//  TimingMate_v2
//
//  Created by easonfafa on 6/25/13.
//  Copyright (c) 2013 fafa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMListViewController : UIViewController
<UITextFieldDelegate>
{
    IBOutlet UITableView *listTableView;
    NSMutableArray *listArray;
    
    __weak UITextField *editField;
    __weak UITextField *addField;
    
    NSIndexPath *editingIndexPath;
    
    NSMutableIndexSet *expandedSections;
}

@property (retain) NSIndexPath* selectedIndexPath;
@end
