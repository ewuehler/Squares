//
//  SuperSquaresViewController.h
//  SuperSquares
//
//  Created by Eric on 6/9/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataBox.h"
#import "GameStateDelegate.h"


@interface SuperSquaresViewController : UIViewController <UIAlertViewDelegate, UIActionSheetDelegate, GameStateDelegate>{

    IBOutlet UIImageView *logoImageView;
    
    IBOutlet UIButton *newGameButton;
    IBOutlet UIButton *changeButton;
    IBOutlet UIButton *setupButton;
    IBOutlet UIButton *highScoreButton;
    IBOutlet UIButton *helpButton;
    IBOutlet UIButton *infoButton;
    
    IBOutlet UIButton *choose3Button;
    IBOutlet UIButton *choose4Button;
    IBOutlet UIButton *choose5Button;
    IBOutlet UIButton *choose6Button;
    IBOutlet UIButton *choose8Button;
    IBOutlet UIButton *choose10Button;
    IBOutlet UIButton *choose15Button;
    IBOutlet UIButton *choose20Button;
    
    UIImageView *gameView;
    NSInteger boardSize;
    
    NSInteger score;
    NSInteger level;
    NSInteger change;
    NSInteger currentSquareCount;
    
    DataBox *scoreBox;
    DataBox *levelBox;
    DataBox *changeBox;
    
}

@property (nonatomic, retain) UIImageView *logoImageView;

@property (nonatomic, retain) UIButton *choose3Button;
@property (nonatomic, retain) UIButton *choose4Button;
@property (nonatomic, retain) UIButton *choose5Button;
@property (nonatomic, retain) UIButton *choose6Button;
@property (nonatomic, retain) UIButton *choose8Button;
@property (nonatomic, retain) UIButton *choose10Button;
@property (nonatomic, retain) UIButton *choose15Button;
@property (nonatomic, retain) UIButton *choose20Button;

@property (nonatomic, retain) UIButton *newGameButton;
@property (nonatomic, retain) UIButton *changeButton;
@property (nonatomic, retain) UIButton *setupButton;
@property (nonatomic, retain) UIButton *highScoreButton;
@property (nonatomic, retain) UIButton *helpButton;
@property (nonatomic, retain) UIButton *infoButton;

@property (nonatomic, retain) UIImageView *gameView;
@property (assign) NSInteger boardSize;
@property (assign) NSInteger score;
@property (assign) NSInteger level;
@property (assign) NSInteger change;
@property (assign) NSInteger currentSquareCount;

@property (nonatomic, retain) DataBox *scoreBox;
@property (nonatomic, retain) DataBox *levelBox;
@property (nonatomic, retain) DataBox *changeBox;


- (void) resetGameBoard;
- (void) moveToNextLevel;
- (void) showUserBonus:(NSInteger)yellow;

- (IBAction) touchStartGame:(id)sender;

- (IBAction) touchNewGame:(id)sender;
- (IBAction) touchChange:(id)sender;
- (IBAction) touchSetup:(id)sender;
- (IBAction) touchHighScore:(id)sender;
- (IBAction) touchHelp:(id)sender;
- (IBAction) touchInfo:(id)sender;

- (BOOL)isPhone;

@end

