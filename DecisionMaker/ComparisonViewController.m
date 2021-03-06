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
    
    self.instructionlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, 320, 25)];
    [self.instructionlabel setText:@"Which one do you care more?"];
    [self.instructionlabel setFont:[UIFont fontWithName: @"HelveticaNeue-Light"  size: 21]];
    [self.instructionlabel setTextColor:redOpaque];
    [self.instructionlabel setTextAlignment:NSTextAlignmentCenter];
    
    [self.view addSubview:self.instructionlabel];
    self.bubbles = [[BubbleView alloc]initWithFrame:CGRectMake(0, 65, 320, 400)];
    [self.bubbles setBackgroundColor:bgColor];
    self.bubbles.target = self;
    self.bubbles.increaseA = @selector(increaseFactorA);
    self.bubbles.increaseB = @selector(increaseFactorB);

    [self.view addSubview:self.bubbles];
    
    /*
    self.choiceALabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 130, 130, 33)];
    [self.view addSubview:self.choiceALabel];
    self.choiceBLabel = [[UILabel alloc]initWithFrame:CGRectMake(170, 130, 130, 33)];
    [self.view addSubview:self.choiceBLabel];
    */
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
    
    

   
    UIImage * confirmImage = [UIImage imageNamed:@"confirm.png"];
    self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.nextButton setFrame:
                       CGRectMake((self.view.frame.size.width-confirmImage.size.width)/2, self.view.frame.size.height-confirmImage.size.height-80, confirmImage.size.width, confirmImage.size.height)];
    [self.nextButton setImage:confirmImage forState:UIControlStateNormal];
    [self.nextButton addTarget:self action:@selector(nextComparison) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextButton];
    
    //internals
    self.decision = decision;
    
    self.choiceA = self.decision.choices[0];
    self.choiceB = self.decision.choices[1];
    
    self.comparisonMaker = [[ComparisonMaker alloc]initWithDecision:self.decision];
    
    self.numOfCompPerRound = MAX(self.choiceA.factors.count, self.choiceB.factors.count);
        
    //NSMutableArray * A = [self.choiceA.factors mutableCopy];
    //NSMutableArray * B = [self.choiceB.factors mutableCopy];

    
    
    if (!self.decision.comparisons || self.decision.comparisons.count == 0)
        self.decision.comparisons = [self.comparisonMaker inputOrderCompsGenerator];
    

    if (self.decision.numOfCompsDone < self.decision.comparisons.count)
    {
        self.currentComparison = self.decision.comparisons[self.decision.numOfCompsDone];
    }
    else
    {
        
        self.currentComparison = self.decision.comparisons[0];
    }
    
    
    self.progressView = [[ProgressView alloc]initWithFrame:CGRectMake(0, 0, 320, 26)];
    [self.progressView setUpWithDecision:self.decision];
    [self.progressView setBackgroundColor:bgColor];
    self.navigationController.navigationBar.clipsToBounds = YES;
    [self.view addSubview:self.progressView];
    
    [self updateLabels];
    
    return self;

}

