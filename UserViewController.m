//
//  UserViewController.m
//  Halp
//
//  Created by John Silvester on 12/28/14.
//  Copyright (c) 2014 PaxtonTechnologies. All rights reserved.
//

#import "UserViewController.h"
#import "SetMatch.h"

@interface UserViewController ()

@end

@implementation UserViewController

- (void)viewDidLoad {
    [self adjustForSize];
    [super viewDidLoad];
    [self Setnums];
    self.counter4 = 100;
    SetMatch *matches = [[SetMatch alloc]init];
    self.matches = [[NSMutableArray alloc]initWithArray:[matches queryForUser]];
    // Do any additional setup after loading the view.
    int hasSaid = [[NSUserDefaults standardUserDefaults]integerForKey:@"chosen"];
    
    self.number.text = [NSString stringWithFormat:@"%@",[[PFUser currentUser]objectForKey:@"Counter"]];
    
    self.KarmaScore.alpha = 0;
    self.heartView.alpha = 0;
    self.othercounterView.alpha = 0;
    self.number.alpha = 0;
    self.numberofcon.alpha = 0;
    
    self.rangAmongFriends.alpha = 0;
    self.rankamountfriendsnum.alpha =0;
    self.OverallKarm.alpha =0;
    self.overallkarmnumber.alpha =0;
    self.buttonGirl.hidden = YES;
    self.buttonGuy.hidden = YES;
    
    self.othercounterView.center = CGPointMake(self.othercounterView.center.x -10, self.othercounterView.center.y);
    
    
     
    
    self.heartimer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(hearttimer) userInfo:nil repeats:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)guyPressed:(id)sender {
    int hasSaid = [[NSUserDefaults standardUserDefaults]integerForKey:@"chosen"];
    if (hasSaid == 0) {
        [[NSUserDefaults standardUserDefaults]setInteger:1 forKey:@"chosen"];
        self.timerside = [NSTimer scheduledTimerWithTimeInterval:.001 target:self selector:@selector(moveside) userInfo:nil repeats:YES];
    }
    
}

- (IBAction)girlPressed:(id)sender {
     int hasSaid = [[NSUserDefaults standardUserDefaults]integerForKey:@"chosen"];
    if (hasSaid == 0) {
        _isGirl = true;
        [[NSUserDefaults standardUserDefaults]setInteger:2 forKey:@"chosen"];
        self.timerside = [NSTimer scheduledTimerWithTimeInterval:.001 target:self selector:@selector(moveside) userInfo:nil repeats:YES];
    }
    
}

-(void)timergoingup{
    self.buttonGirl.frame = CGRectMake(self.buttonGirl.frame.origin.x , self.buttonGirl.frame.origin.y -1, self.buttonGirl.frame.size.width, self.buttonGirl.frame.size.height);
     self.buttonGuy.frame = CGRectMake(self.buttonGuy.frame.origin.x , self.buttonGuy.frame.origin.y -1, self.buttonGuy.frame.size.width, self.buttonGuy.frame.size.height);
    
    
    if (_counter1 >= 558) {
        [self.timerup invalidate];
    }
    
    
    self.counter1++;
}

-(void)moveside{
    
    if (_counter2 >= 320) {
        NSLog(@"%f",self.buttonGirl.frame.origin.x);
        [self.timerside invalidate];
    }
    
    if (self.isGirl == false) {
        //move girl out
    self.buttonGirl.frame = CGRectMake(self.buttonGirl.frame.origin.x + 1 , self.buttonGirl.frame.origin.y , self.buttonGirl.frame.size.width, self.buttonGirl.frame.size.height);
        self.buttonGuy.frame = CGRectMake(self.buttonGuy.frame.origin.x + .25, self.buttonGuy.frame.origin.y , self.buttonGuy.frame.size.width, self.buttonGuy.frame.size.height);}
    else{//move guy out
        self.buttonGirl.frame = CGRectMake(self.buttonGirl.frame.origin.x - .25, self.buttonGirl.frame.origin.y , self.buttonGirl.frame.size.width, self.buttonGirl.frame.size.height);
        self.buttonGuy.frame = CGRectMake(self.buttonGuy.frame.origin.x - 1, self.buttonGuy.frame.origin.y , self.buttonGuy.frame.size.width, self.buttonGuy.frame.size.height);
        }
    
    _counter2++;
    
    
}
-(void)queryConversations{
    
}
-(void)hearttimer{
    if (self.counter3 > 100) {
        [self.heartimer invalidate];
        
    }
    if (self.counter3 == 10) {
        NSString *final =  [[PFUser currentUser]objectForKey:@"Karma"];
        int finalNum = [final intValue];
        self.counter4 = finalNum - 50;
        self.counterTimer = [NSTimer scheduledTimerWithTimeInterval:.05 target:self selector:@selector(numberTimer) userInfo:nil repeats:YES];
    }
    
    self.heartView.center = CGPointMake(self.heartView.center.x, self.heartView.center.y - .1);
    self.heartView.alpha = self.heartView.alpha + .01;
    self.KarmaScore.center = CGPointMake(self.KarmaScore.center.x, self.KarmaScore.center.y - .1);
    self.KarmaScore.alpha = self.KarmaScore.alpha + .01;
    self.othercounterView.alpha =  self.othercounterView.alpha +.01;
    self.number.alpha =   self.number.alpha +.01;
    self.numberofcon.alpha = self.numberofcon.alpha +.01;
    self.rangAmongFriends.alpha = self.rangAmongFriends.alpha + .01;
    self.rankamountfriendsnum.alpha += .01;
    self.OverallKarm.alpha += .01;
    self.overallkarmnumber.alpha += .01;
    
    self.othercounterView.center = CGPointMake(self.othercounterView.center.x +.1, self.othercounterView.center.y);
    
    self.counter3++;
    
}

-(void)Setnums{
    
    int number = arc4random() % 3;
    number++;
    self.number.text = [NSString stringWithFormat:@"%@",[[PFUser currentUser]objectForKey:@"Counter"]];
    self.rankamountfriendsnum.text = [NSString stringWithFormat:@"%i",number];
        self.overallkarmnumber.text = [NSString stringWithFormat:@"%i",[self queryforRank]];
    
if ([self.OverallKarm.text intValue] <=2) {
    self.rankamountfriendsnum.text = @"1";
}

}
-(int)queryforRank{
    
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query orderByDescending:@"Karma"];
    NSArray *results = [query findObjects];
    if (results.count > 0) {
        int count = 0;
        
        while (count < results.count) {
            NSString *first = [[results objectAtIndex:count] objectForKey:@"username"];
            NSString *second = [[PFUser currentUser]username];
            
            int num = [first intValue];
            int num2 = [second intValue];
            if (num == num2) {
                
                return count + 1;
            }
            count++;
        }
    }
    
    
    return 1000;
}

-(void)numberTimer{
    NSString *final =  [[PFUser currentUser]objectForKey:@"Karma"];
    int finalNum = [final intValue];
    
    if (self.counter4 <= finalNum) {
        self.KarmaScore.text = [NSString stringWithFormat:@"%i",self.counter4];
        self.counter4++;
    }else{
        self.counter4++;
    }
    
    if (self.counter4 > finalNum) {
        [self.counterTimer invalidate];
    }
    
}
-(void)adjustForSize{
    
   
    
    
    self.fullView.center = CGPointMake(self.view.frame.size.width /2, self.view.frame.size.height/2);

}
@end
