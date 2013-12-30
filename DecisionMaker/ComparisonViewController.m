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
    
    self.view.backgroundColor = bgColor;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:18.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = titleColor; // change this color
    self.navigationItem.titleView = label;
    
    [label setText: @"Comparison"];
    [label sizeToFit];
    
    


    self.decision = decision;
    
    NSLog(@"stage when enter comparison view: %d", self.decision.stage);
    //using testing decision
    
    //interfaces
    
    self.bubbles = [[BubbleView alloc]initWithFrame:CGRectMake(0, 10, 320, 400)];
    [self.bubbles setBackgroundColor:bgColor];
    self.bubbles.target = self;
    self.bubbles.increaseA = @selector(increaseFactorA);
    self.bubbles.increaseB = @selector(increaseFactorB);

    [self.view addSubview:self.bubbles];
    
    
    self.choiceALabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 70, 130, 33)];
    [self.view addSubview:self.choiceALabel];
    self.choiceBLabel = [[UILabel alloc]initWithFrame:CGRectMake(170, 70, 130, 33)];
    [self.view addSubview:self.choiceBLabel];
    
    //dont delete yet, need to improve
    /*
    self.prevButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.prevButton setFrame:CGRectMake(10, self.view.frame.size.height-130, 80, 33)];
    [self.prevButton setTitle:@"< Previous" forState:UIControlStateNormal];
    [self.prevButton addTarget:self action:@selector(prevComparison) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.prevButton];
    */
    /*
    self.nextButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.nextButton setFrame:CGRectMake(240, self.view.frame.size.height-130, 70, 33)];
    [self.nextButton setTitle:@"Confirm >" forState:UIControlStateNormal];
    [self.nextButton addTarget:self action:@selector(nextComparison) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextButton];
    */
    
    self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.nextButton setFrame:CGRectMake((320-88)/2, self.view.frame.size.height-145, 88, 20)];
    [self.nextButton setBackgroundImage:[UIImage imageNamed:@"confirm.png"] forState:UIControlStateNormal];
    [self.nextButton addTarget:self action:@selector(nextComparison) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextButton];
    
    //internals
    self.decision = decision;
    
    self.choiceA = self.decision.choices[0];
    self.choiceB = self.decision.choices[1];
    
    self.comparisonMaker = [[ComparisonMaker alloc]initWithDecision:self.decision];
    
    self.numOfCompPerRound = MAX(self.choiceA.factors.count, self.choiceB.factors.count);
    self.numOfCompsDone = 0;
        
    //NSMutableArray * A = [self.choiceA.factors mutableCopy];
    //NSMutableArray * B = [self.choiceB.factors mutableCopy];

    
    
    if (!self.decision.comparisons || self.decision.comparisons.count == 0)
        self.decision.comparisons = [self.comparisonMaker inputOrderCompsGenerator];
    
    self.currentComparison = self.decision.comparisons[self.numOfCompsDone];
    
    [self updateLabels];
    
    return self;

}

-(void)reload
{
    self.numOfCompsDone = 0;
    
    //NSMutableArray * A = [self.choiceA.factors mutableCopy];
    //NSMutableArray * B = [self.choiceB.factors mutableCopy];

    self.decision.comparisons = [self.comparisonMaker inputOrderCompsGenerator];
    self.currentComparison = self.decision.comparisons[self.numOfCompsDone];
    self.nextButton.enabled = YES;
    
    [self updateLabels];
}

-(void)increaseFactorA
{
    if (self.currentComparison.factorAWeight <=80)
    {
        self.currentComparison.factorAWeight += 10;
        self.currentComparison.factorBWeight -= 10;
        [self.bubbles setUpWithItemALabel:self.currentComparison.factorA.title
                                 andASize:self.currentComparison.factorAWeight
                                 andisPro:self.currentComparison.factorA.isPro
                            andItemBLabel:self.currentComparison.factorB.title
                                 andBSize:self.currentComparison.factorBWeight
                                 andisPro:self.currentComparison.factorB.isPro andShouldDisplaySize:YES];
        [self.bubbles setNeedsDisplay];
    }
    
    



}


-(void)increaseFactorB
{
    if (self.currentComparison.factorBWeight <=80)
    {
        self.currentComparison.factorAWeight -= 10;
        self.currentComparison.factorBWeight += 10;
        
        [self.bubbles setUpWithItemALabel:self.currentComparison.factorA.title
                                 andASize:self.currentComparison.factorAWeight
                                 andisPro:self.currentComparison.factorA.isPro
                            andItemBLabel:self.currentComparison.factorB.title
                                 andBSize:self.currentComparison.factorBWeight
                                 andisPro:self.currentComparison.factorB.isPro andShouldDisplaySize:YES];
        [self.bubbles setNeedsDisplay];
    }
    
    

}

