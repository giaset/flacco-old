//
//  FLCEditViewController.m
//  Flacco
//
//  Created by Gianni Settino on 2014-05-25.
//  Copyright (c) 2014 Milton and Parc. All rights reserved.
//

#import "FLCEditViewController.h"
#import <Parse/Parse.h>

@interface FLCEditViewController ()

@property UIImage* image;
@property (weak, nonatomic) IBOutlet UIImageView* imageView;
@property (nonatomic, strong) PFFile* photoFile;
@property (nonatomic, assign) UIBackgroundTaskIdentifier fileUploadBackgroundTaskId;

@end

@implementation FLCEditViewController

- (id)initWithImage:(UIImage*)image
{
    self = [super initWithNibName:@"FLCEditViewController" bundle:nil];
    if (self) {
        self.image = image;
        self.fileUploadBackgroundTaskId = UIBackgroundTaskInvalid;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imageView.image = self.image;
    
    [self shouldUploadImage:self.image];
}

- (IBAction)doneButtonPressed {
}

- (IBAction)backButtonPressed {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (BOOL)shouldUploadImage:(UIImage*)image
{
    // Get JPEG NSData representation of our image
    NSData* imageData = UIImageJPEGRepresentation(image, 0.8f);
    
    if (!imageData) {
        return NO;
    }
    
    // Create the PFFile and store it in a property since we'll need it later
    self.photoFile = [PFFile fileWithData:imageData];
    
    // Request a background execution task to allow us to finish uploading the photo even if the application is backgrounded
    self.fileUploadBackgroundTaskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [[UIApplication sharedApplication] endBackgroundTask:self.fileUploadBackgroundTaskId];
    }];
    
    [self.photoFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [[UIApplication sharedApplication] endBackgroundTask:self.fileUploadBackgroundTaskId];
    }];
    
    return YES;
}

@end
