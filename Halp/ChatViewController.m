//
//  ChatViewController.m
//  Halp
//
//  Created by John Silvester on 12/24/14.
//  Copyright (c) 2014 PaxtonTechnologies. All rights reserved.
//

#import "ChatViewController.h"
#import "Matching.h"
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>


@interface ChatViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    CGPoint lastLocation;
}
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Channel = [[NSUserDefaults standardUserDefaults]stringForKey:@"Chat"];
    // Do any additional setup after loading the view.
    [self querychat];
    self.tableview.separatorColor = [UIColor clearColor];
    self.sendbutton.layer.cornerRadius = self.sendbutton.frame.size.height /2;
    self.sendbutton.layer.masksToBounds = YES;
    self.sendbutton.layer.borderWidth = 0;
    [self movechattoFullScreen];
    self.tableview.estimatedRowHeight = 100.0;
    self.tableview.rowHeight = UITableViewAutomaticDimension;
    
    //self.tableview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Bg"]];
   
        //[self tableViewScrollToBottomAnimated];
     
    
    
    self.tabBarItem.selectedImage = [[UIImage imageNamed:@"chat"]
                                     imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.tabBarItem.image = [[UIImage imageNamed:@"chat"]
                             imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}-(void)viewDidAppear:(BOOL)animated{

        [[UIView appearanceWhenContainedIn:[UITabBar class], nil] setTintColor:[UIColor whiteColor]];
        [[UITabBar appearance] setSelectedImageTintColor:[UIColor blackColor]];
    

}



#pragma mark - tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        if (self.conversation.count == 0) {
            return 1;
        }
        return [self.conversation  count];
}




- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
//    if (cell == nil)
//    {
//        
//        
//        
//        
//    }
    [self getlength:indexPath.row];
    [self getheightforlabel:indexPath.row];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:MyIdentifier];
    
    
    UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(0, 1, self.width, self.height)];
    text.numberOfLines = 100;
    text.font = [UIFont fontWithName:@"Avenir-Light" size:15];
    text.textColor = [UIColor blackColor];
    text.lineBreakMode = NSLineBreakByWordWrapping;
    
    //text.layer.borderWidth = 2;
    text.layer.cornerRadius = 10;
    if (self.conversation.count>0) {
        
        if ([[self.side objectAtIndex:indexPath.row] isEqualToString:[[PFUser currentUser]username]]) {
            
           
                text.text = [NSString stringWithFormat:@"%@",[self.conversation objectAtIndex:indexPath.row]];
           
            text.frame = CGRectMake(320 - self.width, 1, self.width, self.height);
            UIColor *color = [UIColor colorWithRed:116/255.0f green:167/255.0f blue:225/255.0f alpha:.31f];
            text.backgroundColor = color;
         text.textAlignment = NSTextAlignmentCenter;
        }else{
            
                text.text = [NSString stringWithFormat:@"%@",[self.conversation objectAtIndex:indexPath.row]];

            
            UIColor *color = [UIColor colorWithRed:115/255.0f green:227/255.0f blue:202/255.0f alpha:.100f];
            text.backgroundColor = color;
            text.textAlignment = NSTextAlignmentCenter;
        }
        [cell addSubview:text];
        
    }else{
        cell.textLabel.text = @"Start a new conversation! :)";
    }

    
    
    
    //checks which side
    
    
    return cell;
    }



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    int size = 33;
    if (self.conversation.count > 0) {
        size = self.height + 3;
    }
    return size;
}



- (IBAction)typing:(id)sender {
    [self movechattohalfway];
}

- (IBAction)Send:(id)sender {
    
    [self.conversation addObject:self.textfield.text];
    [self.side addObject:[[PFUser currentUser]username]];
    NSLog(@"%@",self.textfield.text);
    Matching *newmatch = [[Matching alloc]init];
    
    [newmatch addStringToarray:self.textfield.text :self.Channel];
    self.textfield.text = @"";
    
    dispatch_async(dispatch_get_main_queue(), ^{
       [self.tableview reloadData];
    });
    [self querychat];
    [self.tableview reloadData];
    [self tableViewScrollToBottomAnimated];
}

