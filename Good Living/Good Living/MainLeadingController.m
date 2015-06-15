//
//  MainLeadingController.m
//  Good Living
//
//  Created by Minakshi on 9/20/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import "MainLeadingController.h"
#import <QuartzCore/QuartzCore.h>
#define CORNER_RADIUS 4
#define SLIDE_TIMING .25
#define PANEL_WIDTH 60

@interface MainLeadingController () <LeadingViewController>
@property (nonatomic, strong) LeadingViewController *centerViewController;
@property (nonatomic, strong) LeftPanelViewController *leftPanelViewController;
@property (nonatomic, assign) BOOL showingLeftPanel;
@end

@implementation MainLeadingController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     [self setupView];
 
	// Do any additional setup after loading the view.
}

-(void)setupView
{
    self.centerViewController = [[LeadingViewController alloc] init];
    self.centerViewController.view.tag = CENTER_TAG;
    self.centerViewController.delegate = self;
    
    [self.view addSubview:self.centerViewController.view];
    [self addChildViewController:_centerViewController];
    
    [_centerViewController didMoveToParentViewController:self];
}

#pragma mark - View Will/Did Appear

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"SignUpSuccess"]==YES)
    {
        [self movePanelToOriginalPosition];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
    
}



#pragma mark -
#pragma mark View Will/Did Disappear

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

#pragma mark -
#pragma mark Setup View


- (void)showCenterViewWithShadow:(BOOL)value withOffset:(double)offset
{
    if (value)
    {
        [_centerViewController.view.layer setCornerRadius:CORNER_RADIUS];
        [_centerViewController.view.layer setShadowColor:[UIColor blackColor].CGColor];
        [_centerViewController.view.layer setShadowOpacity:0.8];
        [_centerViewController.view.layer setShadowOffset:CGSizeMake(offset, offset)];
        
    }
    else
    {
        [_centerViewController.view.layer setCornerRadius:0.0f];
        [_centerViewController.view.layer setShadowOffset:CGSizeMake(offset, offset)];
    }
}

- (void)resetMainView
{
}

- (UIView *)getLeftView
{
    if (_leftPanelViewController == nil)
    {
        // this is where you define the view for the left panel
        self.leftPanelViewController = [[LeftPanelViewController alloc] init];
        self.leftPanelViewController.view.tag = LEFT_PANEL_TAG;
     
        
        [self.view addSubview:self.leftPanelViewController.view];
        
        [self addChildViewController:_leftPanelViewController];
        [_leftPanelViewController didMoveToParentViewController:self];
        
        _leftPanelViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
    
    self.showingLeftPanel = YES;
    
    // set up view shadows
    [self showCenterViewWithShadow:YES withOffset:-2];
    
    UIView *view = self.leftPanelViewController.view;
    return view;
}

- (UIView *)getRightView
{
    UIView *view = nil;
    return view;
}

#pragma mark -
#pragma mark Swipe Gesture Setup/Actions

#pragma mark - setup

- (void)setupGestures
{
}

-(void)movePanel:(id)sender
{
}

#pragma mark -
#pragma mark Delegate Actions

- (void)movePanelLeft // to show right panel
{
}

- (void)movePanelRight // to show left panel
{
    UIView *childView = [self getLeftView];
    [self.view sendSubviewToBack:childView];
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
    [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         _centerViewController.view.frame = CGRectMake(self.view.frame.size.width - PANEL_WIDTH, 0, self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             
                             _centerViewController.menuButton.tag = 0;
                         }
                     }];
    
    }
    else
    {
        [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             _centerViewController.view.frame = CGRectMake(self.view.frame.size.width-300, 0, self.view.frame.size.width, self.view.frame.size.height);
                         }
                         completion:^(BOOL finished) {
                             if (finished) {
                                 
                                 _centerViewController.menuButton.tag = 0;
                             }
                         }];
        
    }

}

- (void)movePanelToOriginalPosition
{
    //Vanita:
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"SignUpSuccess"]==YES)
    {
        [UIView animateWithDuration:0 delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             _centerViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                         }
                         completion:^(BOOL finished) {
                             if (finished) {
                                 
                                 [self resetMainView];
                             }
                         }];
        
    }
    else
    {
        [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             _centerViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                         }
                         completion:^(BOOL finished) {
                             if (finished) {
                                 
                                 [self resetMainView];
                             }
                         }];
    }
}
#pragma mark -
#pragma mark Default System Code


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
