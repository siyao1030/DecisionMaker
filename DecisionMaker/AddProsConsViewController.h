//
//  AddProsConsViewController.h
//  DecisionMaker
//
//  Created by Siyao Clara Xie on 11/23/13.
//  Copyright (c) 2013 Siyao Xie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Decision.h"

@interface AddProsConsViewController : UIViewController

//@property (weak, nonatomic) IBOutlet UIButton *choiceAButton;
//@property (weak, nonatomic) IBOutlet UIButton *choiceBButton;

@property UIButton *choiceAButton;
@property UIButton *choiceBButton;
@property UITextField *inputField;
@property UIButton *isPro;
@property UIButton *isCon;


@property Decision * decision;
@property Choice   * listening;

-(void)setUpWithDecision:(Decision *)decision;

@end
