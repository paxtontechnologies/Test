//
//  loginViewController.m
//  Halp
//
//  Created by John Silvester on 12/24/14.
//  Copyright (c) 2014 PaxtonTechnologies. All rights reserved.
//

#import "loginViewController.h"
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>

@interface loginViewController ()

@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self adjustCircles];
    [self adjustCirclesBlue];
    [self adjustheart];
    NSLog(@"Current User%@",[[PFUser currentUser]username ]);
    
    // Do any additional setup after loading the view.
    self.whiteTimer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(whitecircleMovemnt) userInfo:nil repeats:YES];
    self.time = .005;
    self.heartTimer = [NSTimer scheduledTimerWithTimeInterval:self.time target:self selector:@selector(heartMovemnet) userInfo:nil repeats:YES];
    
    self.circleBlue.hidden = YES;
    self.circleWhite.hidden = YES;
    
    self.random = arc4random() % 2;
    
    if (self.random == 0) {
        self.random = 5;
    }else{
        self.random = 5;
    }
   }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)loginuser{
    // checks to see if the user has used the app before, if they havent it'll query for no reason.
    NSNumber *standardUserNumber = [[NSUserDefaults standardUserDefaults]objectForKey:@"User"];
    if (standardUserNumber == nil){
        standardUserNumber = @0;
    }
    //first query if comes back true login
    PFQuery *queryfirst = [PFQuery queryWithClassName:@"_User"];
    [queryfirst whereKey:@"Number" equalTo:standardUserNumber];
    NSArray *arrayfirst = [queryfirst findObjects];
    if (arrayfirst.count != 0) {
        //login
        
        [PFUser logInWithUsernameInBackground:[NSString stringWithFormat:@"%@",standardUserNumber] password:@"password" block:^(PFUser *user, NSError *error) {
            if (user) {
                // Do stuff after successful login.
                self.growing2 = true;
                [self.whiteTimer invalidate];
                [self.blueTimer invalidate];
                [self.heartTimer invalidate];
               
                //[self performSegueWithIdentifier:@"login2" sender:self];
            } else {
                // The login failed. Check error to see why.
                NSLog(@"%@",[error userInfo][@"error"]);
            } 
        }];
        
        
    }else{
    //if comes back false create a user
    
        //queries to see how many users there are
  PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    NSArray *array = [query findObjects];
        //bumps them up one
        long number = array.count +1;
        //converts to number for login
        NSNumber *usernumber = [NSNumber numberWithLong:number];
    //adds credientials 
    PFUser *user = [PFUser user];
    user.username = [NSString stringWithFormat:@"%lu",number];
    user.password = @"password";
    user[@"Number"] = usernumber;
        user[@"Counter"] = @0;
        user[@"Karma"] = @100;
        user[@"Rec"] = @"";
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hooray! Let them use the app now.
           self.growing2 = true;
            [[NSUserDefaults standardUserDefaults]setObject:@1 forKey:@"log"];
          //  [self.whiteTimer invalidate];
//[self.blueTimer invalidate];
            [self.heartTimer invalidate];
            
              [[NSUserDefaults standardUserDefaults]setObject:usernumber forKey:@"User"];
            NSLog(@"USER Created");
        } else {
            NSString *errorString = [error userInfo][@"error"];
            NSLog(@"%@",errorString);
            // Show the errorString somewhere and let the user try again.
        }
    }];
    }
    
}


//setting up circles

-(void)adjustCircles{
    self.circleWhite.frame = CGRectMake(self.circleWhite.frame.origin.x, self.circleWhite.frame.origin.y , 30 , 30 );
    self.circleWhite.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height/2);
    self.circleWhite.layer.cornerRadius = self.circleWhite.frame.size.height/2;
    
    self.circleWhite.backgroundColor = [UIColor clearColor];
   self.circleWhite.layer.masksToBounds=YES;
    self.circleWhite.layer.borderColor=[[UIColor whiteColor]CGColor];
    self.circleWhite.layer.borderWidth= 1.0f;
    self.circleWhite.alpha = 1;
    self.whiteCounter++;
    
 
    if (self.whiteCounter == self.random) {
        self.growing2 = true;
        if (self.heart.frame.size.height >= self.view.frame.size.height) {
            [self loginuser];
        }
      
    }
    
}

