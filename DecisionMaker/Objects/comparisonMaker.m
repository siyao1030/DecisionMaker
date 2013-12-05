//
//  comparisonMaker.m
//  DecisionMaker
//
//  Created by Siyao Clara Xie on 11/23/13.
//  Copyright (c) 2013 Siyao Xie. All rights reserved.
//

#import "ComparisonMaker.h"

@implementation ComparisonMaker

-(id)initWithDecision:(Decision *)decision
{
    self.decision = decision;
    self.choiceA = decision.choices[0];
    self.choiceB = decision.choices[1];
    self.randomCount = 0;
    
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
          [[A[i] comparedWith] addObject:[NSNumber numberWithInt:i]];
        [[B[i] comparedWith] addObject:[NSNumber numberWithInt:i]];

        
    }
    
    //compare the factors that are left with randomly chosen factors
    for (int i = min; i < max; i++)
    {
        Comparison * comp;
        if (numOfFactorsA < numOfFactorsB)
        {
            int randomIndex = arc4random_uniform(min);
            comp = [[Comparison alloc]initWithFactorA:A[randomIndex] andFactorB:B[i]];
            [[A[randomIndex] comparedWith] addObject:[NSNumber numberWithInt:i]];
            [[B[i] comparedWith] addObject:[NSNumber numberWithInt:randomIndex]];
        }
        else
        {
            int randomIndex = arc4random_uniform(min);
            comp = [[Comparison alloc]initWithFactorA:A[i] andFactorB:B[randomIndex]];
            
            [[A[i] comparedWith] addObject:[NSNumber numberWithInt:randomIndex]];
            [[B[randomIndex] comparedWith] addObject:[NSNumber numberWithInt:i]];
            
        }
        [comparisons addObject:comp];
        
    }
    
    return comparisons;
}


-(NSMutableArray *)randomCompsGenerator
{
    int numOfFactorsA = self.choiceA.factors.count;
    int numOfFactorsB = self.choiceB.factors.count;
    int max = MAX(numOfFactorsA, numOfFactorsB);
    NSMutableArray * A = [[NSMutableArray alloc]initWithArray:self.choiceA.factors copyItems:YES];
    NSMutableArray * B = [[NSMutableArray alloc]initWithArray:self.choiceB.factors copyItems:YES];

    NSMutableArray * comparisons = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < max; i++)
    {
        if (A.count == 0)
            A = [[NSMutableArray alloc]initWithArray:self.choiceA.factors copyItems:YES];
        if (B.count == 0)
            B = [[NSMutableArray alloc]initWithArray:self.choiceB.factors copyItems:YES];
        
        Comparison * comp = [self singleRandomCompGeneratorWithAArray:A andBArray:B];
        [comparisons addObject:comp];
        [A removeObjectAtIndex:comp.factorAIndex];
        [B removeObjectAtIndex:comp.factorBIndex];
        self.randomCount = 0;
        

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


-(Comparison *)singleRandomCompGeneratorWithAArray:(NSMutableArray *)A andBArray:(NSMutableArray *)B
{
    
    //NSLog(@"a count: %d", A.count);
    //NSLog(@"b count: %d", B.count);

    
    int randomIndexA = arc4random_uniform(A.count);
    int randomIndexB = arc4random_uniform(B.count);
    
    //NSLog(@"random A: %d",randomIndexA);
    //NSLog(@"random B: %d",randomIndexB);
    
    // how should i handle the case when the items left have already compared with each other
    // currently if have to repeat, let it repeat *** not ideal
    if ([self.choiceA.factors[randomIndexA] alreadyComparedWithFactorAtIndex:[NSNumber numberWithInt:randomIndexB]] && self.randomCount <=MAX(A.count,B.count))
    {
        self.randomCount+=1;
        NSLog(@"shuffle again: %d",self.randomCount);
        return [self singleRandomCompGeneratorWithAArray:A andBArray:B];

    }
    else
    {
        [[self.choiceA.factors[randomIndexA] comparedWith] addObject:[NSNumber numberWithInt:randomIndexB]];
        [[self.choiceB.factors[randomIndexB] comparedWith] addObject:[NSNumber numberWithInt:randomIndexA]];
        return [[Comparison alloc]initWithFactorA:self.choiceA.factors[randomIndexA]
                                         andIndex:randomIndexA
                                       andFactorB:self.choiceB.factors[randomIndexB]
                                         andindex:randomIndexB];
    }
    
}


@end
