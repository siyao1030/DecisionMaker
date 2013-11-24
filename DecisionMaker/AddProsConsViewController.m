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
    self.choiceAPros = [[decision.choices objectAtIndex:0] pros];
    self.choiceACons = [[decision.choices objectAtIndex:0] cons];
    self.choiceBPros = [[decision.choices objectAtIndex:1] pros];
    self.choiceBCons = [[decision.choices objectAtIndex:1] cons];
    
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
    
    self.dimBG = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.dimBG.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    
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
    
    [self.choiceATableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.choiceBTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];




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
    
    
    [self.inputField becomeFirstResponder];
    self.listening = self.decision.choices[0];
}

-(void)choiceBButtonPressed
{

    [self.view addSubview:self.dimBG];
    [self.view addSubview:self.inputField];
    [self.view addSubview:self.isPro];
    [self.view addSubview:self.isCon];
    
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
        NSLog(@"%d",self.choiceAPros.count);
        NSLog(@"%@",[[self.choiceAPros objectAtIndex:0] title]);
    }
    else if (self.isCon)
    {
        [self.listening addToCons:factor];
    }
    else
    {
        NSLog(@"Has to select Pro or Con");
    }
    [self.inputField removeFromSuperview];
    [self.isPro removeFromSuperview];
    [self.isCon removeFromSuperview];
    [self.dimBG removeFromSuperview];
    
    [self.choiceATableView reloadData];
    [self.choiceBTableView reloadData];
    
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
        return ([self.choiceAPros count] + [self.choiceACons count]);
    }
    else
    {
        return ([self.choiceBPros count] + [self.choiceBCons count]);
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    if (self.choiceATableView==tableView)
    {
        if ([self.choiceATableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath])
            cell = [self.choiceATableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    }
    else
    {
        if ([self.choiceBTableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath])
            cell = [self.choiceBTableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    }


    
    // Configure the cell...
    Factor *temp = [[Factor alloc]init];
    if (self.choiceATableView==tableView)
    {
        if (indexPath.row <= self.choiceAPros.count) {
            temp = [self.choiceAPros objectAtIndex:indexPath.row];
            NSLog(@"%d%@",indexPath.row,temp.title);
        }
        else
        {
            temp = [self.choiceACons objectAtIndex:(indexPath.row-self.choiceAPros.count)];
        }
        
        [[cell textLabel] setText:temp.title];
         NSLog(@"%d%@",indexPath.row,cell.textLabel.text);
        [[cell textLabel] setTextAlignment:NSTextAlignmentRight];
        //[cell setFrame:CGRectMake(0, 64, 320,44)];
    }
    else
    {
        if (indexPath.row <= self.choiceBPros.count) {
            temp = [self.choiceBPros objectAtIndex:indexPath.row];
        }
        else
        {
            temp = [self.choiceBCons objectAtIndex:(indexPath.row-self.choiceBPros.count)];
        }
        [[cell textLabel] setText:temp.title];
        [[cell textLabel] setTextAlignment:NSTextAlignmentLeft];
        //[cell setFrame:CGRectMake(160, 64, 320,44)];
    }
    
    //[[cell imageView] setImage:[[UIImage alloc] initWithData:temp.data]];
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
