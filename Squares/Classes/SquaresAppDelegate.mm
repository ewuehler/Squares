//
//  SquaresAppDelegate.m
//  Squares
//
//  Created by Eric on 1/10/09.
//  Copyright ciretose 2009. All rights reserved.
//

#import "SquaresAppDelegate.h"
#import "RootViewController.h"

@implementation SquaresAppDelegate


@synthesize window;
@synthesize rootViewController;


- (void)applicationDidBecomeActive:(UIApplication *)application
{

}

- (void)applicationWillResignActive:(UIApplication *)application
{

}

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
    
    [window addSubview:[rootViewController view]];
    [window makeKeyAndVisible];


}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    // This is where I need to save the current state of the app
    [rootViewController saveCurrentState];

    
}



- (void)dealloc {
    [rootViewController release];
    [window release];
    [super dealloc];
}

@end