-(void)prevComparison
{
    
}

-(void)nextComparison
{
    //record current comp's information
    self.numOfCompsDone +=1;
    //[self.decision addComparison:self.currentComparison];
    [self.currentComparison.factorA.weights addObject:[NSNumber numberWithInt:self.currentComparison.factorAWeight]];
    [self.currentComparison.factorB.weights addObject:[NSNumber numberWithInt:self.currentComparison.factorBWeight]];
    
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
        NSLog(@"current round: %d",self.decision.round);
        
        if (self.numOfCompsDone == self.decision.comparisons.count) {
            if (self.decision.round == 1)
                [self.decision.comparisons addObjectsFromArray:[self.comparisonMaker currentWeightRankingCompsGenerator]];
            else if (self.decision.round >= 2)
                [self.decision.comparisons addObjectsFromArray:[self.comparisonMaker randomCompsGenerator]];
            
        }
        
        self.currentComparison = self.decision.comparisons[self.numOfCompsDone];
        [self updateLabels];
        

/*
        if (self.numOfCompsDone % self.numOfCompPerRound == 0)
        {
            //finished the first round
            if (self.numOfCompsDone == self.numOfCompPerRound)
            {
                [self.decision.comparisons addObjectsFromArray:[self.comparisonMaker currentWeightRankingCompsGenerator]];
                
            }
            else
            {
                [self.decision.comparisons addObjectsFromArray:[self.comparisonMaker randomCompsGenerator]];
                
            }
        }
        
        if (self.numOfCompsDone == self.decision.comparisons.count) {
            [self.decision.comparisons addObjectsFromArray:[self.comparisonMaker randomCompsGenerator]];
        }
*/

        
    }
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.numberOfButtons == 1)
    {
        if (buttonIndex == 0)
        {
            self.decision.stage = ResultStage;
            [self.decision updateResult];
            [Database replaceItemWithData:self.decision atRow:self.decision.rowid];
            
            // Decision table view reload
            [[self.navigationController.viewControllers objectAtIndex:0] reload];
            
            ResultViewController * resultView = [[ResultViewController alloc]initWithDecision:self.decision];
            
            [self.navigationController pushViewController:resultView animated:YES];
            
        }
    }
    if (alertView.numberOfButtons == 2)
    {
        if (buttonIndex == 1)
        {
            self.decision.stage = ResultStage;
            [self.decision updateResult];

            [Database replaceItemWithData:self.decision atRow:self.decision.rowid];
            
            // Decision table view reload
            [[self.navigationController.viewControllers objectAtIndex:0] reload];
            
            ResultViewController * resultView = [[ResultViewController alloc]initWithDecision:self.decision];
            
            [self.navigationController pushViewController:resultView animated:YES];
            
        }
        
    }
}

-(BOOL)shouldEndComparison
{
    // enough comparisons (to be determined) ***
    if (self.numOfCompsDone == 3*MAX(self.choiceA.factors.count,self.choiceB.factors.count))
    {
        NSLog(@"After 3 rounds of comparisons");
        self.alertView = [[UIAlertView alloc]initWithTitle:@"Ready for a Decision!" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"See Result",nil];
        [self.view addSubview:self.alertView];
        
        self.nextButton.enabled = NO;
        
        return YES;
        
    }
    // run out of comparisons
    else if (self.numOfCompsDone == self.choiceA.factors.count * self.choiceB.factors.count)
    {
        NSLog(@"run out of comparisons");
        self.alertView = [[UIAlertView alloc]initWithTitle:@"Ready for a Decision!" message:@"You have compared all of your Pros and Cons" delegate:self cancelButtonTitle:nil otherButtonTitles:@"See Result",nil];
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
    
    [self.bubbles setUpWithItemALabel:self.currentComparison.factorA.title
                             andASize:self.currentComparison.factorAWeight
                             andisPro:self.currentComparison.factorA.isPro
                        andItemBLabel:self.currentComparison.factorB.title
                             andBSize:self.currentComparison.factorBWeight
                             andisPro:self.currentComparison.factorB.isPro andShouldDisplaySize:YES];
    self.factorAWeight = self.currentComparison.factorAWeight;
    self.factorBWeight = self.currentComparison.factorBWeight;
    
    [self.bubbles setNeedsDisplay];

}

-(void) viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        // back button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
        NSLog(@"press back in comparisons: %d",self.decision.stage);
    }
    [super viewWillDisappear:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
