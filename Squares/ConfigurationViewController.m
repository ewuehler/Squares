//
//  ConfigurationViewController.m
//  Squares
//
//  Created by Eric on 5/9/09.
//  Copyright 2009 ciretose. All rights reserved.
//

#import "ConfigurationViewController.h"
#import "MainViewController.h"
#import "UserDataLoader.h"

@implementation ConfigurationViewController

@synthesize mainViewController;
@synthesize soundLabel;
@synthesize soundTypeControl;

@synthesize faceLabel;
@synthesize defaultImages;
@synthesize animeImages;
@synthesize curmudgenImages;
@synthesize monsterImages;
@synthesize stickaImages;
@synthesize defaultCheck;
@synthesize animeCheck;
@synthesize curmudgenCheck;
@synthesize monsterCheck;
@synthesize stickaCheck;

@synthesize customCheck;
@synthesize customHappy;
@synthesize customNervous;
@synthesize customSad;

int customFace = _CUSTOM_GREEN;

int facetype = _FACE_DEFAULT;
BOOL ready = NO;
BOOL loadingImagePicker = NO;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self)
	{
		// this will appear as the title in the navigation bar
		//self.title = NSLocalizedString(@"config", @"");
	}
	return self;
}


- (void)viewDidLoad {

    ready = NO;
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];      
    
    UIImageView *squaresView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title2.0.png"]];
    [squaresView setFrame:CGRectMake(92.0, 0.0, 128.0, 40.0)];
    self.navigationItem.titleView = squaresView;
    [squaresView release];

    UIBarButtonItem *doneButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(touchDismiss)] autorelease];
	self.navigationItem.rightBarButtonItem = doneButton;
    
    [soundLabel setText:NSLocalizedString(@"SOUND", @"Sound")];
    
    [soundTypeControl setTintColor:[UIColor darkGrayColor]];
    [soundTypeControl setTitle:NSLocalizedString(@"DEFAULT", @"Default") forSegmentAtIndex:0];
    [soundTypeControl setTitle:NSLocalizedString(@"CUTE", @"Cute") forSegmentAtIndex:1];
    [soundTypeControl setTitle:NSLocalizedString(@"OFF", @"Off") forSegmentAtIndex:2];
    
    [faceLabel setText:NSLocalizedString(@"FACE", @"Face")];
    
    UserDataLoader *loader = [[UserDataLoader alloc] init];
    
    NSDictionary *map = [loader loadUserData];
    
    NSNumber *t = [map objectForKey:@"soundtype"];
    
    if (t == nil)
    {
        [soundTypeControl setSelectedSegmentIndex:0];
    }
    else
    {
        [soundTypeControl setSelectedSegmentIndex:[t intValue]];
    }
    
    NSNumber *f = [map objectForKey:@"facetype"];
    if (f == nil)
    {
        [self touchDefaultFace:nil];
    }
    else
    {
        switch ([f intValue])
        {
            case _FACE_ANIME:
                [self touchAnimeFace:nil];
                break;
            case _FACE_CURMUDGEN:
                [self touchCurmudgenFace:nil];
                break;
            case _FACE_MONSTER:
                [self touchMonsterFace:nil];
                break;
            case _FACE_STICKA:
                [self touchStickaFace:nil];
                break;
            case _FACE_CUSTOM:
                [self touchCustomFace:nil];
                break;
            case _FACE_DEFAULT:
            default:
                [self touchDefaultFace:nil];
                break;
        }
        
    }
    
    [self loadCustomFaces];
    
    ready = YES;
    
    [f release];
    [t release];
    [loader release];

    [super viewDidLoad];
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */
-(IBAction)touchDismiss
{
    //NSLog(@"touched dismiss");
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)touchSound:(id)sender
{
    if (ready == YES)
    {
        int sound = [soundTypeControl selectedSegmentIndex];
        
        [self.mainViewController playSound:sound];
    }
    
}

- (IBAction)touchMUR
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.mur-design.com"]];
    
}

- (IBAction)touchSticka
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://tylersticka.com/"]];
    
}


- (IBAction)touchDefaultFace:(id)sender
{
    [self.defaultImages setSelected:YES];
    [self.animeImages setSelected:NO];
    [self.curmudgenImages setSelected:NO];
    [self.monsterImages setSelected:NO];
    [self.stickaImages setSelected:NO];
    [self.defaultCheck setSelected:YES];
    [self.animeCheck setSelected:NO];
    [self.curmudgenCheck setSelected:NO];
    [self.monsterCheck setSelected:NO];
    [self.stickaCheck setSelected:NO];
    [self.customCheck setSelected:NO];
    facetype = _FACE_DEFAULT;
}

