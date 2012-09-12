//
//  SuperSquaresViewController.m
//  SuperSquares
//
//  Created by Eric on 6/9/10.
//  Copyright ciretose 2010. All rights reserved.
//

#import "SuperSquaresViewController.h"
#import "Square.h"
#import "InfoViewController.h"
#import "LevelIndicator.h"
#import "HelpViewController.h"
#import "HighScoreViewController.h"
#import "SetupViewController.h"

@implementation SuperSquaresViewController

#define GAMEVIEW_X_PORTRAITX 0
#define GAMEVIEW_Y_PORTRAITX 64
#define GAMEVIEW_SQUAREX 320

#define GAMEVIEW_SIZE3X 96
#define GAMEVIEW_SIZE4X 72
#define GAMEVIEW_SIZE5X 60
#define GAMEVIEW_SIZE6X 48

#define GAMEVIEW_GAP3X 6
#define GAMEVIEW_GAP4X 4
#define GAMEVIEW_GAP5X 3
#define GAMEVIEW_GAP6X 3

#define GAMEVIEW_BORDER3X 10
#define GAMEVIEW_BORDER4X 10
#define GAMEVIEW_BORDER5X 4
#define GAMEVIEW_BORDER6X 6

#define GAMEVIEW_PORTRAITX CGRectMake(GAMEVIEW_X_PORTRAITX, GAMEVIEW_Y_PORTRAITX, GAMEVIEW_SQUAREX, GAMEVIEW_SQUAREX)
#define SCOREBOX_PORTRAITX CGRectMake(140,500,80,80)
#define LEVELBOX_PORTRAITX CGRectMake(32,500,80,80)
#define CHANGEBOX_PORTRAITX CGRectMake(250,500,80,80)



#define GAMEVIEW_X_PORTRAIT 24
#define GAMEVIEW_X_LANDSCAPE 10
#define GAMEVIEW_Y_PORTRAIT 64
#define GAMEVIEW_Y_LANDSCAPE 12
#define GAMEVIEW_SQUARE 720

#define GAMEVIEW_SIZE3 230
#define GAMEVIEW_SIZE4 172
#define GAMEVIEW_SIZE5 136
#define GAMEVIEW_SIZE6 115
#define GAMEVIEW_SIZE8 86
#define GAMEVIEW_SIZE10 68
#define GAMEVIEW_SIZE15 44
#define GAMEVIEW_SIZE20 34

#define GAMEVIEW_GAP3 12
#define GAMEVIEW_GAP4 10
#define GAMEVIEW_GAP5 9
#define GAMEVIEW_GAP6 6
#define GAMEVIEW_GAP8 4
#define GAMEVIEW_GAP10 4
#define GAMEVIEW_GAP15 4
#define GAMEVIEW_GAP20 2

#define GAMEVIEW_BORDER3 3
#define GAMEVIEW_BORDER4 1
#define GAMEVIEW_BORDER5 2
#define GAMEVIEW_BORDER6 0
#define GAMEVIEW_BORDER8 2
#define GAMEVIEW_BORDER10 2
#define GAMEVIEW_BORDER15 2
#define GAMEVIEW_BORDER20 1

#define GAMEVIEW_LANDSCAPE CGRectMake(GAMEVIEW_X_LANDSCAPE, GAMEVIEW_Y_LANDSCAPE, GAMEVIEW_SQUARE, GAMEVIEW_SQUARE)
#define GAMEVIEW_PORTRAIT CGRectMake(GAMEVIEW_X_PORTRAIT, GAMEVIEW_Y_PORTRAIT, GAMEVIEW_SQUARE, GAMEVIEW_SQUARE)

#define SCOREBOX_LANDSCAPE CGRectMake(742,100,200,80)
#define SCOREBOX_PORTRAIT CGRectMake(284,800,200,80)

#define LEVELBOX_LANDSCAPE CGRectMake(742,220, 200, 80)
#define LEVELBOX_PORTRAIT CGRectMake(64,800,200,80)

#define CHANGEBOX_LANDSCAPE CGRectMake(742,340,200,80)
#define CHANGEBOX_PORTRAIT CGRectMake(504,800,200,80)

#define CHOOSEN_BOX 150

