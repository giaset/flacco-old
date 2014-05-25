//
//  FLCEditViewController.m
//  Flacco
//
//  Created by Gianni Settino on 2014-05-25.
//  Copyright (c) 2014 Milton and Parc. All rights reserved.
//

#import "FLCEditViewController.h"

@interface FLCEditViewController ()

@property UIImage* image;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation FLCEditViewController

- (id)initWithImage:(UIImage*)image
{
    self = [super initWithNibName:@"FLCEditViewController" bundle:nil];
    if (self) {
        self.image = image;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imageView.image = self.image;
}

- (IBAction)backButtonPressed {
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
