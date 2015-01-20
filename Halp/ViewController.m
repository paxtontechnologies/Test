//
//  ViewController.m
//  Halp
//
//  Created by John Silvester on 12/23/14.
//  Copyright (c) 2014 PaxtonTechnologies. All rights reserved.
//

#import "ViewController.h"
#import "InfoViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self screenSize];
    
    UIImage *image = [UIImage imageNamed: @"logo.png"];
    UIImageView *imageview = [[UIImageView alloc] initWithImage: image];
    
    // set the text view to the image view
    self.navigationItem.titleView = imageview;
    
    self.tabBarItem.selectedImage = [[UIImage imageNamed:@"plus"]
                                     imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.tabBarItem.image = [[UIImage imageNamed:@"plus"]
                             imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    [[UIView appearanceWhenContainedIn:[UITabBar class], nil] setTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor blackColor]];
}


- (IBAction)LookingButton:(id)sender {
    
    self.animateup = [NSTimer scheduledTimerWithTimeInterval:.0003 target:self selector:@selector(animationup) userInfo:nil repeats:YES];
    self.isLooking = true;
    
    [self slideTabbar];
    
    
}


- (IBAction)HelpingButton:(id)sender {
    self.animateDown = [NSTimer scheduledTimerWithTimeInterval:.0003 target:self selector:@selector(animationdown) userInfo:nil repeats:YES];
    [self slideTabbar];
}

#pragma mark - timer functions
-(void)slideTabbar{
    static BOOL isShowing = YES;
    
    CGRect tabBarFrame = self.tabBarController.tabBar.frame;
    
    if (isShowing) {
        tabBarFrame.origin.y += tabBarFrame.size.height;
    }
    else {
        tabBarFrame.origin.y -= tabBarFrame.size.height;
    }
    
    isShowing = !isShowing;
    
    [UIView animateWithDuration:0.3 animations:^ {
        [self.tabBarController.tabBar setFrame:tabBarFrame];
    }];
    
}

-(void)animationup{
     self.spacerView.hidden = YES;
    if (self.CounterUp >= 684) {
        [self.animateup invalidate];
        self.CounterUp = 0;
        [self performSegueWithIdentifier:@"next" sender:self];
    }

    if (self.CounterUp<=284) {
        self.lookbutton.frame = CGRectMake(self.lookbutton.frame.origin.x , self.lookbutton.frame.origin.y - .75, self.lookbutton.frame.size.width, self.lookbutton.frame.size.height);
        self.lookingText.center = CGPointMake(self.lookingText.center.x, self.lookingText.center.y - .75);

        self.helpButton.frame = CGRectMake(self.helpButton.frame.origin.x, self.helpButton.frame.origin.y - 1, self.helpButton.frame.size.width, self.helpButton.frame.size.height);
        self.helpingText.center = CGPointMake(self.helpingText.center.x, self.helpingText.center.y - 1);
        self.tableView.center = CGPointMake(self.tableView.center.x, self.tableView.center.y - .73);
        NSLog(@"%f",self.tableView.center.y);
    }
    
    
    self.CounterUp++;
}
-(void)animationdown{
    self.spacerView.hidden = YES;
    if (self.CounterDown >= 684) {
        [self.animateDown invalidate];
        self.CounterDown = 0;
        [self performSegueWithIdentifier:@"next" sender:self];
    }
    
    if (self.CounterDown<=284) {
        self.lookbutton.frame = CGRectMake(self.lookbutton.frame.origin.x , self.lookbutton.frame.origin.y + .75, self.lookbutton.frame.size.width, self.lookbutton.frame.size.height);
        self.lookingText.center = CGPointMake(self.lookingText.center.x, self.lookingText.center.y + .75);
         self.tableView.center = CGPointMake(self.tableView.center.x, self.tableView.center.y - .75);
        
        
        
    }
    self.CounterDown++;
   
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    InfoViewController *nextView = segue.destinationViewController;
    nextView.is_Looking = self.isLooking;
    NSLog(@"%f",self.lookbutton.center.y);
}
-(void)screenSize{
    if (self.view.bounds.size.height == 480) {
        self.lookbutton.center = CGPointMake(self.lookbutton.center.x, self.lookbutton.center.y - 65);
        self.helpButton.center = CGPointMake(self.helpButton.center.x, self.helpButton.center.y - 65);
        self.spacerView.center = CGPointMake(self.spacerView.center.x, self.spacerView.center.y - 65);

    }
}
@end
