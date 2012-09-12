//
//  HighScoreViewController.m
//  Squares
//
//  Created by Eric on 1/26/09.
//  Copyright 2009 ciretose. All rights reserved.
//

#import "HighScoreViewController.h"
#import "HighScoreView.h"
#import "HighScoreTableCell.h"
#import "HighScoreLoader.h"


@implementation HighScoreViewController


@synthesize highScoreTableView;
@synthesize highScores, currentRow;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil 
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) 
    {
        self.currentRow = -1;
    }
    return self;
}

- (void)reloadHighScoreData
{
    HighScoreLoader *loader = [[HighScoreLoader alloc] init];
    [self.highScores release];
    self.highScores = [loader loadHighScores];
    [loader release];
    
    [self.highScoreTableView reloadData];
    if (self.currentRow >= 0 && self.currentRow < 20)
    {
        NSIndexPath *path = [NSIndexPath indexPathForRow:self.currentRow inSection:0];
        if ([self.highScoreTableView cellForRowAtIndexPath:path] != nil)
            [self.highScoreTableView selectRowAtIndexPath:path animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        [path release];
    }
    self.currentRow = -1;
}


-(IBAction)touchDismiss
{
    NSLog(@"touched dismiss");
    [self dismissModalViewControllerAnimated:YES];
}


- (void)viewDidLoad 
{
    
    [super viewDidLoad];
    
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(touchDismiss)];

    [self.navigationItem setTitle:NSLocalizedString(@"HIGH_SCORES", @"High Scores")];
    self.navigationItem.rightBarButtonItem = buttonItem;
    self.navigationItem.rightBarButtonItem.style = UIBarButtonItemStyleBordered;
    
    UIBarButtonItem *clearItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(clearHighScores)];
   
    self.navigationItem.leftBarButtonItem = clearItem;
    [self.navigationItem.leftBarButtonItem setStyle:UIBarButtonItemStyleBordered];
    
    [buttonItem release];
    [clearItem release];
    
    [self.highScoreTableView setRowHeight:51.0f];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    NSLog(@"AlertView button clicked: %@ (button index: %d)", alertView, buttonIndex);
    
    if (buttonIndex == 1)
    {
        [self.highScores removeAllObjects];
        HighScoreLoader *loader = [[HighScoreLoader alloc] init];
        [loader saveHighScores:self.highScores];
        [loader release];
        
        [highScoreTableView reloadData];
    }
}


- (void)clearHighScores
{
//    NSLog(@"Clear high scores...");
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"DELETE_HIGH_SCORES", @"Delete High Scores")
                                                    message:NSLocalizedString(@"DELETE_AREYOUSURE", @"Are you sure?")
                                                   delegate:self 
                                          cancelButtonTitle:NSLocalizedString(@"CANCEL", @"Cancel")
                                          otherButtonTitles:NSLocalizedString(@"OK",@"OK"),nil];
    
    [alert show];
    [alert release];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"HighScoreIdentifier";
    
    HighScoreTableCell *cell = (HighScoreTableCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) 
    {
        cell = [[[HighScoreTableCell alloc] initWithFrame:CGRectZero
                                          reuseIdentifier:MyIdentifier] autorelease];
    }
    
    NSUInteger idx = indexPath.row;
    NSMutableArray *hs = [self.highScores objectAtIndex:idx];
    
    if (hs != nil)
    {
        [cell setIndex:[NSNumber numberWithUnsignedInteger:(idx+1)]];
        [cell setName:[hs valueForKey:@"name"]];
        [cell setScore:[hs valueForKey:@"score"]];
        [cell setDate:[hs valueForKey:@"date"]];
        [cell setLevel:[hs valueForKey:@"level"]];
    }
    
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.highScores count];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewWillAppear:(BOOL)animated
{
 
    [self reloadHighScoreData];

    [super viewWillAppear:animated];
}



- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning]; 
}


- (void)dealloc {
    [highScoreTableView release];
    [highScores release];
    
    [super dealloc];
}


@end
