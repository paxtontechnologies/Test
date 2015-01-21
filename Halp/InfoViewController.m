//
//  InfoViewController.m
//  Halp
//
//  Created by John Silvester on 12/23/14.
//  Copyright (c) 2014 PaxtonTechnologies. All rights reserved.
//

#import "InfoViewController.h"
#import "lookingViewController.h"

@interface InfoViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%f",self.tableview.center.y);
    
    if (self.is_Looking == false) {
        [self.buttonView setBackgroundImage:[UIImage imageNamed:@"Helping"] forState:UIControlStateNormal];
        self.lookingText.hidden = true;
        self.HelpingText.hidden = true;
        self.textBottom.text = @"I can help with..";
        self.textTop.text = @"Helping";
        
    }
    //modifies layout
    [self changelayout];
    
    //creates names
    self.array = [[NSMutableArray alloc]initWithObjects:@"Relationships", @"Family", @"Sexual",@"Drugs/Alchol",@"Other", nil];
   //sets up for clicking the different categories
     [self setuparray];
    
   
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    [[UIView appearanceWhenContainedIn:[UITabBar class], nil] setTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor blackColor]];
    }

#pragma mark - tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.array count];    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
   
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier];
       
        
    }
    
    UIButton *circle = [[UIButton alloc]initWithFrame:CGRectMake(100, 50, 80, 80)];
    circle.layer.cornerRadius = circle.frame.size.height /2;
    //circle.layer.masksToBounds = YES;
   
    [cell.contentView addSubview:circle];

    
    if ([[self.smileyPressed objectAtIndex:indexPath.row ] isEqual: @1]) {
        if (indexPath.row % 2 == 0) {
            cell.imageView.image = [UIImage imageNamed:@"bluecirclesmile"];
            [self.smileyPressed replaceObjectAtIndex:indexPath.row withObject:@1];
        }else{
            cell.imageView.image = [UIImage imageNamed:@"greencirclesmile"];
            [self.smileyPressed replaceObjectAtIndex:indexPath.row withObject:@1];
        }

    }else{
        if (indexPath.row % 2 == 0) {
            cell.imageView.image = [UIImage imageNamed:@"bluecircle"];
        }else{
            cell.imageView.image = [UIImage imageNamed:@"greencircle"];
        }
        
    }
    
   
    
    cell.textLabel.text =[self.array objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:23];
    cell.textLabel.textColor = [UIColor grayColor];
    cell.tintColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Here we use the provided setImageWithURL: method to load the web image
    // Ensure you use a placeholder image otherwise cells will be initialized with no image
    
        return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 100;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

   UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.imageView.layer.cornerRadius = cell.imageView.frame.size.height /2;
    
    
    
    
    if ([[self.smileyPressed objectAtIndex:indexPath.row ] isEqual: @1]) {
        if (indexPath.row % 2 == 0) {
            cell.imageView.image = [UIImage imageNamed:@"bluecircle"];
            self.nextButtonisViewable = false;
             [self hiddenButton];
        }else{
            cell.imageView.image = [UIImage imageNamed:@"greencircle"];
            self.nextButtonisViewable = false;
             [self hiddenButton];
        }
        [self.smileyPressed replaceObjectAtIndex:indexPath.row withObject:@0];

        
    }else{
                if (indexPath.row % 2 == 0) {
            cell.imageView.image = [UIImage imageNamed:@"bluecirclesmile"];
            [self.smileyPressed replaceObjectAtIndex:indexPath.row withObject:@1];
            self.nextButtonisViewable = true;
            [self hiddenButton];
        }else{
            cell.imageView.image = [UIImage imageNamed:@"greencirclesmile"];
            [self.smileyPressed replaceObjectAtIndex:indexPath.row withObject:@1];
            self.nextButtonisViewable = true;
             [self hiddenButton];
        }


        
    }

     [self hiddenButton];
    if((self.is_Looking== true)&&(self.allowsSelection==false)){
        self.tableview.allowsSelection = false;
        self.allowsSelection=true;
        
        
    }
    
}

-(void)setuparray{
   self.smileyPressed = [[NSMutableArray alloc]initWithCapacity:self.array.count];
    while (self.smiley < self.array.count) {
        [self.smileyPressed addObject:@0];
        self.smiley++;
       
    }
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    lookingViewController *nextview = segue.destinationViewController;
    nextview.islooking = self.is_Looking;
   
    //tells matching alg if the person is looking for help if
    if (self.is_Looking == true) {
        //looking for help Bottom CLicked
        nextview.isLooking = @1;
    }else{
        //giving help Top Clicked
        nextview.isLooking = @0;
    }
    
    
    //runs through to check what smileys were pressed
    NSMutableArray *selections = [[NSMutableArray alloc]init];
    
//    for (int x; x < self.smileyPressed.count; x++) {
//        NSLog(@"%@",self.smileyPressed);
//        if ([[self.smileyPressed objectAtIndex:x] isEqual: @1]) {
//            
//            [selections addObject:[NSNumber numberWithInt:x]];
//            
//        }
// 
//    }
    int x = 0;
    while (x < self.smileyPressed.count) {
        
        if ([[self.smileyPressed objectAtIndex:x] isEqual: @1]) {
            
            [selections addObject:[NSNumber numberWithInt:x]];
            
        }

        x++;
    }
    
    
    
    //stores array in data
    [[NSUserDefaults standardUserDefaults]setObject:selections forKey:@"Selection"];
    
  
}


