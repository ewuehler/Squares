//
//  HighScoreLoader.h
//  Squares
//
//  Created by Eric on 1/30/09.
//  Copyright 2009 ciretose. All rights reserved.
//

#import <UIKit/UIKit.h>

#define _MAX_HIGH_SCORES 20


@interface HighScoreLoader : NSObject {

}


-(NSMutableArray *)loadHighScores;
-(void)saveHighScores:(NSMutableArray *)highScores;


@end
