//
//  Choice.m
//  DecisionMaker
//
//  Created by Siyao Clara Xie on 11/22/13.
//  Copyright (c) 2013 Siyao Xie. All rights reserved.
//

#import "Choice.h"

@implementation Choice

-(id)initWithTitle:(NSString *)title
{
    self.title = title;
    self.factors = [[NSMutableArray alloc]init];
    
    return self;
}



-(void)addToFactors:(Factor *)factor
{
    [self.factors addObject:factor];
}

@end
