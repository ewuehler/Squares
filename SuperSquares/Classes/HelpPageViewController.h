//
//  HelpPageViewController.h
//  SuperSquares
//
//  Created by Eric on 6/28/10.
//  Copyright 2010 ciretose. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HelpPageViewController : UIViewController {

    IBOutlet UIImageView *helpImageView;
    IBOutlet UILabel *pageNumberLabel;
    int pageNumber;
}

@property (nonatomic, retain) UIImageView *helpImageView;
@property (nonatomic, retain) UILabel *pageNumberLabel;

- (id)initWithPageNumber:(int)page;


@end
