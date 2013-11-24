//
//  DecisionTableViewController.m
//  DecisionMaker
//
//  Created by Siyao Clara Xie on 11/22/13.
//  Copyright (c) 2013 Siyao Xie. All rights reserved.
//

#import "DecisionTableViewController.h"

@interface DecisionTableViewController ()

@end

@implementation DecisionTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.decisions = [[NSMutableArray alloc] init];
        
        // register the type of view to create for a table cell
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        self.tableView.rowHeight = 100;
        
        // initialize the item creation view controller
        self.createDecisionView = [[CreateDecisionViewController alloc] initWithNibName:@"CreateDecisionViewController" bundle:nil];
        self.createDecisionView.target = self;
        self.createDecisionView.action = @selector(addDecision:);
    }
    return self;
}

-(void)addDecision:(Decision *)decision
{
    [self.decisions addObject:decision];
    [self.tableView reloadData];
}

-(void)addButtonPressed
{
    [self.navigationController pushViewController:self.createDecisionView animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem * addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPressed)];
    
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObject:addButton]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [self.decisions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //is this needed?
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Decision *temp = [self.decisions objectAtIndex:indexPath.row];
    [[cell textLabel] setText:temp.title];
    [[cell textLabel] setTextAlignment:NSTextAlignmentRight];
    [cell setFrame:CGRectMake(0, 0, 100,100)];
    
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

@end
