//
//  TermsAndConditionController.m
//  Good Living
//
//  Created by NanoStuffs on 08/10/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import "TermsAndConditionController.h"

@interface TermsAndConditionController ()

@end

@implementation TermsAndConditionController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
     delegate = [[UIApplication sharedApplication] delegate];
    //scrollView.frame = CGRectMake(0, 65, 320, self.view.frame.size.height-105);
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        scrollView.contentSize = CGSizeMake(320, 1286);
    }
    else
    {
        scrollView.contentSize = CGSizeMake(768, 1021);
    }
}

- (IBAction)backMethod:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)AgreeMethod:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    delegate.flag_btnSelected=1;

}

- (IBAction)DisAgreeMethod:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    delegate.flag_btnSelected=0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
