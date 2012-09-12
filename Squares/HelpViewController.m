//
//  HelpViewController.m
//  Squares
//
//  Created by Eric on 1/25/09.
//  Copyright 2009 ciretose. All rights reserved.
//

#import "HelpViewController.h"


@implementation HelpViewController

@synthesize helpWebView;
//@synthesize visitButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(touchDismiss)];
    
    [self.navigationItem setTitle:NSLocalizedString(@"HELP", @"Help")];
    self.navigationItem.rightBarButtonItem = buttonItem;
    self.navigationItem.rightBarButtonItem.style = UIBarButtonItemStyleBordered;
    
//    [self.visitButton setTitle:];
    
    UIBarButtonItem *visitItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"VISIT_WEBSITE", @"Visit") style:UIBarButtonItemStyleBordered target:self action:@selector(visitWebSite)];
    
    self.navigationItem.leftBarButtonItem = visitItem;
    [self.navigationItem.leftBarButtonItem setStyle:UIBarButtonItemStyleBordered];
    
    [buttonItem release];
    [visitItem release];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/help.html",path]];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    [self.helpWebView loadData:data MIMEType:@"text/html" textEncodingName:@"utf-8" baseURL:baseURL];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(IBAction)touchDismiss
{
    NSLog(@"touched dismiss");
    [self dismissModalViewControllerAnimated:YES];
}


- (IBAction)visitWebSite
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://squares.ciretose.com"]];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [helpWebView release];
    //[visitButton release];
     
    [super dealloc];
}


@end
