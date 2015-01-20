//
//  UserViewController.h
//  Halp
//
//  Created by John Silvester on 12/28/14.
//  Copyright (c) 2014 PaxtonTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *buttonGuy;
@property (strong, nonatomic) IBOutlet UIButton *buttonGirl;
- (IBAction)guyPressed:(id)sender;
- (IBAction)girlPressed:(id)sender;

@property(strong,nonatomic) NSTimer *timerup;
@property(strong,nonatomic) NSTimer *timerside;

@property(strong,nonatomic) NSTimer *heartimer;
@property(strong,nonatomic) NSTimer *counterTimer;
@property(nonatomic) int counter4;
@property(nonatomic) int counter1;
@property(nonatomic) int counter2;
@property(nonatomic) int counter3;
@property (nonatomic, strong) NSArray *matches;
@property (strong, nonatomic) IBOutlet UIImageView *heartView;
@property (strong, nonatomic) IBOutlet UILabel *KarmaScore;

@property(nonatomic) BOOL isGirl;
@property (strong, nonatomic) IBOutlet UILabel *number;
@property (strong, nonatomic) IBOutlet UIView *othercounterView;
@property (strong, nonatomic) IBOutlet UILabel *numberofcon;

@property (strong, nonatomic) IBOutlet UILabel *OverallKarm;
@property (strong, nonatomic) IBOutlet UILabel *rangAmongFriends;
@property (strong, nonatomic) IBOutlet UILabel *rankamountfriendsnum;

@property (strong, nonatomic) IBOutlet UILabel *overallkarmnumber;




@end