- (IBAction)Menu:(id)sender {
    
   
   
    
}
-(void)querychat{
    //[self.conversation removeAllObjects];
     PFQuery *query = [PFQuery queryWithClassName:@"Conversations"];
    NSLog(@"Getting here");
    [query whereKey:@"Channel" equalTo:self.Channel];
    [self.conversation arrayByAddingObjectsFromArray:[query findObjects]];
  NSArray *hello = [query findObjects];
   self.conversation = [[NSMutableArray alloc]initWithArray:[[hello objectAtIndex:0]objectForKey:@"Conversation" ]copyItems:YES];
   self.side =[[NSMutableArray alloc]initWithArray:[[hello objectAtIndex:0]objectForKey:@"Sides"]copyItems:YES];
   
    
}
- (NSString *)getSubstring:(NSString *)value betweenString:(NSString *)separator
{
    NSRange firstInstance = [value rangeOfString:separator];
    NSRange secondInstance = [[value substringFromIndex:firstInstance.location + firstInstance.length] rangeOfString:separator];
    NSRange finalRange = NSMakeRange(firstInstance.location + separator.length, secondInstance.location);
    
    return [value substringWithRange:finalRange];
}
-(NSString *)stringsTocheck{
    NSString *stringone = [NSString stringWithFormat:@"%@.",self.Channel];
     NSString *stringtwo = [NSString stringWithFormat:@".%@",self.Channel];
    
   NSString *newString =  [self getSubstring:stringone betweenString:@"."];
    NSString *newstring2 = [self getSubstring:stringtwo betweenString:@"."];
    
    if ([newString isEqual:[[PFUser currentUser]username]]) {
        return newString;
        _isfirst = NO;
    }else{
        return newstring2;
        _isfirst = YES;
    }
    
    
}
-(void)movechattoFullScreen{
    NSLog(@"HEREd");
    self.tableview.frame = CGRectMake(self.tableview.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - 49);
    self.typingview.frame = CGRectMake(self.typingview.frame.origin.x, self.view.frame.size.height - 164, self.view.frame.size.width, 204);
    NSLog(@"%f",self.typingview.frame.origin.y);
    
    
}
-(void)movechattohalfway{
    if (self.view.bounds.size.height == 480) {
        //IPHONE 4/4S
        self.tableview.frame = CGRectMake(self.tableview.frame.origin.x, 0, self.view.frame.size.width, 250);
        self.typingview.frame = CGRectMake(self.tableview.frame.origin.x, 180,self.typingview.frame.size.width, self.typingview.frame.size.height);
    }else{
        // for IPHONE 5/5S
    self.tableview.frame = CGRectMake(self.tableview.frame.origin.x, 0, self.view.frame.size.width, 289);
        self.typingview.frame = CGRectMake(self.tableview.frame.origin.x, 233,self.typingview.frame.size.width, self.typingview.frame.size.height);
    [self tableViewScrollToBottomAnimated];}
    NSLog(@"%f",self.typingview.frame.origin.y);
    
    
}


