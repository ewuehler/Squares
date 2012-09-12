//
//  MainViewController.m
//  Squares
//
//  Created by Eric on 1/10/09.
//  Copyright ciretose 2009. All rights reserved.
//

#import "MainViewController.h"
#import "MainView.h"
#import "HighScoreLoader.h"
#import "UserDataLoader.h"
#import "CurrentState.h"
#import "ConfigurationViewController.h"
#import "SquaresFreeViewController.h"
#import "HelpViewController.h"
#import "HighScoreViewController.h"
#import "FlipsideViewController.h"


#define kAccelerometerFrequency			10 //Hz
#define kFilteringFactor				0.1
#define kMinEraseInterval				0.5
#define kEraseAccelerationThreshold		2.0



@implementation MainViewController

@synthesize rootView;

@synthesize square11Button;
@synthesize square12Button;
@synthesize square13Button;
@synthesize square14Button;
@synthesize square15Button;
@synthesize square21Button;
@synthesize square22Button;
@synthesize square23Button;
@synthesize square24Button;
@synthesize square25Button;
@synthesize square31Button;
@synthesize square32Button;
@synthesize square33Button;
@synthesize square34Button;
@synthesize square35Button;
@synthesize square41Button;
@synthesize square42Button;
@synthesize square43Button;
@synthesize square44Button;
@synthesize square45Button;
@synthesize square51Button;
@synthesize square52Button;
@synthesize square53Button;
@synthesize square54Button;
@synthesize square55Button;

@synthesize scoreText;
@synthesize levelText;
@synthesize shakeText;

@synthesize scoreLabel;
@synthesize levelLabel;
@synthesize shakeLabel;

@synthesize toolbar;
@synthesize newGameButton, shakeButton, configButton, highScoreButton, helpButton;

@synthesize squareMap;

@synthesize moves;
@synthesize score;
@synthesize level;
@synthesize shake;
@synthesize gameState;
@synthesize gamesLeft;
@synthesize whichAlertSelected;

@synthesize highScoreIndex;
@synthesize highScoreScrollView;
@synthesize highScoreName;
@synthesize highScoreLabel;
@synthesize lastHighScoreName;

@synthesize infoButton;

NSInteger quitIndex = -1;
NSInteger cancelIndex = -1;
NSInteger changeIndex = -1;
NSInteger undoIndex = -1;

BOOL canUndo = NO;

int undoTouchType = -1;
int undoTargetType = -1;

UIImage *undoTouchImage = nil;
UIImage *undoTargetImage = nil;

UIButton *undoTouchButton = nil;
UIButton *undoTargetButton = nil;

BOOL shakesAreEnabled = YES;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil 
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) 
    {
        //imageHandler = [[ImageHandler alloc] init];
    }

    return self;
}

-(NSString *)squareButtonState:(UIButton *)button
{
    UIImage *targetImage = [button imageForState:UIControlStateDisabled];
    
    return [[ImageHandler sharedImageHandler] imageId:targetImage];
}


- (IBAction)launchOpenFeint
{

}

- (IBAction) showInfo
{
   // NSLog(@"show info");

    UINavigationController *nav = [[UINavigationController alloc] init];
    [[nav navigationBar] setBarStyle:UIBarStyleBlackOpaque];
    FlipsideViewController *viewController = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
    [nav pushViewController:viewController animated:NO];
    [viewController release];
    
    [self presentModalViewController:nav animated:YES];
    
}

-(void)saveUserData
{
    UserDataLoader *loader = [[UserDataLoader alloc] init];

    NSMutableDictionary *data = [loader loadUserData];
    
#ifndef SQUARES_FREE_VERSION
    [data setObject:self.lastHighScoreName forKey:@"name"];
#else
    NSNumber *pc = [data valueForKey:@"playcount"];
    if (pc == nil)
    {
        pc = [NSNumber numberWithInt:0];
    }
    if (pc != nil && [pc intValue] <= _SQUARES_FREE_COUNT)
    {
        int pci = [pc intValue] + 1;
        [data setValue:[NSNumber numberWithInt:pci] forKey:@"playcount"];
        
        NSLog(@"Adding to playcount: %d ", pci);
    }
    
#endif
//#ifdef SQUARES_DEMO_VERSION
//    [data setObject:[NSString stringWithFormat:@"%d",self.gamesLeft] forKey:@"left"];
//#endif

    [loader saveUserData:data];
    
    [data release];
    [loader release];
}

-(void)saveCurrentState
{
    CurrentState *state = [[CurrentState alloc] init];

    if (self.gameState != _PLAYING)
    {
        [state saveState:nil];
    }
    else
    {
        NSMutableDictionary *map = [NSMutableDictionary dictionaryWithCapacity:31];
        NSEnumerator *keyEnum;
        NSString *key;

        keyEnum = [self.squareMap keyEnumerator];
        while ( (key = [keyEnum nextObject]) != nil)
        {
            UIButton *btn = [self.squareMap objectForKey:key];
            NSString *saveId = [self squareButtonState:btn];
            [map setObject:saveId forKey:key];
        }

        [map setObject:[NSString stringWithFormat:@"%d",self.moves] forKey:@"moves"];
        [map setObject:[NSString stringWithFormat:@"%d",self.score] forKey:@"score"];
        [map setObject:[NSString stringWithFormat:@"%d",self.level] forKey:@"level"];
        [map setObject:[NSString stringWithFormat:@"%d",self.shake] forKey:@"shake"];

        [state saveState:map];
        
        [map release];
    }
    [state release];
}

-(void) setSquare:(UIButton *)square withImage:(UIImage *)img forType:(int)type
{
    if (type == _DIR)
    {
//        NSLog(@"square: %@; image: %@", [square description], [img description]);
        [square setImage:img forState:UIControlStateNormal];
        [square setImage:img forState:UIControlStateSelected];
        [square setImage:img forState:UIControlStateHighlighted];
        [square setImage:img forState:UIControlStateDisabled];
        [square setEnabled:YES];
    }
    else if (type == _DEAD || type == _GOOD || type == _OK)
    {
        [square setImage:img forState:UIControlStateDisabled];
        [square setEnabled:NO];
    }
}

