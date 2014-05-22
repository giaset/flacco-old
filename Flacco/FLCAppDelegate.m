//
//  FLCAppDelegate.m
//  Flacco
//
//  Created by Gianni Settino on 2014-05-22.
//  Copyright (c) 2014 Milton and Parc. All rights reserved.
//

#import "FLCAppDelegate.h"
#import "FLCTimelineTableViewController.h"
#import "GSColor.h"

@implementation FLCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Style the navBar
    [UINavigationBar appearance].barTintColor = [GSColor darkPurple];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]];
    
    // Launch the app
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    FLCTimelineTableViewController* timeline = [[FLCTimelineTableViewController alloc] init];
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:timeline];
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
