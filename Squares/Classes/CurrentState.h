//
//  CurrentState.h
//  Squares
//
//  Created by Eric on 2/13/09.
//  Copyright 2009 ciretose. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CurrentState : NSObject {

}


-(NSMutableDictionary *)loadState;
-(void)saveState:(NSMutableDictionary *)stateData;


@end
