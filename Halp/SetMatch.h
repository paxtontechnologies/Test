//
//  SetMatch.h
//  Halp
//
//  Created by John Silvester on 12/29/14.
//  Copyright (c) 2014 PaxtonTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface SetMatch : NSObject

-(int)getMatches: (NSString *)username : (NSArray *)chosenNumbers :(NSNumber *)islooking;

-(void)MakeConversation;
-(NSArray *)queryForUser;

-(void)makeAnimation :(int)duration View:(UIView *)view;


@property(strong,nonatomic) UIImageView *smiley;


@property(strong,nonatomic) NSTimer *timer;
@property(nonatomic) int counter;
@property(nonatomic) int checker;
@property(nonatomic) int degrees;
@property(nonatomic) int waitCounter;



@end
