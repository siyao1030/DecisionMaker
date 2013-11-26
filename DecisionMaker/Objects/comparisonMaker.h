//
//  comparisonMaker.h
//  DecisionMaker
//
//  Created by Siyao Clara Xie on 11/23/13.
//  Copyright (c) 2013 Siyao Xie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Decision.h"
#import "Comparison.h"


@interface comparisonMaker : NSObject

@property Decision * decision;
@property Choice * choiceA;
@property Choice * choiceB;


-(id)initWithDecision:(Decision *)decision;
-(NSMutableArray *)inOrderCompsGeneratorWithArrayA:(NSArray *)A andArrayB:(NSArray *)B;
-(NSMutableArray *)currentWeightRankingCompsGenerator;
-(NSMutableArray *)randomCompsGenerator;



@end