- (IBAction)touchAnimeFace:(id)sender;
{
    [self.defaultImages setSelected:NO];
    [self.animeImages setSelected:YES];
    [self.curmudgenImages setSelected:NO];
    [self.monsterImages setSelected:NO];
    [self.stickaImages setSelected:NO];
    [self.defaultCheck setSelected:NO];
    [self.animeCheck setSelected:YES];
    [self.curmudgenCheck setSelected:NO];
    [self.monsterCheck setSelected:NO];
    [self.stickaCheck setSelected:NO];
    [self.customCheck setSelected:NO];
    facetype = _FACE_ANIME;
}

- (IBAction)touchCurmudgenFace:(id)sender;
{
    [self.defaultImages setSelected:NO];
    [self.animeImages setSelected:NO];
    [self.curmudgenImages setSelected:YES];
    [self.monsterImages setSelected:NO];
    [self.stickaImages setSelected:NO];
    [self.defaultCheck setSelected:NO];
    [self.animeCheck setSelected:NO];
    [self.curmudgenCheck setSelected:YES];
    [self.monsterCheck setSelected:NO];
    [self.stickaCheck setSelected:NO];
    [self.customCheck setSelected:NO];
    facetype = _FACE_CURMUDGEN;
}

- (IBAction)touchMonsterFace:(id)sender;
{
    [self.defaultImages setSelected:NO];
    [self.animeImages setSelected:NO];
    [self.curmudgenImages setSelected:NO];
    [self.monsterImages setSelected:YES];
    [self.stickaImages setSelected:NO];
    [self.defaultCheck setSelected:NO];
    [self.animeCheck setSelected:NO];
    [self.curmudgenCheck setSelected:NO];
    [self.monsterCheck setSelected:YES];
    [self.stickaCheck setSelected:NO];
    [self.customCheck setSelected:NO];
    facetype = _FACE_MONSTER;
}

- (IBAction)touchStickaFace:(id)sender;
{
    [self.defaultImages setSelected:NO];
    [self.animeImages setSelected:NO];
    [self.curmudgenImages setSelected:NO];
    [self.monsterImages setSelected:NO];
    [self.stickaImages setSelected:YES];
    [self.defaultCheck setSelected:NO];
    [self.animeCheck setSelected:NO];
    [self.curmudgenCheck setSelected:NO];
    [self.monsterCheck setSelected:NO];
    [self.stickaCheck setSelected:YES];
    [self.customCheck setSelected:NO];
    facetype = _FACE_STICKA;
}

- (IBAction)touchCustomFace:(id)sender;
{
    [self.defaultImages setSelected:NO];
    [self.animeImages setSelected:NO];
    [self.curmudgenImages setSelected:NO];
    [self.monsterImages setSelected:NO];
    [self.stickaImages setSelected:NO];
    [self.defaultCheck setSelected:NO];
    [self.animeCheck setSelected:NO];
    [self.curmudgenCheck setSelected:NO];
    [self.monsterCheck setSelected:NO];
    [self.stickaCheck setSelected:NO];
    [self.customCheck setSelected:YES];
    facetype = _FACE_CUSTOM;
}

- (IBAction)saveUserData:(id)sender
{
    //    NSLog(@"Save data");
    UserDataLoader *loader = [[UserDataLoader alloc] init];

    NSMutableDictionary *map = [loader loadUserData];
    NSNumber *ftype = [NSNumber numberWithInteger:facetype];
    NSNumber *stype = [NSNumber numberWithInteger:[soundTypeControl selectedSegmentIndex]];
    [map setValue:stype forKey:@"soundtype"];
    [map setValue:ftype forKey:@"facetype"];

    [self.mainViewController setUseSoundType:stype];
    [self.mainViewController setImageType:ftype];    
    [loader saveUserData:map];
    
    [loader release];
    [map release];
    [stype release];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	if (loadingImagePicker == NO)
	{
		[self saveUserData:nil];
    }
    [super viewWillDisappear:animated];
}

