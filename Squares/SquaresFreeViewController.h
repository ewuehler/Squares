//
//  SquaresFreeViewController.h
//  Squares
//
//  Created by Eric on 7/20/09.
//  Copyright 2009 ciretose. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SquaresFreeViewController : UIViewController {

    IBOutlet UILabel *headerText;
    IBOutlet UIButton *soundButton;
    IBOutlet UIButton *ciretoseButton;
    IBOutlet UIButton *purchaseButton;
    
}

-(IBAction)touchDismiss;


-(IBAction) touchSound;
-(IBAction) touchCiretose;
-(IBAction) touchPurchase;

@end
