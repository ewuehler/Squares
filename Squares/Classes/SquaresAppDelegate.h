//
//  SquaresAppDelegate.h
//  Squares
//
//  Created by Eric on 1/10/09.
//  Copyright ciretose 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface SquaresAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    RootViewController *rootViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet RootViewController *rootViewController;

@end

