//
//  DataBox.h
//  SuperSquares
//
//  Created by Eric on 6/10/10.
//  Copyright 2010 ciretose. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DataBox : UIImageView {

    UILabel *dataLabel;
    UILabel *dataValue;

}

@property (nonatomic, retain) UILabel *dataLabel;
@property (nonatomic, retain) UILabel *dataValue;


@end
