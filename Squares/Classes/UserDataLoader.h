//
//  UserDataLoader.h
//  Squares
//
//  Created by Eric on 2/11/09.
//  Copyright 2009 ciretose. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserDataLoader : NSObject 
{

}

-(NSMutableDictionary *)loadUserData;
-(void)saveUserData:(NSMutableDictionary *)userData;


@end
