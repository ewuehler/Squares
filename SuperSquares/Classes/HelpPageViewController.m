    //
//  HelpPageViewController.m
//  SuperSquares
//
//  Created by Eric on 6/28/10.
//  Copyright 2010 ciretose. All rights reserved.
//

#import "HelpPageViewController.h"

static NSArray *__pageControlImageList = nil;

@implementation HelpPageViewController


@synthesize pageNumberLabel, helpImageView;


// Creates the color list the first time this method is invoked. Returns one color object from the list.
+ (UIImage *)pageControlImageWithIndex:(NSUInteger)index 
{
    if (__pageControlImageList == nil) {
        __pageControlImageList = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"whiten.png"], 
                                  [UIImage imageNamed:@"whitene.png"],
                                  [UIImage imageNamed:@"whitee.png"],
                                  [UIImage imageNamed:@"whitese.png"],
                                  [UIImage imageNamed:@"whites.png"],
                                  [UIImage imageNamed:@"whitesw.png"],
                                  [UIImage imageNamed:@"whitew.png"],
                                  [UIImage imageNamed:@"whitenw.png"],
                                  nil];
    }
    
    // Mod the index by the list length to ensure access remains in bounds.
    return [__pageControlImageList objectAtIndex:index % [__pageControlImageList count]];
}


// Load the view nib and initialize the pageNumber ivar.
- (id)initWithPageNumber:(int)page 
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if ((self = [super initWithNibName:@"HelpPageViewControllerX" bundle:nil])) 
        {
            pageNumber = page;
        }
    }
    else 
    {
        if ((self = [super initWithNibName:@"HelpPageViewController" bundle:nil])) 
        {
            pageNumber = page;
        }
    }

    
    return self;
}



/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Set the label and background color when the view has finished loading.
- (void)viewDidLoad {
    
    [self.pageNumberLabel setText:[NSString stringWithFormat:@"Page %d", pageNumber + 1]];
    [self.helpImageView setImage:[HelpPageViewController pageControlImageWithIndex:pageNumber]];
    NSLog(@"loaded helppageviewer: %d", pageNumber);
    
    NSLog(@"page: %d", [self.pageNumberLabel isHidden]);
    [super viewDidLoad];
}

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
    [helpImageView release];
    [pageNumberLabel release];
    [super dealloc];
}


@end
