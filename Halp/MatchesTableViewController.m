//
//  MatchesTableViewController.m
//  Halp
//
//  Created by John Silvester on 12/24/14.
//  Copyright (c) 2014 PaxtonTechnologies. All rights reserved.
//

#import "MatchesTableViewController.h"
#import "SetMatch.h"
#import "ChatViewController.h"

@interface MatchesTableViewController ()

@end

@implementation MatchesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    NSString *new = [[NSUserDefaults standardUserDefaults]stringForKey:@"Yes"];
    if (new.length != 3) {
        [self performSegueWithIdentifier:@"nu" sender:self];
    }
  
    SetMatch *matches = [[SetMatch alloc]init];
    self.Conversation = [[NSMutableArray alloc]initWithArray:[matches queryForUser]];
    [self.tableView reloadData];
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
       self.tableView.tableFooterView = [[UIView alloc] init];
    NSLog(@"Height %f",self.view.bounds.size.height);
    
    
    if (self.view.bounds.size.height == 667.000000) {
        
        
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg6"]];
        
    }else{
        
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Bg"]];}
    
    
    if ([[PFUser currentUser]objectForKey:@"Karma"]  == [NSNull null]) {
        self.karma.title = @"100";
    }else{
        NSString *final =  [[PFUser currentUser]objectForKey:@"Karma"];
        self.karma.title = [NSString stringWithFormat:@"%@",final];
        
    }
    
    
}
-(void)viewDidAppear:(BOOL)animated{
 
    
    
    [self.tableView reloadData];

    
    

    
 

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return self.Conversation.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
   UIColor * color = [UIColor colorWithRed:115/255.0f green:227/255.0f blue:202/255.0f alpha:1.0f];
    
    
   
  // cell.separatorInset = UIEdgeInsetsZero;
    
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:MyIdentifier];
    }
    
    cell.textLabel.textAlignment = NSTextAlignmentNatural;
    
    long counter = [[[self.Conversation objectAtIndex:indexPath.row]objectForKey:@"Conversation"]count];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    
    if (counter == 0) {
        cell.textLabel.text = @"New Conversation";
    }else{
        cell.textLabel.text = [[[self.Conversation objectAtIndex:indexPath.row]objectForKey:@"Conversation"]objectAtIndex:counter -1 ];}
    cell.accessoryView.backgroundColor = [UIColor clearColor];
    
    [self makelowerString:indexPath.row];
    cell.detailTextLabel.text = [[NSUserDefaults standardUserDefaults]stringForKey:@"lower"];
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"lower"]);
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell     forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
   
    
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *channel = [[self.Conversation objectAtIndex:indexPath.row] objectForKey:@"Channel"];
    [[NSUserDefaults standardUserDefaults]setObject:channel forKey:@"Chat"];
    [self performSegueWithIdentifier:@"cell" sender:self];
}

-(void)timer{
    
    
    //self.counter = 100;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        PFQuery *query = [PFQuery queryWithClassName:@"Conversations"];
          NSString *channel = [[self.Conversation objectAtIndex:indexPath.row] objectForKey:@"Channel"];
        [query whereKey:@"Channel" equalTo:channel];
        NSArray *array = [query findObjects];
        if (array.count > 0) {
            [[array objectAtIndex:0]deleteEventually];
            [self viewDidAppear:YES];
            [self.tableView reloadData];
        }
    }
}
- (IBAction)newconv:(id)sender {
     [self.tabBarController setSelectedIndex:1];
}

- (IBAction)karma:(id)sender {
    [self.tabBarController setSelectedIndex:2];

}
-(void)numberTimer{
//    NSString *final =  [[PFUser currentUser]objectForKey:@"Karma"];
//     self.karma.title = [NSString stringWithFormat:@"%i",self.counter4]
//    int finalNum = [final intValue];
//    
//    if (self.counter4 <= finalNum) {
//        self.karma.title = [NSString stringWithFormat:@"%i",self.counter4];
//        self.counter4++;
//    }else{
//        self.counter4++;
//    }
//    
//    if (self.counter4 > finalNum) {
//        [self.counterTimer invalidate];
//    }
    
}
-(void)makelowerString :(float )indexpath{
    NSString *totalString;
    NSString *finalString;
    NSString *looking = [[self.Conversation objectAtIndex:indexpath]objectForKey:@"Looking"];
    NSLog(@"%@",looking);
    if (looking.length > 0) {
        
        if ([looking isEqualToString:[[PFUser currentUser]username]]) {
            totalString = @"Looking";
            
        }else{
            totalString = @"Helping";
        }
        
    }
    NSNumber *number = [[self.Conversation objectAtIndex:indexpath]objectForKey:@"Topic"];
    int numb = [number intValue];
    NSString *nextString = @"";
    if (numb == 0) {
        nextString = @"Relationships";
    }else if ( numb == 1){
         nextString = @"Family";
    }else if ( numb == 2){
         nextString = @"Addiction";
    }else if ( numb == 3){
         nextString = @"Drugs/Alcohol";
    }else if ( numb == 4){
         nextString = @"Relationships";
    }
    finalString = [NSString stringWithFormat:@"%@ | %@",totalString,nextString];
    [[NSUserDefaults standardUserDefaults]setObject:finalString forKey:@"lower"];
}

@end
