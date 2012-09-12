//
//  UserDataLoader.m
//  Squares
//
//  Created by Eric on 2/11/09.
//  Copyright 2009 ciretose. All rights reserved.
//

#import "UserDataLoader.h"


@implementation UserDataLoader

-(NSMutableDictionary *)loadUserData
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *saveFile = [NSString stringWithFormat:@"%@/user.data", documentsDirectory];
    
    NSMutableDictionary *data = NULL;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:saveFile isDirectory:NO] == YES)
    {
//        NSLog(@"Loading user data from %@", saveFile);
        data = [[NSMutableDictionary dictionaryWithContentsOfFile:saveFile] retain];
    }
    
    if (data == NULL)
    {
        data = [[NSMutableDictionary dictionaryWithCapacity:5] retain];
        [data setValue:@"" forKey:@"name"];
        [data setValue:@"Y" forKey:@"sound"];
        [data setValue:@"5" forKey:@"shakes"];
        [data setValue:@"1" forKey:@"playcount"];
    }
    
    return data;
}

-(void)saveUserData:(NSMutableDictionary *)userData
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *saveFile = [NSString stringWithFormat:@"%@/user.data", documentsDirectory];
    
//    NSLog(@"Save user data file: %@",saveFile);
    [userData writeToFile:saveFile atomically:YES];
}




@end
