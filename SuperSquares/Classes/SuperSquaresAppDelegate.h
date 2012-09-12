//
//  SuperSquaresAppDelegate.h
//  SuperSquares
//
//  Created by Eric on 6/9/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SuperSquaresViewController;

@interface SuperSquaresAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    SuperSquaresViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SuperSquaresViewController *viewController;

@end

