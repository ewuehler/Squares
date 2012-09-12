//
//  CurrentState.m
//  Squares
//
//  Created by Eric on 2/13/09.
//  Copyright 2009 ciretose. All rights reserved.
//

#import "CurrentState.h"


@implementation CurrentState

-(NSMutableDictionary *)loadState
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *saveFile = [NSString stringWithFormat:@"%@/save.state", documentsDirectory];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:saveFile isDirectory:NO] == YES)
    {
//        NSLog(@"Loading saved state from %@", saveFile);
        
        return [NSDictionary dictionaryWithContentsOfFile:saveFile];
    }
    
    return NULL;
}

-(void)saveState:(NSMutableDictionary *)stateData
{
 
//    NSLog(@"MainViewController - save current state");
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *saveFile = [NSString stringWithFormat:@"%@/save.state", documentsDirectory];
    
    //If the game is "over" or we haven't started a "new game", we don't need to save any state...
    if (stateData == nil)
    {
//        NSLog(@"Not playing - not saving any state");
        [[NSFileManager defaultManager] removeItemAtPath:saveFile error:NULL];
        return;
    }
    
//    NSLog(@"Writing the current state to a file: %@", saveFile);
    
    [stateData writeToFile:saveFile atomically:YES];
}


@end
