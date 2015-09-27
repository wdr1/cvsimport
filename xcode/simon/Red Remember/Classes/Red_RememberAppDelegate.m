//
//  Red_RememberAppDelegate.m
//  Red Remember
//
//  Created by Bill Reardon on 8/14/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "Red_RememberAppDelegate.h"
#import "Red_RememberViewController.h"

@implementation Red_RememberAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
