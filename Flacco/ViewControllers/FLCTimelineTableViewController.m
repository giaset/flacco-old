//
//  FLCTimelineTableViewController.m
//  Flacco
//
//  Created by Gianni Settino on 2014-05-22.
//  Copyright (c) 2014 Milton and Parc. All rights reserved.
//

#import "FLCTimelineTableViewController.h"
#import <UIViewController+ScrollingNavbar.h>

@interface FLCTimelineTableViewController ()

@end

@implementation FLCTimelineTableViewController

- (id)init
{
    self = [super initWithNibName:@"FLCTimelineTableViewController" bundle:nil];
    if (self) {
        self.title = @"flacco";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set up rightBarButton to launch camera
    UIBarButtonItem* addMealButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addMealButtonClicked)];
    self.navigationItem.rightBarButtonItem = addMealButton;
    
    // Bind the disappearing navbar to user's scrolls
    [self followScrollView:self.tableView];
}

- (IBAction)addMealButtonClicked
{
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"Cell number %d", indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