-(void) setSquare:(UIButton *)square forType:(int)type
{
    if (type == _DIR)
    {
        int cnt = 0;
        NSString *cdir = [[ImageHandler sharedImageHandler] imageDirection:[square imageForState:UIControlStateNormal]];
        NSString *dir = [[ImageHandler sharedImageHandler] randomDirection];
        while ([cdir isEqualToString:dir] && cnt < 10)
        {
            //NSLog(@"Same direction, try again");
            dir = [[ImageHandler sharedImageHandler] randomDirection];
            cnt++; // Make sure we don't end up in an infinite loop, this should guarantee we don't
        } 
        [self setSquare:square withImage:[[ImageHandler sharedImageHandler] imageForDirection:dir imageType:type] forType:type];
    }
    else if (type == _GOOD)
    {
        [self setSquare:square withImage:[[ImageHandler sharedImageHandler] good] forType:type];
        self.score += 10;
    }
    else if (type == _OK)
    {
        [self setSquare:square withImage:[[ImageHandler sharedImageHandler] ok] forType:type];
        self.score -= 10;
    }
    else if (type == _DEAD)
    {
        [self setSquare:square withImage:[[ImageHandler sharedImageHandler] deadImageFor40] forType:type];
        // Make the final score equivalent to the number of green squares that exist * 10
        self.score += 10;
    }
}


-(void)restoreSquareButtonState:(NSString *)state forButton:(UIButton *)btn
{
    if (state == nil || [state isEqualToString:@"0"])
    {
        // Create a random purple square...
        [self setSquare:btn forType:_DIR];
        return;
    }

    NSString *typeStr = [state substringToIndex:1];
    NSInteger type = [typeStr integerValue];
    
    // Initialize the square with something so that if all else fails, it is at least a purple one...
    [self setSquare:btn forType:_DIR];

    NSString *dir = NULL;
    
    if ([state length] > 1)
    {
        // We also need to retrieve direction to get the right value, otherwise just type is enough...
        dir = [state substringFromIndex:1];
    }
    
    UIImage *img = [[ImageHandler sharedImageHandler] imageForDirection:dir imageType:type];
    [self setSquare:btn withImage:img forType:type];
    
}


- (void)viewDidLoad 
{
    [super viewDidLoad];
    
    NSBundle *mainBundle = [NSBundle mainBundle];	
    
    // afconvert -f caff -d LEI16@44100 -c 1 buzz.aif buzz.caf
	touchAudio = [[SoundEffect alloc] initWithContentsOfFile:[mainBundle pathForResource:@"touch" ofType:@"caf"]];
	shakeAudio = [[SoundEffect alloc] initWithContentsOfFile:[mainBundle pathForResource:@"shake" ofType:@"caf"]];
	buzzAudio = [[SoundEffect alloc] initWithContentsOfFile:[mainBundle pathForResource:@"buzz" ofType:@"caf"]];
	levelAudio = [[SoundEffect alloc] initWithContentsOfFile:[mainBundle pathForResource:@"level" ofType:@"caf"]];
    
    hiAudio = [[SoundEffect alloc] initWithContentsOfFile:[mainBundle pathForResource:@"hi" ofType:@"caf"]];
    uhohAudio = [[SoundEffect alloc] initWithContentsOfFile:[mainBundle pathForResource:@"uhoh" ofType:@"caf"]];
    ahhhAudio = [[SoundEffect alloc] initWithContentsOfFile:[mainBundle pathForResource:@"ahhh" ofType:@"caf"]];
    yeahAudio = [[SoundEffect alloc] initWithContentsOfFile:[mainBundle pathForResource:@"yeah" ofType:@"caf"]];
    
    self.moves = 0;
    self.score = 0;
    self.shake = _DEFAULT_SHAKES;
    self.level = 1;
    self.gameState = _INITIAL;
//#ifdef SQUARES_DEMO_VERSION
//    self.gamesLeft = 3;
//#endif
    self.squareMap = [NSDictionary dictionaryWithObjectsAndKeys:
                      square11Button, @"11", square12Button, @"12", square13Button, @"13", square14Button, @"14", square15Button, @"15",
                      square21Button, @"21", square22Button, @"22", square23Button, @"23", square24Button, @"24", square25Button, @"25",
                      square31Button, @"31", square32Button, @"32", square33Button, @"33", square34Button, @"34", square35Button, @"35",
                      square41Button, @"41", square42Button, @"42", square43Button, @"43", square44Button, @"44", square45Button, @"45",
                      square51Button, @"51", square52Button, @"52", square53Button, @"53", square54Button, @"54", square55Button, @"55",
                      nil];    
    
    UserDataLoader *loader = [[UserDataLoader alloc] init];
    
    NSMutableDictionary *user = [loader loadUserData];
    
    NSString *name = [user objectForKey:@"name"];
    if (name != nil && name != NULL)
    {
        self.lastHighScoreName = [NSString stringWithString:name];
    }
    
/* #ifdef SQUARES_DEMO_VERSION
    NSString *leftStr = [user objectForKey:@"left"];
    if (leftStr != nil)
    {
        self.gamesLeft = [leftStr integerValue];
    }
#endif
 */
    /*
    NSString *shakes = [user objectForKey:@"shakes"];
    if (shakes != nil && shakes != NULL)
    {
        self.shake = [shakes intValue];
        [self.rootView performSelector:@selector(setShakeCount:) withObject:shakes];
    }
    NSLog(@"load main view controller: %d", self.shake);
    */
    //    [name release];
    //    [shakes release];
    [user release];
    [loader release];
    
    
    //Ok, now see if we need to restore the previous state of the system
    CurrentState *state = [[CurrentState alloc] init];
    NSDictionary *map = [state loadState];
    if (map != NULL || map != nil)
    {
        // There is a valid (or hopefully valid) save file - we need to reload state...
        NSEnumerator *keyEnum;
        NSString *key;

        keyEnum = [self.squareMap keyEnumerator];
        while ( (key = [keyEnum nextObject]) != nil)
        {
            UIButton *btn = [self.squareMap objectForKey:key];
            if (btn != nil)
            {
                NSString *btnState = [map objectForKey:key];
                [self restoreSquareButtonState:btnState forButton:btn];
            }
        }
        
        NSString *movesStr = [map objectForKey:@"moves"];
        self.moves = [movesStr integerValue];
        NSString *levelStr = [map objectForKey:@"level"];
        self.level = [levelStr integerValue];
        NSString *scoreStr = [map objectForKey:@"score"];
        self.score = [scoreStr integerValue];
        NSString *shakeStr = [map objectForKey:@"shake"];
        self.shake = [shakeStr integerValue];
        
        [scoreText setText:[NSString stringWithFormat:@"%d",self.score]];
        [levelText setText:[NSString stringWithFormat:@"%d",self.level]];
        [shakeText setText:[NSString stringWithFormat:@"%d",self.shake]];
        //NSLog(@"Shakes is %d", self.shake);
        self.gameState = _PLAYING;
    }
    

    [state release];

    [highScoreLabel setText:NSLocalizedString(@"NEW_HIGH_SCORE", @"New High Score")];
    [highScoreName setPlaceholder:NSLocalizedString(@"ANONYMOUS", @"Anonymous")];
    [scoreLabel setText:NSLocalizedString(@"SCORE", @"Score")];
    [levelLabel setText:NSLocalizedString(@"LEVEL", @"Level")];
    [shakeLabel setText:NSLocalizedString(@"SHAKE", @"Shake")];

    if (self.shake == 0)
    {
        [self enableShakes:NO];
    }
    
    //NSLog(@"View loaded - set accelerometer");
	[[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / kAccelerometerFrequency)];
	[[UIAccelerometer sharedAccelerometer] setDelegate:self];

    if (self.gameState != _PLAYING)
    {
        [self startNewGame];
    }
    
}


