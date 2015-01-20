//
//  lookingViewController.h
//  Halp
//
//  Created by John Silvester on 12/24/14.
//  Copyright (c) 2014 PaxtonTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface lookingViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *bigsmiley;
@property (nonatomic) BOOL islooking;
@property (nonatomic) BOOL isshown;
@property (nonatomic) int degrees;
@property (nonatomic) int finished;
@property (nonatomic) int counter;
@property (strong,nonatomic) NSTimer *spinningTimer;
@property (nonatomic) int counterfortimer;
@property (strong, nonatomic) NSArray *numbersChosen;
@property (strong,nonatomic) NSNumber *isLooking;

@end
