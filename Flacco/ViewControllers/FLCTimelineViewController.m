//
//  FLCTimelineViewController.m
//  Flacco
//
//  Created by Gianni Settino on 2014-05-23.
//  Copyright (c) 2014 Milton and Parc. All rights reserved.
//

#import "FLCTimelineViewController.h"
#import <UIViewController+ScrollingNavbar.h>

@interface FLCTimelineViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FLCTimelineViewController

- (id)init
{
    self = [super initWithNibName:@"FLCTimelineViewController" bundle:nil];
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
    [self followScrollView:self.tableView withDelay:30];
}

- (IBAction)addMealButtonClicked
{
    // launch camera
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
