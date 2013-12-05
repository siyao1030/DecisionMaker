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
    self.result = [[NSMutableDictionary alloc]init]; //Should i initialize here?
    self.Ascore = 0;
    self.Bscore = 0;
    self.Arate = 0;
    self.Brate = 0;
    return self;
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
    NSLog(@"a score %d", self.Ascore);
    NSLog(@"b score: %d", self.Bscore);
    self.Arate = (float)self.Ascore/(self.Ascore+self.Bscore);
    self.Brate = (float)self.Bscore/(self.Ascore+self.Bscore);
    NSLog(@"a rate: %f", self.Arate);
    NSLog(@"b rate: %f", self.Brate);

}

@end
