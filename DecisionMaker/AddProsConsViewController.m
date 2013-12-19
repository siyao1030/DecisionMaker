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

-(void)didPressDecide
{
    
    NSLog(@"end of pros&cons, stage: %d, rowid: %d",self.decision.stage, self.decision.rowid);
    self.decision.stage = ComparisonStage;
    if (self.decision != nil)
    {
        //decicison havent been saved
        if (self.decision.rowid == -1)
        {
            int rowid = [Database saveItemWithData:self.decision];
            self.decision.rowid = rowid;
        }
        else
        {
            [Database replaceItemWithData:self.decision atRow:self.decision.rowid];

        }
        
        // Decision table view reload
        [[self.navigationController.viewControllers objectAtIndex:0] reload];
    }
    
    
    
    self.compareView = [[ComparisonViewController alloc] initWithDecision:self.decision];
    [self.navigationController pushViewController:self.compareView animated:YES];
    
}

-(void)setUpWithDecision:(Decision *)decision
{
    self.decision = decision;
    NSLog(@"stage when enter pros cons view: %d", self.decision.stage);
    
    self.choiceAfactors = [[decision.choices objectAtIndex:0] factors];
    self.choiceBfactors = [[decision.choices objectAtIndex:1] factors];

    NSString *choice1 = [[decision.choices objectAtIndex:0] title];
    NSString *choice2 = [[decision.choices objectAtIndex:1] title];
    
    
    self.choiceAButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.choiceAButton setFrame:CGRectMake(20, 515, 130, 33)];
    [self.choiceAButton setTitle:choice1 forState:UIControlStateNormal];
    [self.choiceAButton.titleLabel setFont:[UIFont fontWithName: @"HelveticaNeue-Bold"  size: 18]];
    [self.choiceAButton setTitleColor:darkGreen forState:UIControlStateNormal];
    [self.choiceAButton addTarget:self action:@selector(choiceAButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.choiceAButton];
    
    
    self.choiceBButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.choiceBButton setFrame:CGRectMake(170, 515, 130, 33)];
    [self.choiceBButton setTitle:choice2 forState:UIControlStateNormal];
    [self.choiceBButton.titleLabel setFont:[UIFont fontWithName: @"HelveticaNeue-Bold"  size: 18]];
    [self.choiceBButton setTitleColor:darkOrange forState:UIControlStateNormal];
    [self.choiceBButton addTarget:self action:@selector(choiceBButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.choiceBButton];
    
    UIView *spacerView = [[UIView alloc] initWithFrame:CGRectMake(0, 170, 10, 40)];

    self.inputField = [[UITextField alloc] initWithFrame:CGRectMake(0, 170, 320, 40)];
    self.inputField.font = [UIFont systemFontOfSize:15];
    self.inputField.placeholder = @" Enter a pro or a con";
    self.inputField.backgroundColor = [UIColor whiteColor];
    self.inputField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.inputField.keyboardType = UIKeyboardTypeDefault;
    self.inputField.returnKeyType = UIReturnKeyDone;
    self.inputField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.inputField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.inputField.delegate = self;
    [self.inputField setLeftView:spacerView];
    [self.inputField setLeftViewMode:UITextFieldViewModeAlways];
    
    self.dimBG = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.dimBG.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    
    self.isPro = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.isPro setFrame:CGRectMake(100, 130, 30, 30)];
    [self.isPro setTitle:@"Pro" forState:UIControlStateNormal];
    [self.isPro.titleLabel setFont:[UIFont fontWithName: @"HelveticaNeue-Bold"  size: 18]];
    [self.isPro setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.isPro setTitleColor:pinkOpaque forState:UIControlStateSelected];
    [self.isPro addTarget:self action:@selector(proButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    self.isCon = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.isCon setFrame:CGRectMake(175, 130, 50, 30)];
    [self.isCon setTitle:@"Con" forState:UIControlStateNormal];
    [self.isCon.titleLabel setFont:[UIFont fontWithName: @"HelveticaNeue-Bold"  size: 18]];
    [self.isCon setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.isCon setTitleColor:pinkOpaque forState:UIControlStateSelected];
    [self.isCon addTarget:self action:@selector(conButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelButton setBackgroundImage:[UIImage imageNamed:@"closeicon.png"] forState:UIControlStateNormal];
    [self.cancelButton setFrame:CGRectMake(295, 72, 16, 16)];
    [self.cancelButton addTarget:self action:@selector(cancelButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    self.choiceATableView = [self makeLeftTableView];
    self.choiceBTableView = [self makeRightTableView];

    [self.choiceATableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.choiceBTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    [self.view addSubview:self.choiceATableView];
    [self.view addSubview:self.choiceBTableView];

    
    if (self.choiceAfactors.count < 1 || self.choiceBfactors.count < 1)
        self.decideButton.enabled = NO;
    else if (self.choiceAfactors.count > 0 || self.choiceBfactors.count > 0)
        self.decideButton.enabled = YES;


}

-(UITableView *)makeLeftTableView
{
    CGFloat x = 0;
    CGFloat y = 64;
    CGFloat width = 159;
    CGFloat height = self.view.frame.size.height - 110;
    CGRect tableFrame = CGRectMake(x, y, width, height);
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStylePlain];
    
    tableView.rowHeight = 45;
    tableView.sectionFooterHeight = 22;
    tableView.sectionHeaderHeight = 22;
    tableView.scrollEnabled = YES;
    tableView.showsVerticalScrollIndicator = YES;
    tableView.userInteractionEnabled = YES;
    tableView.bounces = YES;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = bgColor;

    tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    return tableView;
}

-(UITableView *)makeRightTableView
{
    CGFloat x = 160;
    CGFloat y = 64;
    CGFloat width = 160;
    CGFloat height = self.view.frame.size.height - 110;
    CGRect tableFrame = CGRectMake(x, y, width, height);
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStylePlain];
    
    tableView.rowHeight = 45;
    tableView.sectionFooterHeight = 22;
    tableView.sectionHeaderHeight = 22;
    tableView.scrollEnabled = YES;
    tableView.showsVerticalScrollIndicator = YES;
    tableView.userInteractionEnabled = YES;
    tableView.bounces = YES;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = bgColor;
    tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    return tableView;
}


-(void)cancelButtonPressed
{
    if ([self.inputField isFirstResponder]) {
        [self.inputField resignFirstResponder];
    }

    [self.inputField removeFromSuperview];
    [self.isPro removeFromSuperview];
    [self.isCon removeFromSuperview];
    [self.cancelButton removeFromSuperview];
    [self.dimBG removeFromSuperview];

    [self.inputField setText:@""];

    
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
    [self.view addSubview:self.dimBG];
    [self.view addSubview:self.inputField];
    [self.view addSubview:self.isPro];
    [self.view addSubview:self.isCon];
    [self.view addSubview:self.cancelButton];
    
    
    [self.inputField becomeFirstResponder];
    self.listening = self.decision.choices[0];
}

-(void)choiceBButtonPressed
{

    [self.view addSubview:self.dimBG];
    [self.view addSubview:self.inputField];
    [self.view addSubview:self.isPro];
    [self.view addSubview:self.isCon];
    [self.view addSubview:self.cancelButton];

    
    [self.inputField becomeFirstResponder];
    self.listening = self.decision.choices[1];

    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.inputField isFirstResponder]) {
        [self.inputField resignFirstResponder];
    }

    
    if (self.isPro.selected)
    {
        Factor * factor = [[Factor alloc]initWithTitle:self.inputField.text andIsPro:YES];
        [self.listening addToFactors:factor];
    }
    else if (self.isCon.selected)
    {
        Factor * factor = [[Factor alloc]initWithTitle:self.inputField.text andIsPro:NO];
        [self.listening addToFactors:factor];
    }
    else
    {
        NSLog(@"Has to select Pro or Con");
    }
    [self.inputField removeFromSuperview];
    [self.isPro removeFromSuperview];
    [self.isCon removeFromSuperview];
    [self.cancelButton removeFromSuperview];
    [self.dimBG removeFromSuperview];
    
    
    [self.choiceATableView reloadData];
    [self.choiceBTableView reloadData];
    
    [self.inputField setText:@""];
    if (self.choiceAfactors.count < 1 || self.choiceBfactors.count < 1)
        self.decideButton.enabled = NO;
    else if (self.choiceAfactors.count > 0 && self.choiceBfactors.count > 0)
        self.decideButton.enabled = YES;
    
    
    return YES;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    if (self.choiceATableView==tableView)
    {
        return ([self.choiceAfactors count]);
    }
    else
    {
        return ([self.choiceBfactors count]);
    }

}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell;
    if (self.choiceATableView==tableView)
    {
            cell = [self.choiceATableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    }
    else
    {
            cell = [self.choiceBTableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    }

    
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    // Configure the cell...
    Factor *temp;
    if (self.choiceATableView==tableView)
    {
        temp = [self.choiceAfactors objectAtIndex:indexPath.row];
  
        [[cell textLabel] setText:temp.title];

        if (temp.isPro)
            [cell setBackgroundColor:lightGreen];
        else
            [cell setBackgroundColor:darkGreen];
        
        cell.textLabel.textColor = [UIColor whiteColor];
        [cell.textLabel setFont:[UIFont fontWithName: @"HelveticaNeue-Bold"  size: 18]];
        [[cell textLabel] setTextAlignment:NSTextAlignmentRight];
    }
    else
    {
        [cell.textLabel setTextAlignment:NSTextAlignmentLeft];
        temp = [self.choiceBfactors objectAtIndex:indexPath.row];
        [[cell textLabel] setText:temp.title];
        if (temp.isPro)
            [cell setBackgroundColor:lightOrange];

        else
            [cell setBackgroundColor:darkOrange];

        cell.textLabel.textColor = [UIColor whiteColor];
        [cell.textLabel setFont:[UIFont fontWithName: @"HelveticaNeue-Bold"  size: 18]];
        //[[cell textLabel] setTextAlignment:NSTextAlignmentLeft];
    }
    
    if (cell == nil)
        NSLog(@"Cell is nil");
    
    //[[cell imageView] setImage:[[UIImage alloc] initWithData:temp.data]];
    return cell;
}


 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
     return YES;
 }



 // Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
 if (editingStyle == UITableViewCellEditingStyleDelete) {
     // Delete the row from the data source
     if (self.choiceATableView==tableView)
         [self.choiceAfactors removeObjectAtIndex:indexPath.row];
     if (self.choiceBTableView==tableView)
         [self.choiceBfactors removeObjectAtIndex:indexPath.row];
     
     [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
    
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
    
}


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:18.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = titleColor; // change this color
    self.navigationItem.titleView = label;
    
    [label setText: @"Pros & Cons"];
    [label sizeToFit];
    
    
    self.view.backgroundColor = bgColor;
    
    self.decideButton = [[UIBarButtonItem alloc]initWithTitle:@"Decide!" style:UIBarButtonItemStylePlain target:self action:@selector(didPressDecide)];
    self.decideButton.enabled = NO;
    [self.navigationItem setRightBarButtonItem:self.decideButton animated:YES];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                 style:UIBarButtonItemStylePlain
                                                                target:nil
                                                                action:nil];
    
    [self.navigationItem setBackBarButtonItem:backItem];
    
    

    if ([self.choiceATableView respondsToSelector:@selector(setSeparatorStyle:)]) {
        [self.choiceATableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.choiceBTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];   
    // Dispose of any resources that can be recreated.
}

@end