- (void)initSquareMapLayout
{
//    NSLog(@"Level: %d", self.level);
    
    NSEnumerator *keyEnum;
    NSString *key;
    
    keyEnum = [self.squareMap keyEnumerator];
    double delay = 0.2;
    while ( (key = [keyEnum nextObject]) != nil)
    {
        UIButton *btn = [self.squareMap objectForKey:key];
        if (btn != nil)
        {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDelay:delay];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:btn cache:YES];
            
            [self setSquare:btn forType:_DIR];
            
            [UIView commitAnimations];
            
            delay += 0.1;
        }
    }
    //NSLog(@"startNewGame2: %d", self.shake);
    
    [scoreText setText:[NSString stringWithFormat:@"%d",self.score]];
    [levelText setText:[NSString stringWithFormat:@"%d",self.level]];
    [shakeText setText:[NSString stringWithFormat:@"%d",self.shake]];
    [self enableShakes:YES];

    canUndo = NO;
        
    undoTouchType = -1;
    undoTargetType = -1;
    
    undoTouchImage = nil;
    undoTargetImage = nil;
    
    undoTouchButton = nil;
    undoTargetButton = nil;
    
}


- (void)resetSquareMapLayout
{
    NSEnumerator *keyEnum;
    NSString *key;
    
    keyEnum = [self.squareMap keyEnumerator];
    while ( (key = [keyEnum nextObject]) != nil)
    {
        UIButton *btn = [self.squareMap objectForKey:key];
        if (btn != nil)
        {
            UIImage *img = [btn imageForState:UIControlStateDisabled];
            NSInteger type = [[ImageHandler sharedImageHandler] imageTypeForImage:img];
            if (type != _DIR)
            {
                UIImage *img2 = [[ImageHandler sharedImageHandler] imageForDirection:nil imageType:type];
                [self setSquare:btn withImage:img2 forType:type];
            }
        }
    }
}

-(void)squaresTrial
{
    self.whichAlertSelected = _SQUARES_FREE_TRIAL;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Squares! Free" 
                                           message:@"You are playing a free version of Squares!"
                                          delegate:self 
                                 cancelButtonTitle:nil 
                                 otherButtonTitles:nil];
    quitIndex = [alert addButtonWithTitle:@"Buy"];
    cancelIndex = [alert addButtonWithTitle:@"Play"];
    
    [alert show];
    [alert release];
}

- (void)startNewGame
{
//    NSLog(@"Start new game");
/* 
#ifdef SQUARES_DEMO_VERSION
    if (self.gamesLeft <= 0)
    {
        [self squaresTrial];
        return;
    }
#endif
    
 */
    srandom((unsigned)(time(NULL)));
    
    [self setGameState:_PLAYING];
    self.level = 1;
    
    [self.highScoreScrollView setHidden:YES];
    
    //NSLog(@"startNewGame1: %d", self.shake);
    [self initSquareMapLayout];
    self.shake = _DEFAULT_SHAKES;
    [self enableShakes:YES];

    /*
    NSString *s = [self.rootView performSelector:@selector(shakeCount)];
    if (s == nil || [s length] == 0)
    {
        self.shake = _DEFAULT_SHAKES;
    }
    else
    {
        self.shake = [s intValue];
    }
    NSLog(@"startNewGame3: %d", self.shake);
     */
    
    self.score = 0;
    self.moves = 0;
    
    [scoreText setText:[NSString stringWithFormat:@"%d",self.score]];
    [levelText setText:[NSString stringWithFormat:@"%d",self.level]];
    [shakeText setText:[NSString stringWithFormat:@"%d",self.shake]];
    
    
    if (self.shake == 0)
    {
        [self enableShakes:NO];
    }
    else
    {
        [self enableShakes:YES];
    }
}

