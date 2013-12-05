//
//  ComparisonViewController.m
//  DecisionMaker
//
//  Created by Siyao Clara Xie on 11/24/13.
//  Copyright (c) 2013 Siyao Xie. All rights reserved.
//

#import "ComparisonViewController.h"

@interface ComparisonViewController ()

@end

@implementation ComparisonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(Decision *)jeffDecisionTest
{
    Choice *choiceA = [[Choice alloc]initWithTitle:@"Sandisk"];
    Choice *choiceB = [[Choice alloc]initWithTitle:@"Qualcomm"];
    
    [choiceA addToFactors:[[Factor alloc]initWithTitle:@"Good position" andIsPro:YES]];
    //[choiceA addToFactors:[[Factor alloc]initWithTitle:@"take class at stanford" andIsPro:YES]];
    //[choiceA addToFactors:[[Factor alloc]initWithTitle:@"tech scene" andIsPro:YES]];
    //[choiceA addToFactors:[[Factor alloc]initWithTitle:@"high living expense" andIsPro:NO]];
    //[choiceA addToFactors:[[Factor alloc]initWithTitle:@"not very big company" andIsPro:YES]];
    //[choiceA addToFactors:[[Factor alloc]initWithTitle:@"more friends in the area" andIsPro:YES]];
    //[choiceA addToFactors:[[Factor alloc]initWithTitle:@"uncertain tech advantage" andIsPro:NO]];
    
    [choiceB addToFactors:[[Factor alloc]initWithTitle:@"company reputation" andIsPro:YES]];
    //[choiceB addToFactors:[[Factor alloc]initWithTitle:@"company doing well" andIsPro:YES]];
    //[choiceB addToFactors:[[Factor alloc]initWithTitle:@"SD good location" andIsPro:YES]];
    //[choiceB addToFactors:[[Factor alloc]initWithTitle:@"product market&price" andIsPro:YES]];
    //[choiceB addToFactors:[[Factor alloc]initWithTitle:@"too many indians" andIsPro:NO]];
    
    return [[Decision alloc]initWithChoiceA:choiceA andChoiceB:choiceB andTitle:@"Sandisk vs. Qualcomm"];

}
-(id)initWithDecision:(Decision *)decision
{
    //self.decision = decision;
    //using testing decision
    
    //interfaces
    
    self.bubbles = [[BubbleView alloc]initWithFrame:CGRectMake(0, 40, 320, 400)];
    //[self.bubbles setUpWithItemALabel:@"Seattle" andASize:80 andItemBLabel:@"San Fran" andBSize:20 andShouldDisplaySize:YES];
    [self.bubbles setBackgroundColor:[UIColor whiteColor]];
    self.bubbles.target = self;
    self.bubbles.increaseA = @selector(increaseFactorA);
    self.bubbles.increaseB = @selector(increaseFactorB);

    [self.view addSubview:self.bubbles];
    
    
    self.choiceALabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 70, 130, 33)];
    [self.view addSubview:self.choiceALabel];
    self.choiceBLabel = [[UILabel alloc]initWithFrame:CGRectMake(170, 70, 130, 33)];
    [self.view addSubview:self.choiceBLabel];
    
    /*
    self.factorALabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 300, 33)];
    //title will be updated as user presses the button
    self.factorALabel.adjustsFontSizeToFitWidth = YES;
    [self.factorALabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.factorALabel];
    
    self.factorBLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 410, 300, 33)];
    //title will be updated as user presses the button
    self.factorBLabel.adjustsFontSizeToFitWidth = YES;
    [self.factorBLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.factorBLabel];
    
    self.factorAButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.factorAButton setFrame:CGRectMake(110, 140, 100, 100)];
    //title shall be set according to the comparisons
    [self.factorAButton setBackgroundColor:[UIColor colorWithRed:102/255.0 green:248/255.0 blue:167/255.0 alpha:0.6]];
    [self.factorAButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.factorAButton.titleLabel setFont:[UIFont systemFontOfSize:30]];
    [self.factorAButton addTarget:self action:@selector(increaseFactorA) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.factorAButton];
    
    self.factorBButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.factorBButton setFrame:CGRectMake(110, 250, 100, 100)];
    //title shall be set according to the comparisons,
    [self.factorBButton setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:210/255.0 blue:0/255.0 alpha:0.6]];
    [self.factorBButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.factorBButton.titleLabel setFont:[UIFont systemFontOfSize:30]];
    [self.factorBButton addTarget:self action:@selector(increaseFactorB) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.factorBButton];
    */
    self.prevButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.prevButton setFrame:CGRectMake(10, self.view.frame.size.height-130, 80, 33)];
    [self.prevButton setTitle:@"< Previous" forState:UIControlStateNormal];
    [self.prevButton addTarget:self action:@selector(prevComparison) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.prevButton];
    
    self.nextButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.nextButton setFrame:CGRectMake(240, self.view.frame.size.height-130, 70, 33)];
    [self.nextButton setTitle:@"Confirm >" forState:UIControlStateNormal];
    [self.nextButton addTarget:self action:@selector(nextComparison) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextButton];
    
    
    //internals
    self.decision = [self jeffDecisionTest];
    
    self.choiceA = self.decision.choices[0];
    self.choiceB = self.decision.choices[1];
    
    self.numOfCompPerRound = MAX(self.choiceA.factors.count, self.choiceB.factors.count);
    self.numOfCompsDone = 0;
    
    self.comparisonMaker = [[ComparisonMaker alloc]initWithDecision:self.decision];
    self.comparisons = [self.comparisonMaker inOrderCompsGeneratorWithArrayA:self.choiceA.factors andArrayB:self.choiceB.factors];
    self.currentComparison = self.comparisons[self.numOfCompsDone];
    
    [self updateLabels];
    
    return self;

}

