//
//  ComparisonViewController.h
//  DecisionMaker
//
//  Created by Siyao Clara Xie on 11/24/13.
//  Copyright (c) 2013 Siyao Xie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Decision.h"
#import "Comparison.h"
#import "comparisonMaker.h"

@interface ComparisonViewController : UIViewController

@property UILabel * choiceALabel;
@property UILabel * choiceBLabel;

@property int factorAWeight;
@property int factorBWeight;

@property UILabel * factorAWeightLabel;
@property UILabel * factorBWeightLabel;

@property UILabel * factorALabel;
@property UILabel * factorBLabel;

@property UIButton * factorAButton;
@property UIButton * factorBButton;

@property UIButton * prevButton;
@property UIButton * nextButton;

@property Decision * decision;
@property Choice * choiceA;
@property Choice * choiceB;


@property int numOfCompPerRound;
@property int numOfCompsDone;

@property NSMutableArray * comparisons;
@property Comparison *currentComparison;
@property comparisonMaker * comparisonMaker;

-(id)initWithDecision:(Decision *)decision;

@end
