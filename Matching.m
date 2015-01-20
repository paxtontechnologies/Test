//
//  Matching.m
//  Halp
//
//  Created by John Silvester on 12/27/14.
//  Copyright (c) 2014 PaxtonTechnologies. All rights reserved.
//

#import "Matching.h"
#import <Parse/Parse.h>

@implementation Matching

-(void)addStringToarray: (NSString *)text  :(NSString *)nameofchat{
    
    PFQuery *queryConversation = [PFQuery queryWithClassName:@"Conversations"];
    [queryConversation whereKey:@"Channel" equalTo:nameofchat];
    NSArray *conversationInArray = [queryConversation findObjects];
    if (conversationInArray.count != 0) {
       
        //Update array and send it back replacing the previous
        PFQuery *query = [PFQuery queryWithClassName:@"Conversations"];
        // Retrieve the object by id
        [query getObjectInBackgroundWithId:[[conversationInArray objectAtIndex:0]objectId] block:^(PFObject *object, NSError *error) {
            // Now let's update it with some new data. In this case, only cheatMode and score
            // will get sent to the cloud. playerName hasn't changed.
            NSMutableArray *arrayNew = [[NSMutableArray alloc]initWithArray:[[conversationInArray objectAtIndex:0]objectForKey:@"Conversation" ]copyItems:YES];
            [arrayNew addObject:text];
            NSMutableArray *arrayNewU = [[NSMutableArray alloc]initWithArray:[[conversationInArray objectAtIndex:0]objectForKey:@"Sides" ]copyItems:YES];
            [arrayNewU addObject:[[PFUser currentUser]username]];
            object[@"Conversation"] = arrayNew;
            object[@"Sides"] = arrayNewU;
            [object saveEventually];
            [self sendNotifcation:text channel:nameofchat];
        }];

        
    }else{
        [self newConversation:text :nameofchat];
        
        
    }
    
    
    
    
    
   
}
-(void)newConversation: (NSString *)text  :(NSString *)nameofchat{
    
    PFObject *newConversation = [PFObject objectWithClassName:@"Conversations"];
    NSMutableArray *conversation = [[NSMutableArray alloc]initWithObjects:text, nil];
    NSMutableArray *side = [[NSMutableArray alloc]initWithObjects:[[PFUser currentUser]username], nil];
    newConversation[@"Conversation"] = conversation;
    newConversation[@"Channel"] = nameofchat;
    newConversation[@"Sides"] = side;
    [newConversation saveEventually];
    [self sendNotifcation:text channel:nameofchat];
    
}
-(void)sendNotifcation: (NSString *)message  channel:(NSString *)channel{
    PFQuery *innerQuery = [PFUser query];
    
    // Use hasPrefix: to only match against the month/date
    [innerQuery whereKey:@"username" equalTo:[self stringsTocheck:channel]];
    
    // Build the actual push notification target query
    
    

    // only return Installations that belong to a User that
    // matches the innerQuery
    PFQuery *pushQuery = [PFInstallation query];
    NSString *matching = [[self stringsTocheck:channel] substringFromIndex:1];
    [pushQuery whereKey:@"User" equalTo:matching];
    // Send the notification.
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"New Message", @"alert",
                          @"cheering.caf", @"sound",
                          nil];
    PFPush *push = [[PFPush alloc] init];
    [push setQuery:pushQuery];
    [push setData:data];
    [push sendPushInBackground];

}
-(NSString *)stringsTocheck :(NSString *)channel{
    NSString *stringone = [NSString stringWithFormat:@"%@.",channel];
    NSString *stringtwo = [NSString stringWithFormat:@".%@",channel];
    
    NSString *newString =  [self getSubstring:stringone betweenString:@"."];
    NSString *newstring2 = [self getSubstring:stringtwo betweenString:@"."];
    
    [[NSUserDefaults standardUserDefaults]setObject:newString forKey:@"1"];
    [[NSUserDefaults standardUserDefaults]setObject:newstring2 forKey:@"2"];
    if ([newString isEqual:[[PFUser currentUser]username]]) {
       
        return newString;
        
    }else{
        
        return newstring2;
        
    }
    
}
-(NSString *)stringsTocheck2 :(NSString *)channel{
    NSString *stringone = [NSString stringWithFormat:@"%@.",channel];
    NSString *stringtwo = [NSString stringWithFormat:@".%@",channel];
    
    NSString *newString =  [self getSubstring:stringone betweenString:@"."];
    NSString *newstring2 = [self getSubstring:stringtwo betweenString:@"."];
    
    [[NSUserDefaults standardUserDefaults]setObject:newString forKey:@"1"];
    [[NSUserDefaults standardUserDefaults]setObject:newstring2 forKey:@"2"];
    if ([newString isEqual:[[PFUser currentUser]username]]) {
        
        return newstring2;
        
    }else{
        
        return newString;
        
    }
    
}
- (NSString *)getSubstring:(NSString *)value betweenString:(NSString *)separator
{
    NSRange firstInstance = [value rangeOfString:separator];
    NSRange secondInstance = [[value substringFromIndex:firstInstance.location + firstInstance.length] rangeOfString:separator];
    NSRange finalRange = NSMakeRange(firstInstance.location + separator.length, secondInstance.location);
    
    return [value substringWithRange:finalRange];
}
-(void)counter :(NSString *)channel{
    
   
    NSNumber *counter = [[NSUserDefaults standardUserDefaults]objectForKey:@"counter"];
    int number = [counter intValue];
    number++;
    counter = [NSNumber numberWithInt:number];
    
    
    NSString *firstname =[[NSUserDefaults standardUserDefaults]stringForKey:@"1"];
    NSString *secondname =[[NSUserDefaults standardUserDefaults]stringForKey:@"2"];
 
    
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query whereKey:@"username" equalTo:firstname];
    NSArray *value = [query findObjects];
    
    
    if (value.count > 0) {
        
        NSNumber *number =[[value objectAtIndex:0]objectForKey:@"Counter"];
        int valuee = [number intValue];
        number = [NSNumber numberWithInt:valuee + 1];
        NSString *objectid = [[value objectAtIndex:0]objectId];
      
        [query getObjectInBackgroundWithId:objectid block:^(PFObject *user, NSError *error) {
            NSLog(@"after %@",number);
            // Now let's update it with some new data. In this case, only cheatMode and score
            // will get sent to the cloud. playerName hasn't changed.
            user[@"Counter"] = number;
            [user saveInBackground];
           
            
        }];
    }
    
    PFQuery *query2 = [PFQuery queryWithClassName:@"_User"];
    [query2 whereKey:@"username" equalTo:secondname];
    NSArray *value2 = [query2 findObjects];
    
    if (value2.count > 0) {
        NSNumber *number2 =[[value2 objectAtIndex:0]objectForKey:@"Counter"];
        
        int valuee2 = [number2 intValue];
        number2 = [NSNumber numberWithInt:valuee2 + 1];
        NSString *objectid = [[value2 objectAtIndex:0]objectId];
        [query2 getObjectInBackgroundWithId:objectid block:^(PFObject *user, NSError *error) {
            NSLog(@"after %@",number2);
            // Now let's update it with some new data. In this case, only cheatMode and score
            // will get sent to the cloud. playerName hasn't changed.
            user[@"Counter"] = number2;
           
            [user saveInBackground];
            
        }];
    }

    
    
    
    
    
    
    
    
    
   
}


@end
