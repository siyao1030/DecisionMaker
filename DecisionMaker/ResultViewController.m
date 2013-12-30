//
//  ResultViewController.m
//  DecisionMaker
//
//  Created by Siyao Clara Xie on 12/3/13.
//  Copyright (c) 2013 Siyao Xie. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()

@end

@implementation ResultViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

-(id)initWithDecision:(Decision *)decision
{
    self.decision = decision;

    self.view.backgroundColor = bgColor;

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:18.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = titleColor; // change this color
    self.navigationItem.titleView = label;
    
    [label setText: @"Result"];
    [label sizeToFit];
    
    
    self.bubbles = [[BubbleView alloc]initWithFrame:CGRectMake(0, 60, 320, 400)];

    Choice * a = self.decision.choices[0];
    Choice * b = self.decision.choices[1];
    
    [self.bubbles setUpWithItemALabel:a.title andASize:self.decision.AResult andItemBLabel:b.title andBSize:self.decision.BResult andShouldDisplaySize:YES];
    [self.bubbles setBackgroundColor:bgColor];

    [self.view addSubview:self.bubbles];
    
    
    self.resultLabel = [[UILabel alloc]initWithFrame:CGRectMake((320-250)/2, 40, 250, 30)];
    [self.resultLabel setText:@"Your Heart Belongs to"];
    [self.resultLabel setFont:[UIFont fontWithName: @"HelveticaNeue-Light"  size: 22]];
    [self.resultLabel setTextColor:redOpaque];
    [self.resultLabel setTextAlignment:NSTextAlignmentCenter];
    
    [self.view addSubview:self.resultLabel];
    
    
    self.analysisButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.analysisButton setFrame:CGRectMake((320-88)/2, self.view.frame.size.height-100, 88, 20)];
    [self.analysisButton setTitle:@"See Why" forState:UIControlStateNormal];
    //[self.analysisButton setBackgroundImage:[UIImage imageNamed:@"confirm.png"] forState:UIControlStateNormal];
    [self.analysisButton addTarget:self action:@selector(seeAnalysis) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.analysisButton];
    
    self.endButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(didPressDone)];
    
    UIBarButtonItem * decideAgainButton = [[UIBarButtonItem alloc]initWithTitle:@"Redecide" style:UIBarButtonItemStylePlain target:self action:@selector(decideAgain)];
    
    [self.navigationItem setRightBarButtonItem:self.endButton animated:YES];
    [self.navigationItem setLeftBarButtonItem:decideAgainButton animated:YES];
    
    
    return self;
}

-(void)seeAnalysis
{
    ResultAnalysisViewController * analysisView = [[ResultAnalysisViewController alloc]initWithDecision:self.decision];
    [self.navigationController pushViewController:analysisView animated:YES];
    
}

-(void)didPressDone
{
    
    [Database replaceItemWithData:self.decision atRow:self.decision.rowid];
    
    // Decision table view reload
    [[self.navigationController.viewControllers objectAtIndex:0] reload];

    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

-(void)decideAgain
{
    [self.decision resetStats];
    [[self.navigationController.viewControllers objectAtIndex:3] reload];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
