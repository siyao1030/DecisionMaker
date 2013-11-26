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
    
    [self.comparedWith addObject:[NSNumber numberWithInt:1]];
    
    return self;
}

-(BOOL)alreadyComparedWithFactorAtIndex:(NSNumber *)other
{
    for (NSNumber* i in self.comparedWith)
    {
        if (i == other)
            return YES;
    }
    return NO;
}

-(void)updateAverageWeight
{
    NSNumber *newW = self.weights[self.weights.count-1];
    self.averageWeight = (self.averageWeight * (self.weights.count-1) + newW.doubleValue)/self.weights.count;
}
@end
