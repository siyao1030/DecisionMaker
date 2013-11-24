//
//  DecisionTableViewController.h
//  DecisionMaker
//
//  Created by Siyao Clara Xie on 11/22/13.
//  Copyright (c) 2013 Siyao Xie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Decision.h"
#import "CreateDecisionViewController.h"

@interface DecisionTableViewController : UITableViewController

//ViewControllers
@property CreateDecisionViewController * createDecisionView;

@property NSMutableArray * decisions;

-(void)addDecision:(Decision *)decision;

@end
