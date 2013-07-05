//
//  TMTaskViewController.h
//  TimingMate_v2
//
//  Created by easonfafa on 6/24/13.
//  Copyright (c) 2013 fafa. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TMTask;

@interface TMTaskViewController : UIViewController
{
    IBOutlet UILabel *listNameLabel;
    IBOutlet UILabel *taskNameLabel;
    
    IBOutlet UILabel *timeLeftLabel;
    
    IBOutlet UIView *timerSubview;
    IBOutlet UILabel *timeLeftTimerLabel;
    IBOutlet UILabel *totalTimeTimerLabel;
    //int plannedTimeInSeconds;
    //int plannedTimeLeftInSeconds;
    int timerCount;
    NSTimer *timer;
    IBOutlet UIButton *pauseButton;
    IBOutlet UIButton *startButton;
    
    IBOutlet UITextField *setHourTextField;
    IBOutlet UITextField *setMinTextField;
    
    IBOutlet UIImageView *victoryImage1;
    IBOutlet UIImageView *victoryImage2;
    IBOutlet UIImageView *victoryImage3;
    
    BOOL moreOptions;
    BOOL timeDetail;
    
}
@property (nonatomic, strong) TMTask *task;

- (IBAction)resetTimer:(id)sender;
- (IBAction)startTimer:(id)sender;

- (IBAction)createTask:(id)sender;
- (IBAction)changeToListView:(id)sender;
- (IBAction)changeToTaskStatusView:(id)sender;
- (IBAction)changeToTimeDetailView:(id)sender;
- (IBAction)finishTask:(id)sender;
- (IBAction)stopTimer:(id)sender;

- (void)updateWithTask:(TMTask *)aTask;
@end
