//
//  CreateDecisionViewController.h
//  DecisionMaker
//
//  Created by Siyao Clara Xie on 11/22/13.
//  Copyright (c) 2013 Siyao Xie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Decision.h"
#import "AddProsConsViewController.h"

@interface CreateDecisionViewController : UIViewController

//@property (weak, nonatomic) IBOutlet UITextField *decisionTitle;

//@property (weak, nonatomic) IBOutlet UITextField *choiceA;
//@property (weak, nonatomic) IBOutlet UITextField *choiceB;

@property UITextField *decisionTitle;

@property UITextField *choiceA;
@property UITextField *choiceB;



@property Decision *decision;

@property id target;
@property SEL action;

-(void)setUpWithDecision:(Decision *)decision;
-(void)setup;

-(void)resetFields;


@end
