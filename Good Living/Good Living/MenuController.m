//
//  MenuController.m
//  Good Living
//
//  Created by Minakshi on 9/20/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import "MenuController.h"

@interface MenuController ()

@end

@implementation MenuController

@synthesize stringUrl;

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
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:1.0f];
    //------------------------Navigation Bar
    UIImageView *navigationImage = [[UIImageView alloc] init];
    navigationImage.backgroundColor = [UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f];
    [self.view addSubview:navigationImage];
    navigationImage.frame = CGRectMake(0, 0, 320, 64);
    
    UILabel *topLable = [[UILabel alloc] init];
    topLable.text = @"Menu";
    topLable.frame = CGRectMake(0, 25, 320, 30);
    topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
    topLable.textAlignment = NSTextAlignmentCenter;
    topLable.textColor = [UIColor whiteColor];
    topLable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topLable];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    backButton.frame = CGRectMake(5,25, 35, 35);
    
    stringUrl = [stringUrl stringByReplacingOccurrencesOfString:@"http:" withString:@"https:"];
    
    UIWebView *webview = [[UIWebView alloc] init];
    webview.frame = CGRectMake(0, 65, self.view.frame.size.width, self.view.frame.size.height-65);
    webview.delegate = self;
    webview.scalesPageToFit = YES;
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:stringUrl]]];
    [self.view addSubview:webview];
    
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
        navigationImage.frame = CGRectMake(0, 0, 768, 64);
        backButton.frame = CGRectMake(5,23, 35, 35);
        topLable.frame = CGRectMake(0, 25, 768, 30);
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
