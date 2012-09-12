//
//  SquaresFreeViewController.m
//  Squares
//
//  Created by Eric on 7/20/09.
//  Copyright 2009 ciretose. All rights reserved.
//

#import "SquaresFreeViewController.h"
#import "SoundEffect.h"


@implementation SquaresFreeViewController

SoundEffect *hiAudio; 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil 
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) 
    {
        hiAudio = [[SoundEffect alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"hi" ofType:@"caf"]];

    }
    return self;
}

- (void)viewDidLoad {
    
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];      
    
    UIImageView *squaresView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title2.0.png"]];
    [squaresView setFrame:CGRectMake(92.0, 0.0, 128.0, 40.0)];
    self.navigationItem.titleView = squaresView;
    [squaresView release];
    
    UIBarButtonItem *doneButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(touchDismiss)] autorelease];
	self.navigationItem.rightBarButtonItem = doneButton;
    
    
    [super viewDidLoad];
}

-(IBAction)touchDismiss
{
    NSLog(@"touched dismiss");
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)touchSound
{
    [hiAudio play];
}

- (IBAction)touchCiretose
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://squares.ciretose.com"]];
}

- (IBAction)touchPurchase
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=308622457&mt=8"]];
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


- (void)dealloc 
{
    [hiAudio release];
    
    [super dealloc];
}


@end
