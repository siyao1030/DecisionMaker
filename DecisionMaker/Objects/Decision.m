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
    return self;
}


@end
