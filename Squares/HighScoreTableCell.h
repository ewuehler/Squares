//
//  HighScoreTableCell.h
//  Squares
//
//  Created by Eric on 1/28/09.
//  Copyright 2009 ciretose. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HighScoreTableCell : UITableViewCell {
    
    UILabel *indexLabel;
    UILabel *nameLabel;
    UILabel *scoreLabel;
    UILabel *dateLabel;
    UILabel *levelLabel;
    
}

@property (nonatomic, retain) UILabel *indexLabel;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *scoreLabel;
@property (nonatomic, retain) UILabel *dateLabel;
@property (nonatomic, retain) UILabel *levelLabel;

- (UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold;

- (void) setIndex:(NSNumber *)index;
- (void) setName:(NSString *)name;
- (void) setScore:(NSNumber *)score;
- (void) setDate:(NSDate *)date;
- (void) setLevel:(NSNumber *)level;


@end
