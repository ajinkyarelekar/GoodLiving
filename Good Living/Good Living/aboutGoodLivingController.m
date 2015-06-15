//
//  aboutGoodLivingController.m
//  Good Living
//
//  Created by NanoStuffs on 16/09/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import "aboutGoodLivingController.h"
#import "LeadingViewController.h"
#import "MyAccountController.h"
#import "MyVoucherController.h"
#import "ViewController.h"
#import "myPurchaseController.h"
#import "ContactusController.h"

#import "notificationController.h"

#import "Flurry.h"

@interface aboutGoodLivingController ()
{
    BOOL IsWebViewVisible;
    UIWebView *webViewSubscribe;
}
@end

@implementation aboutGoodLivingController

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
    
    //Contact_Us
    [Flurry logEvent:@"About Good Living"];
    [Flurry logPageView];
    
        self.screenName = @"About Good Living";
    
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:1.0f];
    
    
    //------------------------Navigation Bar
    UIImageView *navigationImage = [[UIImageView alloc] init];
    navigationImage.backgroundColor = [UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f];
    [self.view addSubview:navigationImage];
    
    UILabel *topLable = [[UILabel alloc] init];
    topLable.text = @"About Good Living";


    topLable.textAlignment = NSTextAlignmentCenter;
    topLable.textColor = [UIColor whiteColor];
    topLable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topLable];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UIScrollView *imgscrool=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    imgscrool.contentSize=CGSizeMake(320, 650);
    [self.view addSubview:imgscrool];
    [self.view sendSubviewToBack:imgscrool];
    
    UIButton *btnSubscribe=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnSubscribe addTarget:self action:@selector(SubscribeMethod) forControlEvents:UIControlEventTouchUpInside];
    NSMutableAttributedString *commentString = [[NSMutableAttributedString alloc] initWithString:@"Subscribe to Gulf News."];
   // [commentString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [commentString length])];
    [commentString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:39/255.0f green:142/255.0f blue:175/255.0f alpha:1.0f] range:NSMakeRange(0, [commentString length])];
    [imgscrool addSubview:btnSubscribe];
    
    UIImageView *imageview=[[UIImageView alloc]init];
    [imgscrool addSubview:imageview];
    [imgscrool sendSubviewToBack:imageview];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        navigationImage.frame = CGRectMake(0, 0, 320, 64);
        backButton.frame = CGRectMake(5,25, 35, 35);
            topLable.frame = CGRectMake(0, 25, 320, 30);
            topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
        imageview.image=[UIImage imageNamed:@"aboutUS.png"];
        imageview.frame=CGRectMake(0, 0, 320, 568);
        
        [commentString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica Neue" size:12] range:NSMakeRange(0, [commentString length])];
        
        [btnSubscribe setAttributedTitle:commentString forState:UIControlStateNormal];
        btnSubscribe.frame=CGRectMake(65, 510, 200, 40);
    }
    else
    {
        navigationImage.frame = CGRectMake(0, 0, 768, 64);
        backButton.frame = CGRectMake(5,22, 35, 35);
        topLable.frame = CGRectMake(0, 25, 768, 30);
           topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:26];
        
        imgscrool.frame=self.view.frame;
        imgscrool.contentSize=self.view.frame.size;
        imgscrool.scrollEnabled=NO;
        imageview.image=[UIImage imageNamed:@"aboutUsiPad.png"];
        imageview.frame=self.view.frame;
        
        btnSubscribe.frame=CGRectMake(190, 870, 400, 70);
        [commentString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica Neue" size:26] range:NSMakeRange(0, [commentString length])];
        
        [btnSubscribe setAttributedTitle:commentString forState:UIControlStateNormal];


    }
    
	// Do any additional setup after loading the view.
}

-(void)SubscribeMethod
{
    webViewSubscribe=[[UIWebView alloc ]init];
    webViewSubscribe.delegate=self;
    
    IsWebViewVisible=YES;
    
    webViewSubscribe.frame=CGRectMake(0, 65, self.view.bounds.size.width, self.view.bounds.size.height-65);
    //[webViewSubscribe loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://store.gulfnews.com/subscriptions/gnmagazines.html?from=goodliving"]]];
    
    [webViewSubscribe loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://store.gulfnews.com/subscriptions/12-months-subscription-of-gulf-news-print-edition.html"]]];
    
    
    UIActivityIndicatorView *activityview1 = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityview1.center = self.view.center;
    [activityview1 startAnimating];
    activityview1.tag = 215;
    [webViewSubscribe addSubview:activityview1];
    
    [activityview1 startAnimating];
    
    [self.view addSubview:webViewSubscribe];
    
}
-(void) backMethod
{
    if (IsWebViewVisible)
    {
        [webViewSubscribe removeFromSuperview];
        IsWebViewVisible=NO;
        return;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark- WebView Delegate
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    UIActivityIndicatorView *v=(UIActivityIndicatorView*)[webView viewWithTag:215];
    [v stopAnimating];
    [v removeFromSuperview];
}

@end
