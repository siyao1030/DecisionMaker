//
//  Decision.m
//  DecisionMaker
//
//  Created by Siyao Clara Xie on 11/22/13.
//  Copyright (c) 2013 Siyao Xie. All rights reserved.
//

#import "Decision.h"

@implementation Decision

-(id)initWithChoiceA:(Choice *)choice1 andChoiceB:(Choice *)choice2 andTitle:(NSString *)title
{
    self.title = title;
    self.choices = [[NSMutableArray alloc]initWithObjects:choice1, choice2,nil];
    self.Ascore = 0;
    self.Bscore = 0;
    self.Arate = 0;
    self.Brate = 0;
    self.AResult = 0;
    self.BResult = 0;
    self.rowid = -1;
    return self;
}

-(void)resetStats
{
    self.Ascore = 0;
    self.Bscore = 0;
    self.Arate = 0;
    self.Brate = 0;
    
    [self.choices[0] resetStats];
    [self.choices[1] resetStats];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.choices forKey:@"choices"];
    [aCoder encodeInt:self.Ascore forKey:@"Ascore"];
    [aCoder encodeInt:self.Bscore forKey:@"Bscore"];
    [aCoder encodeFloat:self.Arate forKey:@"Arate"];
    [aCoder encodeFloat:self.Brate forKey:@"Brate"];
    [aCoder encodeInt:self.AResult forKey:@"AResult"];
    [aCoder encodeInt:self.BResult forKey:@"BResult"];
    [aCoder encodeInt:self.stage forKey:@"stage"];

}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.choices = [aDecoder decodeObjectForKey:@"choices"];
        self.Ascore = [aDecoder decodeIntForKey:@"Ascore"];
        self.Bscore = [aDecoder decodeIntForKey:@"Bscore"];
        self.Arate = [aDecoder decodeFloatForKey:@"Arate"];
        self.Brate = [aDecoder decodeFloatForKey:@"Brate"];
        self.AResult = [aDecoder decodeIntForKey:@"AResult"];
        self.BResult = [aDecoder decodeIntForKey:@"BResult"];
        self.stage = [aDecoder decodeIntForKey:@"stage"];
    }
    return self;
}

-(void)updateResult
{
    self.AResult = (int)(self.Arate*100+0.5);
    self.BResult = (int)(self.Brate*100+0.5);
    
}

-(void)updateScore
{
    int Ascore = 0;
    int Bscore = 0;
    for (Factor * factor in [[self.choices objectAtIndex:0] factors])
    {
        if (factor.isPro)
            Ascore += factor.averageWeight;
        else
            Ascore -= factor.averageWeight;
        //NSLog(@"WEIGHT: %f", factor.averageWeight);
        //NSLog(@"a score %d", Ascore);
    }
    
    for (Factor * factor in [[self.choices objectAtIndex:1] factors])
    {
        if (factor.isPro)
            Bscore += factor.averageWeight;
        else
            Bscore -= factor.averageWeight;
    }
    
    self.Ascore = Ascore;
    self.Bscore = Bscore;
    //NSLog(@"a score %d", self.Ascore);
    //NSLog(@"b score: %d", self.Bscore);
    //if (self.Ascore+Bscore !=0)
   // {
        self.Arate = (float)self.Ascore/(self.Ascore+self.Bscore);
        self.Brate = (float)self.Bscore/(self.Ascore+self.Bscore);
    //}
//    else
//    {
//        self.Arate = (float)self.Ascore/(0.01);
//        self.Brate = (float)self.Bscore/(0.01);
//    }

    NSLog(@"a rate: %f", self.Arate);
    NSLog(@"b rate: %f", self.Brate);

}

@end
