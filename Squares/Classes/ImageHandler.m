//
//  ImageLoader.m
//  Squares
//
//  Created by Eric on 2/12/09.
//  Copyright 2009 ciretose. All rights reserved.
//

#import "ImageHandler.h"


@implementation ImageHandler

@synthesize dead;
@synthesize ok;
@synthesize good;

@synthesize happy;
@synthesize nervous;
@synthesize sad;

@synthesize ahappy;
@synthesize anervous;
@synthesize asad;

@synthesize chappy;
@synthesize cnervous;
@synthesize csad;

@synthesize mhappy;
@synthesize mnervous;
@synthesize msad;

@synthesize shappy;
@synthesize snervous;
@synthesize ssad;

@synthesize custhappy;
@synthesize custnervous;
@synthesize custsad;

@synthesize green;
@synthesize yellow;
@synthesize red;

@synthesize dirw;
@synthesize dire;
@synthesize dirn;
@synthesize dirs;
@synthesize dirne;
@synthesize dirnw;
@synthesize dirse;
@synthesize dirsw;


static ImageHandler *sharedImageHandler = nil;

int currentFaceType = _FACE_DEFAULT;

+ (void) initialize
{
    if (self == [ImageHandler class])
    {
        sharedImageHandler = [[self alloc] init];
    }
}

+(ImageHandler *)sharedImageHandler
{
    return sharedImageHandler;
}


- (void) loadCustomFaces
{
    //if (custhappy != nil) [custhappy release];
    //if (custnervous != nil) [custnervous release];
    //if (custsad != nil) [custsad release];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *greenFile = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"customGreen.png"];
    NSString *yellowFile = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"customYellow.png"];
    NSString *redFile = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"customRed.png"];
    
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:greenFile isDirectory:NO] == YES)
    {
        custhappy = [[UIImage alloc] initWithContentsOfFile:greenFile];
    }
    else 
    {
        custhappy = [UIImage imageNamed:@"qgreen.png"];
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:yellowFile isDirectory:NO] == YES)
    {
        custnervous = [[UIImage alloc] initWithContentsOfFile:yellowFile];
    }
    else 
    {
        custnervous = [UIImage imageNamed:@"qyellow.png"];
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:redFile isDirectory:NO] == YES)
    {
        custsad = [[UIImage alloc] initWithContentsOfFile:redFile];
    }
    else 
    {
        custsad = [UIImage imageNamed:@"qred.png"];
    }
    
    //[greenFile release];
    //[yellowFile release];
    //[redFile release];
}

- (UIImage *)deadImageFor40
{
    if (currentFaceType == _FACE_ANIME)
    {
        return [UIImage imageNamed:@"adead.png"];
    }
    else if (currentFaceType == _FACE_CURMUDGEN)
    {
        return [UIImage imageNamed:@"cdead.png"];
    }
    else if (currentFaceType == _FACE_MONSTER)
    {
        return [UIImage imageNamed:@"mdead.png"];
    }
    else if (currentFaceType == _FACE_STICKA)
    {
        return [UIImage imageNamed:@"adead.png"];
    }
    else if (currentFaceType == _FACE_CUSTOM)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSString *redFile = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"customRed.png"];
        
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:redFile isDirectory:NO] == YES)
        {
            return [[UIImage alloc] initWithContentsOfFile:redFile];
        }
        else 
        {
            return [UIImage imageNamed:@"qred.png"];
        }
        
    }
    else 
    {
        return [UIImage imageNamed:@"dead.png"];
    }

}
 
- (id) init
{
    if ((self = [super init])) 
    {
       
        ok = nil;
        good = nil;
        dead = nil;
        
        happy = [UIImage imageNamed:@"good.png"];
        nervous = [UIImage imageNamed:@"ok.png"];
        sad = [UIImage imageNamed:@"dead.png"];
        
        ahappy = [UIImage imageNamed:@"ahappy.png"];
        anervous = [UIImage imageNamed:@"anervous.png"];
        asad = [UIImage imageNamed:@"adead.png"];
        
        chappy = [UIImage imageNamed:@"chappy.png"];
        cnervous = [UIImage imageNamed:@"cnervous.png"];
        csad = [UIImage imageNamed:@"cdead.png"];
        
        mhappy = [UIImage imageNamed:@"mhappy.png"];
        mnervous = [UIImage imageNamed:@"mnervous.png"];
        msad = [UIImage imageNamed:@"mdead.png"];
        
        shappy = [UIImage imageNamed:@"tsticka_green.png"];
        snervous = [UIImage imageNamed:@"tsticka_yellow.png"];
        ssad = [UIImage imageNamed:@"tsticka_red.png"];
        
        //[self loadCustomFaces];
                
        green = [UIImage imageNamed:@"green.png"];
        yellow = [UIImage imageNamed:@"yellow.png"];
        red = [UIImage imageNamed:@"red.png"];
        
        dirw = [UIImage imageNamed:@"whitew.png"];
        dire = [UIImage imageNamed:@"whitee.png"];
        dirn = [UIImage imageNamed:@"whiten.png"];
        dirs = [UIImage imageNamed:@"whites.png"];
        dirne = [UIImage imageNamed:@"whitene.png"];
        dirnw = [UIImage imageNamed:@"whitenw.png"];
        dirse = [UIImage imageNamed:@"whitese.png"];
        dirsw = [UIImage imageNamed:@"whitesw.png"];

    }
    
    return self;    
}

- (void) setDefaultFaces
{
    currentFaceType = _FACE_DEFAULT;
    good = happy;
    ok = nervous;
    dead = sad;
}

- (void) setAnimeFaces
{
    currentFaceType = _FACE_ANIME;
    good = ahappy;
    ok = anervous;
    dead = asad;
}

