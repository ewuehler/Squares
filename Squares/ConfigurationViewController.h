//
//  ConfigurationViewController.h
//  Squares
//
//  Created by Eric on 5/9/09.
//  Copyright 2009 ciretose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"


@interface ConfigurationViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate> {

    MainViewController *mainViewController;
    
    UILabel *soundLabel;
    UISegmentedControl *soundTypeControl;

    UILabel *faceLabel;
    UIButton *defaultImages;
    UIButton *animeImages;
    UIButton *curmudgenImages;
    UIButton *monsterImages;
    UIButton *stickaImages;
    
    UIButton *defaultCheck;
    UIButton *animeCheck;
    UIButton *curmudgenCheck;
    UIButton *monsterCheck;
    UIButton *stickaCheck;
    UIButton *customCheck;
    
    UIButton *customHappy;
    UIButton *customNervous;
    UIButton *customSad;
    
}

@property (nonatomic, retain) MainViewController *mainViewController;

@property (nonatomic, retain) IBOutlet UILabel *soundLabel;
@property (nonatomic, retain) IBOutlet UISegmentedControl *soundTypeControl;

@property (nonatomic, retain) IBOutlet UILabel *faceLabel;
@property (nonatomic, retain) IBOutlet UIButton *defaultImages;
@property (nonatomic, retain) IBOutlet UIButton *animeImages;
@property (nonatomic, retain) IBOutlet UIButton *curmudgenImages;
@property (nonatomic, retain) IBOutlet UIButton *monsterImages;
@property (nonatomic, retain) IBOutlet UIButton *stickaImages;

@property (nonatomic, retain) IBOutlet UIButton *defaultCheck;
@property (nonatomic, retain) IBOutlet UIButton *animeCheck;
@property (nonatomic, retain) IBOutlet UIButton *curmudgenCheck;
@property (nonatomic, retain) IBOutlet UIButton *monsterCheck;
@property (nonatomic, retain) IBOutlet UIButton *stickaCheck;
@property (nonatomic, retain) IBOutlet UIButton *customCheck;

@property (nonatomic, retain) IBOutlet UIButton *customHappy;
@property (nonatomic, retain) IBOutlet UIButton *customNervous;
@property (nonatomic, retain) IBOutlet UIButton *customSad;


- (IBAction)saveUserData:(id)sender;

- (IBAction)touchSound:(id)sender;

- (IBAction)touchDefaultFace:(id)sender;
- (IBAction)touchAnimeFace:(id)sender;
- (IBAction)touchCurmudgenFace:(id)sender;
- (IBAction)touchMonsterFace:(id)sender;
- (IBAction)touchStickaFace:(id)sender;
- (IBAction)touchCustomFace:(id)sender;

- (void)loadCustomFaces;
-(IBAction)acquireCustomHappy:(id)sender;
-(IBAction)acquireCustomNervous:(id)sender;
-(IBAction)acquireCustomSad:(id)sender;

-(IBAction)touchMUR;
-(IBAction)touchSticka;


@end
