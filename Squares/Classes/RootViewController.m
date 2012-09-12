//
//  RootViewController.m
//  Squares
//
//  Created by Eric on 1/10/09.
//  Copyright ciretose 2009. All rights reserved.
//

#import "RootViewController.h"
#import "MainViewController.h"
#import "UserDataLoader.h"

@implementation RootViewController

@synthesize mainViewController;

@synthesize soundOn;
@synthesize soundType;
@synthesize shakesValue;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UserDataLoader *loader = [[UserDataLoader alloc] init];
    NSMutableDictionary *map = [loader loadUserData];
    NSString *snd = [map valueForKey:@"sound"];
    NSNumber *stype = [map valueForKey:@"soundtype"];
    NSNumber *ftype = [map valueForKey:@"facetype"];
    NSString *k = [map valueForKey:@"shakes"];

    
    
    if (snd == nil || [snd length] == 0)
    {
        self.soundOn = YES;
    }
    else
    {
        self.soundOn = [snd boolValue];
    }
    
    if (stype == nil)
    {
        self.soundType = [NSNumber numberWithInt:0];
    }
    else
    {
        self.soundType = [stype copy];
    }
    
    if (k == nil || [k length] == 0)
    {
        self.shakesValue = _DEFAULT_SHAKES;
    }
    else
    {
        self.shakesValue = [k intValue];
    }
    
    if (self.mainViewController == nil)
    {
        MainViewController *viewController = [[MainViewController alloc] initWithNibName:@"MainView" bundle:nil];
        self.mainViewController = viewController;
        [self.mainViewController setImageType:ftype];
        [self.view addSubview:mainViewController.view];
        [viewController release];
        
#ifdef SQUARES_FREE_VERSION
       
        NSNumber *pc = [map valueForKey:@"playcount"];
        
        NSMutableArray *arr = [self.mainViewController.toolbar.items copy];
        NSMutableArray *a = [NSMutableArray array];
        [a addObject:[arr objectAtIndex:0]];
        [a addObject:[arr objectAtIndex:1]];
        [a addObject:[arr objectAtIndex:2]];
        if (pc != nil && [pc intValue] > _SQUARES_FREE_COUNT)
        {
            [a addObject:[arr objectAtIndex:3]];
        }
        [a addObject:[arr objectAtIndex:5]];
    
        [self.mainViewController.toolbar setItems:a animated:NO];        

        [pc release];
#endif
        
    }
    [self.mainViewController setRootView:self];
    
    //NSLog(@"shakes is %d", self.shakesValue);
    //[snd release];
    //[stype release];
    //[ftype release];
    //[k release];
    //[map release];
    [loader release];

    
}

- (void)saveCurrentState
{
//    NSLog(@"Save Current state - RootViewController");
    [self.mainViewController saveCurrentState];
    [self.mainViewController saveUserData];
}

- (void)setUseSound:(NSString *)use
{
    self.soundOn = [use boolValue];
}

- (void)setUseSoundType:(NSNumber *)type
{
    self.soundType = [type copy];
}

- (void)setShakeCount:(NSString *)count 
{
    //NSLog(@"set shake count");
    self.shakesValue = [count intValue];
}

- (NSString *) shakeCount
{
    //NSLog(@"get shake count: %d", self.shakesValue);
    return [NSString stringWithFormat:@"%d", self.shakesValue];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning]; 
}


- (void)dealloc {

    [mainViewController release];
    [soundType release];
    
    [super dealloc];
}


@end
