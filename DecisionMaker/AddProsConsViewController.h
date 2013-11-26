//
//  AddProsConsViewController.h
//  DecisionMaker
//
//  Created by Siyao Clara Xie on 11/23/13.
//  Copyright (c) 2013 Siyao Xie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Decision.h"
#import "ComparisonViewController.h"

@interface AddProsConsViewController : UIViewController

//@property (weak, nonatomic) IBOutlet UITableView *choiceATableView;
//@property (weak, nonatomic) IBOutlet UITableView *choiceBTableView;

@property UITableView *choiceATableView;
@property UITableView *choiceBTableView;

@property ComparisonViewController *compareView;

@property UIButton *choiceAButton;
@property UIButton *choiceBButton;
@property UITextField *inputField;
@property UIView *dimBG;
@property UIButton *isPro;
@property UIButton *isCon;


@property Decision * decision;
@property Choice   * listening;

@property NSMutableArray *choiceAfactors;
@property NSMutableArray *choiceBfactors;




-(void)setUpWithDecision:(Decision *)decision;

@end