- (IBAction)newGameTouched:(id)sender
{
    
    if (self.gameState != _PLAYING)
    {
        [self startNewGame];
    }
    else
    {
        self.whichAlertSelected = _QUIT_CURRENT_GAME;
  
        UIActionSheet *alert = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"QUIT_AREYOUSURE", @"Are you sure?")
                                                           delegate:self 
                                                  cancelButtonTitle:nil 
                                             destructiveButtonTitle:nil  
                                                  otherButtonTitles:nil];
        
        alert.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        
        quitIndex = [alert addButtonWithTitle:NSLocalizedString(@"YES", @"Yes")];
        cancelIndex = [alert addButtonWithTitle:NSLocalizedString(@"NO", @"No") ];
        
        [alert setCancelButtonIndex:cancelIndex];
        
        [alert showInView:self.view];
        [alert release];
    }
}

-(NSString *)imageInDirection:(NSString *)dir currentId:(NSString *)key
{
    NSString *rowCh = [key substringToIndex:1];
    NSString *colCh = [key substringFromIndex:1];
    
    NSInteger row = [rowCh integerValue];
    NSInteger col = [colCh integerValue];
    
    NSInteger nextRow = row;
    NSInteger nextCol = col;
    
    if ([dir isEqualToString:_W])
    {
        if (col == 1)
        {
            nextCol = 5;
        }
        else
        {
            nextCol = col - 1;
        }
    }
    else if ([dir isEqualToString:_E])
    {
        if (col == 5)
        {
            nextCol = 1;
        }
        else
        {
            nextCol = col + 1;
        }
    }
    else if ([dir isEqualToString:_N])
    {
        if (row == 1)
        {
            nextRow = 5;
        }
        else
        {
            nextRow = row - 1;
        }
    }
    else if ([dir isEqualToString:_S])
    {
        if (row == 5)
        {
            nextRow = 1;
        }
        else
        {
            nextRow = row + 1;
        }
    }
    else if ([dir isEqualToString:_NW])
    {
        if (row == 1 && col == 1)
        {
            nextRow = 5;
            nextCol = 5;
        }
        else if (row == 1)
        {
            nextRow = 5;
            nextCol = col - 1;
        }
        else if (col == 1)
        {
            nextRow = row - 1;
            nextCol = 5;
        }
        else
        {
            nextRow = row - 1;
            nextCol = col - 1;
        }
    }
    else if ([dir isEqualToString:_NE])
    {
        if (row == 1 && col == 5)
        {
            nextRow = 5;
            nextCol = 1;
        }
        else if (row == 1)
        {
            nextRow = 5;
            nextCol = col + 1;
        }
        else if (col == 5)
        {
            nextRow = row - 1;
            nextCol = 1;
        }
        else
        {
            nextRow = row - 1;
            nextCol = col + 1;
        }
    }
    else if ([dir isEqualToString:_SW])
    {
        if (row == 5 && col == 1)
        {
            nextRow = 1;
            nextCol = 5;
        }
        else if (row == 5)
        {
            nextRow = 1;
            nextCol = col - 1;
        }
        else if (col == 1)
        {
            nextRow = row + 1;
            nextCol = 5;
        }
        else
        {
            nextRow = row + 1;
            nextCol = col - 1;
        }
    }
    else if ([dir isEqualToString:_SE])
    {
        if (row == 5 && col == 5)
        {
            nextRow = 1;
            nextCol = 1;
        }
        else if (row == 5)
        {
            nextRow = 1;
            nextCol = col + 1;
        }
        else if (col == 5)
        {
            nextRow = row + 1;
            nextCol = 1;
        }
        else
        {
            nextRow = row + 1;
            nextCol = col + 1;
        }
    }
    
    return [NSString stringWithFormat:@"%d%d",nextRow,nextCol];
}


- (int) changeTarget:(UIButton *)currentButton
{
    // Change the direction of the current arrow
    UIImage *img = [currentButton currentImage];
    
    int imageType = [[ImageHandler sharedImageHandler] imageTypeForImage:img];
    
    if (imageType == _DEAD || imageType == _OK || imageType == _GOOD) return imageType;
    
    undoTouchImage = [currentButton currentImage];
    undoTouchButton = currentButton;
    undoTouchType = imageType;
    
    NSArray *arr = [self.squareMap allKeysForObject:currentButton];
    NSString *key = [arr objectAtIndex:0];
    
    NSString *dir = [[ImageHandler sharedImageHandler] imageDirection:img];
    if (dir == NULL || dir == nil) 
    {
//        NSLog(@"Current image is not changable...");
        return imageType;
    }

    NSString *newkey = [self imageInDirection:dir currentId:key];
    
    UIButton *targetButton = [self.squareMap objectForKey:newkey];
    UIImage *targetImage =  [targetButton currentImage];
    NSInteger targetType = [[ImageHandler sharedImageHandler] imageType:targetImage];
    undoTargetImage = [targetButton currentImage];
    undoTargetButton = targetButton;
    undoTargetType = targetType;
    
    canUndo = YES;
    
    [UIButton beginAnimations:nil context:NULL];
    [UIButton setAnimationDuration:0.5];
    [UIButton setAnimationCurve:UIViewAnimationCurveEaseOut];
    if (targetType != _DIR)
    {
        [UIButton setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:currentButton cache:YES];
    }
    
    if (targetType != _DEAD)
    {
        [UIButton setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:targetButton cache:YES];
    }
    
    int sound = 2;
    if (targetType == _DIR || targetType == _GOOD || targetType == _OK)
    {
        NSNumber *n = [self.rootView performSelector:@selector(soundType)];
        sound = [n intValue];
    }
    
    int movesLeft = [self movesLeft];
    int returnType = _GOOD;
    if (targetType == _DIR)
    {
        [self setSquare:currentButton forType:_DIR];
        [self setSquare:targetButton forType:_GOOD];
        returnType = _GOOD;
        if (sound == 0 && movesLeft > 1)
            [touchAudio play];
        else if (sound == 1 && movesLeft > 1)
            [hiAudio play];
    }
    else if (targetType == _GOOD)
    {
        [self setSquare:currentButton forType:_GOOD];
        [self setSquare:targetButton forType:_OK];
        returnType = _OK;
        if (sound == 0 && movesLeft > 1)
            [shakeAudio play];
        else if (sound == 1 && movesLeft > 1)
            [uhohAudio play];
    }
    else if (targetType == _OK)
    {
        [self setSquare:currentButton forType:_OK];
        [self setSquare:targetButton forType:_DEAD];
        returnType = _DEAD;
        if (sound == 0 && movesLeft > 1)
            [buzzAudio play];
        else if (sound == 1 && movesLeft > 1)
            [ahhhAudio play];
    }
    else if (targetType == _DEAD)
    {
        [self setSquare:currentButton forType:_DEAD];
        returnType = _DEAD;
    }
    
    [UIButton commitAnimations];
    
    self.moves++;
    [scoreText setText:[NSString stringWithFormat:@"%d",self.score]];
    [levelText setText:[NSString stringWithFormat:@"%d",self.level]];
    [shakeText setText:[NSString stringWithFormat:@"%d",self.shake]];
    if (self.shake > 0)
    {
        [self enableShakes:YES];
    }
    else
    {
        [self enableShakes:NO];
    }
    return returnType;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
//    NSLog(@"lastHighScoreName: %@",self.lastHighScoreName);
//    NSLog(@"textfield text: %@", [textField text]);
    if (self.lastHighScoreName != nil && [self.lastHighScoreName length] > 0 && [[textField text] length] <= 0)
    {
//        NSLog(@"Set the last high score name: %@", self.lastHighScoreName);
       [textField setText:self.lastHighScoreName];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
  //  NSLog(@"Did end editing");
    // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    //NSLog(@"we should stop now");
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.highScoreName resignFirstResponder];
   // NSLog(@"we're all done");
    
    [self.highScoreLabel setHidden:YES];
    [self.highScoreName setHidden:YES];
    [self.highScoreScrollView setHidden:YES];
    
    [self.highScoreName resignFirstResponder];
    [textField resignFirstResponder];
    return YES;
}