-(void)adjustCirclesBlue{
    self.circleBlue.frame = CGRectMake(self.circleBlue.frame.origin.x, self.circleBlue.frame.origin.y , 30 , 30 );
    self.circleBlue.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height/2);
    self.circleBlue.layer.cornerRadius = self.circleBlue.frame.size.height/2;
    self.circleBlue.backgroundColor = [UIColor clearColor];
    self.circleBlue.layer.masksToBounds=YES;
    self.circleBlue.layer.borderColor=[[UIColor blackColor]CGColor];
    self.circleBlue.layer.borderWidth= 2.0f;
    self.circleBlue.alpha = 1;
    
}
-(void)adjustheart{
    self.heart.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height/2);
    
    
}



//timers

-(void)whitecircleMovemnt{
    self.circleWhite.frame = CGRectMake( self.circleWhite.frame.origin.x, self.circleWhite.frame.origin.y , self.circleWhite.frame.size.width + 2, self.circleWhite.frame.size.height + 2);
    self.circleWhite.alpha = self.circleWhite.alpha - .01;
self.circleWhite.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height/2);
     self.circleWhite.layer.cornerRadius = self.circleWhite.frame.size.height/2;
    NSLog(@"%f",self.circleWhite.alpha);
    if ((self.circleWhite.alpha <= 0.75)&&(self.circleWhite.alpha >= 0.74)) {
        
            if (self.launch == false) {
                [self adjustCirclesBlue];
                self.blueTimer = [NSTimer scheduledTimerWithTimeInterval:.001 target:self selector:@selector(bluecircleMovement) userInfo:nil repeats:YES];
                self.launch = true;
            }
            
            
    }
    
    if (self.circleWhite.alpha <=.01) {
        [self adjustCircles];
        self.heartCounter = 0;
    }
    
}
-(void)bluecircleMovement{
    
   
    
    if (self.circleBlue.alpha <= .50) {
        
        self.circleBlue.frame = CGRectMake( self.circleBlue.frame.origin.x, self.circleBlue.frame.origin.y , self.circleBlue.frame.size.width + 2, self.circleBlue.frame.size.height + 2);
    }else{
        
         self.circleBlue.frame = CGRectMake( self.circleBlue.frame.origin.x, self.circleBlue.frame.origin.y , self.circleBlue.frame.size.width + 2, self.circleBlue.frame.size.height + 2);
    }
    
    
    self.circleBlue.alpha = self.circleBlue.alpha - .01;
    self.circleBlue.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height/2);
    self.circleBlue.layer.cornerRadius = self.circleBlue.frame.size.height/2;

    
    
    if (self.circleBlue.alpha <=.01) {
        [self.blueTimer invalidate];
        self.launch = false;
        
    }

}

-(void)heartMovemnet{
 
    NSLog(@"heart:%f,%f,%i",self.heart.frame.size.height,self.heart.frame.size.width,self.heartCounter);
    
    if (self.growing2 == false) {
        
    
    if (self.heart.frame.size.height == 123) {
        self.growing = true;
        
        
    }else if (self.heart.frame.size.height == 100){
        self.growing = false;
        self.heartCounter++;
    }
    
    
    if (self.heartCounter >= 2) {
        self.heartCounter++;
        
        
        
    }else{
        
        if (self.growing==false) {
            
            self.heart.frame = CGRectMake( self.heart.frame.origin.x, self.heart.frame.origin.y , self.heart.frame.size.width + .5, self.heart.frame.size.height + .5);
        }else{
            
            self.heart.frame = CGRectMake( self.heart.frame.origin.x, self.heart.frame.origin.y , self.heart.frame.size.width - .5, self.heart.frame.size.height - .5);
        }
        
    }
    }else {
         if (self.view.bounds.size.width == 414){
              self.heart.frame = CGRectMake( self.heart.frame.origin.x, self.heart.frame.origin.y , self.heart.frame.size.width + 55, self.heart.frame.size.height  + 55);
         }else{
        self.heart.frame = CGRectMake( self.heart.frame.origin.x, self.heart.frame.origin.y , self.heart.frame.size.width + 25, self.heart.frame.size.height  + 25);
             self.time = .005;}
    }
    
    
    if (self.view.bounds.size.width == 414){
        if (self.heart.frame.size.height - 1600 >= self.view.frame.size.height) {
            [self.whiteTimer invalidate];
            [self.blueTimer invalidate];
            [self.heartTimer invalidate];
            [self performSegueWithIdentifier:@"login2" sender:self];
            
        }
    
    }else{
    
    if (self.heart.frame.size.height - 1200 >= self.view.frame.size.height) {
        [self.whiteTimer invalidate];
        [self.blueTimer invalidate];
        [self.heartTimer invalidate];
        [self performSegueWithIdentifier:@"login2" sender:self];
        
    }}
     self.heart.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height/2);
}

@end
