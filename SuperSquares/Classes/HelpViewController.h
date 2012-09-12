//
//  HelpViewController.h
//  SuperSquares
//
//  Created by Eric on 6/22/10.
//  Copyright 2010 ciretose. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HelpViewController : UIViewController <UIScrollViewDelegate> {

    
    IBOutlet UIButton *closeButton;
    IBOutlet UIPageControl *pageControl;
    IBOutlet UIScrollView *scrollView;
    
    NSMutableArray *viewControllers;
    
    // To be used when scrolls originate from the UIPageControl
    BOOL pageControlUsed;
    
}

@property (nonatomic, retain) UIButton *closeButton;

@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) NSMutableArray *viewControllers;


- (IBAction) changePage:(id)sender;

- (IBAction) touchClose:(id)sender;

@end
