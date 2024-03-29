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
@property (nonatomic, assign) UIBackgroundTaskIdentifier photoPostBackgroundTaskId;

@end

@implementation FLCEditViewController

- (id)initWithImage:(UIImage*)image
{
    self = [super initWithNibName:@"FLCEditViewController" bundle:nil];
    if (self) {
        if (!image) {
            return nil;
        }
        
        self.image = image;
        self.fileUploadBackgroundTaskId = UIBackgroundTaskInvalid;
        self.photoPostBackgroundTaskId = UIBackgroundTaskInvalid;
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
    if (self.photoFile) {
        // Create a Photo object
        PFObject* photo = [PFObject objectWithClassName:@"FlaccoPhoto"];
        [photo setObject:self.photoFile forKey:@"image"];
        
        // Request a background execution task to allow us to finish uploading
        // the photo even if the app is sent to the background
        self.photoPostBackgroundTaskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
            [[UIApplication sharedApplication] endBackgroundTask:self.photoPostBackgroundTaskId];
        }];
        
        // Save the Photo PFObject
        [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [[UIApplication sharedApplication] endBackgroundTask:self.photoPostBackgroundTaskId];
        }];
        
        // Dismiss this screen
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)backButtonPressed {
    [self.navigationController popViewControllerAnimated:NO];
}

- (BOOL)shouldUploadImage:(UIImage*)image
{
    // First resize image
    UIImage* resizedImage = [self resizeImage:image toSize:CGSizeMake(640, 640)];
    
    // Get JPEG NSData representation of our resized image
    NSData* imageData = UIImageJPEGRepresentation(resizedImage, 0.8f);
    
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

- (UIImage*)resizeImage:(UIImage *)image toSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 1.0); // last param is scale (0.0 to use device's retina/non-retina scale, 1.0 to force exact pixel size)
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
