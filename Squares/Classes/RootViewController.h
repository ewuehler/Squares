//
//  RootViewController.h
//  Squares
//
//  Created by Eric on 1/10/09.
//  Copyright ciretose 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;

@interface RootViewController : UIViewController {

    MainViewController *mainViewController;
    
    BOOL soundOn;
    NSNumber *soundType;
    int shakesValue;
    
}

@property (nonatomic, retain) MainViewController *mainViewController;

@property (assign) BOOL soundOn;
@property (nonatomic, retain) NSNumber *soundType;
@property (assign) int shakesValue;

- (void)saveCurrentState;

- (void)setUseSound:(NSString *)use;
- (void)setUseSoundType:(NSNumber *)type;
- (void)setShakeCount:(NSString *)count;
- (NSString *)shakeCount;

@end
