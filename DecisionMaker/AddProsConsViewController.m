//
//  AddProsConsViewController.m
//  DecisionMaker
//
//  Created by Siyao Clara Xie on 11/23/13.
//  Copyright (c) 2013 Siyao Xie. All rights reserved.
//

#import "AddProsConsViewController.h"

@interface AddProsConsViewController ()

@end

@implementation AddProsConsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

        
        
    }
    return self;
}


-(void)setUpWithDecision:(Decision *)decision
{
    self.decision = decision;
    NSString *choice1 = [[decision.choices objectAtIndex:0] title];
    NSString *choice2 = [[decision.choices objectAtIndex:1] title];
    
    self.choiceAButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.choiceAButton setFrame:CGRectMake(20, 515, 130, 33)];
    [self.choiceAButton setTitle:choice1 forState:UIControlStateNormal];
    [self.choiceAButton addTarget:self action:@selector(choiceAButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.choiceAButton];
    
    
    self.choiceBButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.choiceBButton setFrame:CGRectMake(170, 515, 130, 33)];
    [self.choiceBButton setTitle:choice2 forState:UIControlStateNormal];
    [self.choiceBButton addTarget:self action:@selector(choiceBButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.choiceBButton];
    
    self.inputField = [[UITextField alloc] initWithFrame:CGRectMake(0, 170, 320, 40)];
    //self.queryField.borderStyle = UITextBorderStyleRoundedRect;
    self.inputField.font = [UIFont systemFontOfSize:15];
    self.inputField.placeholder = @" Enter a pro or a con";
    self.inputField.backgroundColor = [UIColor whiteColor];
    self.inputField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.inputField.keyboardType = UIKeyboardTypeDefault;
    self.inputField.returnKeyType = UIReturnKeyDone;
    self.inputField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.inputField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.inputField.delegate = self;
    
    self.isPro = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.isPro setFrame:CGRectMake(100, 130, 30, 30)];
    [self.isPro setTitle:@"Pro" forState:UIControlStateNormal];
    [self.isPro setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.isPro setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [self.isPro addTarget:self action:@selector(proButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    self.isCon = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.isCon setFrame:CGRectMake(175, 130, 30, 30)];
    [self.isCon setTitle:@"Con" forState:UIControlStateNormal];
    [self.isCon setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.isCon setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [self.isCon addTarget:self action:@selector(conButtonPressed) forControlEvents:UIControlEventTouchUpInside];

}

-(void)proButtonPressed
{
    if (self.isCon.selected) {
        self.isCon.selected = NO;
    }
    self.isPro.selected = YES;
}

-(void)conButtonPressed
{
    if (self.isPro.selected) {
        self.isPro.selected = NO;
    }
    self.isCon.selected = YES;
}

-(void)choiceAButtonPressed
{
    UIView *dimBG = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    dimBG.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    [self.view addSubview:dimBG];
    [self.view addSubview:self.inputField];
    [self.view addSubview:self.isPro];
    [self.view addSubview:self.isCon];
    
    
    [self.inputField becomeFirstResponder];
    self.listening = self.decision.choices[0];
}

-(void)choiceBButtonPressed
{
    UIView *dimBG = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    dimBG.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6];
    [self.view addSubview:dimBG];
    [self.view addSubview:self.inputField];
    [self.inputField becomeFirstResponder];
    self.listening = self.decision.choices[1];

    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.inputField isFirstResponder]) {
        [self.inputField resignFirstResponder];
    }

    Factor * factor = [[Factor alloc]initWithTitle:self.inputField.text];
    if (self.isPro)
    {
        [self.listening addToPros:factor];
        NSLog(@"%d",self.listening.pros.count);
        NSLog(@"%d",[[self.decision.choices objectAtIndex:0] pros].count);
    }
    else if (self.isCon)
    {
        [self.listening addToCons:factor];
    }
    else
    {
        NSLog(@"Has to select Pro or Con");
    }
    
    return YES;
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
