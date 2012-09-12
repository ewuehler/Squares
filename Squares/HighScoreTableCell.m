//
//  HighScoreTableCell.m
//  Squares
//
//  Created by Eric on 1/28/09.
//  Copyright 2009 ciretose. All rights reserved.
//

#import "HighScoreTableCell.h"


@implementation HighScoreTableCell

@synthesize indexLabel;
@synthesize nameLabel;
@synthesize scoreLabel;
@synthesize dateLabel;
@synthesize levelLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier 
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) 
    {
		UIView *myContentView = self.contentView;
        
		self.indexLabel = [self newLabelWithPrimaryColor:[UIColor darkGrayColor] selectedColor:[UIColor darkGrayColor] fontSize:24.0 bold:NO];
		self.indexLabel.textAlignment = UITextAlignmentCenter; 
		[myContentView addSubview:self.indexLabel];
		[self.indexLabel release];
        
		self.nameLabel = [self newLabelWithPrimaryColor:[UIColor blackColor] selectedColor:[UIColor whiteColor] fontSize:28.0 bold:NO];
		self.nameLabel.textAlignment = UITextAlignmentLeft; 
		[myContentView addSubview:self.nameLabel];
		[self.nameLabel release];
        
		self.scoreLabel = [self newLabelWithPrimaryColor:[UIColor blackColor] selectedColor:[UIColor whiteColor] fontSize:36.0 bold:NO];
		self.scoreLabel.textAlignment = UITextAlignmentRight; 
		[myContentView addSubview:self.scoreLabel];
		[self.scoreLabel release];
        
        self.dateLabel = [self newLabelWithPrimaryColor:[UIColor blackColor] selectedColor:[UIColor lightGrayColor] fontSize:10.0 bold:NO];
		self.dateLabel.textAlignment = UITextAlignmentLeft; 
		[myContentView addSubview:self.dateLabel];
		[self.dateLabel release];
        
		self.levelLabel = [self newLabelWithPrimaryColor:[UIColor blackColor] selectedColor:[UIColor lightGrayColor] fontSize:10.0 bold:NO];
		self.levelLabel.textAlignment = UITextAlignmentRight; 
		[myContentView addSubview:self.levelLabel];
		[self.levelLabel release];
        
    }
    return self;
    
}

/*
- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier 
{
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) 
    {
		UIView *myContentView = self.contentView;
        
		self.indexLabel = [self newLabelWithPrimaryColor:[UIColor darkGrayColor] selectedColor:[UIColor darkGrayColor] fontSize:24.0 bold:NO];
		self.indexLabel.textAlignment = UITextAlignmentCenter; 
		[myContentView addSubview:self.indexLabel];
		[self.indexLabel release];
        
		self.nameLabel = [self newLabelWithPrimaryColor:[UIColor blackColor] selectedColor:[UIColor whiteColor] fontSize:28.0 bold:NO];
		self.nameLabel.textAlignment = UITextAlignmentLeft; 
		[myContentView addSubview:self.nameLabel];
		[self.nameLabel release];
        
		self.scoreLabel = [self newLabelWithPrimaryColor:[UIColor blackColor] selectedColor:[UIColor whiteColor] fontSize:36.0 bold:NO];
		self.scoreLabel.textAlignment = UITextAlignmentRight; 
		[myContentView addSubview:self.scoreLabel];
		[self.scoreLabel release];
        
        self.dateLabel = [self newLabelWithPrimaryColor:[UIColor blackColor] selectedColor:[UIColor lightGrayColor] fontSize:10.0 bold:NO];
		self.dateLabel.textAlignment = UITextAlignmentLeft; 
		[myContentView addSubview:self.dateLabel];
		[self.dateLabel release];
        
		self.levelLabel = [self newLabelWithPrimaryColor:[UIColor blackColor] selectedColor:[UIColor lightGrayColor] fontSize:10.0 bold:NO];
		self.levelLabel.textAlignment = UITextAlignmentRight; 
		[myContentView addSubview:self.levelLabel];
		[self.levelLabel release];
        
    }
    return self;
}
 */

- (void) setIndex:(NSNumber *)index
{
    [self.indexLabel setText:[index stringValue]];
}

- (void) setName:(NSString *)name
{
    [self.nameLabel setText:name];
}

- (void) setScore:(NSNumber *)score
{
    [self.scoreLabel setText:[score stringValue]];
}

- (void) setDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init]  autorelease];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
 
    [self.dateLabel setText:[dateFormatter stringFromDate:date]];
}

- (void) setLevel:(NSNumber *)level
{
    [self.levelLabel setText:[NSString stringWithFormat:NSLocalizedString(@"HS_LEVEL", @"Level"), [level stringValue]]];
}

- (UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor 
                        selectedColor:(UIColor *)selectedColor 
                             fontSize:(CGFloat)fontSize 
                                 bold:(BOOL)bold
{
    UIFont *font;
    if (bold) 
    {
        font = [UIFont boldSystemFontOfSize:fontSize];
    } else 
    {
        font = [UIFont systemFontOfSize:fontSize];
    }
    
	UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	newLabel.backgroundColor = [UIColor whiteColor];
	newLabel.opaque = YES;
	newLabel.textColor = primaryColor;
	newLabel.highlightedTextColor = selectedColor;
	newLabel.font = font;
	
    return newLabel;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGRect contentRect = self.contentView.bounds;
    
    if (!self.editing) 
    {
        CGFloat boundsX = contentRect.origin.x;
		CGRect frame;
        
		frame = CGRectMake(boundsX, 0, 40, 50);
        [self.indexLabel setBackgroundColor:[UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.0f]];
        self.indexLabel.frame = frame;
        
		frame = CGRectMake(boundsX + 45, 0, 165, 36);
		self.nameLabel.frame = frame;
        
        frame = CGRectMake(boundsX + 45, 34, 210, 16);
		self.dateLabel.frame = frame;

        frame = CGRectMake(boundsX + 210, 0, 105, 36);
        self.scoreLabel.frame = frame;

		frame = CGRectMake(boundsX + 210, 34, 105, 16);
		self.levelLabel.frame = frame;
        
    }
}

- (void)dealloc {
  
    [indexLabel dealloc];
    [nameLabel dealloc];
    [scoreLabel dealloc];
    [dateLabel dealloc];
    [levelLabel dealloc];
    
    [super dealloc];
}


@end
