//
//  ResultAnalysisViewController.h
//  DecisionMaker
//
//  Created by Siyao Clara Xie on 12/29/13.
//  Copyright (c) 2013 Siyao Xie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Decision.h"
#import "CompResultCellView.h"

@interface ResultAnalysisViewController : UIViewController

@property UITableView * tableView;
@property Decision * decision;

-(id)initWithDecision:(Decision *)decision;
@end
