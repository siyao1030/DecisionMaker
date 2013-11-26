//
//  comparisonMaker.m
//  DecisionMaker
//
//  Created by Siyao Clara Xie on 11/23/13.
//  Copyright (c) 2013 Siyao Xie. All rights reserved.
//

#import "comparisonMaker.h"

@implementation comparisonMaker

-(id)initWithDecision:(Decision *)decision
{
    self.decision = decision;
    self.choiceA = decision.choices[0];
    self.choiceB = decision.choices[1];
    
    return self;
}



-(NSMutableArray *)inOrderCompsGeneratorWithArrayA:(NSArray *)A andArrayB:(NSArray *)B
{
    int numOfFactorsA = self.choiceA.factors.count;
    int numOfFactorsB = self.choiceB.factors.count;
    int min = MIN(numOfFactorsA, numOfFactorsB);
    int max = MAX(numOfFactorsA, numOfFactorsB);
    
    NSMutableArray *comparisons = [[NSMutableArray alloc]init];
    
    //comparing A's ith factor with B's ith factor
    for (int i = 0; i < min; i++)
    {

        Comparison * comp = [[Comparison alloc]initWithFactorA:A[i] andFactorB:B[i]];
        [comparisons addObject:comp];
        NSLog(@"count: %d",comparisons.count);
        NSLog(@"added comparison %@ and %@", comp.factorA.title, comp.factorB.title);
        [[A[i] comparedWith] addObject:[NSNumber numberWithInt:i]];
        [[B[i] comparedWith] addObject:[NSNumber numberWithInt:i]];

        
    }
    
    //compare the factors that are left with randomly chosen factors
    for (int i = min; i < max; i++)
    {
        Comparison * comp;
        if (numOfFactorsA < numOfFactorsB)
        {
            int randomIndex = arc4random_uniform(min-1);
            comp = [[Comparison alloc]initWithFactorA:A[randomIndex] andFactorB:B[i]];
            [[A[randomIndex] comparedWith] addObject:[NSNumber numberWithInt:i]];
            [[B[i] comparedWith] addObject:[NSNumber numberWithInt:randomIndex]];
        }
        else
        {
            int randomIndex = arc4random_uniform(min-1);
            comp = [[Comparison alloc]initWithFactorA:A[i] andFactorB:B[randomIndex]];
            
            [[A[i] comparedWith] addObject:[NSNumber numberWithInt:randomIndex]];
            [[B[randomIndex] comparedWith] addObject:[NSNumber numberWithInt:i]];
            
        }
        [comparisons addObject:comp];
        
    }
    
    NSLog(@"num of comps before return: %d", comparisons.count);
    return comparisons;
}


-(NSMutableArray *)randomCompsGenerator
{
    int numOfFactorsA = self.choiceA.factors.count;
    int numOfFactorsB = self.choiceB.factors.count;
    int max = MAX(numOfFactorsA, numOfFactorsB);
    int numOfFactorsALeft = numOfFactorsA;
    int numOfFactorsBLeft = numOfFactorsB;

    NSMutableArray * comparisons;
    
    for (int i = 0; i < max; i++)
    {
        if (numOfFactorsALeft == 0)
            numOfFactorsALeft = numOfFactorsA;
        else if (numOfFactorsBLeft == 0)
            numOfFactorsBLeft = numOfFactorsB;
        
        Comparison * comp = [self singleRandomCompGeneratorWithACount:numOfFactorsALeft andBCount:numOfFactorsBLeft];
        [comparisons addObject:comp];
        numOfFactorsA -=1;
        numOfFactorsB -=1;
    }
    
    return comparisons;
    
}


-(NSMutableArray *)currentWeightRankingCompsGenerator
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"averageWeight"
                                                 ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedA = [self.choiceA.factors sortedArrayUsingDescriptors:sortDescriptors];
    NSArray *sortedB = [self.choiceB.factors sortedArrayUsingDescriptors:sortDescriptors];
    
    return [self inOrderCompsGeneratorWithArrayA:sortedA andArrayB:sortedB];
    
}

-(Comparison *)singleRandomCompGeneratorWithACount:(int)a andBCount:(int)b
{
    int randomIndexA = arc4random_uniform(a);
    int randomIndexB = arc4random_uniform(b);
    
    if ([self.choiceA.factors[randomIndexA] alreadyComparedWithFactorAtIndex:[NSNumber numberWithInt:randomIndexB]])
        return [self singleRandomCompGeneratorWithACount:a andBCount:b];
    else
    {
        [[self.choiceA.factors[randomIndexA] comparedWith] addObject:[NSNumber numberWithInt:randomIndexB]];
        [[self.choiceB.factors[randomIndexB] comparedWith] addObject:[NSNumber numberWithInt:randomIndexA]];
        return [[Comparison alloc]initWithFactorA:self.choiceA.factors[randomIndexA]
                                       andFactorB:self.choiceB.factors[randomIndexB]];
    }
    
}


@end
