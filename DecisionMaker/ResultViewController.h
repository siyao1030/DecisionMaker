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

@interface ResultViewController : UIViewController

@property Decision * decision;

@property BubbleView *bubbles;

@property BubbleView * choiceABubble;
@property BubbleView * choiceBBubble;



-(id)initWithDecision:(Decision *)decision;

@end