- (void) canReceiveCallbacksNow
{
   // NSLog(@"canReceiveCallbacksNow");
    
}


- (IBAction)chosenHighScoreName
{
    //NSLog(@"we've chosen a name");
    
    [self.highScoreName resignFirstResponder];
    [self.highScoreName setHidden:YES];
    [self.infoButton setEnabled:YES];
    [self.highScoreScrollView setHidden:YES];
    
    NSString *name = [self.highScoreName text];
    if (name == nil || [name length] <= 0)
    {
        //if (name != nil) [name release];
        name = NSLocalizedString(@"ANONYMOUS", @"Anonymous");
    }
    else
    {
        self.lastHighScoreName = [NSString stringWithString:name];
    }
    
    NSMutableDictionary *hs = [NSMutableDictionary dictionaryWithCapacity:4];
    [hs setValue:name forKey:@"name"];
    [hs setValue:[NSNumber numberWithInteger:self.score] forKey:@"score"];
    [hs setValue:[NSDate date] forKey:@"date"];
    [hs setValue:[NSNumber numberWithInteger:self.level] forKey:@"level"];
   
    HighScoreLoader *loader = [[HighScoreLoader alloc] init];
    NSMutableArray *arr = [loader loadHighScores];
    
    NSInteger idx = 0;
    if (self.highScoreIndex == -1)
    {
        [arr addObject:hs];
        idx = [arr count] - 1;
    }
    else
    {
        [arr insertObject:hs atIndex:self.highScoreIndex];
        idx = self.highScoreIndex;
    }
    [loader saveHighScores:arr];
    
    [hs release];
    [loader release];
    
    //NSLog(@"Show number at: %d", idx);
    //[self showHighScore:idx];
    
}

-(void)addNewHighScore
{
    //NSLog(@"addNewHighScore");
    [self.infoButton setEnabled:NO];
    
    [self.highScoreLabel setHidden:NO];
    [self.highScoreName setHidden:NO];
    [self.highScoreScrollView setAlpha:0.9f];

    [self.highScoreScrollView setHidden:NO];
    
    if (self.lastHighScoreName == nil)
    {
        [self.highScoreName setText:@""];
    }
    else
    {
        [self.highScoreName setText:self.lastHighScoreName];
    }

    [self.highScoreName becomeFirstResponder];
}

-(void)checkAndSetHighScore
{
    //NSLog(@"checkAndSetHighScore");
    HighScoreLoader *loader = [[HighScoreLoader alloc] init];
    
    NSMutableArray *arr = [loader loadHighScores];

    NSUInteger cnt = [arr count];
    if (cnt > 0)
    {
       // NSLog(@"Need to figure out where this new high score fits");
        
        NSMutableDictionary *scores = NULL;
        
        self.highScoreIndex = -1;
        for (NSUInteger i = 0; i < cnt; i++)
        {
            scores = [arr objectAtIndex:i];
            
            NSNumber *s = [scores valueForKey:@"score"];
            NSInteger sc = [s integerValue];
            if (sc <= self.score)
            {
                self.highScoreIndex = i;
                break;
            }
        }

        if (cnt == _MAX_HIGH_SCORES)
        {
            if (self.highScoreIndex != -1 && self.highScoreIndex < _MAX_HIGH_SCORES)
            {
                [self addNewHighScore];
            }
            else
            {
               // NSLog(@"Vibrate action...");
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            }
        }
        else
        {
            [self addNewHighScore];
        }
    }
    else
    {
        self.highScoreIndex = -1;
        [self addNewHighScore];
    }
    
    [loader release];
}

-(int) movesLeft
{
    int counter = 0;
    NSEnumerator *keyEnum;
    NSString *key;
    
    keyEnum = [self.squareMap keyEnumerator];
    while ( (key = [keyEnum nextObject]) != nil)
    {
        UIButton *btn = [self.squareMap objectForKey:key];
        if (btn.enabled)
        {
            counter++;
        }
    }
    return counter;
}

/*
-(int) hasDead
{
    int counter = 0;
    NSEnumerator *keyEnum;
    NSString *key;
    NSLog(@"looking for dead");
    UIImage *deadImg = [[ImageHandler sharedImageHandler] dead];
    
    keyEnum = [self.squareMap keyEnumerator];
    while ( (key = [keyEnum nextObject]) != nil)
    {
        UIButton *btn = [self.squareMap objectForKey:key];
        if ([btn imageForState:UIControlStateDisabled] == deadImg)
        {
            counter++;
        }
    }
    return counter;
}
 */

