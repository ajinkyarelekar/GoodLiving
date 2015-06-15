//
//  GNoffersController.m
//  Good Living
//
//  Created by NanoStuffs on 05/09/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import "GNoffersController.h"
#import "SelectedThemesController.h"
#import "MyAccountController.h"
#import "LeadingViewController.h"
#import "ViewController.h"
#import "MyVoucherController.h"

#import "myPurchaseController.h"
#import "ContactusController.h"
#import "aboutGoodLivingController.h"
#import "notificationController.h"

@interface GNoffersController ()

@end

@implementation GNoffersController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    delegate = [[UIApplication sharedApplication] delegate];
    
    self.navigationController.navigationBarHidden = YES;
    
    //------------------------Navigation Bar
    UIImageView *navigationImage = [[UIImageView alloc] init];
    navigationImage.backgroundColor = [UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f];
    [self.view addSubview:navigationImage];
    
    UILabel *topLable = [[UILabel alloc] init];
    topLable.text = @"All Themes";
    topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
    topLable.textAlignment = NSTextAlignmentCenter;
    topLable.textColor = [UIColor whiteColor];
    topLable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topLable];
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    //--------------------------------------OffersScroll
    UIScrollView *newestdealsScrool = [[UIScrollView alloc] init];
    newestdealsScrool.delegate = self;
    newestdealsScrool.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f];
    [self.view addSubview:newestdealsScrool];
    
    
    NSArray *arrayoffersBtn  = [NSArray arrayWithObjects:@"cd.png",@"fd.png",@"sho.png",@"bea.png",@"hf.png",@"hg.png",@"A&L.png",@"chi.png",@"ser.png" ,nil];
    
    int flag;
    int height;
    
    flag = 0;
    for (int i = 0; i < [arrayoffersBtn count]/2+1; i++)
    {
        for (int j = 0; j < 2; j++)
        {
            if ([arrayoffersBtn count] > flag)
            {
                UIButton *offersBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                    offersBtn.frame = CGRectMake(8+(156*j), 17+(121*i), 150, 105);
                else
                    offersBtn.frame = CGRectMake(56+(356*j), 20+(230*i), 300, 210);

                [offersBtn addTarget:self action:@selector(offersmethod :) forControlEvents:UIControlEventTouchUpInside];
                offersBtn.tag = flag;
                
                [offersBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[arrayoffersBtn objectAtIndex:flag]]] forState:UIControlStateNormal];
                [newestdealsScrool addSubview:offersBtn];
                
                height = 17+(121*i);
                
                flag ++;
            }
        }
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        navigationImage.frame = CGRectMake(0, 0, 320, 64);
        backButton.frame = CGRectMake(5,25, 35, 35);
        topLable.frame = CGRectMake(0, 25, 320, 30);
        
        newestdealsScrool.frame = CGRectMake(0, 64, 320, self.view.frame.size.height-64);
        newestdealsScrool.contentSize = CGSizeMake(320, 625);
    }
    else
    {
        navigationImage.frame = CGRectMake(0, 0, 768, 64);
        backButton.frame = CGRectMake(5,22, 35, 35);
        topLable.frame = CGRectMake(0, 25, 768, 30);
        
        newestdealsScrool.frame = CGRectMake(0, 64, 768, self.view.frame.size.height-64);
        newestdealsScrool.contentSize = CGSizeMake(768, 1100);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    //Dispose of any resources that can be recreated.
}

- (void) backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) filterMethod
{
}

#pragma mark - offers method
- (void) offersmethod : (id) sender
{
    UIButton *btn = (UIButton *) sender;
    
    SelectedThemesController *nextView = [[SelectedThemesController alloc] init];
    
    if (btn.tag == 0)
        nextView.titleString = @"Casual Dining";
    
    else if(btn.tag == 1)
        nextView.titleString = @"Fine Dining";//Shopping
    
    else if(btn.tag == 2)
        nextView.titleString = @"Shopping";//Fine Dining
    
    else if(btn.tag == 3)
        nextView.titleString = @"Beauty & Wellness";//Home & Garden
    
    else if(btn.tag == 4)
        nextView.titleString = @"Health & Fitness";//Children
    
    else if(btn.tag == 5)
        nextView.titleString = @"Home & Garden";
    
    else if(btn.tag == 6)
        nextView.titleString = @"Adventure & Leisure";//Health & Fitness
    
    else if(btn.tag == 7)
        nextView.titleString = @"Children";
    
    else
        nextView.titleString = @"Services";
    
    [self.navigationController pushViewController:nextView animated:YES];
}


@end
