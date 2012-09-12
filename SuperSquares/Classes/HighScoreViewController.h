//
//  HighScoreViewController.h
//  SuperSquares
//
//  Created by Eric on 6/29/10.
//  Copyright 2010 ciretose. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HighScoreViewController : UIViewController {

    IBOutlet UIButton *closeButton;
}

@property (nonatomic, retain) UIButton *closeButton;


- (IBAction) touchClose:(id)sender;

@end