- (void) changeLastTargetForUberBonus
{
    NSEnumerator *keyEnum;
    NSString *key;
    
    keyEnum = [self.squareMap keyEnumerator];
    while ( (key = [keyEnum nextObject]) != nil)
    {
        UIButton *btn = [self.squareMap objectForKey:key];
        if ([btn imageForState:UIControlStateDisabled] != [[ImageHandler sharedImageHandler] good])
        {
            [self setSquare:btn forType:_GOOD];
        }
    }
}

-(int) bonusCount
{
    int counter = 0;
    NSEnumerator *keyEnum;
    NSString *key;
    
    keyEnum = [self.squareMap keyEnumerator];
    while ( (key = [keyEnum nextObject]) != nil)
    {
        UIButton *btn = [self.squareMap objectForKey:key];
        if ([btn imageForState:UIControlStateDisabled] == [[ImageHandler sharedImageHandler] ok])
        {
            counter++;
        }
    }
    return counter;
}

-(void) showGameOver
{
    self.whichAlertSelected = _GAME_OVER;
    
    [self enableShakes:NO];
    
    NSEnumerator *keyEnum;
    NSString *key;
    
    keyEnum = [self.squareMap keyEnumerator];
    while ( (key = [keyEnum nextObject]) != nil)
    {
        UIButton *btn = [self.squareMap objectForKey:key];
        if (btn != nil)
        {                
            btn.enabled = NO;
        }
    }
    
    [self.highScoreLabel setHidden:YES];
    [self.highScoreName setHidden:YES];
    [self.highScoreScrollView setHidden:NO];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"GAME_OVER", @"Game Over") 
                                                    message:[NSString stringWithFormat:NSLocalizedString(@"FINAL_SCORE", @"Final Score"), self.score]
                                                   delegate:self 
                                          cancelButtonTitle:NSLocalizedString(@"OK", @"OK") 
                                          otherButtonTitles:nil];
    
    [alert show];
    [alert release];    
}

- (void) checkForLevelAchievements
{

}

- (void) checkForScoreAchievements
{
}


-(IBAction) squareTouched:(UIButton *)square
{
    int deadType = [self changeTarget:square];
    //NSLog(@"DeadType: %d", deadType);
    
    //int deadCount = [self hasDead];

    if (deadType == _DEAD)
    {
#ifndef SQUARES_FREE_VERSION
        [self checkForScoreAchievements];
#endif
        [self showGameOver];
        return;
    }
    
    int movesLeft = [self movesLeft];

    if (movesLeft == 1)
    {
        // If we only have one move left, then we get the uber bonus and we'll change the remaining square
        if ([self bonusCount] < 1)
        {
            [self changeLastTargetForUberBonus];
            movesLeft = 0;
        }
        else
        {
            return;
        }
    }
    
    if (movesLeft == 0)
    {
        
        // Continue the game...
        self.whichAlertSelected = _LEVEL_COMPLETE;
        [self enableShakes:NO];
        
        int bonus = [self bonusCount];
        int bonusScore = 0;
        if (bonus <= 1)
        {
            bonusScore = 1250;
            self.shake += 5;
        }
        else if (bonus == 2)
        {
            bonusScore = 750;
            self.shake += 2;
        }
        else if (bonus == 3)
        {
            bonusScore = 500;
            self.shake += 1;
        }
        else if (bonus == 4)
        {
            bonusScore = 250;
        }
        
        UIAlertView *alert = NULL;
        
        if (bonusScore > 0)
        {
            self.score += bonusScore;
            alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"LEVEL_CLEARED", @"Level cleared"), self.level] 
                                               message:[NSString stringWithFormat:NSLocalizedString(@"BONUS_POINTS", @"Bonus points!"), bonusScore]
                                              delegate:self 
                                     cancelButtonTitle:NSLocalizedString(@"OK", @"Ok")
                                     otherButtonTitles:nil];
            
        }
        else
        {
            alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"LEVEL_CLEARED", @"Level cleared"), self.level]  
                                               message:NSLocalizedString(@"NO_BONUS", @"No Bonus") 
                                              delegate:self 
                                     cancelButtonTitle:NSLocalizedString(@"OK", @"Ok")
                                     otherButtonTitles:nil];
            
        }

        [alert show];
        [alert release];
        self.level = self.level + 1;
        if ( (self.level % 5) == 0)
        {
            self.shake = self.shake + 1;
        }
        
        
        NSNumber *n = [self.rootView performSelector:@selector(soundType)];
        int sound = [n intValue];
        if (sound == 0)
        {
            [levelAudio play];
        }
        else if (sound == 1)
        {
            [yeahAudio play];
        }
#ifndef SQUARES_FREE_VERSION
        [self checkForLevelAchievements];
#endif
        
    }
}

- (void) changeSquareDirections
{
    self.shake = self.shake - 1;
    canUndo = NO;
    
    if (self.shake == 0)
    {
        [self enableShakes:NO];
    }
    NSEnumerator *keyEnum;
    NSString *key;
    
    keyEnum = [self.squareMap keyEnumerator];
    double delay = 0.2;
    while ( (key = [keyEnum nextObject]) != nil)
    {
        UIButton *btn = [self.squareMap objectForKey:key];
        UIImage *img = [btn imageForState:UIControlStateDisabled];
        
        NSInteger type = [[ImageHandler sharedImageHandler] imageType:img];
        if (type == _DIR)
        {
            [UIButton beginAnimations:nil context:NULL];
            [UIButton setAnimationDelay:delay];
            [UIButton setAnimationDuration:0.5];
            [UIButton setAnimationCurve:UIViewAnimationCurveEaseOut];
            [UIButton setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:btn cache:YES];
            
            [self setSquare:btn forType:type];
            
            [UIButton commitAnimations];
            delay += 0.2;
        }
    }    
    [scoreText setText:[NSString stringWithFormat:@"%d",self.score]];
    [levelText setText:[NSString stringWithFormat:@"%d",self.level]];
    [shakeText setText:[NSString stringWithFormat:@"%d",self.shake]];
    
}