#define CHOOSE3_LANDSCAPE CGRectMake(151,100,CHOOSEN_BOX,CHOOSEN_BOX)
#define CHOOSE3_PORTRAIT CGRectMake(151,150,CHOOSEN_BOX,CHOOSEN_BOX)

#define CHOOSE4_LANDSCAPE CGRectMake(309,100,CHOOSEN_BOX,CHOOSEN_BOX)
#define CHOOSE4_PORTRAIT CGRectMake(309,150,CHOOSEN_BOX,CHOOSEN_BOX)

#define CHOOSE5_LANDSCAPE CGRectMake(467,100,CHOOSEN_BOX,CHOOSEN_BOX)
#define CHOOSE5_PORTRAIT CGRectMake(467,150,CHOOSEN_BOX,CHOOSEN_BOX)

#define CHOOSE6_LANDSCAPE CGRectMake(230,258,CHOOSEN_BOX,CHOOSEN_BOX)
#define CHOOSE6_PORTRAIT CGRectMake(230,308,CHOOSEN_BOX,CHOOSEN_BOX)

#define CHOOSE8_LANDSCAPE CGRectMake(388,258,CHOOSEN_BOX,CHOOSEN_BOX)
#define CHOOSE8_PORTRAIT CGRectMake(388,308,CHOOSEN_BOX,CHOOSEN_BOX)

#define CHOOSE10_LANDSCAPE CGRectMake(151,416,CHOOSEN_BOX,CHOOSEN_BOX)
#define CHOOSE10_PORTRAIT CGRectMake(151,466,CHOOSEN_BOX,CHOOSEN_BOX)

#define CHOOSE15_LANDSCAPE CGRectMake(309,416,CHOOSEN_BOX,CHOOSEN_BOX)
#define CHOOSE15_PORTRAIT CGRectMake(309,466,CHOOSEN_BOX,CHOOSEN_BOX)

#define CHOOSE20_LANDSCAPE CGRectMake(467,416,CHOOSEN_BOX,CHOOSEN_BOX)
#define CHOOSE20_PORTRAIT CGRectMake(467,466,CHOOSEN_BOX,CHOOSEN_BOX)

#define SETUP_LANDSCAPE CGRectMake(800,200,120,37)
#define SETUP_PORTRAIT CGRectMake(196,740,120,37)

#define HIGHSCORE_LANDSCAPE CGRectMake(800,250,120,37)
#define HIGHSCORE_PORTRAIT CGRectMake(324,740,120,37)

#define HELP_LANDSCAPE CGRectMake(800,300,120,37)
#define HELP_PORTRAIT CGRectMake(452,740,120,37)

#define NEWGAME_LANDSCAPE CGRectMake(800,650,120,37)
#define NEWGAME_PORTRAIT CGRectMake(258,947,120,37)

#define CHANGE_LANDSCAPE CGRectMake(800,600,120,37)
#define CHANGE_PORTRAIT CGRectMake(389,947,120,37)

#define LOGO_LANDSCAPE CGRectMake(800,50,128,40)
#define LOGO_PORTRAIT CGRectMake(320,0,128,40)

#define INFO_LANDSCAPE CGRectMake(986,10,18,19)
#define INFO_PORTRAIT CGRectMake(730,10,18,19)

#define ALERT_RESET -1
#define ALERT_NEWGAME 1
#define ALERT_GAMEOVER 2
#define ALERT_LEVELBONUS 3


@synthesize newGameButton, changeButton, setupButton, highScoreButton, helpButton, infoButton;
@synthesize choose3Button, choose4Button, choose5Button, choose6Button, choose8Button, choose10Button, choose15Button, choose20Button;
@synthesize boardSize;
@synthesize gameView;
@synthesize scoreBox, levelBox, changeBox;
@synthesize logoImageView;
@synthesize score, level, change, currentSquareCount;


NSInteger cancelIndex = -1;
NSInteger changeIndex = -1;
NSInteger newBoardIndex = -1;
NSInteger sameBoardIndex = -1;

NSInteger alertViewState = -1;

BOOL shouldAllowRotate = YES;
BOOL terminateGame = NO;


- (BOOL)isPhone
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
}

