//
//  FLCCameraViewController.m
//  Flacco
//
//  Created by Gianni Settino on 2014-05-24.
//  Copyright (c) 2014 Milton and Parc. All rights reserved.
//

#import "FLCCameraViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface FLCCameraViewController ()

@property (weak, nonatomic) IBOutlet UIView *cameraView;

@end

@implementation FLCCameraViewController

- (id)init
{
    self = [super initWithNibName:@"FLCCameraViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /* Set up the capture session */
    AVCaptureSession* captureSession = [[AVCaptureSession alloc] init];
    captureSession.sessionPreset = AVCaptureSessionPresetPhoto;
    
    /* Set up the capture device */
    AVCaptureDevice* device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError* error = nil;
    AVCaptureDeviceInput* input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (!input) {
        // Handle the error appropriately
    }
    [captureSession addInput:input];
    
    /* Set up the preview layer */
    CALayer* cameraViewLayer = self.cameraView.layer;
    AVCaptureVideoPreviewLayer* captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:captureSession];
    captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    captureVideoPreviewLayer.frame = self.cameraView.bounds;
    [cameraViewLayer addSublayer:captureVideoPreviewLayer];
    
    [captureSession startRunning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Hide status bar after a slight delay to make it look nicer (0.35 for modal, 0.15 for crossfade)
    double delayInSeconds = 0.35;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
    });
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (IBAction)closeCamera:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
