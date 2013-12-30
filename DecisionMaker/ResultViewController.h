//
//  ResultViewController.h
//  DecisionMaker
//
//  Created by Siyao Clara Xie on 12/3/13.
//  Copyright (c) 2013 Siyao Xie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Decision.h"
#import "BubbleView.h"
#import "Database.h"
#import "ResultAnalysisViewController.h"

@interface ResultViewController : UIViewController

@property Decision * decision;

@property BubbleView * bubbles;

@property BubbleView * choiceABubble;
@property BubbleView * choiceBBubble;

@property UIBarButtonItem * endButton;
@property UILabel * resultLabel;
@property UILabel * winner;

@property UIButton * analysisButton;

-(id)initWithDecision:(Decision *)decision;

@end