- (IBAction)nextPushed:(id)sender {
    
    

}
-(void)hiddenButton{
    if (self.nextButtonisViewable == true) {
        self.nextButton.hidden = false;
        self.nextTitle.hidden = false;
    }else{
        self.nextButton.hidden = true;
        self.nextTitle.hidden = true;
    }
}
-(void)changelayout{
    
    if (self.view.bounds.size.height == 480) {
        self.totalview.center = CGPointMake(self.view.frame.size.width /2, self.view.frame.size.height/3.1);
self.tableview.frame = CGRectMake(self.tableview.frame.origin.x, self.tableview.frame.origin.y , self.view.frame.size.width, 200);
        
        
    }
    
    if (self.view.frame.size.width == 414) {
        //6 plus
        self.tableview.frame = CGRectMake(self.tableview.frame.origin.x, self.tableview.frame.origin.y, self.view.frame.size.width, 496);
        self.totalview.center = CGPointMake(self.view.frame.size.width /2, self.view.frame.size.height/4);

        
    }
    
    if (self.view.frame.size.width == 375) {
        //iphone 6
        self.tableview.frame = CGRectMake(self.tableview.frame.origin.x, self.tableview.frame.origin.y, self.view.frame.size.width, 427);
        self.totalview.center = CGPointMake(self.view.frame.size.width /2, self.view.frame.size.height/3.2);

    }
    if (self.view.frame.size.height == 568) {
        //iphone 5
        
        
    }
    

   
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   
    
    self.touches = 0;
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
   
   
    
    //5s & under on other devices just center everything.
    
    CGPoint currentOffset = scrollView.contentOffset;
    if (currentOffset.y > self.lastContentOffset.y)
    {
        // Downward
        
        
        
        if (self.tableview.frame.origin.y < 200) {
            self.moveSet = true;
            
        }
        
        else{
            
            if (self.moveSet == false) {
                if (self.view.frame.size.height == 480) {
                    self.tableview.frame = CGRectMake(self.tableview.frame.origin.x , self.tableview.frame.origin.y-18, self.tableview.frame.size.width, 308);
                    self.buttonView.frame = CGRectMake(self.buttonView.frame.origin.x+2.5, self.buttonView.frame.origin.y - 4, self.buttonView.frame.size.width - 5, self.buttonView.frame.size.height - 6.5);
                    self.textTop.center = CGPointMake(self.textTop.center.x+1.6, self.textTop.center.y-4.5);
                    self.textBottom.center = CGPointMake(self.textBottom.center.x, self.textBottom.center.y-10);
                    self.nextButton.center = CGPointMake(self.nextButton.center.x, self.nextButton.center.y-10);
                    self.textTop.font = [UIFont fontWithName:@"Avenir-Light" size:self.textTop.font.pointSize-1];
                    self.nextTitle.center = CGPointMake(self.nextTitle.center.x, self.nextTitle.center.y-10);
                    
                }
                
                
                else
                {
        
        self.tableview.frame = CGRectMake(self.tableview.frame.origin.x , self.tableview.frame.origin.y-10, self.tableview.frame.size.width, 368);
        self.buttonView.frame = CGRectMake(self.buttonView.frame.origin.x+2.5, self.buttonView.frame.origin.y - 4, self.buttonView.frame.size.width - 5, self.buttonView.frame.size.height - 6.5);
            self.textTop.center = CGPointMake(self.textTop.center.x+1.6, self.textTop.center.y-4.5);
            self.textBottom.center = CGPointMake(self.textBottom.center.x, self.textBottom.center.y-10);
            self.nextButton.center = CGPointMake(self.nextButton.center.x, self.nextButton.center.y-10);
            self.textTop.font = [UIFont fontWithName:@"Avenir-Light" size:self.textTop.font.pointSize-1];
            self.nextTitle.center = CGPointMake(self.nextTitle.center.x, self.nextTitle.center.y-10);
                }
            }
            
            
            

        }
        
       
        
    }
    else
    {
        // Upward
           NSLog(@"up");
        
            
        }
    }






@end
