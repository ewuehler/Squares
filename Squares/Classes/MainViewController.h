//
//  MainViewController.h
//  Squares
//
//  Created by Eric on 1/10/09.
//  Copyright ciretose 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SoundEffect.h"
#import "ImageHandler.h"
#import "RootViewController.h"

#define _INITIAL 0
#define _COMPLETE 1
#define _PLAYING 2

#define _DEFAULT_SHAKES 5

#define _NO_ALERT_SELECTED -1
#define _LEVEL_COMPLETE 0
#define _GAME_OVER 1
#define _SHAKE_DETECTED 2
#define _NO_SHAKES_LEFT 3
#define _QUIT_CURRENT_GAME 4
#define _SQUARES_FREE_TRIAL 5

#define _SQUARES_FREE_COUNT 5


@interface MainViewController : UIViewController <UIAlertViewDelegate, UIActionSheetDelegate, UITextFieldDelegate, UIAccelerometerDelegate>
{
    SoundEffect *touchAudio;
    SoundEffect *shakeAudio;
    SoundEffect *buzzAudio;
    SoundEffect *levelAudio;
    
    SoundEffect *hiAudio;
    SoundEffect *uhohAudio;
    SoundEffect *ahhhAudio;
    SoundEffect *yeahAudio;
    
    UIButton *square11Button;
    UIButton *square12Button;
    UIButton *square13Button;
    UIButton *square14Button;
    UIButton *square15Button;
    UIButton *square21Button;
    UIButton *square22Button;
    UIButton *square23Button;
    UIButton *square24Button;
    UIButton *square25Button;
    UIButton *square31Button;
    UIButton *square32Button;
    UIButton *square33Button;
    UIButton *square34Button;
    UIButton *square35Button;
    UIButton *square41Button;
    UIButton *square42Button;
    UIButton *square43Button;
    UIButton *square44Button;
    UIButton *square45Button;
    UIButton *square51Button;
    UIButton *square52Button;
    UIButton *square53Button;
    UIButton *square54Button;
    UIButton *square55Button;
    
    UILabel *scoreText;
    UILabel *levelText;
    UILabel *shakeText;
    
    UILabel *scoreLabel;
    UILabel *levelLabel;
    UILabel *shakeLabel;
    
    UIToolbar *toolbar;
    UIBarButtonItem *playNewGameButton;
    UIBarButtonItem *shakeButton;
    UIBarButtonItem *configButton;
    UIBarButtonItem *highScoreButton;
    UIBarButtonItem *helpButton;
    
    
    NSMutableDictionary *squareMap;
    NSInteger moves;
    NSInteger score;
    NSInteger level;
    NSInteger gameState;
    NSInteger gamesLeft;
    
    NSInteger whichAlertSelected;
    
    NSInteger highScoreIndex;
    
    UIScrollView *highScoreScrollView;
    UILabel *highScoreLabel;
    UITextField *highScoreName;
    NSString *lastHighScoreName;
    
    RootViewController *rootView;
    
    NSInteger shake;
	UIAccelerationValue	myAccelerometer[3];
	CFTimeInterval lastShakeTime;
    
    UIBarButtonItem *infoButton;
}

@property (nonatomic, retain) RootViewController *rootView;

@property (nonatomic, retain) IBOutlet UIButton *square11Button;
@property (nonatomic, retain) IBOutlet UIButton *square12Button;
@property (nonatomic, retain) IBOutlet UIButton *square13Button;
@property (nonatomic, retain) IBOutlet UIButton *square14Button;
@property (nonatomic, retain) IBOutlet UIButton *square15Button;
@property (nonatomic, retain) IBOutlet UIButton *square21Button;
@property (nonatomic, retain) IBOutlet UIButton *square22Button;
@property (nonatomic, retain) IBOutlet UIButton *square23Button;
@property (nonatomic, retain) IBOutlet UIButton *square24Button;
@property (nonatomic, retain) IBOutlet UIButton *square25Button;
@property (nonatomic, retain) IBOutlet UIButton *square31Button;
@property (nonatomic, retain) IBOutlet UIButton *square32Button;
@property (nonatomic, retain) IBOutlet UIButton *square33Button;
@property (nonatomic, retain) IBOutlet UIButton *square34Button;
@property (nonatomic, retain) IBOutlet UIButton *square35Button;
@property (nonatomic, retain) IBOutlet UIButton *square41Button;
@property (nonatomic, retain) IBOutlet UIButton *square42Button;
@property (nonatomic, retain) IBOutlet UIButton *square43Button;
@property (nonatomic, retain) IBOutlet UIButton *square44Button;
@property (nonatomic, retain) IBOutlet UIButton *square45Button;
@property (nonatomic, retain) IBOutlet UIButton *square51Button;
@property (nonatomic, retain) IBOutlet UIButton *square52Button;
@property (nonatomic, retain) IBOutlet UIButton *square53Button;
@property (nonatomic, retain) IBOutlet UIButton *square54Button;
@property (nonatomic, retain) IBOutlet UIButton *square55Button;

@property (nonatomic, retain) IBOutlet UILabel *scoreText;
@property (nonatomic, retain) IBOutlet UILabel *levelText;
@property (nonatomic, retain) IBOutlet UILabel *shakeText;

@property (nonatomic, retain) IBOutlet UILabel *scoreLabel;
@property (nonatomic, retain) IBOutlet UILabel *levelLabel;
@property (nonatomic, retain) IBOutlet UILabel *shakeLabel;

@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *playNewGameButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *shakeButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *configButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *highScoreButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *helpButton;



@property (nonatomic, retain) IBOutlet UIScrollView *highScoreScrollView;
@property (nonatomic, retain) IBOutlet UILabel *highScoreLabel;
@property (nonatomic, retain) IBOutlet UITextField *highScoreName;

@property (nonatomic, retain) NSMutableDictionary *squareMap;

@property (assign) NSInteger moves;
@property (assign) NSInteger score;
@property (assign) NSInteger level;
@property (assign) NSInteger shake;
@property (assign) NSInteger gameState;
@property (assign) NSInteger gamesLeft;
@property (assign) NSInteger whichAlertSelected;
@property (assign) NSInteger highScoreIndex;
@property (nonatomic, retain) NSString *lastHighScoreName;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *infoButton;

- (IBAction)squareTouched:(UIButton *)square;
- (IBAction)newGameTouched:(id)sender;
- (IBAction)chosenHighScoreName;
- (IBAction)showHighScore;
- (void)showHighScore:(NSInteger)row;
- (IBAction)showHelp;
- (IBAction)shakeTouched:(id)sender;
- (IBAction) touchShowConfiguration:(id)sender;

- (IBAction)launchOpenFeint;

- (int) changeTarget:(UIButton *)currentButton;

- (int)movesLeft;
- (void)startNewGame;
- (void)saveUserData;
- (void)saveCurrentState;

- (void)enableShakes:(BOOL)status;
- (void)showGameOver;

- (void)setUseSoundType:(NSNumber *)type;
- (void)setImageType:(NSNumber *)type;
- (void) playSound:(int)type;

- (IBAction) showInfo;

@end
