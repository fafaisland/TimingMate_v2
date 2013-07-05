//
//  TMListViewController.m
//  TimingMate_v2
//
//  Created by easonfafa on 6/25/13.
//  Copyright (c) 2013 fafa. All rights reserved.
//

#import "TMListViewController.h"
#import "TMListsViewEditableCell.h"
#import "TMListItem.h"
#import "TMListStore.h"
#import "TMTask.h"
#import "TMViewControllerStore.h"
#import "TMTaskViewController.h"
#import "DDMenuController.h"

@interface TMListViewController ()

@end

@implementation TMListViewController
@synthesize selectedIndexPath;

- (id)init{
    self = [super init];
    [listTableView setSeparatorColor:[UIColor orangeColor]];
    [listTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    if(self){}
    return self;
}

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
    UINib *nib = [UINib nibWithNibName:@"TMListsViewEditableCell" bundle:nil];
    [listTableView registerNib:nib
         forCellReuseIdentifier:TMListsViewEditableCellIdentifier];
    if(!expandedSections){
        expandedSections = [[NSMutableIndexSet alloc] init];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.editing = NO;
    [addField setText:@""];
    [addField resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [[[TMListStore sharedStore] returnAllLists] count] + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section >=0 && section < [[[TMListStore sharedStore] returnAllLists] count])

    {
        if ([expandedSections containsIndex:section])
        {
            TMListItem *l = [[[TMListStore sharedStore] returnAllLists] objectAtIndex:section];
            NSInteger count =  [[[TMListStore sharedStore] getAllTasksFromList:l.title] count];
            return count+1;
            // return rows when expanded
        }
        
        return 1; // only top row showing
    }
    
    // Return the number of rows in the section.
    return 1;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier1 = @"CellIdentifier1";
    static NSString *CellIdentifier2 = @"CellIdentifier2";
    /*
    if ([indexPath compare:editingIndexPath] == NSOrderedSame) {
        TMListsViewEditableCell *editableCell = [tableView
                                                 dequeueReusableCellWithIdentifier:TMListsViewEditableCellIdentifier];
        [editField performSelector:@selector(becomeFirstResponder)
                        withObject:nil
                        afterDelay:0.1f];
        return editableCell;
    }
    */
    if (indexPath.section >= 0 && indexPath.section < [[[TMListStore sharedStore] returnAllLists] count]){
        UITableViewCell *cell;
        if (indexPath.row == 0)
        {
            cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier1];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
            }
            
            TMListItem *l = [[[TMListStore sharedStore] returnAllLists] objectAtIndex:indexPath.section];
            // Configure the cell
            //cell.textLabel.text = [listArray objectAtIndex: indexPath.section];
            cell.textLabel.text = l.title;
            cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
            
            //set font background to transparent
            [cell.textLabel setBackgroundColor:[UIColor clearColor]];
            [cell.textLabel setTextColor:[UIColor whiteColor]];
            
            //add UILabel
            //UILabel *subtitle = [[UILabel alloc] initWithFrame:CGRectMake(95.0, 45.0, 200.0, 20.0)];
            //[subtitle setTextColor:[UIColor colorWithHue:1.0 saturation:1.0 brightness:1.0 alpha:0.5]];
            //[subtitle setBackgroundColor:[UIColor clearColor]];
            //[subtitle setFont:[UIFont systemFontOfSize:12.0]];
            //[subtitle setText:@"Add annotation"];
            //[cell addSubview:subtitle];
            
            //set background
            [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellBg.png"]]];
            
            //set right conjunction pic of the cell
            if ([expandedSections containsIndex:indexPath.section])
            {
                cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"moreInfo_22inch.png"]];
            }
            else{
                 cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"moreInfo_22inch.png"]];
            }
        }else
        {
            cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier2];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2];
            }
            TMListItem *l = [[[TMListStore sharedStore] returnAllLists] objectAtIndex:indexPath.section];
            TMTask *t = [[[TMListStore sharedStore] getAllTasksFromList:l.title] objectAtIndex:(indexPath.row -1)];
            cell.textLabel.text = t.title;
            [cell.textLabel setBackgroundColor:[UIColor clearColor]];
            [cell.textLabel setTextColor:[UIColor whiteColor]];
            cell.accessoryView = nil;
           // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;

    }else
    {
        TMListsViewEditableCell *editableCell = [tableView dequeueReusableCellWithIdentifier:TMListsViewEditableCellIdentifier];
        addField = editableCell.titleField;
        addField.text = @"";
        [addField setPlaceholder:@"Add a new series"];
        addField.delegate = self;
        editableCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return editableCell; 
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2)
        return 28.0;
    return 0.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selectedIndexPath != nil && [selectedIndexPath compare: indexPath] == NSOrderedSame)
    {
        return listTableView.rowHeight * 2;
    }
    return listTableView.rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section >=0 && indexPath.section < [[[TMListStore sharedStore] returnAllLists] count])
    {
        NSLog(@"indexPath.row: %d",indexPath.row);
        NSLog(@"indexPath.section %d",indexPath.section);
        if (!indexPath.row)
        {
            [listTableView deselectRowAtIndexPath:indexPath animated:YES];
            NSInteger section = indexPath.section;
            BOOL currentlyExpanded = [expandedSections containsIndex:section];
            NSInteger rows;
            NSMutableArray *tmpArray = [NSMutableArray array];
            
            if (currentlyExpanded){
                rows = [self tableView:tableView numberOfRowsInSection:section];
                [expandedSections removeIndex:section];
            }else{
                [expandedSections addIndex:section];
                rows = [self tableView:tableView numberOfRowsInSection:section];
            }
            for (int i=1; i<rows; i++){
                NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:i
                                                               inSection:section];
                [tmpArray addObject:tmpIndexPath];
            }
            if (currentlyExpanded){
                if ([tmpArray count] > 0){
                    [listTableView deleteRowsAtIndexPaths:tmpArray withRowAnimation:UITableViewRowAnimationTop];
                }
                //cell.accessoryView =
            }else{
                if ([tmpArray count] > 0){
                    [listTableView insertRowsAtIndexPaths:tmpArray withRowAnimation:UITableViewRowAnimationTop];
                }
                //cell.accessoryView
            }
        }
        else{
            [listTableView deselectRowAtIndexPath:indexPath animated:YES];
            TMListItem *l = [[[TMListStore sharedStore] returnAllLists] objectAtIndex:indexPath.section];
            TMTask *t = [[[TMListStore sharedStore] getAllTasksFromList:l.title] objectAtIndex:(indexPath.row -1)];
            [[[TMViewControllerStore sharedStore] returnTMtvc] updateWithTask:t];
            [[[TMViewControllerStore sharedStore] returnMenuController] showRootController:YES];
        }

    }
    /*
    NSArray* toReload = [NSArray arrayWithObjects:indexPath,selectedIndexPath,nil];
    selectedIndexPath = indexPath;
    [listTableView reloadRowsAtIndexPaths:toReload withRowAnimation:UITableViewRowAnimationMiddle];
    */
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 2)
        return @"Custom Lists";
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section==2)
    {
        // create the parent view that will hold header Label
        UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(248.0, 6.0, 24.0, 10.0)];
        
        // create the button object
        UIButton * headerBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        //headerBtn.backgroundColor = [UIColor whiteColor];
        headerBtn.opaque = NO;
        headerBtn.frame = CGRectMake(248.0, 6.0, 24.0, 10.0);
        [headerBtn setBackgroundColor:[UIColor grayColor]];
        [headerBtn setTitle:@"Edit" forState:UIControlStateNormal];
        [headerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [headerBtn addTarget:self action:@selector(ActionEventForEditButton:) forControlEvents:UIControlEventTouchUpInside];
        [customView addSubview:headerBtn];
        
        return customView;

    }
    return nil;
}
- (void)ActionEventForEditButton:(id)sender
{
    if ([listTableView isEditing]){
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        [listTableView setEditing:NO animated:YES];
    }else{
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        [listTableView setEditing:YES animated:YES];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section >= 2 && indexPath.section < [[[TMListStore sharedStore] returnAllLists] count])
        return YES;
    return NO;
}
/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - TextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == addField &&
        [[TMListStore sharedStore] listsByTitle:addField.text] != nil) {
        [self showIdenticalTitleWarning];
        return NO;
    }
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == addField) {
        [self addLists:addField.text];
        [listTableView reloadData];
    } //else if (textField == editField) {
        //if (self.isEditing)
          //  [self endCellEdit];
    //}
}
#pragma mark - Helper
- (void)showIdenticalTitleWarning
{
    addField.text = @"";
    addField.placeholder = @"Please enter an UNIQUE title";
}
- (void)addLists:(NSString *)title
{
    if (![title isEqualToString:@""]){
        [[TMListStore sharedStore] createListWithTitle:title];
    }
}
@end
