//
//  Matching.h
//  Halp
//
//  Created by John Silvester on 12/27/14.
//  Copyright (c) 2014 PaxtonTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Matching : NSObject

@property (strong, nonatomic) NSMutableArray *currentConversation;
@property (strong, nonatomic) NSString *addedText;



-(void)addStringToarray: (NSString *)text  :(NSString *)nameofchat;
-(void)counter :(NSString *)channel;
-(NSString *)stringsTocheck2 :(NSString *)channel;

@end
