//
//  PVCPagesViewController.m
//  PageViewController
//
//  Created by Jay Chulani on 10/26/13.
//  Copyright (c) 2013 Jay Chulani. All rights reserved.
//

#import "PVCPagesViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "loginViewController.h"
#import <Parse/Parse.h>

@interface PVCPagesViewController () {
    NSArray *pages;
}

@property (retain, nonatomic) NSArray *pages;
@property (strong, nonatomic) UIPageViewController *pageController;


@end

@implementation PVCPagesViewController


-(void)viewDidAppear:(BOOL)animated{
 self.page1timer = [NSTimer scheduledTimerWithTimeInterval:.05 target:self selector:@selector(firstpageAni) userInfo:nil repeats:YES];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[[PFUser currentUser]username] length] == 0) {
        loginViewController *login = [[loginViewController alloc]init];
        [login loginuser];
    }
    
    
	// Do any additional setup after loading the view.
    _pageControl.center = CGPointMake(self.view.frame.size.width /2, self.view.frame.size.height /1.1 );
    _pageController.delegate = self;
    // instantiate the view controlles from the storyboard
    UIViewController *page1 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"page1"];
    self.image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"banner"]];
    self.image.center = CGPointMake(self.view.frame.size.width /2, self.view.frame.size.height /4 );
    _image.alpha = 0;
    [page1.view addSubview:self.image];
    _image2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"heart"]];
    _image2.center = CGPointMake(self.view.frame.size.width /2, self.view.frame.size.height /2 );
    _image2.alpha = 0;
    [page1.view addSubview:_image2];
  
    _swipe = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
    _swipe.font = [UIFont fontWithName:@"Avenir-Light" size:20];
    _swipe.textColor = [UIColor whiteColor];
    _swipe.textAlignment = NSTextAlignmentCenter;
    _swipe.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height /1.2);
    _swipe.text = @"Swipe to start!";
    _swipe.alpha = 0;
    [page1.view addSubview:_swipe];
    

    UIViewController *page2 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"page2"];
    page2.view.tag = 2;
    [self addview:page2.view];

    UIViewController *page3 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"page3"];
     page3.view.tag = 3;
[self addview:page3.view];
    UIViewController *page4 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"page4"];
     page4.view.tag = 4;
    [self addview:page4.view];
    
    UIViewController *page5 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"page5"];
    self.Okay = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.Okay.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height /1.5);
    [self.Okay setTitle:@"Okay" forState:UIControlStateNormal];
    self.Okay.titleLabel.font =  [UIFont fontWithName:@"Avenir-Light" size:25];
    self.Okay.titleLabel.textColor = [UIColor whiteColor];
    self.Okay.layer.cornerRadius = self.Okay.frame.size.height/2;
    self.Okay.layer.borderWidth = 2;
  [self.Okay addTarget:self action:@selector(startApp:) forControlEvents:UIControlEventTouchUpInside];
    [page5.view addSubview:self.Okay];
    
    
    
    self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
    self.label1.numberOfLines = 100;
    self.label1.textColor = [UIColor whiteColor];
    self.label1.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height /3);
    self.label1.text = @"This is not a crisis hotline.\n If you feel your life is in danger please visit\ndosomething.org for help.";
    self.label1.font =  [UIFont fontWithName:@"Avenir-Light" size:16];
       self.label1.textAlignment = NSTextAlignmentCenter;
    [page5.view addSubview:self.label1];
    
    self.label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
    self.label2.numberOfLines = 100;
    self.label2.textColor = [UIColor whiteColor];
    self.label2.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height /6);
    self.label2.text = @"One More Thing";
    self.label2.textAlignment = NSTextAlignmentCenter;
    self.label2.font =  [UIFont fontWithName:@"Avenir-Light" size:30];
     [page5.view addSubview:self.label2];
    // load the view controllers in our pages array
    self.pages = [[NSArray alloc] initWithObjects:page1, page2, page3, page4, page5, nil];

    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    [self.pageController setDelegate:self];
    [self.pageController setDataSource:self];

    [[self.pageController view] setFrame:[[self view] bounds]];
    NSArray *viewControllers = [NSArray arrayWithObject:[self.pages objectAtIndex:0]];
    [self.pageControl setCurrentPage:0];
    [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];

   
    
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    
    [self.view addSubview:self.pageControl];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
    
    [self.view sendSubviewToBack:[self.pageController view]];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger currentIndex = [self.pages indexOfObject:viewController];    // get the index of the current view controller on display
    
    [self.pageControl setCurrentPage:self.pageControl.currentPage+1];                   // move the pageControl indicator to the next page
    
    // check if we are at the end and decide if we need to present the next viewcontroller
    if ( currentIndex < [self.pages count]-1) {
      
    
        
        return [self.pages objectAtIndex:currentIndex+1];                   // return the next view controller
    } else {
        return nil;                                                         // do nothing
    }
}


