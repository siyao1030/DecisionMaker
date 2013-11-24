//
//  CreateDecisionViewController.m
//  DecisionMaker
//
//  Created by Siyao Clara Xie on 11/22/13.
//  Copyright (c) 2013 Siyao Xie. All rights reserved.
//

#import "CreateDecisionViewController.h"

@interface CreateDecisionViewController ()

@end

@implementation CreateDecisionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        [self.navigationItem setTitle:@"Create Decision"];
        [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(didPressDone)]] animated:NO];
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.decisionTitle.isFirstResponder) {
        [self.decisionTitle resignFirstResponder];
    }
    if (self.choiceA.isFirstResponder) {
        [self.choiceA resignFirstResponder];
    }
    if (self.choiceB.isFirstResponder) {
        [self.choiceB resignFirstResponder];
    }
    
    
    return YES;
}

-(IBAction)backgroundTouched:(id)sender
{
    if (self.decisionTitle.isFirstResponder) {
        [self.decisionTitle resignFirstResponder];
    }
    if (self.choiceA.isFirstResponder) {
        [self.choiceA resignFirstResponder];
    }
    if (self.choiceB.isFirstResponder) {
        [self.choiceB resignFirstResponder];
    }
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    if (self.decisionTitle.isFirstResponder) {
        [self.decisionTitle resignFirstResponder];
    }
    if (self.choiceA.isFirstResponder) {
        [self.choiceA resignFirstResponder];
    }
    if (self.choiceB.isFirstResponder) {
        [self.choiceB resignFirstResponder];
    }
}

- (void)didPressDone
{
    if ([self.decisionTitle.text  isEqual: @""]) {
        [self.decisionTitle setText:[NSString stringWithFormat:@"%@%@%@", self.choiceA.text, @" vs. ", self.choiceB.text]];
    }
    
    Choice * choiceA = [[Choice alloc]initWithTitle:self.choiceA.text];
    Choice * choiceB = [[Choice alloc]initWithTitle:self.choiceB.text];
    Decision * temp = [[Decision alloc]initWithChoiceA:choiceA andChoiceB:choiceB andTitle:self.decisionTitle.text];
    
    [self.target performSelector:self.action withObject:temp];
    //[self.navigationController popToRootViewControllerAnimated:YES];
    //[self.navigationController popViewControllerAnimated:YES];
    AddProsConsViewController *addProsConsView = [[AddProsConsViewController alloc]initWithNibName:@"AddProsConsViewController" bundle:nil];
    [self.navigationController pushViewController:addProsConsView animated:YES];
    [addProsConsView setUpWithDecision:temp];
    //[addProsConsView setUpWithChoiceA:self.choiceA.text andChoiceB:self.choiceB.text];
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
