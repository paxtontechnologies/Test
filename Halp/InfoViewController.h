//
//  InfoViewController.h
//  Halp
//
//  Created by John Silvester on 12/23/14.
//  Copyright (c) 2014 PaxtonTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *buttonView;
@property (nonatomic) int is_Looking;
@property (nonatomic) int smiley;
@property (nonatomic) BOOL nextButtonisViewable;
@property (nonatomic) BOOL allowsSelection;
@property (nonatomic) BOOL moveSet;
@property (strong, nonatomic) NSMutableArray *smileyPressed;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong ,nonatomic) NSMutableArray *array;
@property (strong, nonatomic) IBOutlet UILabel *nextTitle;

@property (strong, nonatomic) IBOutlet UIButton *nextButton;
- (IBAction)nextPushed:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *textTop;

@property (strong, nonatomic) IBOutlet UILabel *textBottom;
@property (strong, nonatomic) IBOutlet UIImageView *lookingText;
@property (strong, nonatomic) IBOutlet UIImageView *HelpingText;
@property (nonatomic) int touches;
@property (nonatomic) int count;
@property (nonatomic) int size;

@property(nonatomic) CGPoint lastContentOffset;
@end
