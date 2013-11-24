//
//  Factor.m
//  DecisionMaker
//
//  Created by Siyao Clara Xie on 11/22/13.
//  Copyright (c) 2013 Siyao Xie. All rights reserved.
//

#import "Factor.h"

@implementation Factor

-(id)initWithTitle:(NSString *)title
{
    self.title = title;
    self.averageWeight = 0;
    self.weights = [[NSMutableArray alloc] init];
    
    return self;
}

@end
