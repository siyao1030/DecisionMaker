//
//  Factor.m
//  DecisionMaker
//
//  Created by Siyao Clara Xie on 11/22/13.
//  Copyright (c) 2013 Siyao Xie. All rights reserved.
//

#import "Factor.h"

@implementation Factor

-(id)initWithTitle:(NSString *)title andIsPro:(BOOL)isPro;
{
    self.title = title;
    self.isPro = isPro;
    self.averageWeight = 0;
    self.weights = [[NSMutableArray alloc] init];
    self.comparedWith = [[NSMutableArray alloc] init];
    
    //[self.comparedWith addObject:[NSNumber numberWithInt:1]];
    
    return self;
}

-(BOOL)alreadyComparedWithFactorAtIndex:(NSNumber *)other
{
    //NSLog(@"B value: %d",other.intValue);
    for (NSNumber* i in self.comparedWith)
    {
        //NSLog(@"A has already compared with: %d",i.intValue);
        if (i.intValue == other.intValue)
            return YES;
    }
    return NO;
}

-(void)updateAverageWeight
{
    NSNumber *newWIndex = self.weights[self.weights.count-1];
    self.averageWeight = (self.averageWeight * (self.weights.count-1) + newWIndex.doubleValue)/self.weights.count;
    
    NSLog(@"average weight: %f", self.averageWeight);
    /*
    if (self.isPro)
    {
        self.averageWeight = (self.averageWeight * (self.weights.count-1) + newWIndex.doubleValue)/self.weights.count;
    }
    else
    {
        self.averageWeight = (self.averageWeight * (self.weights.count-1) - newWIndex.doubleValue)/self.weights.count;
    }
*/
}

- (id)copyWithZone:(NSZone *)zone
{
    Factor * copy = [[Factor alloc] initWithTitle:self.title andIsPro:self.isPro];
    
    if (copy)
    {
        copy.weights = [self.weights copyWithZone:zone];
        copy.comparedWith = [self.comparedWith copyWithZone:zone];
        copy.averageWeight = self.averageWeight;

    }
    
    return copy;
}
@end
