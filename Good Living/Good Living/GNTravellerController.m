//
//  GNTravellerController.m
//  Good Living
//
//  Created by NanoStuffs on 11/09/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import "GNTravellerController.h"
#import "ViewController.h"
#import "MyVoucherController.h"
#import "MyAccountController.h"
#import "LeadingViewController.h"
#import "UILabel+FormattedText.h"
#import "myPurchaseController.h"
#import "ContactusController.h"
#import "aboutGoodLivingController.h"
#import "notificationController.h"
@interface GNTravellerController ()

@end

@implementation GNTravellerController

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
    self.view.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f];
    
    //------------------------------ Navigation Bar
    UIImageView *navigationImage = [[UIImageView alloc] init];
    navigationImage.backgroundColor = [UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f];
    [self.view addSubview:navigationImage];
    navigationImage.frame = CGRectMake(0, 0, 320, 64);
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    backButton.frame = CGRectMake(5, 25, 35, 35);
    UILabel *topLable = [[UILabel alloc] init];
    topLable.text = @"GL Traveller";
    topLable.frame = CGRectMake(0, 25, 320, 30);
    topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
    topLable.textAlignment = NSTextAlignmentCenter;
    topLable.textColor = [UIColor whiteColor];
    topLable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topLable];
      
    //------------------------Restorant
    
    UIScrollView *mainscrollvertical = [[UIScrollView alloc] init];
    mainscrollvertical.delegate = self;
    mainscrollvertical.frame = CGRectMake(0, 64, 320, self.view.frame.size.height-64);
    mainscrollvertical.contentSize = CGSizeMake(320, 580);
    mainscrollvertical.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f];
    [self.view addSubview:mainscrollvertical];
    UIScrollView *restorantImagesScrool = [[UIScrollView alloc] init];
    restorantImagesScrool.delegate = self;
    restorantImagesScrool.backgroundColor = [UIColor clearColor];
    restorantImagesScrool.tag = 100;
    restorantImagesScrool.pagingEnabled = YES;
    [mainscrollvertical addSubview:restorantImagesScrool];
    restorantImagesScrool.frame = CGRectMake(0, 0, 320, 137);
    restorantImagesScrool.contentSize = CGSizeMake(320*3, 137);
    
    for (int i = 0; i < 3; i++)
    {
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(1+(i*320), 1, 318, restorantImagesScrool.frame.size.height-2)];
        imageview.image = [UIImage imageNamed:@"scrolling1.png"];
        [restorantImagesScrool addSubview:imageview];
    }
    
    pageControl = [[UIPageControl alloc] init];
    pageControl.frame = CGRectMake(260,87,50,20);
    pageControl.numberOfPages = 3;
    pageControl.currentPage = 0;
    pageControl.backgroundColor = [UIColor clearColor];
    [mainscrollvertical addSubview:pageControl];
    
    //------------------------------------------------GiftsOftheWeekLabel
    
    
    UIScrollView *offersScrool = [[UIScrollView alloc] init];
    offersScrool.delegate = self;
    offersScrool.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.8f];
    offersScrool.pagingEnabled = NO;
    offersScrool.layer.cornerRadius = 0.0f;
    [mainscrollvertical addSubview:offersScrool];
    offersScrool.frame = CGRectMake(0, 107, 320, 30);
    offersScrool.contentSize = CGSizeMake(320, 30);
    
    UILabel *winwithusLable = [[UILabel alloc] init];
    winwithusLable.text = @"WIN AED 5000 worth shopping Voucher from NATURALIZER";
    winwithusLable.textColor = [UIColor whiteColor];
    winwithusLable.font = [UIFont fontWithName:@"Helvetica Neue" size:11];
    // winwithusLable.backgroundColor = [UIColor blackColor];
    winwithusLable.frame = CGRectMake(5, 7, 320, 20);
    [offersScrool addSubview:winwithusLable];
    
    //---------------------------------------------------------EventTableView
    
    
    titleArray = [[NSMutableArray alloc] init];
    subtitleArray  = [[NSMutableArray alloc] init];
    
    [titleArray addObject:@"To Participate"];
    [titleArray addObject:@"Description"];
    [titleArray addObject:@"Terms & Condition"];
    [titleArray addObject:@"Previous Winner"];
    
    [subtitleArray addObject:@"SMS 'Club Apparel' To 5090"];
    [subtitleArray addObject:@"The warmth and flavours of Mexico have arrived on the Arabian Gulf shores, Tortuga is the new vibrant and colorful Mexican restaurant in Dubai at Mina A'Salarm, Madinat Jumeirah."];
    [subtitleArray addObject:@"This offer is only applicable on Tortuga Kitchen, For Terms & Condition"];
    [subtitleArray addObject:@"Mr. B.J Shetty Dubai"];
    
    eventtableView = [[UITableView alloc] init];
    eventtableView.delegate = self;
    eventtableView.dataSource = self;
    eventtableView.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f];
    eventtableView.frame = CGRectMake(0, 140, 320, self.view.frame.size.height-95);
    eventtableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    eventtableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    eventtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [mainscrollvertical addSubview:eventtableView];
    

	
}

