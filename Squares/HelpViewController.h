//
//  HelpViewController.h
//  Squares
//
//  Created by Eric on 1/25/09.
//  Copyright 2009 ciretose. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HelpViewController : UIViewController {

    UIWebView *helpWebView;
//    UIBarButtonItem *visitButton;
    
}

@property (nonatomic, assign) IBOutlet UIWebView *helpWebView;
//@property (nonatomic, assign) IBOutlet UIBarButtonItem *visitButton;

- (IBAction) visitWebSite;
-(IBAction)touchDismiss;

@end
