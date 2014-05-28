//
//  FLCAppDelegate.m
//  Flacco
//
//  Created by Gianni Settino on 2014-05-22.
//  Copyright (c) 2014 Milton and Parc. All rights reserved.
//

#import "FLCAppDelegate.h"
#import "FLCTimelineViewController.h"
#import "GSColor.h"
#import <Parse/Parse.h>

@implementation FLCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Parse
    [Parse setApplicationId:@"BZfAoL6099iLJQpcD8dqEQL32slvnJYebUCw3MQf" clientKey:@"e1h1pqvrKZzj9lh1DFVLdemqFWd1HMVrAkIdqU5f"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    // Style the navBar
    [UINavigationBar appearance].barTintColor = [GSColor purple];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"Exo2-Regular" size:26], NSFontAttributeName, nil]];
    
    // Launch the app
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    FLCTimelineViewController* timeline = [[FLCTimelineViewController alloc] init];
    UINavigationController* rootNav = [[UINavigationController alloc] initWithRootViewController:timeline];
    rootNav.navigationBar.translucent = NO;
    
    self.window.rootViewController = rootNav;
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