- (void) backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - TableView delegate and datasource methods
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [titleArray count];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 80;
    }
    else if (indexPath.row == 1)
    {
        return 125;
    }
    else if (indexPath.row == 2)
    {
        return 90;
    }
    else
    {
        return 80;
    }
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    NSArray *subviews = [[NSArray alloc] initWithArray:cell.contentView.subviews];
    for (UILabel *subview in subviews)
    {
        [subview removeFromSuperview];
    }
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectZero];
    backView.backgroundColor = [UIColor clearColor];
    cell.backgroundView = backView;
    
    UIView *cellview = [[UIView alloc] initWithFrame:CGRectMake(5, 5, 310, 500)];
    cellview.layer.cornerRadius = 5.0f;
    cellview.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:cellview];
    
    UILabel *nameLable =[[UILabel alloc] init];
    nameLable.frame = CGRectMake(5, 5, 200, 25);
    nameLable.text = [titleArray objectAtIndex:indexPath.row];
    nameLable.textAlignment = NSTextAlignmentLeft;
    nameLable.textColor = [UIColor blackColor];
    nameLable.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    nameLable.backgroundColor = [UIColor clearColor];
    [cellview addSubview:nameLable];
    
    UILabel *detailLable =[[UILabel alloc] init];
    if(indexPath.row==0)
    {
     
        detailLable.text=[subtitleArray objectAtIndex:indexPath.row];
        [detailLable setBackgroundColor:[UIColor clearColor]];
        [detailLable setTextAlignment:NSTextAlignmentCenter];
        detailLable.textColor = [UIColor darkGrayColor];
        [detailLable setTextColor:[UIColor colorWithRed:205/255.0f green:63/255.0f blue:59/255.0f alpha:1.0f] range:NSMakeRange(5, 12)];
     
    }
    else
    {
        detailLable.text = [subtitleArray objectAtIndex:indexPath.row];
        detailLable.textColor = [UIColor darkGrayColor];
        
    }
    
    detailLable.textAlignment = NSTextAlignmentLeft;
    
    if(indexPath.row==0)
    {
        detailLable.numberOfLines = 1;
        detailLable.frame = CGRectMake(50, 30, 300, 30);
        detailLable.font = [UIFont fontWithName:@"Helvetica Neue" size:16];
        
    }
    else  if(indexPath.row==0)
        
    {
        detailLable.numberOfLines = 5;
        detailLable.frame = CGRectMake(10, 20, 300, 80);
        detailLable.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
        
    }
    
    else  if(indexPath.row==1)
        
    {
        detailLable.numberOfLines = 5;
        detailLable.frame = CGRectMake(10, 20, 300, 80);
        detailLable.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
        
    }
    
    else  if(indexPath.row==2)
        
    {
        detailLable.numberOfLines = 2;
        detailLable.frame = CGRectMake(10, 10, 300, 80);
        detailLable.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
        
    }
    
    else
    {
        detailLable.numberOfLines = 1;
        detailLable.frame = CGRectMake(10, 8, 300, 70);
        detailLable.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
        
    }
    
    detailLable.lineBreakMode = NSLineBreakByWordWrapping;

    [cellview addSubview:detailLable];
    
    
    [cell setBackgroundColor:[UIColor clearColor]];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - Scroll delegate methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag == 100)
    {
        CGFloat pageWidth = scrollView.frame.size.width;
        float fractionalPage = scrollView.contentOffset.x / pageWidth;
        NSInteger page = lround(fractionalPage);
        pageControl.currentPage = page;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
