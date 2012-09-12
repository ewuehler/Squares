//
//  Square.m
//  SuperSquares
//
//  Created by Eric on 6/9/10.
//  Copyright 2010 ciretose.com. All rights reserved.
//

#import "Square.h"


@implementation Square

@synthesize boardSize;
@synthesize delegate;

BOOL cancelTouchEvent = NO;


- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) 
    {
        currentImageState = STATE_EMPTY;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    CGPoint p = [[touches anyObject] locationInView:self];
//    NSLog(@"Touches began in bounds: %.2fx%.2f", p.x, p.y);
    
    [self setAlpha:0.5];
    NSInteger target = [self targetSquare];
    
    Square *t = (Square *)[self.superview viewWithTag:target];
    [t setAlpha:0.5];

}

- (void)cancelSquareTouch
{
    if (cancelTouchEvent == NO)
    {
        NSLog(@"Cancel the touch!!!!");
        cancelTouchEvent = YES;
        [self setAlpha:1];
        NSInteger target = [self targetSquare];
        Square *t = (Square *)[self.superview viewWithTag:target];
        [t setAlpha:1];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint p = [[touches anyObject] locationInView:self];
//    NSLog(@"Touches moved in bounds: %.2fx%.2f", p.x, p.y);
    
    if ([self pointInside:p withEvent:event] == NO)
    {
        [self cancelSquareTouch];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Cancelled touch?");
    [self cancelSquareTouch];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (cancelTouchEvent == NO)
    {
       // UITouch *touch = [[event allTouches] anyObject];
//        NSLog(@"Which one: %d (is %d)", [[touch view] tag], self.tag);
        
        NSInteger target = [self targetSquare];
//        NSLog(@"Target Square: %d", target);
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelay:0];
        [UIView setAnimationDuration:0.25];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self cache:YES];
        
        [self randomizeImageDirection];
        [self setAlpha:1];
        
        [UIView commitAnimations];
        
        // Make the target square change to green
        [self changeTargetSquare:target];
    }
    cancelTouchEvent = NO;
}

- (void) initiateGameOverProcedure
{
//    NSLog(@"initiate game over procedure");
    [self.delegate gameOver];
}

- (BOOL) canChange
{
    NSInteger state = [self currentImageState];
    if (state == STATE_GREEN || state == STATE_YELLOW || state == STATE_RED)
    {
        return NO;
    }
    return YES;
}

- (void) changeTargetSquare:(NSInteger)target
{
    Square *ts = (Square *)[self.superview viewWithTag:target];
//    NSLog(@"Target view %d: %@", target, [ts description]);
    
    NSInteger state = [ts currentImageState];
    if (state == STATE_GREEN)
    {
        [self setUserInteractionEnabled:NO];
        [self setCurrentImageState:STATE_GREEN];
        [self.delegate incrementScoreBy:10];
    }
    else if (state == STATE_YELLOW)
    {
        [self setUserInteractionEnabled:NO];
        [self setCurrentImageState:STATE_GREEN];
    }
    
    [ts recieveChangeTargetMessage];
    
}

- (void) recieveChangeTargetMessage
{
//    NSLog(@"I am %d, and was asked to change", self.tag);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelay:0];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self cache:YES];
    
    [self setUserInteractionEnabled:NO];
    if (currentImageState == STATE_GREEN)
    {
        [self setCurrentImageState:STATE_YELLOW];
        [self.delegate incrementScoreBy:-10];
    }
    else if (currentImageState == STATE_YELLOW)
    {
        [self setCurrentImageState:STATE_RED];
        [self.delegate incrementScoreBy:10];
        [self initiateGameOverProcedure];
    }
    else 
    {
        [self setCurrentImageState:STATE_GREEN];
        [self.delegate incrementScoreBy:10];
    }

    [self setAlpha:1];
    
    [UIView commitAnimations];
    
    // Now, check to see if there is anything left to do...
    [self.delegate decrementSquareCount];
}

