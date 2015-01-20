//
//  ChatViewController.h
//  Halp
//
//  Created by John Silvester on 12/24/14.
//  Copyright (c) 2014 PaxtonTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UIView *typingview;
@property (strong, nonatomic) IBOutlet UITextField *textfield;
@property (strong, nonatomic) IBOutlet UIButton *sendbutton;
@property (strong, nonatomic) IBOutlet UITableView *tableview2;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *menu_pressedNew;

- (IBAction)menu:(id)sender;
@property(strong, nonatomic) NSTimer *moveup;
@property(strong, nonatomic) NSTimer *movedown;
@property(strong, nonatomic) NSTimer *Timer;


@property(strong, nonatomic) NSString *Channel;
@property (nonatomic) BOOL shouldScrollToLastRow;
@property (nonatomic) BOOL scrolled;

@property(nonatomic)int counter1;
@property(nonatomic)int counter2;
@property(nonatomic)int duration;
@property(nonatomic)double seconds;

@property(nonatomic)double width;
@property(nonatomic)double height;

@property(strong, nonatomic) NSMutableArray *conversation;
@property(strong, nonatomic) NSMutableArray *side;
- (IBAction)typing:(id)sender;

- (IBAction)Send:(id)sender;
- (IBAction)Menu:(id)sender;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *pgr;


@property(nonatomic)BOOL isMenuDown;
@property(nonatomic)BOOL isfirst;

@property(strong,nonatomic) UIView *messageView;

@end
