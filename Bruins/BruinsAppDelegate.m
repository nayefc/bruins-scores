//
//  BruinsAppDelegate.m
//  Bruins
//
//  Created by Nayef Copty on 23/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BruinsAppDelegate.h"

@implementation BruinsAppDelegate

@synthesize window, tabBarController, navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self.window makeKeyAndVisible];
    self.window.rootViewController = self.tabBarController;
    return YES;
}

- (void)dealloc {
    [window release];
    [tabBarController release];
    [navigationController release];
    [super dealloc];
}

@end