- (void)squareAnimationDidStart:(NSString *)animationID context:(void *)context
{
//    NSLog(@"Started: %@", animationID);
}

-(void)squareAnimationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
//    NSLog(@"Stopped: %@", animationID);
    [(Square *)context setUserInteractionEnabled:YES];
}


- (void) animateMyView:(UIView *)myView 
             withDelay:(NSTimeInterval)delay 
           andDuration:(NSTimeInterval)duration 
              andCurve:(UIViewAnimationCurve)curve 
         andTransition:(UIViewAnimationTransition)transition
{
    [UIView beginAnimations:[[NSNumber numberWithInt:[myView tag]] stringValue] context:myView];
    [UIView setAnimationDelay:delay];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationTransition:transition forView:myView cache:YES];
}


- (IBAction) touchNewGame:(id)sender
{
    shouldAllowRotate = NO;
    alertViewState = ALERT_NEWGAME;
    
    UIActionSheet *alert = [[UIActionSheet alloc] initWithTitle:@"New Game" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    [alert setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    sameBoardIndex = [alert addButtonWithTitle:@"Replay Board"];
    newBoardIndex = [alert addButtonWithTitle:@"Play New Board"];
    cancelIndex = [alert addButtonWithTitle:@"Cancel"];
    
    [alert setCancelButtonIndex:cancelIndex];
    [alert showFromRect:[self.newGameButton frame] inView:self.view animated:YES];
    [alert release];
    
}

- (void) changeSquareDirection:(Square *)square withDelay:(CGFloat)delay
{
    [square setUserInteractionEnabled:NO];
    [self animateMyView:square withDelay:delay andDuration:0.5 andCurve:UIViewAnimationCurveEaseInOut andTransition:UIViewAnimationTransitionFlipFromRight];
    
    [UIView setAnimationDelegate:self];
    [UIView setAnimationWillStartSelector:@selector(squareAnimationDidStart:context:)];
    [UIView setAnimationDidStopSelector:@selector(squareAnimationDidStop:finished:context:)];
    
    [square randomizeImageDirection];
    [UIView commitAnimations];
}

- (IBAction) touchChange:(id)sender
{
    if (self.change > 0)
    {
        self.change = (self.change - 1);
        [changeBox.dataValue setText:[[NSNumber numberWithInt:self.change] stringValue]];

        CGFloat delayShift = (self.boardSize >= 10) ? 0.05 : 0.08;
        CGFloat delay = 0;
        
        for (id square in [self.gameView subviews])
        {
            if ([square canChange] == YES)
            {
                [self changeSquareDirection:square withDelay:delay];
                delay += delayShift;
            }
        }
    }
}

- (IBAction) touchInfo:(id)sender
{
    if ([self isPhone] == YES)
    {
        InfoViewController *vc = [[InfoViewController alloc] initWithNibName:@"InfoViewControllerX" bundle:nil];
        [self presentModalViewController:vc animated:YES];
        [vc release];
    }
    else
    {
        InfoViewController *vc = [[InfoViewController alloc] initWithNibName:@"InfoViewController" bundle:nil];
        [self presentModalViewController:vc animated:YES];
        [vc release];
    }
}

- (IBAction) touchSetup:(id)sender
{
    if ([self isPhone] == YES)
    {
        SetupViewController *vc = [[SetupViewController alloc] initWithNibName:@"SetupViewControllerX" bundle:nil];
        [self presentModalViewController:vc animated:YES];
        [vc release];
    }
    else 
    {
        SetupViewController *vc = [[SetupViewController alloc] initWithNibName:@"SetupViewController" bundle:nil];
        [self presentModalViewController:vc animated:YES];
        [vc release];
    }
}

- (IBAction) touchHighScore:(id)sender
{
    if ([self isPhone] == YES)
    {
        HighScoreViewController *vc = [[HighScoreViewController alloc] initWithNibName:@"HighScoreViewControllerX" bundle:nil];
        [self presentModalViewController:vc animated:YES];
        [vc release];
    }
    else 
    {
        HighScoreViewController *vc = [[HighScoreViewController alloc] initWithNibName:@"HighScoreViewController" bundle:nil];
        [self presentModalViewController:vc animated:YES];
        [vc release];
    }
}

- (IBAction) touchHelp:(id)sender
{
    if ([self isPhone] == YES)
    {
        HelpViewController *vc = [[HelpViewController alloc] initWithNibName:@"HelpViewControllerX" bundle:nil];
        [self presentModalViewController:vc animated:YES];
        [vc release];
    }
    else 
    {
        HelpViewController *vc = [[HelpViewController alloc] initWithNibName:@"HelpViewController" bundle:nil];
        [self presentModalViewController:vc animated:YES];
        [vc release];
    }
}

- (void) setupGameView:(NSInteger)size
{
    srandom((unsigned)(time(NULL)));
    
    terminateGame = NO;
    
    if (gameView) [gameView release];
    if (scoreBox) [scoreBox release];
    if (levelBox) [levelBox release];
    if (changeBox) [changeBox release];
    
    self.boardSize = size;
    self.currentSquareCount = (size * size);
    self.score = 0;
    self.level = 1;
    self.change = 5; // This will be variable depending on the game style
    
    
    if ([self isPhone] == YES)
    {
        // Setup for the phone
        gameView = [[UIImageView alloc] initWithFrame:GAMEVIEW_PORTRAITX];
        scoreBox = [[DataBox alloc] initWithFrame:SCOREBOX_PORTRAITX];
        levelBox = [[DataBox alloc] initWithFrame:LEVELBOX_PORTRAITX];
        changeBox = [[DataBox alloc] initWithFrame:CHANGEBOX_PORTRAITX];
    }
    else 
    {
        if (self.interfaceOrientation == UIInterfaceOrientationLandscapeRight || self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
        {
            gameView = [[UIImageView alloc] initWithFrame:GAMEVIEW_LANDSCAPE];
            scoreBox = [[DataBox alloc] initWithFrame:SCOREBOX_LANDSCAPE];
            levelBox = [[DataBox alloc] initWithFrame:LEVELBOX_LANDSCAPE];
            changeBox = [[DataBox alloc] initWithFrame:CHANGEBOX_LANDSCAPE];
        }
        else
        {
            gameView = [[UIImageView alloc] initWithFrame:GAMEVIEW_PORTRAIT];
            scoreBox = [[DataBox alloc] initWithFrame:SCOREBOX_PORTRAIT];
            levelBox = [[DataBox alloc] initWithFrame:LEVELBOX_PORTRAIT];
            changeBox = [[DataBox alloc] initWithFrame:CHANGEBOX_PORTRAIT];
        }
    }
    [gameView setUserInteractionEnabled:YES];
    //[gameView setBackgroundColor:[UIColor darkGrayColor]];
    //[gameView setHidden:YES];
    
    NSInteger squareSize = 0;
    NSInteger gapSize = 0;
    NSInteger borderSize = 0;
    
    if ([self isPhone] == YES)
    {
        switch (self.boardSize){
            case 3:
                squareSize = GAMEVIEW_SIZE3X;
                gapSize = GAMEVIEW_GAP3X;
                borderSize = GAMEVIEW_BORDER3X;
                break;
            case 4:
                squareSize = GAMEVIEW_SIZE4X;
                gapSize = GAMEVIEW_GAP4X;
                borderSize = GAMEVIEW_BORDER4X;
                break;
            case 6:
                squareSize = GAMEVIEW_SIZE6X;
                gapSize = GAMEVIEW_GAP6X;
                borderSize = GAMEVIEW_BORDER6X;
                break;
            case 5:
            default:
                squareSize = GAMEVIEW_SIZE5X;
                gapSize = GAMEVIEW_GAP5X;
                borderSize = GAMEVIEW_BORDER5X;
                break;
        }
    }
    else 
    {
        switch (self.boardSize){
            case 3:
                squareSize = GAMEVIEW_SIZE3;
                gapSize = GAMEVIEW_GAP3;
                borderSize = GAMEVIEW_BORDER3;
                [gameView setImage:[UIImage imageNamed:@"3x3bkg.png"]];
                break;
            case 4:
                squareSize = GAMEVIEW_SIZE4;
                gapSize = GAMEVIEW_GAP4;
                borderSize = GAMEVIEW_BORDER4;
                break;
            case 5:
                squareSize = GAMEVIEW_SIZE5;
                gapSize = GAMEVIEW_GAP5;
                borderSize = GAMEVIEW_BORDER5;
                break;
            case 8:
                squareSize = GAMEVIEW_SIZE8;
                gapSize = GAMEVIEW_GAP8;
                borderSize = GAMEVIEW_BORDER8;
                break;
            case 10:
                squareSize = GAMEVIEW_SIZE10;
                gapSize = GAMEVIEW_GAP10;
                borderSize = GAMEVIEW_BORDER10;
                break;
            case 15:
                squareSize = GAMEVIEW_SIZE15;
                gapSize = GAMEVIEW_GAP15;
                borderSize = GAMEVIEW_BORDER15;
                break;
            case 20:
                squareSize = GAMEVIEW_SIZE20;
                gapSize = GAMEVIEW_GAP20;
                borderSize = GAMEVIEW_BORDER20;
                break;
            case 6:
            default:
                squareSize = GAMEVIEW_SIZE6;
                gapSize = GAMEVIEW_GAP6;
                borderSize = GAMEVIEW_BORDER6;
                break;
        }
    }

    
    // Build the squares...
    for (int x = 0; x < self.boardSize; x++)
    {
        for (int y = 0; y < self.boardSize; y++)
        {
            int framex = borderSize + ((squareSize+gapSize)*x);
            int framey = borderSize + ((squareSize+gapSize)*y);
            Square *btn = [[Square alloc] initWithFrame:CGRectMake(framex, framey,squareSize,squareSize)];
            [btn setBounds:CGRectMake(0, 0, squareSize, squareSize)];
            [btn setUserInteractionEnabled:YES];
            [btn setTag:((x*100)+y)+SQUARE_TAG_OFFSET];
            [btn setBoardSize:self.boardSize];
            [btn setBoardSize:self.boardSize];
            [btn setDelegate:self];
            
            [btn randomizeImageDirection];
            
            [gameView addSubview:btn];
            [btn release];
        }
    }
    
    [gameView setAlpha:0];
    [self.view addSubview:gameView];
    [self animateMyView:gameView withDelay:0.6 andDuration:0.5 andCurve:UIViewAnimationCurveLinear andTransition:UIViewAnimationTransitionNone];
    [gameView setAlpha:1];
    [UIView commitAnimations];

    [scoreBox setImage:[UIImage imageNamed:@"green.png"]];
    [scoreBox.dataLabel setText:@"SCORE"];
    [scoreBox.dataValue setText:[[NSNumber numberWithInt:self.score] stringValue]];

    [levelBox setImage:[UIImage imageNamed:@"yellow.png"]];
    [levelBox.dataLabel setText:@"LEVEL"];
    [levelBox.dataValue setText:[[NSNumber numberWithInt:self.level] stringValue]];
    
    [changeBox setImage:[UIImage imageNamed:@"red.png"]];
    [changeBox.dataLabel setText:@"CHANGE"];
    [changeBox.dataValue setText:[[NSNumber numberWithInt:self.change] stringValue]];
    
    
    [scoreBox setAlpha:0];
    [self.view addSubview:scoreBox];
    [self animateMyView:scoreBox withDelay:0.6 andDuration:0.5 andCurve:UIViewAnimationCurveLinear andTransition:UIViewAnimationTransitionNone];
    [scoreBox setAlpha:1];
    [UIView commitAnimations];
    
    [levelBox setAlpha:0];
    [self.view addSubview:levelBox];
    [self animateMyView:levelBox withDelay:0.6 andDuration:0.5 andCurve:UIViewAnimationCurveLinear andTransition:UIViewAnimationTransitionNone];
    [levelBox setAlpha:1];
    [UIView commitAnimations];
    
    [changeBox setAlpha:0];
    [self.view addSubview:changeBox];
    [self animateMyView:changeBox withDelay:0.6 andDuration:0.5 andCurve:UIViewAnimationCurveLinear andTransition:UIViewAnimationTransitionNone];
    [changeBox setAlpha:1];
    [UIView commitAnimations];
    
}

- (void) setGameButtonVisibility:(BOOL)hidden
{
    [self animateMyView:choose3Button withDelay:0 andDuration:0.5 andCurve:UIViewAnimationCurveEaseOut andTransition:UIViewAnimationTransitionFlipFromRight];
    [choose3Button setHidden:hidden];
    [UIButton commitAnimations];
    
    [self animateMyView:choose4Button withDelay:0 andDuration:0.5 andCurve:UIViewAnimationCurveEaseOut andTransition:UIViewAnimationTransitionFlipFromRight];
    [choose4Button setHidden:hidden];
    [UIButton commitAnimations];
    
    [self animateMyView:choose5Button withDelay:0 andDuration:0.5 andCurve:UIViewAnimationCurveEaseOut andTransition:UIViewAnimationTransitionFlipFromRight];
    [choose5Button setHidden:hidden];
    [UIButton commitAnimations];
    
    [self animateMyView:choose6Button withDelay:0 andDuration:0.5 andCurve:UIViewAnimationCurveEaseOut andTransition:UIViewAnimationTransitionFlipFromRight];
    [choose6Button setHidden:hidden];
    [UIButton commitAnimations];
    
    [self animateMyView:choose8Button withDelay:0 andDuration:0.5 andCurve:UIViewAnimationCurveEaseOut andTransition:UIViewAnimationTransitionFlipFromRight];
    [choose8Button setHidden:hidden];
    [UIButton commitAnimations];
    
    [self animateMyView:choose10Button withDelay:0 andDuration:0.5 andCurve:UIViewAnimationCurveEaseOut andTransition:UIViewAnimationTransitionFlipFromRight];
    [choose10Button setHidden:hidden];
    [UIButton commitAnimations];
    
    [self animateMyView:choose15Button withDelay:0 andDuration:0.5 andCurve:UIViewAnimationCurveEaseOut andTransition:UIViewAnimationTransitionFlipFromRight];
    [choose15Button setHidden:hidden];
    [UIButton commitAnimations];
    
    [self animateMyView:choose20Button withDelay:0 andDuration:0.5 andCurve:UIViewAnimationCurveEaseOut andTransition:UIViewAnimationTransitionFlipFromRight];
    [choose20Button setHidden:hidden];
    [UIButton commitAnimations];
    
    [setupButton setHidden:hidden];
    [highScoreButton setHidden:hidden];
    [helpButton setHidden:hidden];
    
    [newGameButton setHidden:!hidden];
    [changeButton setHidden:!hidden];
}

- (IBAction) touchStartGame:(id)sender
{
    [self setGameButtonVisibility:YES];
    [self setupGameView:([sender tag] % 100)];
}

- (void) resetGameBoard
{
    for (id square in [self.gameView subviews])
    {
        [square removeFromSuperview];
    }
    [self.gameView removeFromSuperview];
    [self.changeBox removeFromSuperview];
    [self.scoreBox removeFromSuperview];
    [self.levelBox removeFromSuperview];
}

- (void) gameOver
{
    NSLog(@"Call game over!");
    alertViewState = ALERT_GAMEOVER;
    terminateGame = YES;

    for (id square in [self.gameView subviews])
    {
        [square setUserInteractionEnabled:NO];
    }
    
    UIActionSheet *alert = [[UIActionSheet alloc] initWithTitle:@"Game Over" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    [alert setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    sameBoardIndex = [alert addButtonWithTitle:@"Replay Board"];
    newBoardIndex = [alert addButtonWithTitle:@"Play New Board"];
    
    [alert showInView:self.view];
    [alert release];
    
}

- (void) incrementScoreBy:(NSInteger)incScore
{
//    NSLog(@"Increment Score");
    self.score += incScore;
    [scoreBox.dataValue setText:[[NSNumber numberWithInt:self.score] stringValue]];
}

- (BOOL) hasAllGreen
{
    NSInteger left = 0;
    Square *lastSquare = nil;
    
    for (id square in [self.gameView subviews])
    {
        if([square currentImageState] != STATE_GREEN)
        {
            left = left + 1;
            lastSquare = square;
        }
    }
    
    if (left == 1)
    {
        [lastSquare setCurrentImageState:STATE_GREEN];
        return YES;
    }
    return NO;
}

- (NSInteger) countYellowsForBonus
{
    NSInteger yellow = 0;
    for (id square in [self.gameView subviews])
    {
        if ([square currentImageState] == STATE_YELLOW)
        {
            yellow = yellow+1;
        }
    }
    return yellow;
}

- (void) moveToNextLevel
{
    CGSize size = self.view.frame.size;
    LevelIndicator *li = nil;
    if (UIInterfaceOrientationIsPortrait([self interfaceOrientation]) == YES)
    {
        li = [[LevelIndicator alloc] initWithFrame:CGRectMake((size.width/2)-150, (size.height/2)-175, 300, 150)];
    }
    else
    {
        li = [[LevelIndicator alloc] initWithFrame:CGRectMake((size.width/2)-150, (size.height/2)-225, 300, 150)];
    }
    [self.view addSubview:li];
    
    self.level = self.level + 1;
    //        NSLog(@"We're moving on to level %d", self.level);
    [[self.levelBox dataValue] setText:[[NSNumber numberWithInt:self.level] stringValue]];
    
    NSInteger delay = 0;
    NSInteger delayShift = 0.02;
    for (id square in [self.gameView subviews])
    {
        [self changeSquareDirection:square withDelay:delay];
        delay += delayShift;
    }
    
    [[li levelLabel] setText:[NSString stringWithFormat:@"Level %d", self.level]];
    [li runLevelAnimation];
    [li release];
    
    // reset the square count
    self.currentSquareCount = (self.boardSize * self.boardSize);
}

- (void) showUserBonus:(NSInteger)yellow
{
    alertViewState = ALERT_LEVELBONUS;
    NSInteger bonusBase = (self.boardSize * self.boardSize) * 10;
    NSInteger bonus = bonusBase;
    
    if (yellow == 0)
    {
        // Perfect score!
        bonus = bonus * self.boardSize;
        NSString *msg = [NSString stringWithFormat:@"\nYou got a perfect score!\nBonus Multiplier %d × %d\n\nYou earned %d point bonus!", bonusBase, self.boardSize, bonus];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Perfect Score!" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        
        [alert show];
        [alert release];
        [self incrementScoreBy:bonus];
    }
    else
    {
        // Do the Bonus Algorithm!
        NSInteger bonusMultiplier = self.boardSize - yellow;

        if (bonusMultiplier > 0)
        {
            bonus = bonus * bonusMultiplier;
            NSString *msg = [NSString stringWithFormat:@"\nFinished with %d Yellow Squares\nBonus Multiplier %d × %d\n\nYou earned %d point bonus!", yellow, bonusBase, bonusMultiplier, bonus];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations!" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            [alert release];
            [self incrementScoreBy:bonus];
        }
    }
    
}

- (void) decrementSquareCount
{
    self.currentSquareCount = self.currentSquareCount - 1;
//    NSLog(@"%d empty squares left to touch", self.currentSquareCount);
    
    BOOL perfectScore = NO;
    if (self.currentSquareCount == 1 && terminateGame == NO)
    {
        perfectScore = [self hasAllGreen];
        if (perfectScore == YES)
        {
            [self incrementScoreBy:10];
            self.currentSquareCount = self.currentSquareCount - 1;
        }
    }
    
    if (self.currentSquareCount == 0 && terminateGame == NO)
    {
        if (perfectScore == YES)
        {
            // Inform user they have a perfect score!
            [self showUserBonus:0];
        }
        else
        {
            NSInteger yellow = [self countYellowsForBonus];
            if (yellow >= self.boardSize)
            {
                [self moveToNextLevel];
            }
            else
            {
                [self showUserBonus:yellow];
            }
        }
    }
}











- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
        
    }
    return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}



- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"Will rotate");
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        [self.gameView setFrame:GAMEVIEW_LANDSCAPE];

        [self.scoreBox setFrame:SCOREBOX_LANDSCAPE];
        [self.levelBox setFrame:LEVELBOX_LANDSCAPE];
        [self.changeBox setFrame:CHANGEBOX_LANDSCAPE];
        
        [self.choose3Button setFrame:CHOOSE3_LANDSCAPE];
        [self.choose4Button setFrame:CHOOSE4_LANDSCAPE];
        [self.choose5Button setFrame:CHOOSE5_LANDSCAPE];
        [self.choose6Button setFrame:CHOOSE6_LANDSCAPE];
        [self.choose8Button setFrame:CHOOSE8_LANDSCAPE];
        [self.choose10Button setFrame:CHOOSE10_LANDSCAPE];
        [self.choose15Button setFrame:CHOOSE15_LANDSCAPE];
        [self.choose20Button setFrame:CHOOSE20_LANDSCAPE];
        
        [self.newGameButton setFrame:NEWGAME_LANDSCAPE];
        [self.changeButton setFrame:CHANGE_LANDSCAPE];
        [self.setupButton setFrame:SETUP_LANDSCAPE];
        [self.highScoreButton setFrame:HIGHSCORE_LANDSCAPE];
        [self.helpButton setFrame:HELP_LANDSCAPE];
        
        [self.infoButton setFrame:INFO_LANDSCAPE];
        [self.logoImageView setFrame:LOGO_LANDSCAPE];
    }
    else
    {
        [self.gameView setFrame:GAMEVIEW_PORTRAIT];
        
        [self.scoreBox setFrame:SCOREBOX_PORTRAIT];
        [self.levelBox setFrame:LEVELBOX_PORTRAIT];
        [self.changeBox setFrame:CHANGEBOX_PORTRAIT];
        
        [self.choose3Button setFrame:CHOOSE3_PORTRAIT];
        [self.choose4Button setFrame:CHOOSE4_PORTRAIT];
        [self.choose5Button setFrame:CHOOSE5_PORTRAIT];
        [self.choose6Button setFrame:CHOOSE6_PORTRAIT];
        [self.choose8Button setFrame:CHOOSE8_PORTRAIT];
        [self.choose10Button setFrame:CHOOSE10_PORTRAIT];
        [self.choose15Button setFrame:CHOOSE15_PORTRAIT];
        [self.choose20Button setFrame:CHOOSE20_PORTRAIT];

        [self.newGameButton setFrame:NEWGAME_PORTRAIT];
        [self.changeButton setFrame:CHANGE_PORTRAIT];
        [self.setupButton setFrame:SETUP_PORTRAIT];
        [self.highScoreButton setFrame:HIGHSCORE_PORTRAIT];
        [self.helpButton setFrame:HELP_PORTRAIT];

        [self.infoButton setFrame:INFO_PORTRAIT];
        [self.logoImageView setFrame:LOGO_PORTRAIT];
    }
}


- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    shouldAllowRotate = YES;
    if (alertViewState == ALERT_NEWGAME || alertViewState == ALERT_GAMEOVER)
    {
        if (buttonIndex == cancelIndex)
        {
            return;
        }
        else if (buttonIndex == sameBoardIndex)
        {
            [self resetGameBoard];
            [self setupGameView:self.boardSize];
        }
        else if (buttonIndex == newBoardIndex)
        {
            [self resetGameBoard];
            [self setGameButtonVisibility:NO];
        }
    }
    else
    {
        NSLog(@"Should never be in this alertViewState: %d", alertViewState);
    }
    
    alertViewState = ALERT_RESET;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertViewState == ALERT_LEVELBONUS)
    {
        [self moveToNextLevel];
    }
    else
    {
        NSLog(@"Should never be in this alertState: %d", alertViewState);
    }
    alertViewState = ALERT_RESET;
}

- (void)alertViewCancel:(UIAlertView *)alertView
{
    NSLog(@"alertViewCancel");
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if ([self isPhone] == YES)
    {
        return (shouldAllowRotate && UIInterfaceOrientationIsPortrait(interfaceOrientation));
    }
    return shouldAllowRotate;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {


    [gameView release];
    [scoreBox release];
    [levelBox release];
    [changeBox release];

    [newGameButton release];
    [changeButton release];
    [setupButton release];
    [highScoreButton release];
    [helpButton release];
    
    [choose3Button release];
    [choose4Button release];
    [choose5Button release];
    [choose6Button release];
    [choose8Button release];
    [choose10Button release];
    [choose15Button release];
    [choose20Button release];
    
    [super dealloc];
}

@end

