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
    self.comparisons = [[NSMutableArray alloc]init];
    self.Ascore = 0;
    self.Bscore = 0;
    self.Arate = 0;
    self.Brate = 0;
    self.AResult = 0;
    self.BResult = 0;
    self.round = 0;
    self.rowid = -1;
    self.numOfCompsDone = 0;
    return self;
}

-(void)resetStats
{
    self.Ascore = 0;
    self.Bscore = 0;
    self.Arate = 0;
    self.Brate = 0;
    self.round = 1;
    self.numOfCompsDone = 0;
    
    for (Comparison * comp in self.comparisons)
    {
        [comp resetStats];
    }
    
    [self.choices[0] resetStats];
    [self.choices[1] resetStats];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.choices forKey:@"choices"];
    [aCoder encodeObject:self.comparisons forKey:@"comparisons"];
    [aCoder encodeInt:self.Ascore forKey:@"Ascore"];
    [aCoder encodeInt:self.Bscore forKey:@"Bscore"];
    [aCoder encodeFloat:self.Arate forKey:@"Arate"];
    [aCoder encodeFloat:self.Brate forKey:@"Brate"];
    [aCoder encodeInt:self.AResult forKey:@"AResult"];
    [aCoder encodeInt:self.BResult forKey:@"BResult"];
    [aCoder encodeInt:self.stage forKey:@"stage"];
    [aCoder encodeInt:self.round forKey:@"round"];
    [aCoder encodeInt:self.numOfCompsDone forKey:@"numOfCompsDone"];
    

}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.choices = [aDecoder decodeObjectForKey:@"choices"];
        self.comparisons = [aDecoder decodeObjectForKey:@"comparisons"];
        self.Ascore = [aDecoder decodeIntForKey:@"Ascore"];
        self.Bscore = [aDecoder decodeIntForKey:@"Bscore"];
        self.Arate = [aDecoder decodeFloatForKey:@"Arate"];
        self.Brate = [aDecoder decodeFloatForKey:@"Brate"];
        self.AResult = [aDecoder decodeIntForKey:@"AResult"];
        self.BResult = [aDecoder decodeIntForKey:@"BResult"];
        self.stage = [aDecoder decodeIntForKey:@"stage"];
        self.round = [aDecoder decodeIntForKey:@"round"];
        self.numOfCompsDone = [aDecoder decodeIntForKey:@"numOfCompsDone"];
    }
    return self;
}

-(void)updateResult
{
    if (self.Arate >= 0 && self.Brate >= 0)
    {
        self.AResult = (int)(self.Arate*100+0.5);
        self.BResult = (int)(self.Brate*100+0.5);
    }
    else if (self.Arate < 0)
    {
        self.AResult = 1;
        self.BResult = 99;
    }
    else if (self.Brate < 0)
    {
        self.AResult = 99;
        self.BResult = 1;
    }

    
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

    self.Arate = (float)self.Ascore/(self.Ascore+self.Bscore);
    self.Brate = (float)self.Bscore/(self.Ascore+self.Bscore);

    NSLog(@"a rate: %f", self.Arate);
    NSLog(@"b rate: %f", self.Brate);

}

-(void)addComparison:(Comparison *)comparison
{
    [self.comparisons addObject:comparison];
}

@end