-(void)increaseFactorA
{
    NSLog(@"in increase a");
    self.currentComparison.factorAWeight += 10;
    self.currentComparison.factorBWeight -= 10;
    
    [self.bubbles setUpWithItemALabel:self.currentComparison.factorA.title andASize:self.currentComparison.factorAWeight andItemBLabel:self.currentComparison.factorB.title andBSize:self.currentComparison.factorBWeight andShouldDisplaySize:YES];
    [self.bubbles setNeedsDisplay];

    /*
    [self.factorAButton setTitle:[NSString stringWithFormat:@"%d", self.factorAWeight]  forState:UIControlStateNormal];
    [self.factorBButton setTitle:[NSString stringWithFormat:@"%d", self.factorBWeight]  forState:UIControlStateNormal];
     */

}


-(void)increaseFactorB
{
    self.currentComparison.factorAWeight -= 10;
    self.currentComparison.factorBWeight += 10;
    
    [self.bubbles setUpWithItemALabel:self.currentComparison.factorA.title andASize:self.currentComparison.factorAWeight andItemBLabel:self.currentComparison.factorB.title andBSize:self.currentComparison.factorBWeight andShouldDisplaySize:YES];
    [self.bubbles setNeedsDisplay];
    /*
    [self.factorAButton setTitle:[NSString stringWithFormat:@"%d", self.factorAWeight]  forState:UIControlStateNormal];
    [self.factorBButton setTitle:[NSString stringWithFormat:@"%d", self.factorBWeight]  forState:UIControlStateNormal];
    */
}

-(void)prevComparison
{
    
}

-(void)nextComparison
{
    //record current comp's information
    self.numOfCompsDone +=1;
    [self.currentComparison.factorA.weights addObject:[NSNumber numberWithInt:self.factorAWeight]];
    [self.currentComparison.factorB.weights addObject:[NSNumber numberWithInt:self.factorBWeight]];
    [self.currentComparison.factorA updateAverageWeight];
    [self.currentComparison.factorB updateAverageWeight];
    [self.decision updateScore];

    
    //generate new comparisons if needed
    if ([self shouldEndComparison])
    {
        
        [self.alertView show];
    }
    else
    {
        if (self.numOfCompsDone % self.numOfCompPerRound == 0)
        {
            //finished the first round
            if (self.numOfCompsDone == self.numOfCompPerRound)
            {
                [self.comparisons addObjectsFromArray:[self.comparisonMaker currentWeightRankingCompsGenerator]];
            }
            else
            {
                [self.comparisons addObjectsFromArray:[self.comparisonMaker randomCompsGenerator]];
                
            }
        }
        
        self.currentComparison = self.comparisons[self.numOfCompsDone];
        [self updateLabels];
    }
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.numberOfButtons == 1)
    {
        if (buttonIndex == 0)
        {
            ResultViewController * resultView = [[ResultViewController alloc]initWithDecision:self.decision];
            
            [self.navigationController pushViewController:resultView animated:YES];
            
        }
            // present result view
    }
    if (alertView.numberOfButtons == 2)
    {
        if (buttonIndex == 1)
        {
            
        }
            //present result view
    }
}

-(BOOL)shouldEndComparison
{
    // run out of comparisons
    if (self.numOfCompsDone == self.choiceA.factors.count * self.choiceB.factors.count)
    {
        NSLog(@"run out of comparisons");
        self.alertView = [[UIAlertView alloc]initWithTitle:@"Ready for a Decision!" message:@"You have compared all of your Pros and Cons" delegate:self cancelButtonTitle:nil otherButtonTitles:@"See Result",nil];
        [self.view addSubview:self.alertView];
        
        self.nextButton.enabled = NO;
        
        return YES;
        
    }
    // enough comparisons (to be determined) ***
    if (self.numOfCompsDone == 3*MAX(self.choiceA.factors.count,self.choiceB.factors.count))
    {
        NSLog(@"After 3 rounds of comparisons");
        self.alertView = [[UIAlertView alloc]initWithTitle:@"Ready for a Decision!" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"See Result",nil];
        [self.view addSubview:self.alertView];
        
        self.nextButton.enabled = NO;
        
        return YES;
        
    }
    //NSLog(@"difference: %f", abs(self.decision.Arate-self.decision.Brate));
    // if theres a huge difference in score
    else if (self.numOfCompsDone % self.numOfCompPerRound == 0 &&
             abs((self.decision.Arate-self.decision.Brate)*100)>= 50)
    {
        NSLog(@"enough comparisons");
        self.alertView = [[UIAlertView alloc]initWithTitle:@"Ready for a Decision!" message:@"You have indicated a strong preference." delegate:self cancelButtonTitle:@"Compare More" otherButtonTitles:@"See Result", nil];
        [self.view addSubview:self.alertView];
        
        
        return YES;
    }
    
    return NO;
}
- (void)updateLabels
{
    
    [self.bubbles setUpWithItemALabel:self.currentComparison.factorA.title andASize:self.currentComparison.factorAWeight andItemBLabel:self.currentComparison.factorB.title andBSize:self.currentComparison.factorBWeight andShouldDisplaySize:YES];
    self.factorAWeight = self.currentComparison.factorAWeight;
    self.factorBWeight = self.currentComparison.factorBWeight;
    
    /*
    [self.factorALabel setText:self.currentComparison.factorA.title];
    [self.factorBLabel setText:self.currentComparison.factorB.title];
    [self.factorAButton setTitle:[NSString stringWithFormat:@"%d", self.factorAWeight]  forState:UIControlStateNormal];
    [self.factorBButton setTitle:[NSString stringWithFormat:@"%d", self.factorBWeight]  forState:UIControlStateNormal];
     */
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
