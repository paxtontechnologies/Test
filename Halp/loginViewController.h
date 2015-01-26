//
//  loginViewController.h
//  Halp
//
//  Created by John Silvester on 12/24/14.
//  Copyright (c) 2014 PaxtonTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *circleWhite;
@property (strong, nonatomic) IBOutlet UILabel *circleBlue;
@property (strong, nonatomic) IBOutlet UIImageView *heart;



-(void)loginuser;

@property(strong,nonatomic) NSTimer *whiteTimer;
@property(nonatomic) int whiteCounter;

@property(strong,nonatomic) NSTimer *blueTimer;
@property(nonatomic) int blueCounter;

@property(strong,nonatomic) NSTimer *heartTimer;
@property(nonatomic) int heartCounter;
@property(nonatomic) double time;

@property(nonatomic) BOOL switch_off;
@property(nonatomic) BOOL launch;
@property(nonatomic) BOOL growing;
@property(nonatomic) BOOL growing2;

@property(nonatomic) int random;


@end
