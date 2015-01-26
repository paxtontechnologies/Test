//
//  SetMatch.m
//  Halp
//
//  Created by John Silvester on 12/29/14.
//  Copyright (c) 2014 PaxtonTechnologies. All rights reserved.
//

#import "SetMatch.h"
#import "Matching.h"

@implementation SetMatch

-(int)getMatches: (NSString *)username : (NSArray *)chosenNumbers :(NSNumber *)islooking{
    //starts looking for matches
       NSLog(@"USER:%@ Numb:%@ Looking:%@",username,chosenNumbers,islooking);
    NSArray *Matches = [[NSArray alloc]init];
    NSNumber *opositeNumber;
    //sets opposite
    if ([islooking  isEqual: @1]) {
        NSLog(@"Looking");
        opositeNumber = @0;
    }else{
         NSLog(@"Looking!!!!");
        opositeNumber = @1;
    }

    int x = 0;
    while (x < chosenNumbers.count) {
        
        PFQuery *query = [PFQuery queryWithClassName:@"Matching"];
        NSString *chosenOption = [chosenNumbers objectAtIndex:x];
        [query whereKey:@"Choice" equalTo:chosenOption];
        Matches = [query findObjects];
        //checks to see if there is a match
       
       
        //checks if matches came back
        if (Matches.count > 0 ) {
            NSLog(@"MAtch");
           
            //checks if match is the person looking
            if (![[[Matches objectAtIndex:x] objectForKey:@"User"] isEqual: [[PFUser currentUser]username]]) {
                
            
            
            NSLog(@"HERE>?>?4");
            //checks if the match is opposite
                NSLog(@"DD%@",[[Matches objectAtIndex:x] objectForKey:@"Looking"] );
            if (![[[Matches objectAtIndex:x] objectForKey:@"Looking"] isEqualToNumber:opositeNumber]) {
                // if its equal
                NSLog(@"ere");
                
              
                
                [self upload:chosenNumbers :islooking];
                
                return 110;
            } else{
                
                [[NSUserDefaults standardUserDefaults]setObject:islooking forKey:@"matchlooking"];
                [[NSUserDefaults standardUserDefaults]setObject:chosenOption forKey:@"chosenoption"];
                username =[[Matches objectAtIndex:0]objectForKey:@"User"];
                [[NSUserDefaults standardUserDefaults]setValue:username forKey:@"matchup"];
                NSLog(@"User: %@",username);
                [[NSUserDefaults standardUserDefaults]setObject:username forKey:@"1"];
                
                [[Matches objectAtIndex:0]deleteEventually];
                return 100;
                
            
        }
            }
        }else if(Matches.count == 0){
            [self upload:chosenNumbers :islooking];
            return 110;
        }
        x++;
    }
    NSLog(@"%lu matches",(unsigned long)Matches.count);
   
    [self upload:chosenNumbers :islooking];
    return 110;
    
    
}
-(void)upload: (NSArray *)chosennumber :(NSNumber *)Looking{
        int x = 0;
    NSLog(@"CounteR: %lu",(unsigned long)chosennumber.count);
    while (x < chosennumber.count) {
        NSLog(@"HERE2");
        PFObject *object = [PFObject objectWithClassName:@"Matching"];
        object[@"Choice"] = [chosennumber objectAtIndex:x];
        object[@"Looking"] = Looking;
        object[@"User"] = [[PFUser currentUser] username];
        [object saveEventually];
        NSLog(@"Saved");
        x++;
    }
    
}

-(void)MakeConversation{
    
    PFObject *newConversation = [PFObject objectWithClassName:@"Conversations"];
    NSString *otherUser = [[NSUserDefaults standardUserDefaults]stringForKey:@"matchup"];
    NSLog(@"Cahnnel: other %@",otherUser);
    NSString *channel = [NSString stringWithFormat:@"%@.%@",[[PFUser currentUser]username],otherUser];
    NSLog(@"%@",channel);
    newConversation[@"Channel"] = [NSString stringWithFormat:@"%@.%@",[[PFUser currentUser]username],otherUser];
    NSArray *emptyarray = [[NSArray alloc]init];
    newConversation[@"Conversation"] = emptyarray;
    
    NSNumber *number = [[NSUserDefaults standardUserDefaults]objectForKey:@"matchlooking"];
    if ([number  isEqual: @1]) {
        newConversation[@"Looking"] = [[PFUser currentUser]username];
    }else{
        
        newConversation[@"Looking"] = otherUser;
    }
    
   newConversation[@"Topic"] = [[NSUserDefaults standardUserDefaults]objectForKey:@"chosenoption"];

    [newConversation saveEventually];
    Matching *matches = [[Matching alloc]init];
       [matches counter:[NSString stringWithFormat:@"%@.%@",[[PFUser currentUser]username],otherUser]];
}

-(NSArray *)queryForUser{
    NSString *nameFirst = [NSString stringWithFormat:@".%@",[[PFUser currentUser]username]];
       NSString *nameSecond = [NSString stringWithFormat:@"%@.",[[PFUser currentUser]username]];
    NSMutableArray *conversationTotal = [[NSMutableArray alloc]init];
    
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"Conversations"];
    [query whereKey:@"Channel" containsString:nameFirst];
    NSArray *firstConSet = [query findObjects];
   
    if (firstConSet.count != 0) {
        
            [conversationTotal addObjectsFromArray:firstConSet];
        
    }
    
    PFQuery *query2 = [PFQuery queryWithClassName:@"Conversations"];
    [query2 whereKey:@"Channel" containsString:nameSecond];
    NSArray *secondConset = [query2 findObjects];
    if (secondConset.count != 0) {
       
        [conversationTotal addObjectsFromArray:secondConset];
        
    }
   
    NSArray *array = [[NSArray alloc]initWithArray:conversationTotal];
    
    return array;
}


-(void)makeAnimation :(int)duration View:(UIView *)view{
   
    UIView *darkview = [[UIView alloc]initWithFrame:CGRectMake(0, (view.bounds.size.height /2) - 100, view.bounds.size.width, 200)];
    darkview.backgroundColor = [UIColor blackColor];
    darkview.alpha = .5f;
    
    
    self.smiley = [[UIImageView alloc]initWithFrame:CGRectMake((view.bounds.size.width /2) - 100, 50, 100, 100)];
    _smiley.image = [UIImage imageNamed:@"animationsmile"];
    
    [view addSubview:darkview];
    [darkview addSubview:_smiley];
      self.checker = duration + 40;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:.0001 target:self selector:@selector(timerForAni) userInfo:nil repeats:YES];
    

    
}

-(void)timerForAni{
    
    
    
    if (self.counter>self.checker) {
        [self.timer invalidate];
    }
    
  //  self.smiley.frame = CGRectMake(self.smiley.frame.origin.x , self.smiley.frame.origin.y, 100, 100);
    self.smiley.center = CGPointMake(self.smiley.center.x +.5933333, self.smiley.center.y);
     self.degrees = (self.degrees + 1) % 360;
    self.smiley.transform = CGAffineTransformMakeRotation( self.degrees / 180.0 * 3.14 );
    
    if (self.smiley.center.x == 210) {
        
        self.waitCounter++;
        if (self.waitCounter > 100) {
            self.smiley.center = CGPointMake(self.smiley.center.x +1, self.smiley.center.y);
        
        }}else{
        self.counter++;
    }
    
    
    if (self.smiley.frame.origin.x > 320) {
        self.smiley.frame = CGRectMake(-100, self.smiley.frame.origin.y, 100, 100);
    }
    
    
    
}




@end
