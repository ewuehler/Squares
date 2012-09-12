//
//  HighScoreLoader.m
//  Squares
//
//  Created by Eric on 1/30/09.
//  Copyright 2009 ciretose. All rights reserved.
//

#import "HighScoreLoader.h"


@implementation HighScoreLoader


-(NSMutableArray *)loadHighScores
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *saveFile = [NSString stringWithFormat:@"%@/high.scores", documentsDirectory];
    
    NSMutableArray *highScores = nil;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:saveFile isDirectory:NO] == YES)
    {
        highScores = [[NSMutableArray arrayWithContentsOfFile:saveFile] retain];
    }
    
    if (highScores == nil)
    {
        highScores = [[NSMutableArray arrayWithCapacity:_MAX_HIGH_SCORES] retain];
    }
    
    return highScores;
}

-(void)saveHighScores:(NSMutableArray *)highScores
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *saveFile = [NSString stringWithFormat:@"%@/high.scores", documentsDirectory];
    
    while ([highScores count] > _MAX_HIGH_SCORES)
    {
        [highScores removeLastObject];
    }
    
    [highScores writeToFile:saveFile atomically:YES];
}

-(void)dealloc
{
    [super dealloc];
}

@end
