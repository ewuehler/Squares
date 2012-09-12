//
//  FlipsideViewController.h
//  Squares
//
//  Created by Eric on 1/10/09.
//  Copyright ciretose 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlipsideViewController : UIViewController {

    UILabel *teaserLabel;
    UILabel *developLabel;
    UILabel *designLabel;
    
    UIButton *launchWebsite;
    UIButton *launchDesign;
    
    UIImageView *happyImageView;
    UIImageView *nervousImageView;
    UIImageView *deadImageView;
}

@property (nonatomic, retain) IBOutlet UILabel *teaserLabel;
@property (nonatomic, retain) IBOutlet UILabel *developLabel;
@property (nonatomic, retain) IBOutlet UILabel *designLabel;

@property (nonatomic, retain) IBOutlet UIButton *launchWebsite;
@property (nonatomic, retain) IBOutlet UIButton *launchDesign;

@property (nonatomic, retain) IBOutlet UIImageView *happyImageView;
@property (nonatomic, retain) IBOutlet UIImageView *nervousImageView;
@property (nonatomic, retain) IBOutlet UIImageView *deadImageView;

- (IBAction)launchBrowser;
- (IBAction)launchDesignBrowser;

- (IBAction) touchDismiss;

@end
