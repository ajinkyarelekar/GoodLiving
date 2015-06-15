//
//  myPurchaseController.m
//  Good Living
//
//  Created by NanoStuffs on 16/09/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import "myPurchaseController.h"
#import "LeadingViewController.h"
#import "MyAccountController.h"
#import "MyVoucherController.h"
#import "ViewController.h"
#import "myPurchaseController.h"
#import "ContactusController.h"
#import "aboutGoodLivingController.h"
#import "notificationController.h"

@interface myPurchaseController ()

@end

@implementation myPurchaseController

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
    
    delegate = [[UIApplication sharedApplication] delegate];
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:1.0f];
    //------------------------Navigation Bar
    UIImageView *navigationImage = [[UIImageView alloc] init];
    navigationImage.backgroundColor = [UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f];
    [self.view addSubview:navigationImage];
    
    UILabel *topLable = [[UILabel alloc] init];
    topLable.text = @"My Purchases";
  
    topLable.textAlignment = NSTextAlignmentCenter;
    topLable.textColor = [UIColor whiteColor];
    topLable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topLable];
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:backButton];

    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        navigationImage.frame = CGRectMake(0, 0, 320, 64);
        backButton.frame = CGRectMake(40, 29, 25, 25);
        topLable.frame = CGRectMake(0, 25, 320, 30);
        topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:18];

    }
    else
    {
        navigationImage.frame = CGRectMake(0, 0, 768, 64);
        backButton.frame = CGRectMake(5,22, 35, 35);
        topLable.frame = CGRectMake(0, 25, 768, 30);
        topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:26];
    }
}


-(void) backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
