//
//  PVCPagesViewController.h
//  PageViewController
//
//  Created by Jay Chulani on 10/26/13.
//  Copyright (c) 2013 Jay Chulani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PVCPagesViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
- (void)changePage:(id)sender;


@property(strong,nonatomic) UILabel *notprofessional;

@property(strong,nonatomic) UILabel *swipe;

@property(strong,nonatomic) NSTimer *animation;

@property(strong,nonatomic) NSTimer *page1timer;
@property(nonatomic) int counterfirst;

@property(strong,nonatomic ) UIImageView *image;
@property(strong,nonatomic ) UIImageView *image2;
@property(nonatomic) int counter;

@property(nonatomic) int wtf;

@property(strong,nonatomic) UIButton *Okay;

@property(strong,nonatomic) UILabel *label1;
@property(strong,nonatomic) UILabel *label2;
@property(strong,nonatomic) UILabel *label3;
@end