- (IBAction)menu:(id)sender {

    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Options" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Thank User",
                            @"Flag User",
                            @"Delete Conversation",
                            nil];
    popup.tag = 1;
    
    
    [popup showInView:[UIApplication sharedApplication].keyWindow];
    
    
    
}
- (void)tableViewScrollToBottomAnimated {
    [self.tableview reloadData];
    int lastRowNumber = [self.tableview numberOfRowsInSection:0] - 1;
    NSIndexPath* ip = [NSIndexPath indexPathForRow:lastRowNumber inSection:0];
    [self.tableview scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:NO];
}
- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (popup.tag) {
        case 1: {
            switch (buttonIndex) {
                case 0:
                    [self ReccomendUser];
                    break;
                case 1:
                    [self FlagUser];
                    break;
                case 2:
                    [self deleteConversation];
                    break;
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
}
-(void)deleteConversation{
    NSLog(@"delete;");
   
    
    PFQuery *query = [PFQuery queryWithClassName:@"Conversations"];
    
    [query whereKey:@"Channel" equalTo:self.Channel];
    NSArray *array = [query findObjects];
    if (array.count > 0) {
        [[array objectAtIndex:0]deleteEventually];
    }
     [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)ReccomendUser{
    NSLog(@"rec;");
    Matching *match = [[Matching alloc]init];
    NSString *name =[match stringsTocheck2:self.Channel];
    NSLog(@"%@",name);
    NSString  *newStr = [name substringToIndex:[name length]-1];
    
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query whereKey:@"username" equalTo:newStr];
    NSArray *array = [query findObjects];
    NSLog(@"Counter : %@",array);
    
    if (array.count > 0) {
        
        NSString *userRetireved = [[array objectAtIndex:0]objectForKey:@"Rec"];
        NSLog(@"%@",userRetireved);
        NSLog(@"%@",[[PFUser currentUser]username]);
        // sees if they were the last one to give karma if they were it wont let them add more
        if (![userRetireved isEqualToString:[[PFUser currentUser]username]]) {
            
            NSNumber *number =[[array objectAtIndex:0]objectForKey:@"Karma"];
            int valuee = [number intValue];
            number = [NSNumber numberWithInt:valuee + 10];
            NSString *objectid = [[array objectAtIndex:0]objectId];
            NSLog(@"%@",objectid);
            [query getObjectInBackgroundWithId:objectid block:^(PFObject *user, NSError *error) {
                NSLog(@"after %@",number);
                // Now let's update it with some new data. In this case, only cheatMode and score
                // will get sent to the cloud. playerName hasn't changed.
                user[@"Karma"] = number;
                user[@"Rec"] = [[PFUser currentUser]username];
                [user saveInBackground];
                [self ShowMessage:@"User\nThanked!"];
            }];
           

        }
        
        
        
            }
   
}
-(void)FlagUser{
    
    NSLog(@"flag;");
    PFObject *Flag = [PFObject objectWithClassName:@"Flags"];
    Flag[@"user_who_clicked"] = [[PFUser currentUser]username];
    Flag[@"channel"] = self.Channel;
    [Flag saveEventually];
     [self ShowMessage:@"User Flagged" ];
    
    
}
-(void)ShowMessage: (NSString *)text{
    self.messageView = [[UIView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width /2 -50, 150, 0, 0)];
    self.messageView.backgroundColor = [UIColor blackColor];
    self.messageView.alpha = .5;
    self.messageView.layer.cornerRadius = 10;
    UILabel *lavel = [[UILabel alloc]initWithFrame:CGRectMake(2, 10, 98, 80)];
    lavel.text = text;
    lavel.font = [UIFont fontWithName:@"Avenir-Light" size:19];
    lavel.textAlignment = NSTextAlignmentCenter;
    lavel.textColor = [UIColor whiteColor];
    lavel.numberOfLines = 13;
   
    [self.messageView addSubview:lavel];
    [self.view addSubview:self.messageView];
    self.seconds = .0001;
    self.Timer = [NSTimer scheduledTimerWithTimeInterval:self.seconds target:self selector:@selector(timerfunc) userInfo:nil repeats:YES];
   
    
    
}
-(void)timerfunc{
    
    
    if (self.duration >  6000) {
        self.messageView.center = CGPointMake(self.messageView.center.x, self.messageView.center.y -1);
        if (self.messageView.center.y < -100) {
            [self.Timer invalidate];
            self.duration = 0;
        }
        
    }else{
        
        if (self.duration <= 100) {
            
            self.messageView.frame = CGRectMake(self.messageView.frame.origin.x, self.messageView.frame.origin.y, self.messageView.frame.size.width+1, self.messageView.frame.size.height+1);}
        
        
    }
    _duration++;
}

- (UIImage *)stretchableImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight{
    
    return [UIImage imageNamed:@"chatbox"];
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%lu",(unsigned long)[[self.conversation objectAtIndex:indexPath.row] length]);
}


-(void)getlength :(int )index{
    double number = [[self.conversation objectAtIndex:index] length];
    if (number <= 3) {
        number =  number * 13.954;
    }
    else if (number <= 4) {
        number =  number * 11.153848;

    }else{
        number =  number * 8.153848;}
    if (number > 319) {
        self.width = 319;
    }else{
        self.width = number;}
}
-(void)getheightforlabel :(int )index{
     self.height = 30;
    double heighted = 48;
    while ([[self.conversation objectAtIndex:index] length] > heighted) {
        self.height  =self.height + 20;
        heighted = heighted + 50;
    }
   
}

@end
