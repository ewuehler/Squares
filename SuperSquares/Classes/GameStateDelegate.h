//
//  GameStateDelegate.h
//  SuperSquares
//
//  Created by Eric on 6/18/10.
//  Copyright 2010 ciretose. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol GameStateDelegate <NSObject>

- (void)gameOver;
- (void)incrementScoreBy:(NSInteger)score;
- (void)decrementSquareCount;

@optional
- (void)setScore:(NSInteger)score;

@end

