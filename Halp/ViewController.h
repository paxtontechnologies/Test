//
//  ViewController.h
//  Halp
//
//  Created by John Silvester on 12/23/14.
//  Copyright (c) 2014 PaxtonTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *helpButton;
@property (strong, nonatomic) IBOutlet UIButton *lookbutton;
@property (strong, nonatomic) IBOutlet UIImageView *spacerView;
@property (strong, nonatomic) IBOutlet UIView *totalView;

@property (strong, nonatomic) NSTimer *animateup;
@property (strong, nonatomic) NSTimer *animateDown;

@property (nonatomic) int CounterDown;
@property (nonatomic) int CounterUp;

@property (nonatomic) BOOL isLooking;

- (IBAction)LookingButton:(id)sender;
- (IBAction)HelpingButton:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lookingText;
@property (strong, nonatomic) IBOutlet UILabel *helpingText;
@property (strong, nonatomic) IBOutlet UILabel *tableView;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
- (IBAction)back:(id)sender;

@end

