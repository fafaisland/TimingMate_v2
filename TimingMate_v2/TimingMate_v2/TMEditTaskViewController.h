//
//  TMEditTaskViewController.h
//  TimingMate_v2
//
//  Created by easonfafa on 6/27/13.
//  Copyright (c) 2013 fafa. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TMTask;

@interface TMEditTaskViewController : UIViewController
{
    IBOutlet UITextField *taskNameTextField;
    IBOutlet UIButton *listTitleButton;
    IBOutlet UIButton *allowedTimeButton;
    
    UIActionSheet *actionSheet;
    UIPickerView *listPickerView;
    UIPickerView *timePickerView;
    NSMutableArray *pickerArray;
    
    NSInteger selectedHourRow;
    NSInteger selectedMinuteRow;
}
@property (nonatomic, strong) TMTask *task;

- (IBAction)cancelTask:(id)sender;
- (IBAction)doneTask:(id)sender;

- (IBAction)showListPicker:(id)sender;
- (IBAction)showTimePicker:(id)sender;

- (NSString *)makeTimeStringFromHours:(int)hours Minutes:(int) minutes;
@end
