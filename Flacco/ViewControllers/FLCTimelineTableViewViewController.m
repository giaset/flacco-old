//
//  FLCTimelineTableViewViewController.m
//  Flacco
//
//  Created by Gianni Settino on 2014-05-29.
//  Copyright (c) 2014 Milton and Parc. All rights reserved.
//

#import "FLCTimelineTableViewViewController.h"
#import "FLCCameraViewController.h"
#import "FLCPhotoTableViewCell.h"

@interface FLCTimelineTableViewViewController ()

@end

@implementation FLCTimelineTableViewViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"flacco";
        self.parseClassName = @"FlaccoPhoto";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set up rightBarButton to launch camera
    UIBarButtonItem* addMealButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(addMealButtonClicked)];
    self.navigationItem.rightBarButtonItem = addMealButton;
}

- (IBAction)addMealButtonClicked
{
    FLCCameraViewController* cameraViewController = [[FLCCameraViewController alloc] init];
    UINavigationController* cameraNavController = [[UINavigationController alloc] initWithRootViewController:cameraViewController];
    cameraNavController.navigationBarHidden = YES;
    [self presentViewController:cameraNavController animated:YES completion:nil];
}

#pragma mark - Table view data source

- (PFQuery*)queryForTable
{
    PFQuery* photosQuery = [PFQuery queryWithClassName:@"FlaccoPhoto"];
    
    return photosQuery;
}

- (PFObject*)objectAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.objects objectAtIndex:indexPath.section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.objects.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (PFTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    static NSString* CellIdentifier = @"Cell";
    
    FLCPhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[FLCPhotoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.photoView.backgroundColor = [UIColor redColor];
    cell.photoView.file = [object objectForKey:@"image"];
    
    // PFQTVC will take care of asynchronously downloading files, but will only load them when the tableview is not moving. If the data is there, let's load it right away.
    if ([cell.photoView.file isDataAvailable]) {
     [cell.photoView loadInBackground];
     }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 320;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Picture number %ld", (long)(section+1)];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
