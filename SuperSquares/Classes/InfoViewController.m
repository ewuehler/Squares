    //
//  InfoViewController.m
//  SuperSquares
//
//  Created by Eric on 6/17/10.
//  Copyright 2010 ciretose. All rights reserved.
//

#import "InfoViewController.h"


@implementation InfoViewController

#define CIRETOSELOGO_LANDSCAPE CGRectMake(140,375, 150, 150)
#define CIRETOSELABEL_LANDSCAPE CGRectMake(140,545, 150, 65)
#define MURLOGO_LANDSCAPE CGRectMake(409,375, 221, 150)
#define MURLABEL_LANDSCAPE CGRectMake(428,545, 180, 65)
#define COPYRIGHTLABEL_LANDSCAPE CGRectMake(566,708, 181, 21)

#define CIRETOSELOGO_PORTRAIT CGRectMake(140,630, 150, 150)
#define CIRETOSELABEL_PORTRAIT CGRectMake(140,800, 150, 65)
#define MURLOGO_PORTRAIT CGRectMake(409,630, 221, 150)
#define MURLABEL_PORTRAIT CGRectMake(428,800, 180, 65)
#define COPYRIGHTLABEL_PORTRAIT CGRectMake(566,963, 181, 21)



@synthesize ciretoseLogo, murLogo, ciretoseLabel, murLabel, copyrightLabel, doneButton;


- (BOOL)isPhone
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
}

-(IBAction) touchDone:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}


- (void)setFrameForControls:(UIInterfaceOrientation)toInterfaceOrientation
{
    
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        [self.ciretoseLogo setFrame:CIRETOSELOGO_LANDSCAPE];
        [self.ciretoseLabel setFrame:CIRETOSELABEL_LANDSCAPE];
        [self.murLogo setFrame:MURLOGO_LANDSCAPE];
        [self.murLabel setFrame:MURLABEL_LANDSCAPE];
        [self.copyrightLabel setFrame:COPYRIGHTLABEL_LANDSCAPE];
    }
    else
    {
        [self.ciretoseLogo setFrame:CIRETOSELOGO_PORTRAIT];
        [self.ciretoseLabel setFrame:CIRETOSELABEL_PORTRAIT];
        [self.murLogo setFrame:MURLOGO_PORTRAIT];
        [self.murLabel setFrame:MURLABEL_PORTRAIT];
        [self.copyrightLabel setFrame:COPYRIGHTLABEL_PORTRAIT];
    }
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
        
        if ([self isPhone] == YES)
        {
            [self setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        }
        else
        {
            [self setModalTransitionStyle:UIModalTransitionStylePartialCurl];
        }
    }
    return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (void)viewDidLoad {

    [super viewDidLoad];
    if ([self isPhone] == NO)
    {
        [self setFrameForControls:[self interfaceOrientation]];
    }
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if ([self isPhone] == NO)
    {
        [self dismissModalViewControllerAnimated:YES];
        [self setFrameForControls:toInterfaceOrientation];
    }
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    if ([self isPhone] == YES)
    {
        return UIInterfaceOrientationIsPortrait(interfaceOrientation);
    }
    else
    {
        return YES;
    }
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
