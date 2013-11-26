//
//  Comparison.h
//  DecisionMaker
//
//  Created by Siyao Clara Xie on 11/24/13.
//  Copyright (c) 2013 Siyao Xie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Decision.h"


@interface Comparison : NSObject

@property Factor * factorA;
@property Factor * factorB;

@property float factorAWeight;
@property float factorBWeight;

-(id)initWithFactorA:(Factor *)factorA andFactorB:(Factor *)factorB;

@end
