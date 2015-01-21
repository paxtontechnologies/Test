//
//  lookingViewController.m
//  Halp
//
//  Created by John Silvester on 12/24/14.
//  Copyright (c) 2014 PaxtonTechnologies. All rights reserved.
//

#import "lookingViewController.h"
#import "SetMatch.h"

@interface lookingViewController ()<UIAlertViewDelegate>

@end

@implementation lookingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.islooking == false) {
        self.bigsmiley.image = [UIImage imageNamed:@"bighelping"];
    }
    self.numbersChosen = [[NSArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults]arrayForKey:@"Selection"] copyItems:YES ];
    NSLog(@"KEYSelection: %@",[[NSUserDefaults standardUserDefaults]arrayForKey:@"Selection"]);
    SetMatch *match = [[SetMatch alloc]init];
    NSLog(@"%lu",(unsigned long)self.numbersChosen.count);
    self.finished = [match getMatches:[[PFUser currentUser]username] :self.numbersChosen :self.isLooking];
     self.bigsmiley.frame = CGRectMake(1, 1, 100, 100);
    self.bigsmiley.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/4);
   
    
   
    self.spinningTimer = [NSTimer scheduledTimerWithTimeInterval:.0025 target:self selector:@selector(startSpinning) userInfo:nil repeats:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - animations
-(void)startSpinning {
    self.degrees = (self.degrees + 1) % 360;
        //[UIView beginAnimations:nil context:NULL];
        //[UIView setAnimationDuration:5];
        self.bigsmiley.center=CGPointMake(self.bigsmiley.center.x + .5, self.bigsmiley.center.y);
        self.bigsmiley.transform = CGAffineTransformMakeRotation( self.degrees / 180.0 * 3.14 );
    
    if (self.bigsmiley.center.x > self.view.bounds.size.width + 250) {
        self.bigsmiley.center =CGPointMake(self.view.bounds.size.width - 400, self.bigsmiley.center.y);
    }
    
    
       // [UIView commitAnimations];
    self.counterfortimer++;
    
    if (self.counter > 1250) {
    
    if (self.finished == 100) {
        [self.spinningTimer invalidate];
        [self performSegueWithIdentifier:@"match" sender:self];
    }
    if (self.finished == 110) {
        UIAlertView *mes=[[UIAlertView alloc] initWithTitle:@"Sorry!"
                                                    message:@"Looks like no one is avaible right now, we'll let you know as soon as someone is!" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        UIImageView *smile = [[UIImageView alloc]initWithFrame:CGRectMake(10, 50, 32.2, 32.2)];
        smile.image = [UIImage imageNamed:@"smallsmileb"];
        smile.contentMode = UIViewContentModeScaleToFill;
        [mes addSubview:smile];
        
        if (_isshown == false) {
             [mes show];
            _isshown = true;
        }
       
       
    }
    
    }
    
    self.counter++;
    
    
    if (self.counter == 10000) {
         [self performSegueWithIdentifier:@"upload" sender:self];
    }
    
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // the user clicked OK
    if (buttonIndex == 0) {
        // do something here...
        [self.spinningTimer invalidate];
        [self performSegueWithIdentifier:@"upload" sender:self];
        
    }
}


@end
