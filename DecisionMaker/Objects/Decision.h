//
//  Decision.h
//  DecisionMaker
//
//  Created by Siyao Clara Xie on 11/22/13.
//  Copyright (c) 2013 Siyao Xie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Choice.h"

@interface Decision : NSObject

@property NSString *title;
@property NSMutableArray *choices;
@property NSMutableDictionary *result;

-(id)initWithChoiceA:(Choice *)choice1 andChoiceB:(Choice *)choice2 andTitle:(NSString *)title;


@end