- (void) doUndo
{
    if (undoTouchImage != nil && undoTouchButton != nil && undoTargetImage != nil && undoTargetButton != nil && undoTouchType != -1 && undoTargetType != -1)
    {
        canUndo = NO;
        
        [self setSquare:undoTouchButton withImage:undoTouchImage forType:undoTouchType];
        [self setSquare:undoTargetButton withImage:undoTargetImage forType:undoTargetType];
        
        if (undoTargetType == _DIR) 
        {
            self.score -= 10;
            [scoreText setText:[NSString stringWithFormat:@"%d",self.score]];
        }

        //self.shake -= 1;
        //[shakeText setText:[NSString stringWithFormat:@"%d",self.shake]];
        
        undoTouchType = -1;
        undoTargetType = -1;
        
        undoTouchImage = nil;
        undoTargetImage = nil;
        
        undoTouchButton = nil;
        undoTargetButton = nil;
        
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.whichAlertSelected == _SHAKE_DETECTED && buttonIndex == changeIndex)
    {
        [self changeSquareDirections]; 
    }
    else if (self.whichAlertSelected == _SHAKE_DETECTED && buttonIndex == undoIndex)
    {
        [self doUndo];
    }
    else if (self.whichAlertSelected == _QUIT_CURRENT_GAME && buttonIndex != cancelIndex)
    {
        [self startNewGame];
    }
    else
    {
        // Cancel
    }
    
    // Reset the alert pane...
    self.whichAlertSelected = _NO_ALERT_SELECTED;
    quitIndex = -1;
    cancelIndex = -1;
    changeIndex = -1;
    undoIndex = -1;
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // NSLog(@"AlertView button clicked: %@", alertView);
    
    if (self.whichAlertSelected == _LEVEL_COMPLETE)
    {
        [self setGameState:_PLAYING];
        [self initSquareMapLayout];
    }
    else if (self.whichAlertSelected == _GAME_OVER)
    {
        [self setGameState:_COMPLETE];
#ifndef SQUARES_FREE_VERSION
        [self checkAndSetHighScore];
#else
        [self saveUserData];
#endif
    }
    else if (self.whichAlertSelected == _SHAKE_DETECTED && buttonIndex != 0)
    {
        [self changeSquareDirections]; 
    }
    else if (self.whichAlertSelected == _QUIT_CURRENT_GAME && buttonIndex != cancelIndex)
    {
        [self startNewGame];
    }
    else if (self.whichAlertSelected == _NO_SHAKES_LEFT)
    {
        
    }

    quitIndex = -1;
    cancelIndex = -1;
    changeIndex = -1;
    undoIndex = -1;
    // Reset the alert pane...
    self.whichAlertSelected = _NO_ALERT_SELECTED;
}
        
- (IBAction)showHighScore
{
    [self showHighScore:-1];
}

- (void) showHighScore:(NSInteger)row
{
//    if ([self.highScoreName isFirstResponder] == YES)
//    {
//        NSLog(@"high score name is first reponder still");
//    }
    [self.highScoreName resignFirstResponder];
    
    UINavigationController *nav = [[UINavigationController alloc] init];
    [[nav navigationBar] setBarStyle:UIBarStyleBlackOpaque];
    
    HighScoreViewController *highScoreController = [[HighScoreViewController alloc] initWithNibName:@"HighScoreView" bundle:nil];
    
    [nav pushViewController:highScoreController animated:NO];
    [highScoreController setCurrentRow:row];
    [highScoreController release];    
    
    [self presentModalViewController:nav animated:YES];
}


- (IBAction)showHelp 
{
    UINavigationController *nav = [[UINavigationController alloc] init];
    [[nav navigationBar] setBarStyle:UIBarStyleBlackOpaque];
    HelpViewController *helpController = [[HelpViewController alloc] initWithNibName:@"HelpView" bundle:nil];
    [nav pushViewController:helpController animated:NO];
    [helpController release];
    
    [self presentModalViewController:nav animated:YES];
    
}

- (void)enableShakes:(BOOL)status
{
    if (status == YES && self.gameState == _PLAYING && self.shake > 0)
    {
        [shakeButton setEnabled:YES];
        shakesAreEnabled = YES;
    }
    else
    {
        [shakeButton setEnabled:NO];
        shakesAreEnabled = NO;
    }
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [self enableShakes:NO];
}

-(void)viewDidAppear:(BOOL)animated
{
   // NSLog(@"View did appear");
    [self enableShakes:YES];
    [self.infoButton setEnabled:YES];
   // NSLog(@"highscore is first responder: %d", [self.highScoreName isFirstResponder]);
   // [self.highScoreName resignFirstResponder];
}

- (void) shakeAction
{
    if (shakesAreEnabled == NO)
    {
        //NSLog(@"Game view is currently hidden...");
        return;
    }
    
    if (self.shake <= 0)
    {
        self.whichAlertSelected = _NO_SHAKES_LEFT;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"SHAKE_UP", @"Shake!")
                                                        message:NSLocalizedString(@"NO_SHAKES", @"No Shakes")
                                                       delegate:self 
                                              cancelButtonTitle:NSLocalizedString(@"OK", @"Ok") 
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }
    else
    {
        self.whichAlertSelected = _SHAKE_DETECTED;
        NSString *msg = NULL;
        if (self.shake == 1)
        {
            msg = @"SHAKE_LEFT";
        }
        else
        {
            msg = @"SHAKES_LEFT";
        }
        
        NSString *undoMsg = NULL;
        if (canUndo)
        {
            undoMsg = @"CAN_UNDO";
        }
        else
        {
            undoMsg = @"NO_CAN_UNDO";
        }
        
        UIActionSheet *alert = [[UIActionSheet alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(msg, @"Shakes left"), NSLocalizedString(undoMsg, @"Shakes left"), self.shake]
                                                       delegate:self 
                                              cancelButtonTitle:nil 
                                         destructiveButtonTitle:nil  
                                              otherButtonTitles:nil];
        
        alert.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        
        if (canUndo && self.shake > 0)
        {
            undoIndex = [alert addButtonWithTitle:NSLocalizedString(@"UNDO", @"Undo")];
        }
        
        changeIndex = [alert addButtonWithTitle:NSLocalizedString(@"CHANGE", @"Change")];
        cancelIndex = [alert addButtonWithTitle:NSLocalizedString(@"CANCEL", @"Cancel")];

        [alert setCancelButtonIndex:cancelIndex];
        
        [alert showInView:self.view];
        [alert release];
        [msg release];
    }
}

