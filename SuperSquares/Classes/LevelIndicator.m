//
//  LevelIndicator.m
//  SuperSquares
//
//  Created by Eric on 6/19/10.
//  Copyright 2010 ciretose. All rights reserved.
//

#import "LevelIndicator.h"


@implementation LevelIndicator

@synthesize levelLabel;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
        
        CALayer *l = [self layer];
        [l setMasksToBounds:YES];
        [l setCornerRadius:10.0];
        
        [self setOpaque:NO];
        [self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.7]];
        
        self.levelLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,frame.size.width, frame.size.height)];
        [self.levelLabel setFont:[UIFont systemFontOfSize:32]];
        [self.levelLabel setTextAlignment:UITextAlignmentCenter];
        [self.levelLabel setTextColor:[UIColor colorWithWhite:0.9 alpha:1.0]];
        [self.levelLabel setOpaque:NO];
        [self.levelLabel setBackgroundColor:[UIColor clearColor]];
        
        [self addSubview:self.levelLabel];
        
    }
    return self;
}

- (void)levelAnimationDidStart:(NSString *)animationID context:(void *)context
{
    //NSLog(@"Started: %@", animationID);
}

-(void)levelAnimationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    //NSLog(@"Stopped: %@", animationID);
    [(LevelIndicator *)context removeFromSuperview];
}


- (void) runLevelAnimation
{
    [UIView beginAnimations:[self description] context:self];
    [UIView setAnimationDelay:2.0];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self cache:YES];
    
    [UIView setAnimationDelegate:self];
    [UIView setAnimationWillStartSelector:@selector(levelAnimationDidStart:context:)];
    [UIView setAnimationDidStopSelector:@selector(levelAnimationDidStop:finished:context:)];

    [self setAlpha:0];
    
    [UIView commitAnimations];
    
}

- (void)dealloc 
{
    [levelLabel release];
    
    [super dealloc];
}


@end