- (NSInteger) targetSquare
{
    NSInteger thisSquare = (self.tag - SQUARE_TAG_OFFSET);
    NSInteger thisRow = (thisSquare % 100);
    NSInteger thisColumn = (thisSquare / 100);
    
//    NSLog(@"thisRow: %d and thisColumn: %d", thisRow, thisColumn);
    NSInteger targetRow = thisRow;
    NSInteger targetColumn = thisColumn;
    
    NSInteger rowBorder = self.boardSize - 1;
    NSInteger columnBorder = self.boardSize - 1;
    
    NSInteger targetSquare = 0;
    switch (currentImageState)
    {
        case STATE_N:
            if (thisRow == 0)
            {
                targetRow = rowBorder;
            }
            else
            {
                targetRow--;
            }
            break;
        case STATE_NE:
            if (thisColumn == columnBorder)
            {
                targetColumn = 0;
                if (thisRow == 0)
                {
                    targetRow = rowBorder;
                }
                else
                {
                    targetRow--;
                }
            }
            else
            {
                targetColumn++;
                if ( thisRow == 0 )
                {
                    targetRow = rowBorder;
                }
                else
                {
                    targetRow--;
                }
            }
            break;
        case STATE_E:
            if (thisColumn == columnBorder)
            {
                targetColumn = 0;
            }
            else 
            {
                targetColumn++;
            }
            break;
        case STATE_SE:
            if (thisColumn == columnBorder)
            {
                targetColumn = 0;
                if (thisRow == rowBorder)
                {
                    targetRow = 0;
                }
                else
                {
                    targetRow++;
                }
            }
            else
            {
                targetColumn++;
                if ( thisRow == rowBorder )
                {
                    targetRow = 0;
                }
                else
                {
                    targetRow++;
                }
            }
            break;
        case STATE_S:
            if (thisRow == rowBorder)
            {
                targetRow = 0;
            }
            else
            {
                targetRow++;
            }
            break;
        case STATE_SW:
            if (thisColumn == 0)
            {
                targetColumn = columnBorder;
                if (thisRow == rowBorder)
                {
                    targetRow = 0;
                }
                else
                {
                    targetRow++;
                }
            }
            else
            {
                targetColumn--;
                if ( thisRow == rowBorder )
                {
                    targetRow = 0;
                }
                else
                {
                    targetRow++;
                }
            }
            break;
        case STATE_W:
            if (thisColumn == 0)
            {
                targetColumn = columnBorder;
            }
            else
            {
                targetColumn--;
            }
            break;
        case STATE_NW:
            if (thisColumn == 0)
            {
                targetColumn = columnBorder;
                if (thisRow == 0)
                {
                    targetRow = rowBorder;
                }
                else
                {
                    targetRow--;
                }
            }
            else
            {
                targetColumn--;
                if ( thisRow == 0 )
                {
                    targetRow = rowBorder;
                }
                else
                {
                    targetRow--;
                }
            }
            break;
            
        case STATE_EMPTY:
        case STATE_GREEN:
        case STATE_YELLOW:
        case STATE_RED:
        default:
            NSLog(@"This should not be hit - these squares are not \"touchable\"");
    }
    
    targetSquare = (targetColumn * 100) + targetRow + SQUARE_TAG_OFFSET;
//    NSLog(@"Target is %d", targetSquare);
    return targetSquare;
}

- (NSInteger) currentImageState
{
    return currentImageState;
}

- (void) setCurrentImageState:(NSInteger)state
{
    currentImageState = state;
    [self setImage:[UIImage imageNamed:[self imageNameForState:state]]];
}

- (NSString *)imageNameForState:(NSInteger)state
{
    switch (state) {
        case STATE_EMPTY:
            return IMAGE_EMPTY;
        case STATE_N:
            return IMAGE_N;
        case STATE_NE:
            return IMAGE_NE;
        case STATE_E:
            return IMAGE_E;
        case STATE_SE:
            return IMAGE_SE;
        case STATE_S:
            return IMAGE_S;
        case STATE_SW:
            return IMAGE_SW;
        case STATE_W:
            return IMAGE_W;
        case STATE_NW:
            return IMAGE_NW;
        case STATE_GREEN:
            return IMAGE_GREEN;
        case STATE_YELLOW:
            return IMAGE_YELLOW;
        case STATE_RED:
            return IMAGE_RED;
        default:
            self.currentImageState = STATE_N;
            return IMAGE_N;
    }
}

- (void) randomizeImageDirection
{
    // This should be a number 1 thru 8, or STATE_N - STATE_NW
    NSInteger arrow = 0;
    NSInteger makeSureWeDontGoInfinite = 0;
    do 
    {
        arrow = (random() % 8) + 1;
        makeSureWeDontGoInfinite++;
    } 
    while (arrow == currentImageState || makeSureWeDontGoInfinite < 10);
    
    [self setCurrentImageState:arrow];
}




- (void)dealloc 
{
    [super dealloc];
}


@end
