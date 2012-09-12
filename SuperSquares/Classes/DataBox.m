//
//  DataBox.m
//  SuperSquares
//
//  Created by Eric on 6/10/10.
//  Copyright 2010 ciretose. All rights reserved.
//

#import "DataBox.h"


@implementation DataBox

@synthesize dataLabel, dataValue;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
        dataLabel = [[UILabel alloc] initWithFrame:CGRectMake(5,5,frame.size.width-10,30)];
        [dataLabel setTextAlignment:UITextAlignmentCenter];
        [dataLabel setBackgroundColor:[UIColor clearColor]];
        [dataLabel setFont:[UIFont systemFontOfSize:14.0]];
        [self addSubview:dataLabel];
        
        dataValue = [[UILabel alloc] initWithFrame:CGRectMake(5,35,frame.size.width-10,frame.size.height-40)];
        [dataValue setTextAlignment:UITextAlignmentCenter];
        [dataValue setBackgroundColor:[UIColor clearColor]];
        [dataValue setFont:[UIFont systemFontOfSize:28.0]];
        [self addSubview:dataValue];
    }
    return self;
}

- (void)dealloc {
    
    [dataLabel release];
    [dataValue release];
    
    [super dealloc];
}


@end
