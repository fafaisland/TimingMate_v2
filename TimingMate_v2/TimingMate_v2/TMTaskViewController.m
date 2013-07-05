//
//  TMTaskViewController.m
//  TimingMate_v2
//
//  Created by easonfafa on 6/24/13.
//  Copyright (c) 2013 fafa. All rights reserved.
//

#import "TMTaskViewController.h"
#import "TMEditTaskViewController.h"
#import "TMViewControllerStore.h"
#import "DDMenuController.h"
#import "TMtask.h"
#import "TMListItem.h"
#import "TMViewControllerStore.h"
#import "TMTaskStatusViewController.h"
#import "TMTimeDetailViewController.h"
#import "TMGlobal.h"
#import "TMTimer.h"

@implementation TMTaskViewController
@synthesize task;
- (id)init{
    self = [super init];
    if (self){
        moreOptions = false;
        timeDetail = false;
        timerCount = 0;
        timer = [[NSTimer alloc] init];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    setHourTextField.delegate = self;
    setMinTextField.delegate = self;
    
}
#pragma mark - helper
- (void)updateWithTask:(TMTask *)aTask
{
    task = aTask;
    listNameLabel.text = task.list.title;
    taskNameLabel.text = task.title;
    
}
#pragma mark - Event Handler
- (IBAction)changeToListView:(id)sender
{
    [[[TMViewControllerStore sharedStore] returnMenuController] showLeftController:YES];
}
- (IBAction)resetTimer:(id)sender{
    setHourTextField.text = @"";
    setMinTextField.text = @"";
    [timerSubview removeFromSuperview];
    timerCount = 0;
}

- (IBAction)startTimer:(id)sender{
     timerSubview.frame = CGRectMake(0,278,320,100);
    [self.view addSubview:timerSubview];
    totalTimeTimerLabel.text = [NSString stringWithFormat:@"%@ Hour %@ Min",setHourTextField.text,setMinTextField.text];
    [self createTimer];
    
    pauseButton.frame = startButton.frame;
    [startButton setHidden:YES];
    [self.view addSubview:pauseButton];
}

- (IBAction)stopTimer
{
    [timer invalidate];
    timer = nil;
    [pauseButton removeFromSuperview];
    [startButton setHidden:NO];
}

- (IBAction)createTask:(id)sender{
    TMEditTaskViewController *createTaskViewController = [[TMEditTaskViewController alloc] init];
    [self presentViewController:createTaskViewController animated:YES completion:NULL];
}
- (IBAction)changeToTaskStatusView:(id)sender
{
    TMTaskStatusViewController *tmtsvc = [[TMViewControllerStore sharedStore] returnTaskStatusController];
    
    if (!moreOptions){
        tmtsvc.view.frame = CGRectMake(150, 64, 164, 30);
        [self addChildViewController:tmtsvc];
        [self.view addSubview:tmtsvc.view];
        moreOptions = true;
    }else{
        [tmtsvc willMoveToParentViewController:nil];
        [tmtsvc.view removeFromSuperview];
        [tmtsvc removeFromParentViewController];
        moreOptions = false;
    }
}

- (IBAction)changeToTimeDetailView:(id)sender
{
    TMTimeDetailViewController *timeDetailViewController = [[TMViewControllerStore sharedStore] returnTimeDetailController];
    if (!timeDetail){
    
        timeDetailViewController.view.frame = CGRectMake(0, 160, 260, 120);
        [self addChildViewController:timeDetailViewController];
        [self.view addSubview:timeDetailViewController.view];
        timeDetail = true;
    }else{
        [timeDetailViewController willMoveToParentViewController:nil];
        [timeDetailViewController.view removeFromSuperview];
        [timeDetailViewController removeFromParentViewController];
        timeDetail = false;
    }
}

- (IBAction)finishTask:(id)sender
{
    [self fallOneFlower:victoryImage1 WithVelocity:4.0 FromX:10 FromY:0 ToX:10];
    [self fallOneFlower:victoryImage2 WithVelocity:3.0 FromX:30 FromY:0 ToX:30];
    [self fallOneFlower:victoryImage3 WithVelocity:3.5 FromX:100 FromY:0 ToX:100];
}

#pragma mark - Timer Methods
- (void)createTimer
{
    if (timer == nil){
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(increaseTimerCount) userInfo:nil repeats:YES];
    }

}
- (void)increaseTimerCount
{
    timerCount += 1;
    [self setLabelFromLeftTime];
}

- (void)setLabelFromLeftTime
{
    [timeLeftTimerLabel setText:TMTimerStringFromSeconds(timerCount)];
    
}

#pragma mark - falling flowers
- (void)fallOneFlower:(UIImageView *)vi WithVelocity:(NSTimeInterval)v FromX:(CGFloat)fx FromY:(CGFloat)fy ToX:(CGFloat)tx
{
    vi.frame = CGRectMake(fx, fy, 28, 24);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:v];
    [self.view addSubview:vi];
    [UIView setAnimationTransition:UIViewAnimationOptionTransitionFlipFromTop forView:vi cache:YES];
    vi.frame = CGRectMake(tx, 568, 28, 24);
    [UIView commitAnimations];
}

#pragma mark - TextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //if [[TMTaskStore sharedStore] tasksByListTitle:addField.text] != nil]]
    //[self showIdenticalTitleWarning];
    //return NO;
    /*if (textField == taskNameTextField){
        [textField resignFirstResponder];
        return YES;
    }
    return NO;*/
    [textField resignFirstResponder];
    return YES;
}

@end