- (void) showImagePicker
{

    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    [imagePickerController setDelegate:self];
    [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [imagePickerController.navigationBar setBarStyle:UIBarStyleBlackOpaque];
//TODO: Need to change this after everybody is on OS 3.1
    [imagePickerController setAllowsEditing:YES];

    [self presentModalViewController:imagePickerController animated:YES];
}

- (IBAction) acquireCustomHappy:(id)sender
{
	loadingImagePicker = YES;
   // NSLog(@"acquireCustomHappy");
    customFace = _CUSTOM_GREEN;
    [self touchCustomFace:sender];
    [self showImagePicker];
}

- (IBAction) acquireCustomNervous:(id)sender
{
	loadingImagePicker = YES;
   // NSLog(@"acquireCustomNervous");
    customFace = _CUSTOM_YELLOW;
    [self touchCustomFace:sender];
    [self showImagePicker];
}

- (IBAction) acquireCustomSad:(id)sender
{
	loadingImagePicker = YES;
   // NSLog(@"acquireCustomSad");
    customFace = _CUSTOM_RED;
    [self touchCustomFace:sender];
    [self showImagePicker];
}

- (void) loadCustomFaces
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *greenFile = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"customGreen.png"];
    NSString *yellowFile = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"customYellow.png"];
    NSString *redFile = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"customRed.png"];

    
    if ([[NSFileManager defaultManager] fileExistsAtPath:greenFile isDirectory:NO] == YES)
    {
        [customHappy setImage:[UIImage imageWithContentsOfFile:greenFile] forState:UIControlStateNormal];
    }
    else 
    {
        [customHappy setImage:[UIImage imageNamed:@"qgreen.png"] forState:UIControlStateNormal];
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:yellowFile isDirectory:NO] == YES)
    {
        [customNervous setImage:[UIImage imageWithContentsOfFile:yellowFile] forState:UIControlStateNormal];
    }
    else 
    {
        [customNervous setImage:[UIImage imageNamed:@"qyellow.png"] forState:UIControlStateNormal];
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:redFile isDirectory:NO] == YES)
    {
        [customSad setImage:[UIImage imageWithContentsOfFile:redFile] forState:UIControlStateNormal];
    }
    else 
    {
        [customSad setImage:[UIImage imageNamed:@"qred.png"] forState:UIControlStateNormal];
    }
    
    //[greenFile release];
    //[yellowFile release];
    //[redFile release];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
   // NSLog(@"picked image");

    [picker dismissModalViewControllerAnimated:YES];
    
    UIImage *bottomImage;
    
    switch (customFace) {
        case _CUSTOM_RED:
            bottomImage = [UIImage imageNamed:@"red.png"];
            break;
        case _CUSTOM_YELLOW:
            bottomImage = [UIImage imageNamed:@"yellow.png"];
            break;
        case _CUSTOM_GREEN:
        default:
            bottomImage = [UIImage imageNamed:@"green.png"];
            break;
    }
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    CGSize newSize = CGSizeMake(56.0, 56.0);
    
    UIGraphicsBeginImageContext( newSize );
    
    [bottomImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height) blendMode:kCGBlendModeNormal alpha:0.8];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    NSData *imageData = UIImagePNGRepresentation(newImage);
    NSMutableString *fileName = [NSMutableString string];
    
    switch (customFace) {
        case _CUSTOM_RED:
            [fileName setString:@"customRed.png"];
            break;
        case _CUSTOM_YELLOW:
            [fileName setString:@"customYellow.png"];
            break;
        case _CUSTOM_GREEN:
        default:
            [fileName setString:@"customGreen.png"];
            break;
    }

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *saveFile = [NSString stringWithFormat:@"%@/%@", documentsDirectory, fileName];
             
    [imageData writeToFile:saveFile atomically:YES];
    UIGraphicsEndImageContext();


    //[fileName release];
    //[imageData release];
    
	loadingImagePicker = NO;

    [self loadCustomFaces];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
   // NSLog(@"cancel image selection");
    [picker dismissModalViewControllerAnimated:YES];
	loadingImagePicker = NO;
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
    
    [mainViewController release];
    
    [soundLabel release];
    [soundTypeControl release];
    
    [faceLabel release];
    [defaultImages release];
    [animeImages release];
    [curmudgenImages release];
    [monsterImages release];
    [stickaImages release];
    
    [defaultCheck release];
    [animeCheck release];
    [curmudgenCheck release];
    [monsterCheck release];
    [stickaCheck release];
    [customCheck release];

    [customHappy release];
    [customNervous release];
    [customSad release];
    
    [super dealloc];
}


@end
