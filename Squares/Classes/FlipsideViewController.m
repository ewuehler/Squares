//
//  FlipsideViewController.m
//  Squares
//
//  Created by Eric on 1/10/09.
//  Copyright ciretose 2009. All rights reserved.
//

#import "FlipsideViewController.h"
#import "UserDataLoader.h"


@implementation FlipsideViewController

@synthesize teaserLabel;
@synthesize designLabel;
@synthesize developLabel;

@synthesize launchWebsite;
@synthesize launchDesign;

@synthesize happyImageView;
@synthesize nervousImageView;
@synthesize deadImageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil 
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) 
    {
    }
    return self;
}



-(IBAction)touchDismiss
{
    NSLog(@"touched dismiss");
    [self dismissModalViewControllerAnimated:YES];
}


- (void)viewDidLoad 
{
        
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];      
    
    UIImageView *squaresView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title2.0.png"]];
    [squaresView setFrame:CGRectMake(92.0, 0.0, 128.0, 40.0)];
    self.navigationItem.titleView = squaresView;
    [squaresView release];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(touchDismiss)];
	self.navigationItem.rightBarButtonItem = doneButton;
    
    [doneButton release];

    [teaserLabel setText:NSLocalizedString(@"TEASER", @"Teaser")];
    [developLabel setText:NSLocalizedString(@"DEVELOPED_BY", @"Developed")];
    [designLabel setText:NSLocalizedString(@"DESIGNED_BY", @"Designed")];

    happyImageView.animationImages = [NSArray arrayWithObjects:
                                       [UIImage imageNamed:@"good.png"],
                                       [UIImage imageNamed:@"ahappy.png"],
                                       [UIImage imageNamed:@"chappy.png"],
                                       [UIImage imageNamed:@"mhappy.png"], nil];
    
    happyImageView.animationDuration = 8.0;
    happyImageView.animationRepeatCount = 0;

     nervousImageView.animationImages = [NSArray arrayWithObjects:
                                        [UIImage imageNamed:@"ok.png"],
                                        [UIImage imageNamed:@"anervous.png"],
                                        [UIImage imageNamed:@"cnervous.png"],
                                        [UIImage imageNamed:@"mnervous.png"], nil];
     
     nervousImageView.animationDuration = 8.0;
     nervousImageView.animationRepeatCount = 0;
     
      deadImageView.animationImages = [NSArray arrayWithObjects:
                                         [UIImage imageNamed:@"dead.png"],
                                         [UIImage imageNamed:@"adead.png"],
                                         [UIImage imageNamed:@"cdead.png"],
                                         [UIImage imageNamed:@"mdead.png"], nil];
      
      deadImageView.animationDuration = 8.0;
      deadImageView.animationRepeatCount = 0;
      
    
    [super viewDidLoad];
   
}

- (void)viewWillAppear:(BOOL)animated
{
    [happyImageView startAnimating];
    [nervousImageView startAnimating];
    [deadImageView startAnimating];

    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [happyImageView stopAnimating];
    [nervousImageView stopAnimating];
    [deadImageView stopAnimating];
    
    [super viewWillDisappear:animated];
}


- (IBAction)launchBrowser
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://ciretose.com"]];
}

- (IBAction)launchDesignBrowser
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://mur-design.com"]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}


- (void)dealloc 
{
    [teaserLabel release];
    [developLabel release];
    [designLabel release];
    
    [launchWebsite release];
    [launchDesign release];
    
    [happyImageView release];
    [nervousImageView release];
    [deadImageView release];
    
    [super dealloc];
}


@end
