//
//  TMEditTaskViewController.m
//  TimingMate_v2
//
//  Created by easonfafa on 6/27/13.
//  Copyright (c) 2013 fafa. All rights reserved.
//

#import "TMEditTaskViewController.h"
#import "TMTaskViewController.h"
#import "TMListStore.h"
#import "TMListItem.h"
#import "TMTaskStore.h"
#import "TMTask.h"

NSString * const TMListUncategorized = @"Uncategorized";
enum{
    TMHourComponent = 0,
    TMMinuteComponent = 1
};

@implementation TMEditTaskViewController

@synthesize task;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated
{
    [self initializeListPickerWithString:TMListUncategorized];
    [self initializeTimePicker];

}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [taskNameTextField becomeFirstResponder];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Event Handler
- (IBAction)cancelTask:(id)sender{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)doneTask:(id)sender{
    if ([taskNameTextField.text isEqualToString:@""]) {
        taskNameTextField.placeholder = @"Please enter a task name";
        return;
    }
    NSString *taskTitle = taskNameTextField.text;
    TMListItem *list = [[TMListStore sharedStore] listsByTitle:listTitleButton.titleLabel.text];
    double allowedTime = [self getSecondsFromTimePicker];
    TMTask *newTask =[[TMTaskStore sharedStore] createTaskWithTitle:taskTitle list:list allowedTime:allowedTime];
    [[TMListStore sharedStore] addTask:newTask toList:listTitleButton.titleLabel.text];
    [self dismissViewControllerAnimated:YES completion:NULL];
    /*TMTaskViewController *tmtvc = [[TMTaskViewController alloc] init];
    [self presentViewController:tmtvc animated:NO completion:NULL];*/
}

- (IBAction)showListPicker:(id)sender
{
    [self showPicker:listPickerView];
}

- (IBAction)showTimePicker:(id)sender
{
    [self showPicker:timePickerView];
}

#pragma mark - Helper Functions
- (NSString *)makeTimeStringFromHours:(int)hours Minutes:(int) minutes
{
    NSMutableString *timeStr = [NSMutableString string];
    if (hours != 0)
        [timeStr appendString:[NSString stringWithFormat:@"%d hr ", hours]];
    
    [timeStr appendString:[NSString stringWithFormat:@"%d min ", minutes]];
    
    return timeStr;
}
- (double)getSecondsFromTimePicker
{
    return selectedHourRow*3600.0 + selectedMinuteRow*60.0;
}

#pragma mark - Picker Functions
- (void)showPicker:(UIPickerView *)picker
{
    if (!actionSheet)
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                  delegate:nil
                                         cancelButtonTitle:nil
                                    destructiveButtonTitle:nil
                                         otherButtonTitles:nil];
    
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    [actionSheet addSubview:picker];
    
    UISegmentedControl *doneButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Done"]];
    doneButton.momentary = YES;
    doneButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
    doneButton.segmentedControlStyle = UISegmentedControlStyleBar;
    doneButton.tintColor = [UIColor blackColor];
    [doneButton addTarget:self action:@selector(dismissActionSheet:) forControlEvents:UIControlEventValueChanged];
    [actionSheet addSubview:doneButton];
    
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    
    [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
}

- (void)dismissActionSheet:(id)sender
{
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView == listPickerView)
        return 1;
    else // pickerView == timePickerView
        return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == listPickerView)
        return pickerArray.count;
    else { // pickerView == timePickerView
        if (component == TMHourComponent)
            return 100;
        else // component == TMMinuteComponent
            return 60;
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == listPickerView)
        [listTitleButton setTitle:[pickerArray objectAtIndex:row] forState:UIControlStateNormal];
    else { // pickerView == timePickerView
        if (component == TMHourComponent)
            selectedHourRow = row;
        else // component == TMMinuteComponent
            selectedMinuteRow = row;
        [allowedTimeButton setTitle:[self makeTimeStringFromHours:selectedHourRow Minutes:selectedMinuteRow] forState:UIControlStateNormal];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == listPickerView)
        return [pickerArray objectAtIndex:row];
    else // pickerView == timePickerView
        return [self timePickerStringFromRow:row forComoonent:component];
}

- (NSString *)timePickerStringFromRow:(NSInteger)row forComoonent:(NSInteger)component
{
    if (component == TMHourComponent)
        return [NSString stringWithFormat:@"%d hr", row];
    else // component == TMMinuteComponent
        return [NSString stringWithFormat:@"%d min", row];
}

- (void)initializeListPickerWithString:(NSString *)s
{
    if (!listPickerView) {
        CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
        listPickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
        
        pickerArray = [NSMutableArray array];
        [pickerArray addObject:TMListUncategorized];
        
        NSArray *allLists = [[TMListStore sharedStore] returnAllLists];
        for (TMListItem *list in allLists) {
            [pickerArray addObject:list.title];
        }
        
        listPickerView.showsSelectionIndicator = YES;
        listPickerView.dataSource = self;
        listPickerView.delegate = self;
    }
    
    NSInteger row = 0;
    if (s == TMListUncategorized) {
        row = 0;
    }else{
        row = 1;
    }
    /*
    else {
        NSInteger idx = [[TMListStore sharedStore] indexOfSeriesByTitle:s];
        if (idx >= 0)
            row = TMDefaultSeriesEnd + idx;
    }
    */
    [listPickerView selectRow:row inComponent:0 animated:NO];
}

- (void)initializeTimePicker
{
    if (!timePickerView) {
        CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
        timePickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
        
        timePickerView.showsSelectionIndicator = YES;
        timePickerView.dataSource = self;
        timePickerView.delegate = self;
    }
    
    //selectedMinuteRow = task.expectedTimeMinutes;
    //selectedHourRow = task.expectedTimeHours;
    [timePickerView selectRow:30 inComponent:TMMinuteComponent animated:NO];
    [timePickerView selectRow:10 inComponent:TMHourComponent animated:NO];
}

#pragma mark - TextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //if [[TMTaskStore sharedStore] tasksByListTitle:addField.text] != nil]]
    //[self showIdenticalTitleWarning];
    //return NO;
    if (textField == taskNameTextField){
        [textField resignFirstResponder];
        return YES;
    }
    return NO;
}

/*
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self addLists:addField.text];
        [listTableView reloadData];
    } //else if (textField == editField) {
    //if (self.isEditing)
    //  [self endCellEdit];
    //}
}
*/
@end
