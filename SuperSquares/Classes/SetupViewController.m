    //
//  SetupViewController.m
//  SuperSquares
//
//  Created by Eric on 7/9/10.
//  Copyright 2010 ciretose. All rights reserved.
//

#import "SetupViewController.h"


@implementation SetupViewController

@synthesize closeButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
        [self setModalPresentationStyle:UIModalPresentationPageSheet];
        [self setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        
    }
    return self;
}


- (IBAction) touchClose:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
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
