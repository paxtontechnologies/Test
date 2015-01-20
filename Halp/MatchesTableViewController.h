//
//  MatchesTableViewController.h
//  Halp
//
//  Created by John Silvester on 12/24/14.
//  Copyright (c) 2014 PaxtonTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface MatchesTableViewController : UITableViewController
@property (strong,nonatomic) NSMutableArray *Conversation;
@property(nonatomic) int counter;
@end
