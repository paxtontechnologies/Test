//
//  GotMatchViewController.m
//  Halp
//
//  Created by John Silvester on 12/30/14.
//  Copyright (c) 2014 PaxtonTechnologies. All rights reserved.
//

#import "GotMatchViewController.h"
#import "SetMatch.h"

@interface GotMatchViewController ()

@end

@implementation GotMatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)talkTothem:(id)sender {
    SetMatch *matchsetup = [[SetMatch alloc]init];
    [matchsetup MakeConversation];
    
}
@end
