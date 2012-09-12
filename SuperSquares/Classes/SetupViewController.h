//
//  SetupViewController.h
//  SuperSquares
//
//  Created by Eric on 7/9/10.
//  Copyright 2010 ciretose. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SetupViewController : UIViewController {

    IBOutlet UIButton *closeButton;
}

@property (nonatomic, retain) UIButton *closeButton;


- (IBAction) touchClose:(id)sender;


@end
