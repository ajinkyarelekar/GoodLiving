//
//  FAQViewController.m
//  Good Living
//
//  Created by NanoStuffs on 20/10/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import "FAQViewController.h"

@interface FAQViewController ()

@end

@implementation FAQViewController

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
    // Do any additional setup after loading the view from its nib.
    
    scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    scrollview.delegate = self;
    scrollview.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:239.0f/255.0f blue:245.0f/255.0f alpha:1.0f];
    [self.view addSubview:scrollview];
    
    UIImageView *FAQimage = [[UIImageView alloc] init];
    [scrollview addSubview:FAQimage];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        scrollview.contentSize = CGSizeMake(320, 3380);
        
        FAQimage.frame = CGRectMake(0, 0, 320, 6180);
        FAQimage.image = [UIImage imageNamed:@"FAQ_640.png"];
    }
    else
    {
        scrollview.contentSize = CGSizeMake(768, 7848);
        FAQimage.frame = CGRectMake(0, 0, 768, 7848);
        FAQimage.image = [UIImage imageNamed:@"FAQ_1536.png"];
    }
}

- (IBAction)backMethod:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