- (void) setCurmudgenFaces
{
    currentFaceType = _FACE_CURMUDGEN;
    good = chappy;
    ok = cnervous;
    dead = csad;
}

- (void) setMonsterFaces
{
    currentFaceType = _FACE_MONSTER;
    good = mhappy;
    ok = mnervous;
    dead = msad;
}

- (void) setStickaFaces
{
    currentFaceType = _FACE_STICKA;
    good = shappy;
    ok = snervous;
    dead = ssad;
}

- (void) setCustomFaces
{
    currentFaceType = _FACE_CUSTOM;
    [self loadCustomFaces];
    
    good = custhappy;
    ok = custnervous;
    dead = custsad;
}

- (NSString *)imageId:(UIImage *)image
{
    if (image == dead) { return [NSString stringWithFormat:@"%d", _DEAD]; }
    else if (image == ok) { return [NSString stringWithFormat:@"%d", _OK]; }
    else if (image == good) { return [NSString stringWithFormat:@"%d", _GOOD]; }
    else if (image == dirw) { return [NSString stringWithFormat:@"%d%@", _DIR, _W]; }
    else if (image == dire) { return [NSString stringWithFormat:@"%d%@", _DIR, _E]; }
    else if (image == dirn) { return [NSString stringWithFormat:@"%d%@", _DIR, _N]; }
    else if (image == dirs) { return [NSString stringWithFormat:@"%d%@", _DIR, _S]; }
    else if (image == dirne) { return [NSString stringWithFormat:@"%d%@", _DIR, _NE]; }
    else if (image == dirnw) { return [NSString stringWithFormat:@"%d%@", _DIR, _NW]; }
    else if (image == dirse) { return [NSString stringWithFormat:@"%d%@", _DIR, _SE]; }
    else if (image == dirsw) { return [NSString stringWithFormat:@"%d%@", _DIR, _SW]; }
    else { return @"0"; }
    
}

- (NSString *)imageDirection:(UIImage *)image
{
    NSString *imgid = [self imageId:image];
    NSString *dir = NULL;
    
    if ([imgid length] > 1)
    {
        dir = [imgid substringFromIndex:1];
    }
    
    return dir;
}

- (NSInteger)imageType:(UIImage *)image
{
    NSString *imgid = [self imageId:image];
    NSString *typeStr = [imgid substringToIndex:1];
    return [typeStr integerValue];
}

- (UIImage *)imageForDirection:(NSString *)direction imageType:(int)imageType
{
    if (direction == NULL || direction == nil)
    {
        if (imageType == _DIR) return dirs;
        else if (imageType == _GOOD) return good;
        else if (imageType == _OK) return ok;
    }
    else
    {
        if ([direction isEqualToString:_W])
        {
            if (imageType == _DIR) return dirw;
        }
        else if ([direction isEqualToString:_E])
        {
            if (imageType == _DIR) return dire;
        }
        else if ([direction isEqualToString:_N])
        {
            if (imageType == _DIR) return dirn;
        }
        else if ([direction isEqualToString:_S])
        {
            if (imageType == _DIR) return dirs;
        }
        else if ([direction isEqualToString:_NW])
        {
            if (imageType == _DIR) return dirnw;
        }
        else if ([direction isEqualToString:_NE])
        {
            if (imageType == _DIR) return dirne;
        }
        else if ([direction isEqualToString:_SW])
        {
            if (imageType == _DIR) return dirsw;
        }
        else if ([direction isEqualToString:_SE])
        {
            if (imageType == _DIR) return dirse;
        }
    }

    return dirs;
}

-(NSString *)randomDirection
{
    int dir = random() % 8;
    
    if (dir == 0)
    {        
        return _W;
    }
    else if (dir == 1)
    {
        return _E;
    }
    else if (dir == 2)
    {
        return _N;
    }
    else if (dir == 3)
    {
        return _S;
    }
    else if (dir == 4)
    {
        return _NW;
    }
    else if (dir == 5)
    {
        return _NE;
    }
    else if (dir == 6)
    {
        return _SW;
    }
    else if (dir == 7)
    {
        return _SE;
    }
    else 
    {
        // Should never get here...
        return _N;
    }
}

- (NSInteger) imageTypeForImage:(UIImage *)img
{
    // Current button gets set based on current state
    if (img == dirw || img == dire || img == dirs || img == dirn || img == dirnw 
        || img == dirne || img == dirsw || img == dirse)
    {
        return _DIR;
    }
    else if (img == good || img == green || img == happy || img == ahappy || img == chappy 
             || img == mhappy || img == shappy || img == custhappy)
    {
        return _GOOD;
    }
    else if (img == ok || img == nervous || img == yellow || img == anervous || img == cnervous 
             || img == mnervous || img == snervous || img == custnervous)
    {
        return _OK;
    }
    else if (img == dead || img == red || img == sad || img == asad || img == csad || img == msad 
             || img == ssad || img == custsad)
    {
        return _DEAD;
    }
    else
    {
        return 0;
    }
}




- (void) dealloc
{
    [dead release];
    [ok release];
    [good release];
    
    [happy release];
    [nervous release];
    [sad release];
    
    [ahappy release];
    [anervous release];
    [asad release];
    
    [chappy release];
    [cnervous release];
    [csad release];
    
    [mhappy release];
    [mnervous release];
    [msad release];
    
    [shappy release];
    [snervous release];
    [ssad release];
    
    [custhappy release];
    [custnervous release];
    [custsad release];
    
    [green release];
    [yellow release];
    [red release];
    
    [dirw release];
    [dire release];
    [dirn release];
    [dirs release];
    [dirne release];
    [dirnw release];
    [dirse release];
    [dirsw release];
    
    [super dealloc];
}

@end

