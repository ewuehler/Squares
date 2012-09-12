//
//  Square.h
//  SuperSquares
//
//  Created by Eric on 6/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GameStateDelegate.h"

#define SQUARE_TAG_OFFSET 10000

#define STATE_EMPTY 0

#define STATE_N   1
#define STATE_NE  2
#define STATE_E   3
#define STATE_SE  4
#define STATE_S   5
#define STATE_SW  6
#define STATE_W   7
#define STATE_NW  8

#define STATE_GREEN  10
#define STATE_YELLOW 20
#define STATE_RED    30

#define IMAGE_EMPTY @"empty.png"

#define IMAGE_N @"whiten.png"
#define IMAGE_NE @"whitene.png"
#define IMAGE_E @"whitee.png"
#define IMAGE_SE @"whitese.png"
#define IMAGE_S @"whites.png"
#define IMAGE_SW @"whitesw.png"
#define IMAGE_W @"whitew.png"
#define IMAGE_NW @"whitenw.png"

#define IMAGE_GREEN @"green.png"
#define IMAGE_YELLOW @"yellow.png"
#define IMAGE_RED @"red.png"

@interface Square : UIImageView {

    NSInteger currentImageState;
    NSInteger boardSize;
    
    id<GameStateDelegate> delegate;
}

@property(nonatomic,assign) id<GameStateDelegate> delegate;

@property (assign) NSInteger boardSize;

- (NSInteger) currentImageState;
- (void) setCurrentImageState:(NSInteger)state;

- (NSString *)imageNameForState:(NSInteger)state;

- (NSInteger) targetSquare;

- (void) randomizeImageDirection;

- (BOOL) canChange;

// This is the initiator
- (void) changeTargetSquare:(NSInteger)target;
// This is the receiver
- (void) recieveChangeTargetMessage;


// Game Over - somebody changed to red
- (void) initiateGameOverProcedure;

@end
