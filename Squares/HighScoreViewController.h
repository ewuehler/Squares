//
//  HighScoreViewController.h
//  Squares
//
//  Created by Eric on 1/26/09.
//  Copyright 2009 ciretose. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HighScoreViewController : UIViewController  <UITableViewDataSource, UIAlertViewDelegate> 
{

    UITableView *highScoreTableView;
    NSMutableArray *highScores;
    
    NSInteger currentRow;
}

@property (nonatomic, retain) IBOutlet UITableView *highScoreTableView;
@property (nonatomic, assign) NSMutableArray *highScores;
@property (assign) NSInteger currentRow;


- (void) clearHighScores;
- (void) reloadHighScoreData;

-(IBAction)touchDismiss;

@end
