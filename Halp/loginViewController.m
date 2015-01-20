//
//  loginViewController.m
//  Halp
//
//  Created by John Silvester on 12/24/14.
//  Copyright (c) 2014 PaxtonTechnologies. All rights reserved.
//

#import "loginViewController.h"
#import <Parse/Parse.h>

@interface loginViewController ()

@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loginuser];
    NSLog(@"%@",[[PFUser currentUser]username ]);
    // Do any additional setup after loading the view.
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
                [self performSegueWithIdentifier:@"login2" sender:self];
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
            [[NSUserDefaults standardUserDefaults]setObject:@1 forKey:@"log"];
            [self performSegueWithIdentifier:@"login" sender:self];
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


@end
