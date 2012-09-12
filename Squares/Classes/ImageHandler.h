//
//  ImageLoader.h
//  Squares
//
//  Created by Eric on 2/12/09.
//  Copyright 2009 ciretose. All rights reserved.
//

#import <Foundation/Foundation.h>


#define _W @"W"
#define _E @"E"
#define _N @"N"
#define _S @"S"
#define _NW @"NW"
#define _NE @"NE"
#define _SW @"SW"
#define _SE @"SE"

#define _DIR 1
#define _GOOD 3
#define _OK 4
#define _DEAD 5

#define _FACE_DEFAULT 0
#define _FACE_ANIME 1
#define _FACE_CURMUDGEN 2
#define _FACE_MONSTER 3
#define _FACE_STICKA 4
#define _FACE_CUSTOM 5

#define _CUSTOM_GREEN 0
#define _CUSTOM_YELLOW 1
#define _CUSTOM_RED 2



@interface ImageHandler : NSObject {

    UIImage *dead;
    UIImage *ok;
    UIImage *good;
    
    UIImage *happy;
    UIImage *nervous;
    UIImage *sad;
    
    UIImage *ahappy;
    UIImage *anervous;
    UIImage *asad;
    
    UIImage *chappy;
    UIImage *cnervous;
    UIImage *csad;
    
    UIImage *mhappy;
    UIImage *mnervous;
    UIImage *msad;
    
    UIImage *shappy;
    UIImage *snervous;
    UIImage *ssad;
    
    UIImage *custhappy;
    UIImage *custnervous;
    UIImage *custsad;
    
    UIImage *green;
    UIImage *yellow;
    UIImage *red;
    
    UIImage *dirw;
    UIImage *dire;
    UIImage *dirn;
    UIImage *dirs;
    UIImage *dirne;
    UIImage *dirnw;
    UIImage *dirse;
    UIImage *dirsw;

}

@property (nonatomic, retain) UIImage *dead;
@property (nonatomic, retain) UIImage *ok;
@property (nonatomic, retain) UIImage *good;

@property (nonatomic, retain) UIImage *happy;
@property (nonatomic, retain) UIImage *nervous;
@property (nonatomic, retain) UIImage *sad;

@property (nonatomic, retain) UIImage *ahappy;
@property (nonatomic, retain) UIImage *anervous;
@property (nonatomic, retain) UIImage *asad;

@property (nonatomic, retain) UIImage *chappy;
@property (nonatomic, retain) UIImage *cnervous;
@property (nonatomic, retain) UIImage *csad;

@property (nonatomic, retain) UIImage *mhappy;
@property (nonatomic, retain) UIImage *mnervous;
@property (nonatomic, retain) UIImage *msad;

@property (nonatomic, retain) UIImage *shappy;
@property (nonatomic, retain) UIImage *snervous;
@property (nonatomic, retain) UIImage *ssad;

@property (nonatomic, retain) UIImage *custhappy;
@property (nonatomic, retain) UIImage *custnervous;
@property (nonatomic, retain) UIImage *custsad;

@property (nonatomic, retain) UIImage *green;
@property (nonatomic, retain) UIImage *yellow;
@property (nonatomic, retain) UIImage *red;

@property (nonatomic, retain) UIImage *dirw;
@property (nonatomic, retain) UIImage *dire;
@property (nonatomic, retain) UIImage *dirn;
@property (nonatomic, retain) UIImage *dirs;
@property (nonatomic, retain) UIImage *dirne;
@property (nonatomic, retain) UIImage *dirnw;
@property (nonatomic, retain) UIImage *dirse;
@property (nonatomic, retain) UIImage *dirsw;

+ (ImageHandler *)sharedImageHandler;

- (NSString *)imageId:(UIImage *)image;
- (UIImage *)imageForDirection:(NSString *)direction imageType:(int)imageType;
- (NSString *)randomDirection;
- (NSString *)imageDirection:(UIImage *)image;
- (NSInteger)imageType:(UIImage *)img;
- (NSInteger)imageTypeForImage:(UIImage *)img;
- (UIImage *)deadImageFor40;

- (void)setDefaultFaces;
- (void)setAnimeFaces;
- (void)setCurmudgenFaces;
- (void)setMonsterFaces;
- (void)setStickaFaces;
- (void)setCustomFaces;

- (void)loadCustomFaces;


@end
