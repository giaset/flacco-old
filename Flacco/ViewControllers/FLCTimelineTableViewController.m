//
//  FLCTimelineTableViewController.m
//  Flacco
//
//  Created by Gianni Settino on 2014-05-22.
//  Copyright (c) 2014 Milton and Parc. All rights reserved.
//

#import "FLCTimelineTableViewController.h"

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
}

- (IBAction)addMealButtonClicked
{
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

@end
