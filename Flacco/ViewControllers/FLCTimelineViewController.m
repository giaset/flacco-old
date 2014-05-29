//
//  FLCTimelineViewController.m
//  Flacco
//
//  Created by Gianni Settino on 2014-05-23.
//  Copyright (c) 2014 Milton and Parc. All rights reserved.
//

#import "FLCTimelineViewController.h"
#import <UIViewController+ScrollingNavbar.h>
#import "FLCCameraViewController.h"
#import <Parse/Parse.h>

@interface FLCTimelineViewController ()

@property (weak, nonatomic) IBOutlet UITableView* tableView;
@property (nonatomic, retain) NSArray* objects;

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
    UIBarButtonItem* addMealButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(addMealButtonClicked)];
    self.navigationItem.rightBarButtonItem = addMealButton;
    
    // Bind the disappearing navbar to user's scrolls
    //[self followScrollView:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadObjects];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self showNavBarAnimated:NO];
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

- (void)loadObjects
{
    [[self queryForTable] findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.objects = objects;
        [self.tableView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.objects.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.backgroundColor = [UIColor lightGrayColor];
    
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