- (UIViewController *) pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger currentIndex = [self.pages indexOfObject:viewController];    // get the index of the current view controller on display
    [self.pageControl setCurrentPage:self.pageControl.currentPage-1];                   // move the pageControl indicator to the next page

    // check if we are at the beginning and decide if we need to present the previous viewcontroller
    if ( currentIndex > 0) {
        return [self.pages objectAtIndex:currentIndex-1];                   // return the previous viewcontroller
    } else {
        return nil;                                                         // do nothing
    }
}

- (void)changePage:(id)sender {
    
    UIViewController *visibleViewController = self.pageController.viewControllers[0];
    NSUInteger currentIndex = [self.pages indexOfObject:visibleViewController];
    
    NSArray *viewControllers = [NSArray arrayWithObject:[self.pages objectAtIndex:self.pageControl.currentPage]];
    
    if (self.pageControl.currentPage > currentIndex) {
        [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    } else {
        [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
        
    }
}

- (IBAction)changpg:(id)sender {
    UIViewController *visibleViewController = self.pageController.viewControllers[0];
    NSUInteger currentIndex = [self.pages indexOfObject:visibleViewController];
    
    NSArray *viewControllers = [NSArray arrayWithObject:[self.pages objectAtIndex:self.pageControl.currentPage]];
    
    if (self.pageControl.currentPage > currentIndex) {
        [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    } else {
        [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
        
    }

}


-(void)animatonfortmer{
    self.notprofessional.alpha += .01;
    self.notprofessional.center = CGPointMake(self.notprofessional.center.x + .1, self.notprofessional.center.y );
   
    _counter++;
    NSLog(@"%i",_counter);
    }

-(void)firstpageAni{
    _image.alpha = _image.alpha + .04;
    _image.center = CGPointMake(_image.center.x, _image.center.y-.5);
    _image2.alpha = _image2.alpha + .04;
    _image2.center = CGPointMake(_image2.center.x, _image2.center.y-.5);
    
    _swipe.alpha = _swipe.alpha + .04;
    _swipe.center = CGPointMake(_swipe.center.x, _swipe.center.y-.5);
    
    _counterfirst++;
    NSLog(@"timer");
    if (_counterfirst >= 25) {
        [self.page1timer invalidate];
    }
    
}
-(void)addview :(UIView *)view{
    
    
    
    if (view.tag == 2) {
        UIImageView *photo = [[UIImageView alloc]initWithFrame:CGRectMake(1, 1, 320, 596)];
       
        photo.image = [UIImage imageNamed:@"page2"];
        photo.center = CGPointMake(self.view.frame.size.width /2, self.view.frame.size.height /2);
        [view addSubview:photo];

        
    }else if (view.tag == 3){
         UIImageView *photo = [[UIImageView alloc]initWithFrame:CGRectMake(1, 1, 320, 596)];
         photo.image = [UIImage imageNamed:@"page3"];
        photo.center = CGPointMake(self.view.frame.size.width /2, self.view.frame.size.height /2);
        [view addSubview:photo];

    }
    else if (view.tag == 4){
         UIImageView *photo = [[UIImageView alloc]initWithFrame:CGRectMake(1, 1, 320, 596)];
         photo.image = [UIImage imageNamed:@"page4"];
        photo.center = CGPointMake(self.view.frame.size.width /2, self.view.frame.size.height /2);
        [view addSubview:photo];

    }
    }
-(IBAction)startApp:(id)sender{
    [self performSegueWithIdentifier:@"start" sender:self];
    [[NSUserDefaults standardUserDefaults]setObject:@"Yes" forKey:@"Yes"];
}



@end