-(void)reload
{
    self.decision.numOfCompsDone= 0;
    
    //NSMutableArray * A = [self.choiceA.factors mutableCopy];
    //NSMutableArray * B = [self.choiceB.factors mutableCopy];

    // need to fixxxxx, this is right, since the comparisons are based on the first round
    //self.decision.comparisons = [self.comparisonMaker inputOrderCompsGenerator];
    self.currentComparison = self.decision.comparisons[self.decision.numOfCompsDone];
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
    
    self.decision.numOfCompsDone +=1;
    [self.progressView setNeedsDisplay];
    //[self.decision addComparison:self.currentComparison];
    [self.currentComparison.factorA.weights addObject:[NSNumber numberWithInt:self.currentComparison.factorAWeight]];
    [self.currentComparison.factorB.weights addObject:[NSNumber numberWithInt:self.currentComparison.factorBWeight]];
    
    NSArray * a = @[self.currentComparison.factorB,
                    [NSNumber numberWithFloat: self.currentComparison.factorBWeight]];
    NSArray * b = @[self.currentComparison.factorA,
                    [NSNumber numberWithFloat: self.currentComparison.factorAWeight]];
    
    [self.currentComparison.factorA.comparedWith addObject:a];
    [self.currentComparison.factorB.comparedWith addObject:b];
    
    
    self.currentComparison.factorA.totalContribution+=self.currentComparison.factorBWeight;
    self.currentComparison.factorB.totalContribution+=self.currentComparison.factorAWeight;
    
    [self.currentComparison.factorA updateAverageWeight];
    [self.currentComparison.factorB updateAverageWeight];


    if (self.decision.numOfCompsDone % MAX(self.choiceA.factors.count,self.choiceB.factors.count) == 0)
    {
        [self.decision convergeNetworkScore];
    }
        
    
    //generate new comparisons if needed
    if ([self shouldEndComparison])
    {
        
        [self.alertView show];
    }
    else
    {        
        if (self.decision.numOfCompsDone == self.decision.comparisons.count) {
            if (self.decision.round == 1)
            {
                NSMutableArray * newComps = [self.comparisonMaker currentWeightRankingCompsGenerator];
                
                if (newComps.count!=0)
                {
                    [self.decision.comparisons addObjectsFromArray:newComps];
                    NSLog(@"pushing currentWeightComps: %lu", (unsigned long)newComps.count);
                }
                else
                {
                    newComps = [self.comparisonMaker randomCompsGenerator];
                    [self.decision.comparisons addObjectsFromArray:newComps];
                    self.decision.round++;
                }
            }
            else if (self.decision.round == 2)
            {
                NSMutableArray * newComps = [self.comparisonMaker randomCompsGenerator];
                [self.decision.comparisons addObjectsFromArray:newComps];
            }
            else
            {
                NSMutableArray * newComps = [self.comparisonMaker restCompsGenerator];
                [self.decision.comparisons addObjectsFromArray:newComps];
            }
            
            
            
            
        }
        
        self.currentComparison = self.decision.comparisons[self.decision.numOfCompsDone];
        [self updateLabels];
        
        
        

        

        
    }
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.numberOfButtons == 1)
    {
        if (buttonIndex == 0)
        {
            self.decision.stage = ResultStage;
            [self.decision convergeNetworkScore];
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

            [self.decision convergeNetworkScore];

            [Database replaceItemWithData:self.decision atRow:self.decision.rowid];

            ResultViewController * resultView = [[ResultViewController alloc]initWithDecision:self.decision];
            
            [self.navigationController pushViewController:resultView animated:YES];
            
        }
        
    }
}

-(BOOL)shouldEndComparison
{
    
    // enough comparisons (to be determined) ***
    if (self.decision.numOfCompsDone == 3*MAX(self.choiceA.factors.count,self.choiceB.factors.count))
    {
        NSLog(@"After 3 rounds of comparisons");
        self.alertView = [[UIAlertView alloc]initWithTitle:@"Ready for a Decision!" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"See Result",nil];
        [self.view addSubview:self.alertView];
        
        self.nextButton.enabled = NO;
        
        return YES;
        
    }
    
    // run out of comparisons
    else if (self.decision.numOfCompsDone == self.choiceA.factors.count * self.choiceB.factors.count)
    {
        NSLog(@"run out of comparisons");
        self.alertView = [[UIAlertView alloc]initWithTitle:@"Ready for a Decision!" message:@"You have compared all of your Pros and Cons" delegate:self cancelButtonTitle:nil otherButtonTitles:@"See Result",nil];
        [self.view addSubview:self.alertView];
        
        self.nextButton.enabled = NO;
        
        return YES;
        
    }
    /*
    // if theres a huge difference in score *** huge difference to be determined
    else if (self.decision.numOfCompsDone % MAX(self.choiceA.factors.count,self.choiceB.factors.count) == 0 &&
             abs(self.decision.Arate-self.decision.Brate)>= 60)
    {
        self.alertView = [[UIAlertView alloc]initWithTitle:@"Ready for a Decision!" message:@"You have indicated a strong preference." delegate:self cancelButtonTitle:@"Compare More" otherButtonTitles:@"See Result", nil];
        [self.view addSubview:self.alertView];
        
        
        return YES;
    }
     */
    
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
    [self.progressView setNeedsDisplay];

}

-(void) viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        // back button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
        NSLog(@"press back in comparisons: %d",self.decision.stage);
    }
    [super viewWillDisappear:animated];
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