-(IBAction) touchShowConfiguration:(id)sender
{
    UINavigationController *nav = [[UINavigationController alloc] init];
    [[nav navigationBar] setBarStyle:UIBarStyleBlackOpaque];
    
#ifndef SQUARES_FREE_VERSION
    
    ConfigurationViewController *cViewController = [[ConfigurationViewController alloc] initWithNibName:@"ConfigurationViewController" bundle:nil];
    [cViewController setMainViewController:self];
    [nav pushViewController:cViewController animated:NO];
    [cViewController release];
    
#else
    
    SquaresFreeViewController *viewController = [[SquaresFreeViewController alloc] initWithNibName:@"SquaresFreeView" bundle:nil];
    [nav pushViewController:viewController animated:NO];
    [viewController release];
    
#endif
    
    [self presentModalViewController:nav animated:YES];
}

- (IBAction) shakeTouched:(id)sender
{
    if (self.gameState != _PLAYING)
    {
        return;
    }
    [self shakeAction];
}

- (void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    if (self.gameState != _PLAYING)
    {
//        NSLog(@"not playing - ignore accelerometer for now...");
        return;
    }
    
	UIAccelerationValue length;
    UIAccelerationValue x;
    UIAccelerationValue y;
    UIAccelerationValue z;
	
    // Shake code taken from GLPaint example from Apple developer
	//Use a basic high-pass filter to remove the influence of the gravity
	myAccelerometer[0] = acceleration.x * kFilteringFactor + myAccelerometer[0] * (1.0 - kFilteringFactor);
	myAccelerometer[1] = acceleration.y * kFilteringFactor + myAccelerometer[1] * (1.0 - kFilteringFactor);
	myAccelerometer[2] = acceleration.z * kFilteringFactor + myAccelerometer[2] * (1.0 - kFilteringFactor);
	// Compute values for the three axes of the acceleromater
	x = acceleration.x - myAccelerometer[0];
	y = acceleration.y - myAccelerometer[0];
	z = acceleration.z - myAccelerometer[0];
	
	//Compute the intensity of the current acceleration 
	length = sqrt(x * x + y * y + z * z);
	// If above a given threshold, play the erase sounds and erase the drawing view
	if((length >= kEraseAccelerationThreshold) && (CFAbsoluteTimeGetCurrent() > lastShakeTime + kMinEraseInterval) && self.whichAlertSelected != _SHAKE_DETECTED) 
    {
        //NSLog(@"detected shake");
	
        lastShakeTime = CFAbsoluteTimeGetCurrent();
        
        [self shakeAction];
    }
}

- (void) setImageType:(NSNumber *)type
{
    if ([type intValue] == _FACE_ANIME)
    {
        [[ImageHandler sharedImageHandler] setAnimeFaces];
    }
    else if ([type intValue] == _FACE_CURMUDGEN)
    {
        [[ImageHandler sharedImageHandler] setCurmudgenFaces];
    }
    else if ([type intValue] == _FACE_MONSTER)
    {
        [[ImageHandler sharedImageHandler] setMonsterFaces];
    }
    else if ([type intValue] == _FACE_STICKA)
    {
        [[ImageHandler sharedImageHandler] setStickaFaces];
    }
    else
    {
        [[ImageHandler sharedImageHandler] setDefaultFaces];
    }
    
    if (self.gameState == _PLAYING)
    {
        if ([type intValue] == _FACE_CUSTOM)
        {
            [self resetSquareMapLayout];
            [[ImageHandler sharedImageHandler] setCustomFaces];
        }
        
        [self resetSquareMapLayout];
    }
    else
    {
        if ([type intValue] == _FACE_CUSTOM)
        {
            [[ImageHandler sharedImageHandler] setCustomFaces];
        }
        
    }
}

- (void) setUseSoundType:(NSNumber *)type
{
    [self.rootView performSelector:@selector(setUseSoundType:) withObject:type];
}

- (void) playSound:(int)type
{
    if (type == 0)
        [touchAudio play];
    else if (type == 1)
        [hiAudio play];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)dealloc {
    
    [touchAudio release];
    [shakeAudio release];
    [buzzAudio release];
    [levelAudio release];
	
    [squareMap release];
    
   
    
    [rootView release];

    [square11Button release];
    [square12Button release];
    [square13Button release];
    [square14Button release];
    [square15Button release];
    [square21Button release];
    [square22Button release];
    [square23Button release];
    [square24Button release];
    [square25Button release];
    [square31Button release];
    [square32Button release];
    [square33Button release];
    [square34Button release];
    [square35Button release];
    [square41Button release];
    [square42Button release];
    [square43Button release];
    [square44Button release];
    [square45Button release];
    [square51Button release];
    [square52Button release];
    [square53Button release];
    [square54Button release];
    [square55Button release];
    
    
    [scoreText release];
    [levelText release];
    [shakeText release];
    
    [scoreLabel release];
    [levelLabel release];
    [shakeLabel release];
    
    [toolbar release];
    [newGameButton release];
    [shakeButton release];
    [configButton release];
    [highScoreButton release];
    [helpButton release];
    
    [highScoreScrollView release];
    [highScoreLabel release];
    [highScoreName release];
    
    [squareMap release];
    
    [lastHighScoreName release];
    
    [infoButton release];
    
    [super dealloc];
}


@end
