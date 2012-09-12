//
//  LevelIndicator.h
//  SuperSquares
//
//  Created by Eric on 6/19/10.
//  Copyright 2010 ciretose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface LevelIndicator : UIView {

    UILabel *levelLabel;
}

@property (nonatomic, retain) UILabel *levelLabel;

- (void) runLevelAnimation;


@end
