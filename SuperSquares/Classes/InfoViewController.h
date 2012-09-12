//
//  InfoViewController.h
//  SuperSquares
//
//  Created by Eric on 6/17/10.
//  Copyright 2010 ciretose. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface InfoViewController : UIViewController {

    IBOutlet UIImageView *ciretoseLogo;
    IBOutlet UILabel *ciretoseLabel;

    IBOutlet UIImageView *murLogo;
    IBOutlet UILabel *murLabel;
    
    IBOutlet UILabel *copyrightLabel;
    
    IBOutlet UIBarButtonItem *doneButton;
    
}

@property (nonatomic, retain) UIImageView *ciretoseLogo;
@property (nonatomic, retain) UILabel *ciretoseLabel;
@property (nonatomic, retain) UIImageView *murLogo;
@property (nonatomic, retain) UILabel *murLabel;
@property (nonatomic, retain) UILabel *copyrightLabel;
@property (nonatomic, retain) UIBarButtonItem *doneButton;

-(BOOL) isPhone;

-(IBAction) touchDone:(id)sender;

@end
