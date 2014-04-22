//
//  AppDelegate.m
//  TopAppsLister
//
//  Created by Daniel Stokowski on 22.04.2014.
//  Copyright (c) 2014 BLTest. All rights reserved.
//

#import "AppDelegate.h"
#import "TopListViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];

    TopListViewController *mainController = [[TopListViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc]  initWithRootViewController:mainController];

    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    [mainController release];
    [navigationController release];
    return YES;

}

@end
