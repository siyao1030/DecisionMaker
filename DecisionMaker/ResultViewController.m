//
//  ResultViewController.m
//  DecisionMaker
//
//  Created by Siyao Clara Xie on 12/3/13.
//  Copyright (c) 2013 Siyao Xie. All rights reserved.
//

#import "ResultViewController.h"
#import "BubbleView.h"

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
    
    self.bubbles = [[BubbleView alloc]initWithFrame:CGRectMake(0, 40, 320, 400)];
    [self.bubbles setUpWithItemALabel:@"Seattle" andASize:80 andItemBLabel:@"San Fran" andBSize:20 andShouldDisplaySize:YES];
    [self.bubbles setBackgroundColor:[UIColor whiteColor]];
    

    [self.view addSubview:self.bubbles];
    
    return self;
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
