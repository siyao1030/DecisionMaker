//
//  BubbleView.m
//  DecisionMaker
//
//  Created by Siyao Clara Xie on 12/3/13.
//  Copyright (c) 2013 Siyao Xie. All rights reserved.
//

#import "BubbleView.h"

@implementation BubbleView

#define darkGreen [UIColor colorWithRed:103/255.0 green:192/255.0 blue:145/255.0 alpha:1]
#define lightGreen [UIColor colorWithRed:102/255.0 green:248/255.0 blue:167/255.0 alpha:0.6]

#define darkOrange [UIColor colorWithRed:248/255.0 green:178/255.0 blue:3/255.0 alpha:1]
#define lightOrange [UIColor colorWithRed:255.0/255.0 green:210/255.0 blue:0/255.0 alpha:0.6]


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setUpWithSiza:(int)size andLabel:(NSString *)label andChoice:(int)index andShouldDisplaySize:(BOOL)shouldDisplay
{

    
    /*
    self.label = [[UILabel alloc]init];
    [self.label setText:label];
    if (index == 0)
        [self.label setTextColor:darkGreen];
    else
        [self.label setTextColor:darkOrange];
    */
    
}

-(void)setUpWithItemALabel:(NSString *)labelA andASize:(int)sizeA andItemBLabel: (NSString *)labelB andBSize:(int)sizeB andShouldDisplaySize:(BOOL)shouldDisplay
{
    self.sizeA = sizeA;
    self.labelA= labelA;
    self.sizeB = sizeB;
    self.labelB= labelB;
    self.displaySize = shouldDisplay;
    self.isProA = -1;
    self.isProB = -1;
    
}


-(void)setUpWithItemALabel:(NSString *)labelA andASize:(int)sizeA andisPro:(BOOL)isProA andItemBLabel: (NSString *)labelB andBSize:(int)sizeB  andisPro:(BOOL)isProB andShouldDisplaySize:(BOOL)shouldDisplay
{
    self.sizeA = sizeA;
    self.labelA= labelA;
    self.isProA = isProA;
    self.sizeB = sizeB;
    self.labelB= labelB;
    self.isProB = isProB;
    self.displaySize = shouldDisplay;
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    // gets the coordinats of the touch with respect to the specified view.
    CGPoint touchPoint = [touch locationInView:self];
    
    // test the coordinates however you wish,
    // within circle A
    int radiusA = 170*(self.sizeA/100.0)/2;
    float Axdiff = fabsf(touchPoint.x-160);
    float Aydiff = fabsf(touchPoint.y-(200-radiusA));
    
    int radiusB = 170*(self.sizeB/100.0)/2;
    float Bxdiff = fabsf(touchPoint.x-160);
    float Bydiff = fabsf(touchPoint.y-(200+radiusB));
    
    if (Axdiff*Axdiff + Aydiff*Aydiff <=radiusA*radiusA)
    {
        [self.target performSelector:self.increaseA withObject:nil];
        //[self setNeedsDisplay];
    }
    
    if (Bxdiff*Bxdiff + Bydiff*Bydiff <=radiusB*radiusB)
    {
        [self.target performSelector:self.increaseB withObject:nil];
        //[self setNeedsDisplay];
    }
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


- (void)drawRect:(CGRect)rect
{
    
    //// Color Declarations
    UIColor* fillColor = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    
    //// Abstracted Attributes
    NSString* sizeContentA = [NSString stringWithFormat:@"%d",self.sizeA];
    NSString* sizeContentB = [NSString stringWithFormat:@"%d",self.sizeB];
    int diameterA = 170*(self.sizeA/100.0);
    int diameterB = 170*(self.sizeB/100.0);
    int sizeFontA = 60*(self.sizeA/100.0);
    int sizeFontB = 60*(self.sizeB/100.0);
    
    if (diameterA < 17) {
        diameterA = 17;
        diameterB = 170*0.9;
        sizeFontA = 6;
        sizeFontB = 60*0.9;
    }
    if (diameterB < 17)
    {
        diameterA = 170*0.9;
        diameterB = 17;
        sizeFontA = 60*0.9;
        sizeFontB = 6;
    }


    
    //// Oval Drawing
    CGRect ovalRect = CGRectMake(160-diameterA/2, 200-diameterA, diameterA, diameterA);
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: ovalRect];
    UIColor * colorGreen;
    if (self.isProA == NO)
        colorGreen = darkGreen;
    else
        colorGreen = lightGreen;
    
    [colorGreen setFill];
    [ovalPath fill];
    [colorGreen setStroke];
    ovalPath.lineWidth = 0.5;
    [ovalPath stroke];
    [fillColor setFill];
    [sizeContentA drawInRect: CGRectInset(ovalRect, 0, (diameterA-sizeFontA)/2) withFont: [UIFont fontWithName: @"HelveticaNeue-Light"  size: sizeFontA] lineBreakMode: NSLineBreakByWordWrapping alignment: NSTextAlignmentCenter];
    
    
    //// Text 1 Drawing
    CGRect text2Rect = CGRectMake(0, 200-diameterA-39, 321, 39);
    [darkGreen setFill];
    [self.labelA drawInRect: text2Rect withFont: [UIFont fontWithName: @"HelveticaNeue-Light" size: 30] lineBreakMode: NSLineBreakByWordWrapping alignment: NSTextAlignmentCenter];
    
    //// Text 2 Drawing
    CGRect textRect = CGRectMake(0, 200+diameterB, 321, 39);
    [darkOrange setFill];
    [self.labelB drawInRect: textRect withFont: [UIFont fontWithName: @"HelveticaNeue-Light"  size: 30] lineBreakMode: NSLineBreakByWordWrapping alignment: NSTextAlignmentCenter];
    
    
    //// Oval 2 Drawing
    CGRect oval2Rect = CGRectMake(160-diameterB/2, 200, diameterB, diameterB);
    UIBezierPath* oval2Path = [UIBezierPath bezierPathWithOvalInRect: oval2Rect];
    
    UIColor * colorOrange;
    if (self.isProB == NO)
        colorOrange = darkOrange;
    else
        colorOrange = lightOrange;
    
    [colorOrange setFill];
    [oval2Path fill];
    [colorOrange setStroke];
    oval2Path.lineWidth = 0.5;
    [oval2Path stroke];
    [fillColor setFill];
    [sizeContentB drawInRect: CGRectInset(oval2Rect, 0, (diameterB-sizeFontB)/2) withFont: [UIFont fontWithName: @"HelveticaNeue-Light"  size: sizeFontB] lineBreakMode: NSLineBreakByWordWrapping alignment: NSTextAlignmentCenter];
    
    

    

}


@end
