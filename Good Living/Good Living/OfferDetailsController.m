//
//  OfferDetailsController.m
//  Good Living
//
//  Created by NanoStuffs on 05/09/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import "OfferDetailsController.h"
#import "DownlaodVoucherController.h"
#import "MyAccountController.h"
#import "LeadingViewController.h"
#import "ViewController.h"
#import "MyVoucherController.h"
#import "FavoriteController.h"
#import "SelectedThemesController.h"
#import "myPurchaseController.h"
#import "ContactusController.h"
#import "aboutGoodLivingController.h"
#import "notificationController.h"
#import "MapController.h"
#import "MenuController.h"
#import "LocationController.h"
#import "globalURL.h"

#import "Flurry.h"

@interface OfferDetailsController ()

@end

@implementation OfferDetailsController

@synthesize Preaddress,menuGlobalUrl;

@synthesize newestOfferID;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    check=YES;
    delegate = [[UIApplication sharedApplication] delegate];
    
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:1.0f];
    
    getNewestAlert = [[UIAlertView alloc] initWithTitle:@"Please wait..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [getNewestAlert show];
    [self performSelector:@selector(newestOfferDetails) withObject:nil afterDelay:0.1];
    [self performSelector:@selector(getsimilarOfferDetails) withObject:nil afterDelay:0.1];
    
    UIImageView *backimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 768, 1024)];
    backimage.image = [UIImage imageNamed:@"3-offers-Details_Ipad2.jpg"];
//    [self.view addSubview:backimage];
    
    //------------------------Navigation Bar
    UIImageView *navigationImage = [[UIImageView alloc] init];
    navigationImage.backgroundColor = [UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f];
    [self.view addSubview:navigationImage];
    
    UILabel *topLable = [[UILabel alloc] init];
    topLable.text = @"Offer Details";
    topLable.textAlignment = NSTextAlignmentCenter;
    topLable.textColor = [UIColor whiteColor];
    topLable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topLable];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    mainScrool = [[UIScrollView alloc] init];
    mainScrool.delegate = self;
    mainScrool.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mainScrool];
    
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureTurnPage)];
    [mainScrool addGestureRecognizer:recognizer];
    

    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        //        mainScrool.frame = CGRectMake(0, 209, 320, self.view.frame.size.height-215);
        mainScrool.frame = CGRectMake(0, 244, 320, self.view.frame.size.height-240);
        mainScrool.contentSize = CGSizeMake(320, 1210);
    }
    else
    {
        mainScrool.frame = CGRectMake(0, 434, 768, (self.view.frame.size.height-434));
        mainScrool.contentSize = CGSizeMake(768, 2010);
    }

    
    
//    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
//    {
//        mainScrool.frame = CGRectMake(0, 209, 320, self.view.frame.size.height-215);
//        mainScrool.contentSize = CGSizeMake(320, 1210);
//    }
//    else
//    {
//        mainScrool.frame = CGRectMake(0, 404, 768, (self.view.frame.size.height-404));
//        mainScrool.contentSize = CGSizeMake(768, 2010);
//    }
    
    //The warmth and flavours of maxico have arrived on the Arabian Gulf shores.
    UIView *downloadVoucherBtn = [[UIView alloc] init];
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        if (self.view.frame.size.height == 568)
        {
            downloadVoucherBtn.frame=CGRectMake(0, self.view.frame.size.height-56, 320 , 56);
        }
        else
        {
            downloadVoucherBtn.frame=CGRectMake(0, self.view.frame.size.height-56, 320 , 56);
        }
    }
    else
    {
        downloadVoucherBtn.frame=CGRectMake(0, self.view.frame.size.height- 89, 768 , 89);
    }
    
    downloadVoucherBtn.backgroundColor = [UIColor whiteColor];
    downloadVoucherBtn.layer.cornerRadius = 5.0f;
    [self.view addSubview:downloadVoucherBtn];
    
    UIButton *downloadButtonVoucher = [UIButton buttonWithType:UIButtonTypeCustom];

    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        [downloadButtonVoucher setImage:[UIImage imageNamed:@"download.png"] forState:UIControlStateNormal];
    }
    else
    {
        [downloadButtonVoucher setImage:[UIImage imageNamed:@"downloadiPad.png"] forState:UIControlStateNormal];
    }

    [downloadButtonVoucher addTarget:self action:@selector(downloadVoucherMethod) forControlEvents:UIControlEventTouchUpInside];
    downloadButtonVoucher.frame = CGRectMake(0, 0, downloadVoucherBtn.frame.size.width, downloadVoucherBtn.frame.size.height);
    [downloadVoucherBtn addSubview:downloadButtonVoucher];
    
    //-------------------featureButtons
    FeaturesArra = [NSArray arrayWithObjects:@"1map_d.png",@"1call.png",@"1menu.png",@"1share.png", @"locations-1.png",nil];
    
    featureButtonmap = [UIButton buttonWithType:UIButtonTypeCustom];
    featureButtonmap.frame = CGRectMake(28, 110, 38, 38);//(32, 110, 38, 38)
    [featureButtonmap addTarget:self action:@selector(featureMethod:) forControlEvents:UIControlEventTouchUpInside];
    [featureButtonmap setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[FeaturesArra objectAtIndex:0]]] forState:UIControlStateNormal];
    featureButtonmap.tag = 0;
    featureButtonmap.userInteractionEnabled = NO;
    
    UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(28, 150, 38, 12)];//(32, 150, 38, 12)
    lable1.text = @"Map";//Call//Menu//Share//Favorite
    lable1.textColor = [UIColor darkGrayColor];
    lable1.backgroundColor = [UIColor clearColor];
    lable1.textAlignment = NSTextAlignmentCenter;
    lable1.font = [UIFont fontWithName:@"Helvetica Neue" size:10];
    
    featureButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    featureButton2.frame = CGRectMake(83, 110, 38, 38);//(102, 110, 38, 38)
    [featureButton2 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[FeaturesArra objectAtIndex:1]]] forState:UIControlStateNormal];
    [featureButton2 addTarget:self action:@selector(featureMethod:) forControlEvents:UIControlEventTouchUpInside];
    featureButton2.tag = 1;
    
    UILabel *lable2 = [[UILabel alloc] initWithFrame:CGRectMake(83, 150, 38, 12)];//(102, 150, 38, 12)
    lable2.text = @"Call";//Call//Menu//Share//Favorite
    lable2.textColor = [UIColor darkGrayColor];
    lable2.backgroundColor = [UIColor clearColor];
    lable2.textAlignment = NSTextAlignmentCenter;
    lable2.font = [UIFont fontWithName:@"Helvetica Neue" size:10];
    
    
    featureButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
    featureButton3.frame = CGRectMake(138, 110, 38, 38);//(172, 110, 38, 38)
    [featureButton3 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[FeaturesArra objectAtIndex:2]]] forState:UIControlStateNormal];
    [featureButton3 addTarget:self action:@selector(featureMethod:) forControlEvents:UIControlEventTouchUpInside];
    featureButton3.tag = 2;
    
    hideMenuButton=featureButton3;
    
//    if([maincategory isEqualToString:@"Casual Dining"] || [maincategory isEqualToString:@"Fine Dining"])
//    {
//        featureButton3.enabled=YES;
//    }
//    else
//    {
//        featureButton3.enabled=NO;
//        [featureButton3 setImage:[UIImage imageNamed:@"1menu_d.png"] forState:UIControlStateNormal];
//        
//
//    }
    
    UILabel *lable3 = [[UILabel alloc] initWithFrame:CGRectMake(138, 150, 38, 12)];//(172, 150, 38, 12)
    lable3.text = @"Menu";//Call//Menu//Share//Favorite
    lable3.textColor = [UIColor darkGrayColor];
    lable3.backgroundColor = [UIColor clearColor];
    lable3.textAlignment = NSTextAlignmentCenter;
    lable3.font = [UIFont fontWithName:@"Helvetica Neue" size:10];
    
    UIButton *featureButton4 = [UIButton buttonWithType:UIButtonTypeCustom];
    featureButton4.frame = CGRectMake(193, 110, 38, 38);//(242, 110, 38, 38)
    [featureButton4 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[FeaturesArra objectAtIndex:3]]] forState:UIControlStateNormal];
    [featureButton4 addTarget:self action:@selector(featureMethod:) forControlEvents:UIControlEventTouchUpInside];
    featureButton4.tag = 3;
    
    UILabel *lable4 = [[UILabel alloc] initWithFrame:CGRectMake(193, 150, 38, 12)];//(242, 150, 38, 12)
    lable4.text = @"Share";//Call//Menu//Share//Favorite
    lable4.textColor = [UIColor darkGrayColor];
    lable4.backgroundColor = [UIColor clearColor];
    lable4.textAlignment = NSTextAlignmentCenter;
    lable4.font = [UIFont fontWithName:@"Helvetica Neue" size:10];
    
    UIButton *featureButton6 = [UIButton buttonWithType:UIButtonTypeCustom];
    featureButton6.frame = CGRectMake(252, 110, 38, 38);//(32, 110, 38, 38)
    [featureButton6 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[FeaturesArra objectAtIndex:4]]] forState:UIControlStateNormal];
    [featureButton6 addTarget:self action:@selector(featureMethod:) forControlEvents:UIControlEventTouchUpInside];
    featureButton6.tag = 6;
    
    UILabel *lable5 = [[UILabel alloc] initWithFrame:CGRectMake(246, 150, 50, 12)];
    lable5.text = @"Locations";//Call//Menu//Share//Favorite
    lable5.textColor = [UIColor darkGrayColor];
    lable5.backgroundColor = [UIColor clearColor];
    lable5.textAlignment = NSTextAlignmentCenter;
    lable5.font = [UIFont fontWithName:@"Helvetica Neue" size:10];
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        [mainScrool addSubview:featureButtonmap];
        [mainScrool addSubview:lable1];
        [mainScrool addSubview:featureButton2];
        [mainScrool addSubview:lable2];
        [mainScrool addSubview:featureButton3];
        [mainScrool addSubview:lable3];
        [mainScrool addSubview:featureButton4];
        [mainScrool addSubview:lable4];
        [mainScrool addSubview:featureButton6];
        [mainScrool addSubview:lable5];
    }
    
    
    //--------------------------------------contact Info
    ContactInfoView = [[UIView alloc] init];
    ContactInfoView.frame = CGRectMake(5, 421, 310, 140);
    ContactInfoView.backgroundColor = [UIColor whiteColor];
    ContactInfoView.layer.cornerRadius = 5.0f;
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        [mainScrool addSubview:ContactInfoView];
    }

    UILabel *contactInfolabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 290, 20)];
    contactInfolabel.text = @"Contact Details";
    contactInfolabel.textAlignment = NSTextAlignmentLeft;
    contactInfolabel.textColor = [UIColor blackColor];
    contactInfolabel.backgroundColor = [UIColor clearColor];
    contactInfolabel.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    //contactInfolabel.font = [UIFont boldSystemFontOfSize:16];
    [ContactInfoView addSubview:contactInfolabel];
    
    UILabel *addresslabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 35, 100, 14)];//50
    addresslabel.text =       @"Address              :";
    addresslabel.textAlignment = NSTextAlignmentLeft;
    addresslabel.textColor = [UIColor grayColor];
    addresslabel.backgroundColor = [UIColor clearColor];
    addresslabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
    [ContactInfoView addSubview:addresslabel];
    
    UILabel *locationlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 65, 100, 14)];//100
    locationlabel.text =         @"Location             :";
    locationlabel.textAlignment = NSTextAlignmentLeft;
    locationlabel.textColor = [UIColor grayColor];
    locationlabel.backgroundColor = [UIColor clearColor];
    locationlabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
    [ContactInfoView addSubview:locationlabel];
    
    UILabel *phonelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, 100, 14)];//100
    phonelabel.text =         @"Phone                 :";
    phonelabel.textAlignment = NSTextAlignmentLeft;
    phonelabel.textColor = [UIColor grayColor];
    phonelabel.backgroundColor = [UIColor clearColor];
    phonelabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
    [ContactInfoView addSubview:phonelabel];
    
    UILabel *emaillabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 115, 100, 14)];//115
    emaillabel.text =         @"Email                   :";
    emaillabel.textAlignment = NSTextAlignmentLeft;
    emaillabel.textColor = [UIColor grayColor];
    emaillabel.backgroundColor = [UIColor clearColor];
    emaillabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
    [ContactInfoView addSubview:emaillabel];

    
    swipeGestureLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedScreenLeft:)];
    //swipeGestureLeft.delegate=self;
    swipeGestureLeft.numberOfTouchesRequired = 1;
    swipeGestureLeft.direction = (UISwipeGestureRecognizerDirectionRight);
    [mainScrool addGestureRecognizer:swipeGestureLeft];////self.view
    
  
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        navigationImage.frame = CGRectMake(0, 0, 320, 64);
        backButton.frame = CGRectMake(5, 25, 35, 35);
        
        topLable.frame = CGRectMake(0, 26, 320, 30);
        topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
    }
    else
    {
        navigationImage.frame = CGRectMake(0, 0, 768, 64);
        backButton.frame = CGRectMake(5, 26, 35, 35);
        
        topLable.frame = CGRectMake(0, 28, 768, 30);
        topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:22];
    }
    
    UITapGestureRecognizer* gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerViewTapGestureRecognized:)];
    [myPickerView addGestureRecognizer:gestureRecognizer];
}

- (void) tapGestureTurnPage
{
    [myPickerView removeFromSuperview];
}

-(void)viewWillAppear:(BOOL)animated
{
}

- (void) ipadDesigns
{
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 435, 1000)];
    leftView.backgroundColor = [UIColor whiteColor];
    leftView.layer.cornerRadius = 5.0f;
    [mainScrool addSubview:leftView];
    
    UILabel *DescriptionTitlelable = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 405, 30)];
    DescriptionTitlelable.text = @"Description";
    DescriptionTitlelable.textAlignment = NSTextAlignmentLeft;
    DescriptionTitlelable.font = [UIFont fontWithName:@"Helvetica Neue" size:24];
    //DescriptionTitlelable.font = [UIFont boldSystemFontOfSize:25];
    DescriptionTitlelable.textColor = [UIColor blackColor];
    DescriptionTitlelable.backgroundColor = [UIColor clearColor];
    [leftView addSubview:DescriptionTitlelable];
    
    
    if ([is_premium isEqualToString:@"1"] == TRUE)
    {
        UIImageView *imageprimium = [[UIImageView alloc] initWithFrame:CGRectMake(301, 15, 92, 18)];
        imageprimium.image = [UIImage imageNamed:@"premiumoffer.png"];
        [leftView addSubview:imageprimium];
    }
    
    if ([is_new isEqualToString:@"1"] == TRUE)
    {
        UIImageView *imagenew = [[UIImageView alloc] initWithFrame:CGRectMake(395, 15, 35, 18)];
        imagenew.image = [UIImage imageNamed:@"new.png"];
        [leftView addSubview:imagenew];
    }

    
    
    CGSize labelSize = [merchantDesc sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:16]
                        constrainedToSize:CGSizeMake(405, 9999)
                            lineBreakMode:NSLineBreakByWordWrapping];
    
    UIImageView *pofferimg = [[UIImageView alloc] initWithFrame:CGRectMake((leftView.frame.size.width/2)-50, (DescriptionTitlelable.frame.origin.y+DescriptionTitlelable.frame.size.height), 100, 100)];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",logoUrl]]]];
    
    if (img.size.width*2 <  pofferimg.frame.size.width || img.size.height*2 < pofferimg.frame.size.height)
    {
        [pofferimg setContentMode:UIViewContentModeScaleAspectFit];
    }
    if(img)
    {
        pofferimg.image = img;
    }
    else
    {
        pofferimg.frame = CGRectMake(0, 40, 0, 0);
//        pofferimg.image =[UIImage imageNamed:@"11_186X186.png"];
    }
    [leftView addSubview:pofferimg];
    
    UILabel *DescriptionDetaillable = [[UILabel alloc] initWithFrame:CGRectMake(15, (pofferimg.frame.origin.y+pofferimg.frame.size.height)+5, 405, labelSize.height)];//(labelSize.height/22)*24)
    DescriptionDetaillable.text = merchantDesc;
    DescriptionDetaillable.textAlignment = NSTextAlignmentLeft;
    DescriptionDetaillable.font = [UIFont fontWithName:@"Helvetica Neue" size:16];
    
    DescriptionDetaillable.lineBreakMode = NSLineBreakByWordWrapping;
    DescriptionDetaillable.numberOfLines = 100;
    
    DescriptionDetaillable.textColor = [UIColor darkGrayColor];
    DescriptionDetaillable.backgroundColor = [UIColor clearColor];
    [leftView addSubview:DescriptionDetaillable];
    
    //-------------------featureButtons
    FeaturesArra = [NSArray arrayWithObjects:@"1map_d.png",@"1call.png",@"1menu.png",@"1share.png", @"locations-1.png",nil];

    featureButtonmap = [UIButton buttonWithType:UIButtonTypeCustom];
    featureButtonmap.frame = CGRectMake(30, (DescriptionDetaillable.frame.size.height+DescriptionDetaillable.frame.origin.y)+30, 50, 50);//(32, 110, 38, 38)
    [featureButtonmap setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[FeaturesArra objectAtIndex:0]]] forState:UIControlStateNormal];
    [featureButtonmap addTarget:self action:@selector(featureMethod:) forControlEvents:UIControlEventTouchUpInside];
    featureButtonmap.tag = 0;
    featureButtonmap.userInteractionEnabled = NO;

    [mainScrool addSubview:featureButtonmap];

    UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(30,(DescriptionDetaillable.frame.size.height+DescriptionDetaillable.frame.origin.y)+90, 50, 18)];
    lable1.text = @"Map";//Call//Menu//Share//Favorite
    lable1.textColor = [UIColor darkGrayColor];
    lable1.backgroundColor = [UIColor clearColor];
    lable1.textAlignment = NSTextAlignmentCenter;
    lable1.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    [mainScrool addSubview:lable1];

    
    featureButton2iPad = [UIButton buttonWithType:UIButtonTypeCustom];
    featureButton2iPad.frame = CGRectMake(110, (DescriptionDetaillable.frame.size.height+DescriptionDetaillable.frame.origin.y)+30, 50, 50);//(102, 110, 38, 38)
    [featureButton2iPad addTarget:self action:@selector(featureMethod:) forControlEvents:UIControlEventTouchUpInside];
    featureButton2iPad.tag = 1;
    [mainScrool addSubview:featureButton2iPad];

    UILabel *lable2 = [[UILabel alloc] initWithFrame:CGRectMake(110, (DescriptionDetaillable.frame.size.height+DescriptionDetaillable.frame.origin.y)+90, 50, 18)];//(102, 150, 38, 12)
    lable2.text = @"Call";//Call//Menu//Share//Favorite
    lable2.textColor = [UIColor darkGrayColor];
    lable2.backgroundColor = [UIColor clearColor];
    lable2.textAlignment = NSTextAlignmentCenter;
    lable2.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    [mainScrool addSubview:lable2];

   featureButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
    featureButton3.frame = CGRectMake(190, (DescriptionDetaillable.frame.size.height+DescriptionDetaillable.frame.origin.y)+30, 50, 50);//(172, 110, 38, 38)
    [featureButton3 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[FeaturesArra objectAtIndex:2]]] forState:UIControlStateNormal];
    [featureButton3 addTarget:self action:@selector(featureMethod:) forControlEvents:UIControlEventTouchUpInside];
    featureButton3.tag = 2;
    
    hideMenuButtoniPad=featureButton3;

    if([maincategory isEqualToString:@"Casual Dining"] || [maincategory isEqualToString:@"Fine Dining"])
    {
        featureButton3.enabled=YES;
        if(!isMenu_availabel)
            featureButton3.enabled=NO;
    }
    else
    {
        featureButton3.enabled=NO;
        [featureButton3 setImage:[UIImage imageNamed:@"1menu_d.png"] forState:UIControlStateNormal];
   
    }
    [mainScrool addSubview:featureButton3];

    UILabel *lable3 = [[UILabel alloc] initWithFrame:CGRectMake(190, (DescriptionDetaillable.frame.size.height+DescriptionDetaillable.frame.origin.y)+90, 50, 18)];//(172, 150, 38, 12)
    lable3.text = @"Menu";//Call//Menu//Share//Favorite
    lable3.textColor = [UIColor darkGrayColor];
    lable3.backgroundColor = [UIColor clearColor];
    lable3.textAlignment = NSTextAlignmentCenter;
    lable3.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    [mainScrool addSubview:lable3];

    UIButton *featureButton4 = [UIButton buttonWithType:UIButtonTypeCustom];
    featureButton4.frame = CGRectMake(270, (DescriptionDetaillable.frame.size.height+DescriptionDetaillable.frame.origin.y)+30, 50, 50);//(242, 110, 38, 38)
    [featureButton4 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[FeaturesArra objectAtIndex:3]]] forState:UIControlStateNormal];
    [featureButton4 addTarget:self action:@selector(featureMethod:) forControlEvents:UIControlEventTouchUpInside];
    featureButton4.tag = 3;
    [mainScrool addSubview:featureButton4];

    UILabel *lable4 = [[UILabel alloc] initWithFrame:CGRectMake(270, (DescriptionDetaillable.frame.size.height+DescriptionDetaillable.frame.origin.y)+90, 50, 18)];//(242, 150, 38, 12)
    lable4.text = @"Share";//Call//Menu//Share//Favorite
    lable4.textColor = [UIColor darkGrayColor];
    lable4.backgroundColor = [UIColor clearColor];
    lable4.textAlignment = NSTextAlignmentCenter;
    lable4.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    [mainScrool addSubview:lable4];

    UIButton *featureButton6 = [UIButton buttonWithType:UIButtonTypeCustom];
    featureButton6.frame = CGRectMake(350, (DescriptionDetaillable.frame.size.height+DescriptionDetaillable.frame.origin.y)+30, 50, 50);//(32, 110, 38, 38)
    [featureButton6 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[FeaturesArra objectAtIndex:4]]] forState:UIControlStateNormal];
    [featureButton6 addTarget:self action:@selector(featureMethod:) forControlEvents:UIControlEventTouchUpInside];
    featureButton6.tag = 6;
    [mainScrool addSubview:featureButton6];

    UILabel *lable5 = [[UILabel alloc] initWithFrame:CGRectMake(350, (DescriptionDetaillable.frame.size.height+DescriptionDetaillable.frame.origin.y)+90, 60, 18)];
    lable5.text = @"Locations";//Call//Menu//Share//Favorite
    lable5.textColor = [UIColor darkGrayColor];
    lable5.backgroundColor = [UIColor clearColor];
    lable5.textAlignment = NSTextAlignmentCenter;
    lable5.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
    [mainScrool addSubview:lable5];

//    UIButton *featureButton5 = [UIButton buttonWithType:UIButtonTypeCustom];
//    featureButton5.frame = CGRectMake(280, 27, 25, 25);
//    [featureButton5 setImage:[UIImage imageNamed:@"fav_n.png"] forState:UIControlStateNormal];
//    featureButton5.tag=5;
//    [featureButton5 addTarget:self action:@selector(featureMethod:) forControlEvents:UIControlEventTouchUpInside];
//    [featureButton5 setSelected:NO];
//    [self.view addSubview:featureButton5];
    
    
    leftView.frame = CGRectMake(10, 10, 435, lable5.frame.size.height+lable5.frame.origin.y);
    
    //---------
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(455, 10, 303, 1000)];
    rightView.backgroundColor = [UIColor whiteColor];
    rightView.layer.cornerRadius = 5.0f;
    [mainScrool addSubview:rightView];

    //offersName title offerDesc
    
    UIImageView *offerTitleBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 402,768 ,30 )];
    offerTitleBack.backgroundColor = [UIColor blackColor];
    [self.view addSubview:offerTitleBack];
    
    UILabel *offernmlable = [[UILabel alloc] initWithFrame:CGRectMake(15, 406, 273, 25)];
    offernmlable.text = [NSString stringWithFormat:@"%@",offersName];
    offernmlable.textAlignment = NSTextAlignmentLeft;
    offernmlable.font = [UIFont fontWithName:@"Helvetica Neue" size:21];
    offernmlable.font = [UIFont boldSystemFontOfSize:21];
    offernmlable.textColor = [UIColor whiteColor];
    offernmlable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:offernmlable];
    
//    UILabel *offernmlable = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 273, 25)];
//    offernmlable.text = [NSString stringWithFormat:@"%@",offersName];
//    offernmlable.textAlignment = NSTextAlignmentCenter;
//    offernmlable.font = [UIFont fontWithName:@"Helvetica Neue" size:21];
//    offernmlable.font = [UIFont boldSystemFontOfSize:21];
//    offernmlable.textColor = [UIColor blackColor];
//    offernmlable.backgroundColor = [UIColor clearColor];
//    [rightView addSubview:offernmlable];
    
//    UILabel *offertitlelable = [[UILabel alloc] initWithFrame:CGRectMake(15,(offernmlable.frame.size.height+offernmlable.frame.origin.y), 273, 50)];
    UILabel *offertitlelable = [[UILabel alloc] initWithFrame:CGRectMake(15,15, 273, 50)];
    offertitlelable.text = [NSString stringWithFormat:@"%@",title];
    offertitlelable.textAlignment = NSTextAlignmentCenter;
    offertitlelable.numberOfLines = 2;
    offertitlelable.lineBreakMode = NSLineBreakByWordWrapping;
    offertitlelable.font = [UIFont fontWithName:@"Helvetica Neue" size:19];
    offertitlelable.textColor = [UIColor colorWithRed:205/255.0f green:63/255.0f blue:59/255.0f alpha:1.0f];
    offertitlelable.backgroundColor = [UIColor clearColor];
    [rightView addSubview:offertitlelable];
    
    CGSize labelSize2 = [offerDesc sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:16]
                                constrainedToSize:CGSizeMake(273, 9999)
                                    lineBreakMode:NSLineBreakByWordWrapping];
    
    UILabel *offerdesclable = [[UILabel alloc] initWithFrame:CGRectMake(15,(offertitlelable.frame.size.height+offertitlelable.frame.origin.y), 273, labelSize2.height)];
    offerdesclable.text = [NSString stringWithFormat:@"%@",offerDesc];
    offerdesclable.textAlignment = NSTextAlignmentLeft;
    offerdesclable.numberOfLines = 100;
    offerdesclable.lineBreakMode = NSLineBreakByWordWrapping;
    offerdesclable.font = [UIFont fontWithName:@"Helvetica Neue" size:16];
    offerdesclable.textColor = [UIColor lightGrayColor];
    offerdesclable.backgroundColor = [UIColor clearColor];
    [rightView addSubview:offerdesclable];
    
    //t And c
    
    UILabel *TandClable = [[UILabel alloc] initWithFrame:CGRectMake(15, (offerdesclable.frame.size.height+offerdesclable.frame.origin.y)+40, 273, 25)];
    TandClable.text = @"Terms & Conditions";
    TandClable.textAlignment = NSTextAlignmentLeft;
    TandClable.font = [UIFont fontWithName:@"Helvetica Neue" size:22];
//    TandClable.font = [UIFont boldSystemFontOfSize:25];
    TandClable.textColor = [UIColor blackColor];
    TandClable.backgroundColor = [UIColor clearColor];
    [rightView addSubview:TandClable];
    
    
    CGSize labelSize3 = [termsAndCondition sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:16]
                              constrainedToSize:CGSizeMake(273, 9999)
                                  lineBreakMode:NSLineBreakByWordWrapping];

    UILabel *TandCDetaillable = [[UILabel alloc] initWithFrame:CGRectMake(15, (TandClable.frame.size.height+TandClable.frame.origin.y)+5, 273,labelSize3.height)];//((labelSize3.height/20)*18)
    TandCDetaillable.text = termsAndCondition;
    TandCDetaillable.lineBreakMode = NSLineBreakByWordWrapping;
    TandCDetaillable.numberOfLines = 10;
    TandCDetaillable.textAlignment = NSTextAlignmentLeft;
    TandCDetaillable.font = [UIFont fontWithName:@"Helvetica Neue" size:16];
    TandCDetaillable.textColor = [UIColor darkGrayColor];
    TandCDetaillable.backgroundColor = [UIColor clearColor];
    [rightView addSubview:TandCDetaillable];
    
    //contact details
    UILabel *Contactdetailslable = [[UILabel alloc] initWithFrame:CGRectMake(15, (TandCDetaillable.frame.size.height+TandCDetaillable.frame.origin.y)+30, 273, 25)];
    Contactdetailslable.text = @"Contact Details";
    Contactdetailslable.textAlignment = NSTextAlignmentLeft;
    
        Contactdetailslable.font = [UIFont fontWithName:@"Helvetica Neue" size:22];
  
   // Contactdetailslable.font = [UIFont boldSystemFontOfSize:25];
    Contactdetailslable.textColor = [UIColor blackColor];
    Contactdetailslable.backgroundColor = [UIColor clearColor];
    [rightView addSubview:Contactdetailslable];
    
    UILabel *contactPersonlable = [[UILabel alloc] initWithFrame:CGRectMake(15, (Contactdetailslable.frame.size.height+Contactdetailslable.frame.origin.y)+10, 273, 22)];
//    contactPersonlable.text = @"Contact Person :";
//    contactPersonlable.textAlignment = NSTextAlignmentLeft;
//    contactPersonlable.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
//    contactPersonlable.font = [UIFont boldSystemFontOfSize:20];
//    contactPersonlable.textColor = [UIColor darkGrayColor];
//    contactPersonlable.backgroundColor = [UIColor clearColor];
//    [rightView addSubview:contactPersonlable];
    
    NSUInteger indexOfTheObject;
    
    if (Preaddress || Preaddress.length > 0)
    {
        indexOfTheObject = [location indexOfObject:Preaddress];
    }

    contactaddresslable = [[UILabel alloc] initWithFrame:CGRectMake(15, (contactPersonlable.frame.origin.y), 273, 40)];
    
    if (Preaddress.length > 0 || Preaddress.length)
        if ([addressArr count] > indexOfTheObject)
            contactaddresslable.text = [NSString stringWithFormat:@"Address: %@",[addressArr objectAtIndex:indexOfTheObject]];
        else
            contactaddresslable.text = @"Address:  ";
        else
            contactaddresslable.text = [NSString stringWithFormat:@"Address: %@",addressArr.firstObject];
    
    contactaddresslable.textAlignment = NSTextAlignmentLeft;
    contactaddresslable.font = [UIFont fontWithName:@"Helvetica Neue" size:16];
//    contactaddresslable.font = [UIFont boldSystemFontOfSize:16];
    contactaddresslable.numberOfLines=2;
    contactaddresslable.lineBreakMode=NSLineBreakByWordWrapping;
    contactaddresslable.textColor = [UIColor darkGrayColor];
    contactaddresslable.backgroundColor = [UIColor clearColor];
    [rightView addSubview:contactaddresslable];
    
    
    contactlocationlable = [[UILabel alloc] initWithFrame:CGRectMake(15, (contactaddresslable.frame.size.height+contactaddresslable.frame.origin.y)+10, 273, 20)];
    
    if (Preaddress || Preaddress.length > 0)
        contactlocationlable.text = [NSString stringWithFormat:@"Location: %@",Preaddress];
    else
        contactlocationlable.text = [NSString stringWithFormat:@"Location: %@",location.firstObject];
    
    contactlocationlable.textAlignment = NSTextAlignmentLeft;
    contactlocationlable.font = [UIFont fontWithName:@"Helvetica Neue" size:16];
//    contactlocationlable.font = [UIFont boldSystemFontOfSize:16];
    contactlocationlable.textColor = [UIColor darkGrayColor];
    contactlocationlable.backgroundColor = [UIColor clearColor];
    [rightView addSubview:contactlocationlable];
    
   contactphonelable = [[UILabel alloc] initWithFrame:CGRectMake(15, (contactlocationlable.frame.size.height+contactlocationlable.frame.origin.y)+10, 273, 20)];
    
    if (Preaddress.length > 0 || Preaddress.length)
        if ([phoneArr count] > indexOfTheObject)
            contactphonelable.text = [NSString stringWithFormat:@"Phone: %@",[phoneArr objectAtIndex:indexOfTheObject]];
        else
            contactphonelable.text = @"Phone:  ";
        else
            contactphonelable.text = [NSString stringWithFormat:@"Phone: %@",phoneArr.firstObject];
    
    contactphonelable.textAlignment = NSTextAlignmentLeft;
    contactphonelable.font = [UIFont fontWithName:@"Helvetica Neue" size:16];
//    contactphonelable.font = [UIFont boldSystemFontOfSize:16];
    contactphonelable.textColor = [UIColor darkGrayColor];
    contactphonelable.backgroundColor = [UIColor clearColor];
    [rightView addSubview:contactphonelable];
    
    contactemaillable = [[UILabel alloc] initWithFrame:CGRectMake(15, (contactphonelable.frame.size.height+contactphonelable.frame.origin.y)+10, 273, 40)];
    
    if (Preaddress.length > 0 || Preaddress.length)
        if ([emailArr count] > indexOfTheObject)
            contactemaillable.text = [NSString stringWithFormat:@"Email: %@",[emailArr objectAtIndex:indexOfTheObject]];
        else
            contactemaillable.text = @"Email:  ";
        else
            contactemaillable.text = [NSString stringWithFormat:@"Email: %@",emailArr.firstObject];
    

    if ([contactphonelable.text length] > 7)
    {
        [featureButton2iPad setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[FeaturesArra objectAtIndex:1]]] forState:UIControlStateNormal];
        featureButton2iPad.enabled = YES;
    }
    else
    {
        [featureButton2iPad setImage:[UIImage imageNamed:@"discall_1.png"] forState:UIControlStateNormal];
        featureButton2iPad.enabled = NO;
    }

    contactemaillable.textAlignment = NSTextAlignmentLeft;
    contactemaillable.font = [UIFont fontWithName:@"Helvetica Neue" size:16];
//    contactemaillable.font = [UIFont boldSystemFontOfSize:16];
    contactemaillable.numberOfLines=2;
    contactemaillable.lineBreakMode=NSLineBreakByWordWrapping;
    contactemaillable.textColor = [UIColor darkGrayColor];
    contactemaillable.backgroundColor = [UIColor clearColor];
    [rightView addSubview:contactemaillable];
    
    UIButton *emailPressebth = [UIButton buttonWithType:UIButtonTypeCustom];
    [emailPressebth addTarget:self action:@selector(ContactemailMethod) forControlEvents:UIControlEventTouchUpInside];
    emailPressebth.frame = CGRectMake(15, (contactphonelable.frame.size.height+contactphonelable.frame.origin.y)+10, 273, 19);
    [rightView addSubview:emailPressebth];
    
    
    rightView.frame = CGRectMake(455, 10, 303, (contactemaillable.frame.size.height+contactemaillable.frame.origin.y)+20);

    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        if(rightView.frame.size.height>leftView.frame.size.height)
        {
            dealsnearView.frame = CGRectMake(10, (rightView.frame.size.height+rightView.frame.origin.y)+20, 748, 250);//20 728
        }
        else
        {
            dealsnearView.frame = CGRectMake(10, (leftView.frame.size.height+leftView.frame.origin.y)+20, 748, 250);
        }
        
        
        dealsNearScrool.frame = CGRectMake(10, 55, 728, 200);//708
        dealsNearScrool.contentSize = CGSizeMake(300*similarOfferImg.count, 200);
        mainScrool.contentSize = CGSizeMake(768, (dealsnearView.frame.size.height+dealsnearView.frame.origin.y)+100);
    }
}

-(void) swipedScreenLeft:(UISwipeGestureRecognizer*)swipeGesture
{
    if (swipeGesture.direction == UISwipeGestureRecognizerDirectionRight)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
    }
}

- (void) nextMethod : (id) sender
{
  //UIButton *btn = (UIButton *) sender;
}


- (void) featureMethod : (id) sender
{
    UIButton *btn = (UIButton *) sender;
    
    if(btn.tag==0)
    {
     MapController *map ;//= nil;
        if ([lattitude count] && [longitude count])
        {
//            map=[[MapController alloc]initWithLat:[lattitude objectAtIndex:selectedArrIndex] andLong:[longitude objectAtIndex:selectedArrIndex]];
            
            map=[[MapController alloc]init];
            
            NSString *Latstring = [NSString stringWithFormat:@"%@",[lattitude objectAtIndex:selectedArrIndex]];
            Latstring = [Latstring stringByAppendingString:@"0000000000"];
            Latstring = [Latstring substringToIndex:8];
            
            NSString *Longstring = [NSString stringWithFormat:@"%@",[longitude objectAtIndex:selectedArrIndex]];
            Longstring = [Longstring stringByAppendingString:@"0000000000"];
            Longstring = [Longstring substringToIndex:8];
            
            map.lat=Latstring;
            map.lon=Longstring;
            
            
        }else
        {
              map=[[MapController alloc]init];
            
        }
        [self.navigationController pushViewController:map animated:YES];

    }

    else if(btn.tag==1)
    {
//        if ([phoneNumber length] > 0)
//        {
        
        NSString *phoneNumber1;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            phoneNumber1 = [NSString stringWithFormat: @"telprompt://%@",phonelabel1.text];
        }
        else
        {
            phoneNumber1 = [NSString stringWithFormat: @"telprompt://%@",contactphonelable.text];
            phoneNumber1 = [phoneNumber1 stringByReplacingOccurrencesOfString:@"Phone: " withString:@""];
        }
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber1]];
//        }
    }
    else if(btn.tag==2)
    {
        MenuController *menu=[[MenuController alloc]init];
        menu.stringUrl = menuGlobalUrl;
        [self.navigationController pushViewController:menu animated:YES];
    }
    else if(btn.tag==3)
    {
        NSString *message=[NSString stringWithFormat:@"I thought you’d like this:\n%@\n%@\nhttp://www.goodliving.ae",title,offersName];
        
        //NSString *message=[NSString stringWithFormat:@"%@ At %@ \nhttps://test.goodliving.ae",title,offersName];
        
        NSArray *poastitemsArray = [NSArray arrayWithObjects:shareImage,message, nil];
        
        UIActivityViewController *activityVC =
        [[UIActivityViewController alloc] initWithActivityItems:poastitemsArray
                                          applicationActivities:nil];
        
        [activityVC setValue:@"I found a great offer for you! Take a look" forKey:@"Subject"];
        
        activityVC.completionHandler = ^(NSString *activityType, BOOL completed)
        {
            if (completed == 1)
            {
                if (completed == 1)
                {
                    voucherAlert = [[UIAlertView alloc] initWithTitle:@"Please wait..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
                    [voucherAlert show];
                    
                    [self performSelector:@selector(SendVoucerStatus:) withObject:activityType afterDelay:0.1];
                }
            }
        };
        
        [self presentViewController:activityVC animated:YES completion:nil];
        
//        NSString *message=[NSString stringWithFormat:@"%@ At %@ \nhttps://test.goodliving.ae",title,offersName];
//        NSArray *poastitemsArray = [NSArray arrayWithObjects:shareImage,message, nil];
//        
//        UIActivityViewController *activityVC =
//        [[UIActivityViewController alloc] initWithActivityItems:poastitemsArray
//                                          applicationActivities:nil];
//        
//        activityVC.completionHandler = ^(NSString *activityType, BOOL completed)
//        {
//            if (completed == 1)
//            {
//                if (completed == 1)
//                {
//                    voucherAlert = [[UIAlertView alloc] initWithTitle:@"Please wait..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
//                    [voucherAlert show];
//                    
//                    [self performSelector:@selector(SendVoucerStatus:) withObject:activityType afterDelay:0.1];
//                }
//            }
//        };
//        
//        [self presentViewController:activityVC animated:YES completion:nil];
    }
    else if(btn.tag==6)
    {
        int loc=location.count;
//        int emir=emirates.count;
        
        mainLocationArr =[[NSMutableArray alloc]init];
   
      
            for(int i=0; i<loc ;i++)
            {
                [mainLocationArr addObject:[NSString stringWithFormat:@"%@,%@",[emirates objectAtIndex:i],[location objectAtIndex:i]]];
                
            }
        
        
          myPickerView = [[UIPickerView alloc] init];
        
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        myPickerView.frame=CGRectMake(30,184,260,200);
        else
            myPickerView.frame=CGRectMake(60,500,648,500);
        myPickerView.delegate = self;
        myPickerView.showsSelectionIndicator = YES;
        myPickerView.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:myPickerView];
        
    }
     else if(btn.tag==5)
    {
        if(delegate.loginFlag==0)
        {
            showAlert2 = [[UIAlertView alloc] initWithTitle:@"Like this offer?" message:@"Sign in / Register to access our Gulf News subscriber exclusive Premium offers." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            showAlert2.tag=7;
            [showAlert2 show];
        }
        
        else{
            
            getNewestAlert = [[UIAlertView alloc] initWithTitle:@"Please wait..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [getNewestAlert show];

            
            if([[NSString stringWithFormat:@"%@",is_favorite] isEqualToString:@"1"])
            {
                
                if([btn isSelected]==YES)
                {
                    [self performSelectorInBackground:@selector(addFavorite) withObject:nil];
                    [btn setImage:[UIImage imageNamed:@"fav_p.png"] forState:UIControlStateNormal];
                    [btn setSelected:NO];

                    
//                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                        [self addFavorite];
//                        
//                        [btn setImage:[UIImage imageNamed:@"fav_p.png"] forState:UIControlStateNormal];
//                        [btn setSelected:NO];
//                    });
                    
                   
                    
                    
                }
                else
                {
                    [self performSelectorInBackground:@selector(removeFavorite) withObject:nil];
                    [btn setImage:[UIImage imageNamed:@"fav_n.png"] forState:UIControlStateNormal];
                    [btn setSelected:YES];

                    
//                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                        [self removeFavorite];
//                        
//                        [btn setImage:[UIImage imageNamed:@"fav_n.png"] forState:UIControlStateNormal];
//                        [btn setSelected:YES];
//                    });
                    
                 }
                
            
            }
            
            else
            {
                if([btn isSelected]==YES)
                {
                    [self performSelectorInBackground:@selector(removeFavorite) withObject:nil];
                    [btn setImage:[UIImage imageNamed:@"fav_n.png"] forState:UIControlStateNormal];
                    [btn setSelected:NO];

                    
//                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                        [self removeFavorite];
//                        
//                        [btn setImage:[UIImage imageNamed:@"fav_n.png"] forState:UIControlStateNormal];
//                        [btn setSelected:NO];
//                    });
                }
                else
                {
//                    activityIndicatorNew =[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//                    activityIndicatorNew.color = [UIColor grayColor];
//                    
//                    CGRect indicatorFrame =activityIndicatorNew.frame;
//                    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
//                    {
//                        indicatorFrame.origin.x = 705;
//                        indicatorFrame.origin.y =21;
//                    }
//                    else
//                    {
//                        indicatorFrame.origin.x = 278;
//                        indicatorFrame.origin.y =21;
//                    }                    activityIndicatorNew.frame = indicatorFrame;
//                    
//                    [self.view addSubview:activityIndicatorNew];
//                    
//                    //[activityIndicatorNew startAnimating];
//
//                      [activityIndicatorNew performSelectorOnMainThread:@selector(startAnimating) withObject:nil waitUntilDone:YES];
//
                    [self performSelectorInBackground:@selector(addFavorite) withObject:nil];
                    [btn setImage:[UIImage imageNamed:@"fav_p.png"] forState:UIControlStateNormal];
                    [btn setSelected:YES];
//                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                            [self addFavorite];
//                        [btn setImage:[UIImage imageNamed:@"fav_p.png"] forState:UIControlStateNormal];
//                        [btn setSelected:YES];
//
//                    });
                   
                    
                }

            }
        }

}

}


- (void) SendVoucerStatus : (NSString *) type
{
    NSArray *array = [type componentsSeparatedByString:@"."];
    NSString *string;
    if ([[array objectAtIndex:[array count]-1] isEqualToString:@"PostToTwitter"] == TRUE)
        string = @"Twiter";
    else if ([[array objectAtIndex:[array count]-1] isEqualToString:@"PostToFacebook"] == TRUE)
        string = @"Facebook";
    else
        string = type;
    
    NSString *url = [NSString stringWithFormat:@"https://testws.goodliving.ae/api/index.php/offer/storeShareOffer/%@/%@/%@/iPhone",delegate.userID,nearestOfferID,string];
    
    url=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    NSHTTPURLResponse *response = nil;
    NSError *error = [[NSError alloc] init];
    NSData *data= [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSDictionary*json;
    if (data)
    {
        NSError* error;
        json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        //        NSMutableArray *DataArray = [json objectForKey:@"data"];
        
        [voucherAlert dismissWithClickedButtonIndex:0 animated:YES];
    }
    //        loginUsername= [[DataArray objectAtIndex:0] valueForKey:@"Mobile__c"];
}

- (void)downloadVoucherMethod
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    // getting an dictionary
    NSDictionary *mydictionary=(NSDictionary *) [prefs objectForKey:@"Registration"];
    NSString *subType=[mydictionary valueForKey:@"subType"];

    if(delegate.loginFlag==0)
    {
        showAlert2 = [[UIAlertView alloc] initWithTitle:@"Like this offer?" message:@"Sign in / Register to access our Gulf News subscriber exclusive Premium offers." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];showAlert2.tag=7;
        [showAlert2 show];
    }
    
    else if([[NSString stringWithFormat:@"%@",subType] isEqualToString:@"0"]==TRUE && [[NSString stringWithFormat:@"%@",is_non_subscriber] isEqualToString:@"1"]==TRUE)
    {
        showAlert = [[UIAlertView alloc] initWithTitle:@"Locked!" message:@"Locked! Open only to Gulf News subscribers.Subscribe now & start saving or Call 80045" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [showAlert show];
    }
    
    else if([[NSString stringWithFormat:@"%@",is_downloaded] isEqualToString:@"1"]== TRUE )//&& [[NSString stringWithFormat:@"%@",subType] isEqualToString:@"0"]==FALSE && [[NSString stringWithFormat:@"%@",is_non_subscriber] isEqualToString:@"0"]==FALSE
    {
        myAlert = [[UIAlertView alloc] initWithTitle:@"Confirm?"
                                             message:@"The offer will get downloaded. Do you wish to continue? "
                                            delegate:self
                                   cancelButtonTitle:nil
                                   otherButtonTitles:@"Yes", @"No", nil];
        myAlert.tag=3;
        [myAlert show];

        //Commented By Gafar on
//        showAlert = [[UIAlertView alloc] initWithTitle:@"Download Voucher" message:@"Voucher already downloaded." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [showAlert show];
        
    }

    
   
    
    //[[NSString stringWithFormat:@"%@",is_subscriber] isEqualToString:@"0"]==TRUE

    else if(check==YES)
    {
     myAlert = [[UIAlertView alloc] initWithTitle:@"Confirm?"
                                                          message:@"The offer will get downloaded. Do you wish to continue? "
                                                         delegate:self
                                                cancelButtonTitle:nil
                                                otherButtonTitles:@"Yes", @"No", nil];
        myAlert.tag=3;
        [myAlert show];
        
    }
    else
    {
        myAlert = [[UIAlertView alloc] initWithTitle:@"Confirm?"
                                             message:@"The offer will get downloaded. Do you wish to continue? "
                                            delegate:self
                                   cancelButtonTitle:nil
                                   otherButtonTitles:@"Yes", @"No", nil];
        myAlert.tag=3;
        [myAlert show];

        
//        showAlert = [[UIAlertView alloc] initWithTitle:@"Download Voucher." message:@"Voucher already downloaded." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [showAlert show];

    }
    
}


-(void)addDownloadVoucherMethod
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSString *userId1=delegate.userID;
        NSString *offerID1=offerID;//offerID;
        NSString *iPhoneOriPad;
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            iPhoneOriPad=@"iPhone";
        }
        else
        {
            iPhoneOriPad=@"iPad";
        }
        
        NSString *url = [NSString stringWithFormat:@"https://testws.goodliving.ae/api/index.php/offer/downloadVoucher/%@/%@/%@/UserApp",userId1,offerID1,iPhoneOriPad];
        url=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//request.URL=[NSURL URLWithString:url];
        [request setURL:[NSURL URLWithString:url]];
        [request setHTTPMethod:@"POST"];
        NSHTTPURLResponse *response = nil;
        NSError *error = [[NSError alloc] init];
        NSData *data= [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        NSString *returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSDictionary*json;
        if (data)
        {
            NSError* error;
            json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSMutableArray *DataArray = [json objectForKey:@"data"];
            
            NSString *status=[[DataArray objectAtIndex:0] valueForKey:@"status"];
            NSString *message=[[DataArray objectAtIndex:0] valueForKey:@"msg"];
        
            if ([[NSString stringWithFormat:@"%@",status] isEqual:@"1"]) {
                
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Success!" message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                alertView.delegate=self;
                alertView.tag=2;
                [alertView show];

            }
            else
            {
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
            }
            
        }
        
    });
}

- (void) backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark AlertView Delegate
    
    - (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
    {
    
        if(alertView.tag==2)
        {
            if (buttonIndex==0) {
               
                check=NO;
            }
            
        }
       else if(alertView.tag==3)
        {
            if(buttonIndex==0)
            {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [self addDownloadVoucherMethod];
                });

            }
            else
            {
                [myAlert dismissWithClickedButtonIndex:0 animated:YES];
            }
        }
        
       else if(alertView.tag==7)
       {
           delegate.loginFlag=1;
            ViewController *nextView=[[ViewController alloc]init];
            [self.navigationController pushViewController:nextView animated:YES];

       // [showAlert dismissWithClickedButtonIndex:0 animated:YES];
        }
        
        else if(alertView.tag==105)
        {
          if(buttonIndex==1)
            {
                
                NSString *message=[NSString stringWithFormat:@"%@ At %@ \nhttps://test.goodliving.ae",title,offersName];
                
                NSArray *poastitemsArray = [NSArray arrayWithObjects:shareImage,message, nil];
                
                UIActivityViewController *activityVC =
                [[UIActivityViewController alloc] initWithActivityItems:poastitemsArray
                                                  applicationActivities:nil];
                
                activityVC.completionHandler = ^(NSString *activityType, BOOL completed)
                {
                    if (completed == 1)
                    {
             
                        if (completed == 1)
                        {
                            voucherAlert = [[UIAlertView alloc] initWithTitle:@"Please wait..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
                            [voucherAlert show];
                            
                            [self performSelector:@selector(SendVoucerStatus:) withObject:activityType afterDelay:0.1];
                        }
                    }
                };
                
                [self presentViewController:activityVC animated:YES completion:nil];
                
              
            }
        }
    }
    
    
#pragma mark - Picker View Delegate

-(void)pickerViewTapGestureRecognized:(id)sender
{
    UIGestureRecognizer *gestureRecognizer=(UIGestureRecognizer *)sender;
    CGPoint touchPoint = [gestureRecognizer locationInView:gestureRecognizer.view.superview];
    
    CGRect frame = myPickerView.frame;
    CGRect selectorFrame = CGRectInset( frame, 0.0, myPickerView.bounds.size.height * 0.85 / 2.0 );
    
    if( CGRectContainsPoint( selectorFrame, touchPoint) )
    {
//        genderTextfield.text=[genderArray objectAtIndex:[myPickerView selectedRowInComponent:0]];
        [self pickerView:myPickerView didSelectRow:[myPickerView selectedRowInComponent:0] inComponent:0];
        [myPickerView removeFromSuperview];
    }
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return true;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger numRows=mainLocationArr.count;
    return numRows;
}
// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    selectedArrIndex = row;
//   contactpersonlabel1
    
    if ([[lattitude objectAtIndex:0] isEqualToString:@"0"] == FALSE || [[longitude objectAtIndex:0] isEqualToString:@"0"] == FALSE)
    {
        featureButtonmap.userInteractionEnabled = YES;
        [featureButtonmap setImage:[UIImage imageNamed:@"1map.png"] forState:UIControlStateNormal];
    }
    
    row=[pickerView selectedRowInComponent:0];
    
//    if(row==0)
//    {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        contactaddresslable.text = [NSString stringWithFormat:@"Address: %@",[addressArr objectAtIndex:row]];
        contactlocationlable.text=[NSString stringWithFormat:@"Location: %@",[location objectAtIndex:row]];

        contactphonelable.text=[NSString stringWithFormat:@"Phone: %@",[phoneArr objectAtIndex:row]];

        contactemaillable.text=[NSString stringWithFormat:@"Email: %@",[emailArr objectAtIndex:row]];
        if ([contactphonelable.text length] > 7)
        {
            [featureButton2iPad setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[FeaturesArra objectAtIndex:1]]] forState:UIControlStateNormal];
            featureButton2iPad.enabled = YES;
        }
        else
        {
            [featureButton2iPad setImage:[UIImage imageNamed:[NSString stringWithFormat:@"discall_1.png"]] forState:UIControlStateNormal];
            featureButton2iPad.enabled = NO;
        }
        
    }
        addresslabel1.text=[NSString stringWithFormat:@"%@",[addressArr objectAtIndex:row]];
        locationlabel1.text = [NSString stringWithFormat:@"%@",[location objectAtIndex:row]];
        phonelabel1.text=[NSString stringWithFormat:@"%@",[phoneArr objectAtIndex:row]];
        emaillabel1.text=[NSString stringWithFormat:@"%@",[emailArr objectAtIndex:row]];
        phoneNumber =[NSString stringWithFormat:@"%@",[phoneArr objectAtIndex:row]];
    
    if ([phonelabel1.text length] > 0)
    {
        [featureButton2 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[FeaturesArra objectAtIndex:1]]] forState:UIControlStateNormal];
        featureButton2.enabled = YES;
    }
    else
    {
        [featureButton2 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[FeaturesArra objectAtIndex:1]]] forState:UIControlStateNormal];
        featureButton2.enabled = NO;
    }


//    }
//    else if(row==1)
//    {
//        addresslabel1.text=[NSString stringWithFormat:@"%@",[addressArr objectAtIndex:1]];
//        phonelabel1.text=[NSString stringWithFormat:@"%@",[phoneArr objectAtIndex:1]];
//        emaillabel1.text=[NSString stringWithFormat:@"%@",[emailArr objectAtIndex:1]];
//    }
//    
//    else if(row==2)
//    {
//        addresslabel1.text=[NSString stringWithFormat:@"%@",[addressArr objectAtIndex:2]];
//        phonelabel1.text=[NSString stringWithFormat:@"%@",[phoneArr objectAtIndex:2]];
//        emaillabel1.text=[NSString stringWithFormat:@"%@",[emailArr objectAtIndex:2]];
//    }
//
//    else if(row==3)
//    {
//        addresslabel1.text=[NSString stringWithFormat:@"%@",[addressArr objectAtIndex:3]];
//        phonelabel1.text=[NSString stringWithFormat:@"%@",[phoneArr objectAtIndex:3]];
//        emaillabel1.text=[NSString stringWithFormat:@"%@",[emailArr objectAtIndex:3]];
//    }
//    else
//    {
//        addresslabel1.text=[NSString stringWithFormat:@"%@",[addressArr objectAtIndex:4]];
//        phonelabel1.text=[NSString stringWithFormat:@"%@",[phoneArr objectAtIndex:4]];
//        emaillabel1.text=[NSString stringWithFormat:@"%@",[emailArr objectAtIndex:4]];
//    }

    myPickerView.hidden=YES;
//    emaillabel1.text =[mainLocationArr objectAtIndex:row];
//    [emaillabel1 resignFirstResponder];

    
  //[emirateLable setText:[NSString stringWithFormat:@"%@",[locationArr objectAtIndex:[pickerView selectedRowInComponent:0]]]];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [mainLocationArr objectAtIndex:row];
    
}
// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    CGFloat componentWidth = 0.0;
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        
        componentWidth = 260.0;
    }
    else
    {
        
        componentWidth = 600.0;
    }
    return componentWidth;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* tView = (UILabel*)view;
      if (!tView)
    {
        tView = [[UILabel alloc] init];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if (self.view.frame.size.height == 568)
            {
                [tView setFont:[UIFont fontWithName:@"Helvetica" size:12]];
            }
            else
            {
                [tView setFont:[UIFont fontWithName:@"Helvetica" size:10]];
                
            }
        }
        else
        {
            [tView setFont:[UIFont fontWithName:@"Helvetica" size:20]];
        }
    }
    // Fill the label text here
    tView.text=[mainLocationArr objectAtIndex:row];
    tView.textAlignment = NSTextAlignmentCenter;
  
    return tView;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [myPickerView removeFromSuperview];
}


#pragma mark - Scroll delegate methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    float fractionalPage = scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    pageControl.currentPage = page;
}

//- (void) gnOffersMethod1 : (id) sender
//{
//    [self viewDidLoad];
//   // UIButton *btn = (UIButton *) sender;
//}

-(void)newestOfferDetails
{
    @try {
        
        
        NSString *url=offerDetailsURL;
        
        
        if(newestOfferID!=nil)
            url=[url stringByAppendingString:newestOfferID];
        
        if (delegate.userID!=nil) {
            NSString *str=@"/";
            str=[str stringByAppendingString:delegate.userID];
            url=[url stringByAppendingString:str];
        }
        
        NSString *urlString =url;
        
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *Final_Url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",urlString]];
        
        NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:Final_Url];
        [request setValue:@"Basic Z2xvYnVzdXNlcjpHbDBidVMyMDE0" forHTTPHeaderField:@"Authorization"];
        
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        NSDictionary*json;
        if (data)
        {
            NSError* error;
            json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSMutableArray *DataArray = [json objectForKey:@"data"];
            
            maincategory=[[DataArray objectAtIndex:0] valueForKey:@"Main_Category__c"] ;
            
            if([maincategory isEqualToString:@"Casual Dining"] || [maincategory isEqualToString:@"Fine Dining"])
            {
                featureButton3.enabled=YES;
                isMenu_availabel=YES;
                if ( [[DataArray objectAtIndex:0] valueForKey:@"Menu_URL"]== nil || [[[DataArray objectAtIndex:0] valueForKey:@"Menu_URL"] isEqual:[NSNull null]]|| [[[DataArray objectAtIndex:0] valueForKey:@"Menu_URL"] isEqualToString:@""])
                {
                    featureButton3.enabled=NO;
                    isMenu_availabel=NO;
                }
                else
                {
                    menuGlobalUrl = [NSString stringWithFormat:@"%@",[[DataArray objectAtIndex:0] valueForKey:@"Menu_URL"]];
                }
                
//                hideMenuButton.enabled=YES;
            }
            else
            {
                [featureButton3 setImage:[UIImage imageNamed:@"1menu_d.png"] forState:UIControlStateNormal];
                featureButton3.enabled=NO;
                
//                [hideMenuButtoniPad setImage:[UIImage imageNamed:@"1menu_d.png"] forState:UIControlStateNormal];
//                hideMenuButtoniPad.enabled=NO;
            }
            
            
            offerID=[[DataArray objectAtIndex:0] valueForKey:@"Offer_id"] ;
            title=[[DataArray objectAtIndex:0] valueForKey:@"Title"] ;
            offerDesc=[[DataArray objectAtIndex:0] valueForKey:@"Offer_Description__c"];
            termsAndCondition=[[DataArray objectAtIndex:0] valueForKey:@"Terms_Conditions__c"];
            offersName=[[DataArray objectAtIndex:0] valueForKey:@"Name"];
            
            is_favorite=[[DataArray objectAtIndex:0] valueForKey:@"is_fav"];
            is_downloaded= [[DataArray objectAtIndex:0] valueForKey:@"is_voucher_download"];
            is_non_subscriber=[[DataArray objectAtIndex:0]valueForKey:@"For_Non_Subscribers__c"];
            
            is_subscriber=[[DataArray objectAtIndex:0]valueForKey:@"For_Subscribers__c"];
            
            logoUrl=[[DataArray objectAtIndex:0] valueForKey:@"Logo_URL__c"];
            merchantDesc=[[DataArray objectAtIndex:0] valueForKey:@"Description__c"];
            
            offerImg1=[[DataArray objectAtIndex:0] valueForKey:@"Offer_Image_1__c"];
            offerImg2=[[DataArray objectAtIndex:0] valueForKey:@"Offer_Image_2__c"];
            offerImg3=[[DataArray objectAtIndex:0] valueForKey:@"Offer_Image_3__c"];
            offerImg4=[[DataArray objectAtIndex:0] valueForKey:@"Offer_Image_4__c"];
            offerImg5=[[DataArray objectAtIndex:0] valueForKey:@"Offer_Image_5__c"];
            
            is_premium =[[DataArray objectAtIndex:0] valueForKey:@"is_premium"];
            is_new =[[DataArray objectAtIndex:0] valueForKey:@"New"];
            
            offerArr =[[NSMutableArray alloc]init];
            
            if (offerImg1.length>0)
            {
                [offerArr addObject:offerImg1];
            }
            if (offerImg2.length > 0)
            {
                [offerArr addObject:offerImg2];
            }
            if (offerImg3.length > 0)
            {
                [offerArr addObject:offerImg3];
            }
            if (offerImg4.length > 0)
            {
                [offerArr addObject:offerImg4];
            }
            if (offerImg5.length > 0)
            {
                [offerArr addObject:offerImg5];
            }
            
            pageControl.numberOfPages = [offerArr count];
            
            location=[[NSMutableArray alloc]init];
            emirates=[[NSMutableArray alloc]init];
            locationId=[[NSMutableArray alloc]init];
            
            addressArr=[[NSMutableArray alloc]init];
            emailArr=[[NSMutableArray alloc]init];
            contactPersonNameArr=[[NSMutableArray alloc]init];
            
            phoneArr=[[NSMutableArray alloc]init];
            lattitude =[[NSMutableArray alloc]initWithCapacity:0];
            longitude =[[NSMutableArray alloc]initWithCapacity:0];
            
            //        contactPersonName=[[DataArray objectAtIndex:0] valueForKey:@"Address__c"];
            //        email=[[DataArray objectAtIndex:0] valueForKey:@"Email__c"];
            //        address=[[DataArray objectAtIndex:0] valueForKey:@"Logo_URL__c"];
            //        phone=[[DataArray objectAtIndex:0] valueForKey:@"Telephone__c"];
            
            for(int i=0; i<[DataArray count];i++)
            {
                [location addObject:[[DataArray objectAtIndex:i] valueForKey:@"Location__c"] ];
                [emirates addObject:[[DataArray objectAtIndex:i] valueForKey:@"Emirate__c"]];
                [locationId addObject:[[DataArray objectAtIndex:i] valueForKey:@"Loc_id"]];
                
                [addressArr addObject:[[DataArray objectAtIndex:i] valueForKey:@"Address__c"] ];
                [emailArr addObject:[[DataArray objectAtIndex:i] valueForKey:@"Email__c"]];
                //  [contactPersonNameArr addObject:[[DataArray objectAtIndex:i] valueForKey:@"Logo_URL__c"]];
                [phoneArr addObject:[[DataArray objectAtIndex:i] valueForKey:@"Telephone__c"]];
                
                phoneNumber = [[DataArray objectAtIndex:0] valueForKey:@"Telephone__c"];
                
                [geoCordinates addObject:[[DataArray objectAtIndex:i]valueForKey:@"Geo_Coordinates__c"]];
                
                [lattitude addObject:[[DataArray objectAtIndex:i]valueForKey:@"lat"]];
                [longitude addObject:[[DataArray objectAtIndex:i]valueForKey:@"long"]];
            }
        }
        
        
        //Offer_Detail
        if (newestOfferID && title && offersName)
        {
            [Flurry logEvent:[NSString stringWithFormat:@"Offer Details - %@ - %@",offersName,title]];
            [Flurry logPageView];
            
            //Google Analytics
            self.screenName = [NSString stringWithFormat:@"Offer Details - %@ - %@",offersName,title];
        }
        
        if ([[lattitude objectAtIndex:0] isEqualToString:@"0"] == FALSE || [[longitude objectAtIndex:0] isEqualToString:@"0"] == FALSE)
        {
            featureButtonmap.userInteractionEnabled = YES;
            [featureButtonmap setImage:[UIImage imageNamed:@"1map.png"] forState:UIControlStateNormal];
        }
        
        

        
        [getNewestAlert dismissWithClickedButtonIndex:0 animated:YES];
        
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            [self performSelector:@selector(offerNameAndDesc) withObject:nil afterDelay:0.1];
        }
        
        [self performSelector:@selector(restorantImg) withObject:nil afterDelay:0.1];
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            [self ipadDesigns];
        }

    }
    @catch (NSException *exception)
    {
        }
   
}

-(void)offerNameAndDesc
{
    UIImageView *offerNameBackimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 207, 320, 30)];
    offerNameBackimage.backgroundColor = [UIColor blackColor];
    [self.view addSubview:offerNameBackimage];
    
    UILabel *offertitlelabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 212, 300, 20)];
    offertitlelabel.text = offersName;
    offertitlelabel.textAlignment = NSTextAlignmentLeft;
    offertitlelabel.textColor = [UIColor whiteColor];
    offertitlelabel.backgroundColor = [UIColor clearColor];
    offertitlelabel.font = [UIFont fontWithName:@"Helvetica Neue" size:16];
    [self.view addSubview:offertitlelabel];
    
    //-------------------------------Downlaod Voucher
    UIView *DownloadVoucher = [[UIView alloc] initWithFrame:CGRectMake(5, 0, 310, 95)];
    DownloadVoucher.backgroundColor = [UIColor whiteColor];
    DownloadVoucher.layer.cornerRadius = 5.0f;
    [mainScrool addSubview:DownloadVoucher];
    
    UILabel *discountlabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 160, 20)];
    discountlabel.text = title;
    discountlabel.textAlignment = NSTextAlignmentLeft;
    discountlabel.textColor = [UIColor colorWithRed:205/255.0f green:63/255.0f blue:59/255.0f alpha:1.0f];
    discountlabel.backgroundColor = [UIColor clearColor];
    discountlabel.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    [DownloadVoucher addSubview:discountlabel];
    
    if ([is_premium isEqualToString:@"1"] == TRUE)
    {
        UIImageView *imageprimium = [[UIImageView alloc] initWithFrame:CGRectMake(169, 11, 92, 18)];
        imageprimium.image = [UIImage imageNamed:@"premiumoffer.png"];
        [DownloadVoucher addSubview:imageprimium];
    }
    else
    {
        discountlabel.frame = CGRectMake(5,10 ,discountlabel.frame.size.width+92 , discountlabel.frame.size.height);
    }
    
    if ([is_new isEqualToString:@"1"] == TRUE)
    {
        UIImageView *imagenew = [[UIImageView alloc] initWithFrame:CGRectMake(263, 11, 35, 18)];
        imagenew.image = [UIImage imageNamed:@"new.png"];
        [DownloadVoucher addSubview:imagenew];
    }
    else
    {
        discountlabel.frame = CGRectMake(5,10 ,discountlabel.frame.size.width+35 , discountlabel.frame.size.height);
    }
    
    
    CGSize labelSizeOD = [offerDesc sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:12]
                               constrainedToSize:CGSizeMake(300, 9999)
                                   lineBreakMode:NSLineBreakByWordWrapping];
    
    if (labelSizeOD.height > 40)
    {
        labelSizeOD.height = 40;
    }
    
    UILabel *offerDetaillabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 40, 300, labelSizeOD.height)];
    offerDetaillabel.text = offerDesc;
    offerDetaillabel.textAlignment = NSTextAlignmentLeft;
    offerDetaillabel.numberOfLines = 3;
    offerDetaillabel.lineBreakMode = NSLineBreakByWordWrapping;
    offerDetaillabel.textColor = [UIColor grayColor];
    offerDetaillabel.backgroundColor = [UIColor clearColor];
    offerDetaillabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
    [DownloadVoucher addSubview:offerDetaillabel];


    
    //-------------------DescriptionView
    descriptionView = [[UIView alloc] init];
    descriptionView.frame = CGRectMake(5, 170, 310, 200);
    descriptionView.backgroundColor = [UIColor whiteColor];
    descriptionView.layer.cornerRadius = 5.0f;
    [mainScrool addSubview:descriptionView];

    UIImageView *pofferimg = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 100, 100)];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",logoUrl]]]];
    
    if (img.size.width*2 <  pofferimg.frame.size.width || img.size.height*2 < pofferimg.frame.size.height)
    {
        [pofferimg setContentMode:UIViewContentModeScaleAspectFit];
    }
    
    pofferimg.image = img;

    [descriptionView addSubview:pofferimg];
    
    UILabel *descriptionlabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 10, 290, 20)];
    descriptionlabel.text = @"Description";
    descriptionlabel.textAlignment = NSTextAlignmentLeft;
    descriptionlabel.textColor = [UIColor blackColor];
    descriptionlabel.backgroundColor = [UIColor clearColor];
    descriptionlabel.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    //descriptionlabel.font = [UIFont boldSystemFontOfSize:16];
    [descriptionView addSubview:descriptionlabel];
    
    CGSize labelSize = [merchantDesc sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:12]
                                                   constrainedToSize:CGSizeMake(200, 500)
                                                       lineBreakMode:NSLineBreakByWordWrapping];
    descHeight = (labelSize.height/12)*12;
    
    UILabel *descriptionDetaillabel=[[UILabel alloc]initWithFrame:CGRectMake(110, 30, 200, descHeight+10)];
    descriptionDetaillabel.text = merchantDesc;
    descriptionDetaillabel.lineBreakMode = NSLineBreakByWordWrapping;
    descriptionDetaillabel.textAlignment = NSTextAlignmentLeft;
    descriptionDetaillabel.numberOfLines = 100;
    descriptionDetaillabel.textColor = [UIColor grayColor];
    descriptionDetaillabel.backgroundColor = [UIColor clearColor];
    descriptionDetaillabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
    [descriptionView addSubview:descriptionDetaillabel];

    descriptionView.frame = CGRectMake(5, 170, 310, descHeight+40);

    if (descHeight+40 < 100)
    {
        pofferimg.frame = CGRectMake(5, 10, descHeight+20, descHeight+20);
    }
  
    //-------------------T&C
    UIView *termsAndConditionView = [[UIView alloc] init];
    termsAndConditionView.frame = CGRectMake(5, descriptionView.frame.origin.y+descHeight+65, 310, 120);
    termsAndConditionView.backgroundColor = [UIColor whiteColor];
    termsAndConditionView.layer.cornerRadius = 5.0f;
    [mainScrool addSubview:termsAndConditionView];
    
    UILabel *TermsandConditionlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 290, 20)];
    TermsandConditionlabel.text = @"Terms & Conditions";
    TermsandConditionlabel.textAlignment = NSTextAlignmentLeft;
    TermsandConditionlabel.textColor = [UIColor blackColor];
    TermsandConditionlabel.backgroundColor = [UIColor clearColor];
    TermsandConditionlabel.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
  //  TermsandConditionlabel.font = [UIFont boldSystemFontOfSize:16];
    [termsAndConditionView addSubview:TermsandConditionlabel];
    
    CGSize labelSize1 = [termsAndCondition sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:12]
                                constrainedToSize:CGSizeMake(290, 500)
                                    lineBreakMode:NSLineBreakByWordWrapping];
    tANDcHeight = (labelSize1.height/12)*13;
    
    UILabel *TandCDetaillabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 290, tANDcHeight)];
    TandCDetaillabel.text =termsAndCondition;
    TandCDetaillabel.textAlignment = NSTextAlignmentLeft;
    TandCDetaillabel.lineBreakMode = NSLineBreakByWordWrapping;
    TandCDetaillabel.numberOfLines = 100;
    TandCDetaillabel.textColor = [UIColor grayColor];
    TandCDetaillabel.backgroundColor = [UIColor clearColor];
    TandCDetaillabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
    [termsAndConditionView addSubview:TandCDetaillabel];
    
    termsAndConditionView.frame = CGRectMake(5, descriptionView.frame.origin.y+descHeight+45, 310, tANDcHeight+45);

    ContactInfoView.frame = CGRectMake(5, termsAndConditionView.frame.origin.y+tANDcHeight+50, 310, 140);
    dealsnearView.frame = CGRectMake(5, ContactInfoView.frame.origin.y+ContactInfoView.frame.size.height+5, 310, 125);

    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        mainScrool.contentSize = CGSizeMake(320, (dealsnearView.frame.origin.y+dealsnearView.frame.size.height)+60);
    }



    //------------ Contact Details
    
//    contactpersonlabel1 = [[UILabel alloc] initWithFrame:CGRectMake(110, 40, 200, 14)];
//    contactpersonlabel1.text = @"";
//    contactpersonlabel1.textAlignment = NSTextAlignmentLeft;
//    contactpersonlabel1.textColor = [UIColor grayColor];
//    contactpersonlabel1.backgroundColor = [UIColor clearColor];
//    contactpersonlabel1.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
    //[ContactInfoView addSubview:contactpersonlabel1];
    
    NSUInteger indexOfTheObject;
    
    if (Preaddress || Preaddress.length > 0)
    {
        indexOfTheObject = [location indexOfObject:Preaddress];
    }
    
    CGSize labelSize11;
    if (Preaddress.length > 0)
    {
        if ([addressArr count] > indexOfTheObject)
            labelSize11 = [[addressArr objectAtIndex:indexOfTheObject] sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:12]
                                                                  constrainedToSize:CGSizeMake(200, 9999)
                                                                      lineBreakMode:NSLineBreakByWordWrapping];
        else
        {
            labelSize11.height = 0;
            labelSize11.width = 0;
        }
    }
    else
    {
        labelSize11 = [addressArr.firstObject sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:12]
                                         constrainedToSize:CGSizeMake(200, 9999)
                                             lineBreakMode:NSLineBreakByWordWrapping];
    }

    if(labelSize11.height > 28)
    {
        labelSize11.height = 28;
    }
    

    addresslabel1 = [[UILabel alloc] initWithFrame:CGRectMake(110, 35, 200, labelSize11.height)];//55
    
    addresslabel1.textAlignment = NSTextAlignmentLeft;
    addresslabel1.textColor = [UIColor grayColor];
    addresslabel1.numberOfLines=2;
    addresslabel1.backgroundColor = [UIColor clearColor];
    addresslabel1.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
    [ContactInfoView addSubview:addresslabel1];

    if (Preaddress.length > 0)
        if ([addressArr count] > indexOfTheObject)
            addresslabel1.text = [addressArr objectAtIndex:indexOfTheObject];
        else
            addresslabel1.text = @"";
    else
        addresslabel1.text = addressArr.firstObject;
    
    
    locationlabel1 = [[UILabel alloc] initWithFrame:CGRectMake(110, 65, 200, 14)];//100
    
    if (Preaddress || Preaddress.length > 0)
        locationlabel1.text = Preaddress;
    else
        locationlabel1.text = location.firstObject;
    
    locationlabel1.textAlignment = NSTextAlignmentLeft;
    locationlabel1.textColor = [UIColor grayColor];
    locationlabel1.backgroundColor = [UIColor clearColor];
    locationlabel1.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
    [ContactInfoView addSubview:locationlabel1];
    
    phonelabel1 = [[UILabel alloc] initWithFrame:CGRectMake(110, 90, 200, 14)];//100
    
    if (Preaddress.length > 0)
        if ([phoneArr count] > indexOfTheObject)
            phonelabel1.text = [phoneArr objectAtIndex:indexOfTheObject];
        else
            phonelabel1.text = @"";
    else
        phonelabel1.text = phoneArr.firstObject;
    
    phonelabel1.textAlignment = NSTextAlignmentLeft;
    phonelabel1.textColor = [UIColor grayColor];
    phonelabel1.backgroundColor = [UIColor clearColor];
    phonelabel1.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
    [ContactInfoView addSubview:phonelabel1];
 
    
    if ([phonelabel1.text length] > 0)
    {
        [featureButton2 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[FeaturesArra objectAtIndex:1]]] forState:UIControlStateNormal];
        featureButton2.enabled = YES;
    }
    else
    {
        [featureButton2 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[FeaturesArra objectAtIndex:1]]] forState:UIControlStateNormal];
        featureButton2.enabled = NO;
    }
    
    
    emaillabel1 = [[UILabel alloc] initWithFrame:CGRectMake(110, 115,200, 14)];//115
    if (Preaddress.length > 0)
        if ([emailArr count] > indexOfTheObject)
            emaillabel1.text = [emailArr objectAtIndex:indexOfTheObject];
        else
            emaillabel1.text = @"";
    else
        emaillabel1.text = emailArr.firstObject;
    
    emaillabel1.textAlignment = NSTextAlignmentLeft;
    emaillabel1.textColor = [UIColor grayColor];
    emaillabel1.backgroundColor = [UIColor clearColor];
    emaillabel1.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
    [ContactInfoView addSubview:emaillabel1];
    
    UIButton *emailPressebth = [UIButton buttonWithType:UIButtonTypeCustom];
    [emailPressebth addTarget:self action:@selector(ContactemailMethod) forControlEvents:UIControlEventTouchUpInside];
    emailPressebth.frame = CGRectMake(110, 115,200, 14);
    [ContactInfoView addSubview:emailPressebth];
}

-(void)ContactemailMethod
{
    //iphone
    //emaillabel1
    
    //ipad
    //contactemaillable

    
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
        mail.mailComposeDelegate = self;
        [mail setSubject:@""];
        [mail setMessageBody:@"" isHTML:NO];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            NSArray *toRecipients = [NSArray arrayWithObject:[NSString stringWithFormat:@"%@",emaillabel1.text]];
            [mail setToRecipients:toRecipients];
        }
        else
        {
            NSString *str = [NSString stringWithFormat:@"%@",contactemaillable.text];
            str = [str stringByReplacingOccurrencesOfString:@"Email: " withString:@""];
            
            NSArray *toRecipients = [NSArray arrayWithObject:str];
            [mail setToRecipients:toRecipients];
        }
        
        [self presentViewController:mail animated:YES completion:NULL];
    }
    else
    {
        NSLog(@"This device cannot send email");
    }
    
}
    
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultSent:
            NSLog(@"You sent the email.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"You saved a draft of this email");
            break;
        case MFMailComposeResultCancelled:
            NSLog(@"You cancelled sending this email.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed:  An error occurred when trying to compose this email");
            break;
        default:
            NSLog(@"An error occurred when trying to compose this email");
            break;
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void)restorantImg
{
    UIButton *featureButton5 = [UIButton buttonWithType:UIButtonTypeCustom];
  
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        featureButton5.frame = CGRectMake(280, 23, 44, 44);
    }
    else
    {
        featureButton5.frame = CGRectMake(708, 23, 44, 44);
    }
    
    
    if([[NSString stringWithFormat:@"%@",is_favorite] isEqualToString:@"1"]== TRUE)
    {
        [featureButton5 setImage:[UIImage imageNamed:@"fav_p.png"] forState:UIControlStateNormal];
    }
    else
    {
        [featureButton5 setImage:[UIImage imageNamed:@"fav_n.png"] forState:UIControlStateNormal];
    }
    
    featureButton5.tag=5;
    [featureButton5 addTarget:self action:@selector(featureMethod:) forControlEvents:UIControlEventTouchUpInside];
    [featureButton5 setSelected:NO];
    [self.view addSubview:featureButton5];
    
    //------------------------Restorant
    UIScrollView *restorantImagesScrool = [[UIScrollView alloc] init];
    restorantImagesScrool.delegate = self;
    restorantImagesScrool.backgroundColor = [UIColor clearColor];
    restorantImagesScrool.pagingEnabled = YES;
    restorantImagesScrool.tag = 100;
    [self.view addSubview:restorantImagesScrool];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureTurnPage)];
    [restorantImagesScrool addGestureRecognizer:recognizer];
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        restorantImagesScrool.frame = CGRectMake(0, 64, 320, 144);
        restorantImagesScrool.contentSize = CGSizeMake(320*offerArr.count, 144);
    }
    else
    {
        restorantImagesScrool.frame = CGRectMake(0, 64, 768, 340);
        restorantImagesScrool.contentSize = CGSizeMake(768*offerArr.count, 340);
    }
    
    pageControl.numberOfPages = [offerArr count];
    NSArray *arrwithImagesname = offerArr;
    for (int i = 0; i < arrwithImagesname.count; i++)
    {
        UIImageView *imageview = [[UIImageView alloc] init];
        
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            imageview.frame = CGRectMake(1+(i*320), 0, 318, restorantImagesScrool.frame.size.height-2);
        }
        else
        {
            imageview.frame = CGRectMake(1+(i*768), 0, 766, restorantImagesScrool.frame.size.height-2);
        }
        
        activityview1 = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityview1.center = CGPointMake(imageview.bounds.size.width / 2,imageview.bounds.size.height /2);
        [activityview1 startAnimating];
        activityview1.tag = i;
        [imageview addSubview:activityview1];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[arrwithImagesname objectAtIndex:i] ]]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (imageData)
                {
                    NSArray *subviewArray = [imageview subviews];
                    
                    for (UIView *view in subviewArray)
                    {
                        if([view isKindOfClass:[UIActivityIndicatorView class]])
                        {
                            UIActivityIndicatorView *activity = (UIActivityIndicatorView *)view;
                            [activity stopAnimating];
                            [activity removeFromSuperview];
                        }
                    }
              
                    if (!imageData)
                    {
                        imageview.image = [UIImage imageNamed:@""];
                    }
                    else
                    {
                        imageview.image = [UIImage imageWithData:imageData];
                          shareImage= [UIImage imageWithData:imageData];
                    }
                    
                }
            });
        });
        
      [restorantImagesScrool addSubview:imageview];
    }
    
    pageControl = [[UIPageControl alloc] init];
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        pageControl.frame = CGRectMake(250,170,50,20);
    }
    else
    {
        pageControl.frame = CGRectMake(640 ,360 ,120 ,36 );
    }
//    pageControl.numberOfPages = 5;
    pageControl.numberOfPages = [offerArr count];
    pageControl.currentPage = 0;
    [self.view addSubview:pageControl];
    pageControl.backgroundColor = [UIColor clearColor];
}


    
-(void)addFavorite
{
    @try {
        
        
        
//        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *userId1=delegate.userID;
            NSString *offerID1=offerID;
            
            NSString *url = [NSString stringWithFormat:@"https://testws.goodliving.ae/api/index.php/offer/addFavOffer/%@/%@",userId1,offerID1];
            url=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
            [request setURL:[NSURL URLWithString:url]];
            [request setHTTPMethod:@"POST"];
            
            NSHTTPURLResponse *response = nil;
            NSError *error = [[NSError alloc] init];
            NSData *data= [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            NSString *returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
//        });
        
        showAlert1 = [[UIAlertView alloc] initWithTitle:@"Like this offer?" message:@"Why not share it with your friends and family!" delegate:self cancelButtonTitle:@"Maybe later!"  otherButtonTitles:@"OK",nil];
         showAlert1.tag=105;
        [showAlert1 show];
        
          [getNewestAlert dismissWithClickedButtonIndex:0 animated:YES];
        //[activityIndicatorNew stopAnimating];
      
    }
    @catch (NSException *exception) {
          [getNewestAlert dismissWithClickedButtonIndex:0 animated:YES];
    }
    
      [getNewestAlert dismissWithClickedButtonIndex:0 animated:YES];
}
    
-(void)removeFavorite
{
    @try {
        
//        dispatch_async(dispatch_get_main_queue(), ^{
        
            NSString *userId1=delegate.userID;
            NSString *offerID1=offerID;
            
            NSString *url = [NSString stringWithFormat:@"https://testws.goodliving.ae/api/index.php/offer/removeFavOffer/%@/%@",userId1,offerID1];
            url=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
            [request setURL:[NSURL URLWithString:url]];
            [request setHTTPMethod:@"POST"];
            
            NSHTTPURLResponse *response = nil;
            NSError *error = [[NSError alloc] init];
            NSData *data= [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            NSString *returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
               // [activityIndicatorNew stopAnimating];
//        });
        [getNewestAlert dismissWithClickedButtonIndex:0 animated:YES];
          }
    @catch (NSException *exception) {
          [getNewestAlert dismissWithClickedButtonIndex:0 animated:YES];
          }
      [getNewestAlert dismissWithClickedButtonIndex:0 animated:YES];
}


- (void) similarOffersMethod2 :(id) sender
{
    UIButton *btn = (UIButton *)sender;
    
    for(int i=0; i<[similarOfferID count];i++)
    {
        if(btn.tag==i)
        {
           self.newestOfferID= [similarOfferID objectAtIndex:i];
            break;
        }
        
    }
    
      [self.view.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    [self viewDidLoad];
    [self viewWillAppear:YES];
}

-(void)getsimilarOfferDetails
{

    @try {
        
        
        NSString *cLat=[lattitude firstObject] ? [lattitude firstObject] : @"0";
        NSString *cLong=[longitude firstObject] ? [longitude firstObject] : @"0";
        NSString *emiratesLbl=delegate.emiratesLbl;
        
        NSString *url=getSimilarOffer;
        if(newestOfferID!=nil)
            url=[url stringByAppendingString:newestOfferID];
        
        NSString *lastString=[NSString stringWithFormat:@"/%@/%@/%@",emiratesLbl,cLat,cLong]; //
        url=[url stringByAppendingString:lastString];
        
        
        NSString *urlString = url;
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *Final_Url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",urlString]];
        
         NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:Final_Url];
        [request setValue:@"Basic Z2xvYnVzdXNlcjpHbDBidVMyMDE0" forHTTPHeaderField:@"Authorization"];
        
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        NSDictionary*json;
        if (data)
        {
            NSError* error;
            json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            
            NSMutableArray *DataArray = [json objectForKey:@"data"];
            
            similarOfferID=[[NSMutableArray alloc]init];
            similarOfferImg=[[NSMutableArray alloc]init];
            similarOfferTitle=[[NSMutableArray alloc]init];
            
            for (int i = 0; i < [DataArray count]; i++)
            {
                [similarOfferID addObject:[[DataArray objectAtIndex:i] valueForKey:@"offerId"]];
                [similarOfferImg addObject:[[DataArray objectAtIndex:i] valueForKey:@"Offer_Image_1__c"]];
                [similarOfferTitle addObject:[[DataArray objectAtIndex:i] valueForKey:@"Title"]];
            }
        }
        
        [getNewestAlert dismissWithClickedButtonIndex:0 animated:YES];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
                [self similarOffer];
            else if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
            {  [self similarOffer];
                [self ipadDesigns];}
        });
        
    }
    @catch (NSException *exception) {
        
    }
   

}

-(void)similarOffer
{
    //---------------------Similar offers
    //-----------------------------deals near me
    dealsnearView = [[UIView alloc] init];
    dealsnearView.backgroundColor = [UIColor whiteColor];
    dealsnearView.layer.cornerRadius = 5.0f;
    [mainScrool addSubview:dealsnearView];
    
    UILabel *dealsnearLable = [[UILabel alloc] init];
    dealsnearLable.text = @"We also recommend...";
    dealsnearLable.textColor = [UIColor blackColor];
    dealsnearLable.backgroundColor = [UIColor clearColor];
    [dealsnearView addSubview:dealsnearLable];
    
    UIButton *nextBtndelersnew = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtndelersnew setImage:[UIImage imageNamed:@"next.png"] forState:UIControlStateNormal];
    nextBtndelersnew.frame = CGRectMake(292, 8, 20, 20);
    nextBtndelersnew.tag = 2;
    [nextBtndelersnew addTarget:self action:@selector(nextMethod:) forControlEvents:UIControlEventTouchUpInside];
    // [dealsnearView addSubview:nextBtndelersnew];
    
    dealsNearScrool = [[UIScrollView alloc] init];
    dealsNearScrool.delegate = self;
    dealsNearScrool.backgroundColor = [UIColor clearColor];
    dealsNearScrool.pagingEnabled = NO;
    [dealsnearView addSubview:dealsNearScrool];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureTurnPage)];
    [dealsNearScrool addGestureRecognizer:recognizer];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        dealsnearLable.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
        dealsNearScrool.contentSize = CGSizeMake(140*similarOfferImg.count, 93);
        dealsnearLable.frame = CGRectMake(5, 10, 150, 20);
        dealsnearView.frame = CGRectMake(10, 505, 310, 125);
        dealsNearScrool.frame = CGRectMake(5, 24, 300, 93);
    }
    else
    {
        dealsnearLable.font = [UIFont fontWithName:@"Helvetica Neue" size:25];
        dealsnearLable.frame = CGRectMake(15, 10, 700, 40);
    }
    
//    NSArray *arrwithImagesname1 = [NSArray arrayWithObjects:@"4.png",@"5.png",@"6.png",@"4.png",@"5.png",@"6.png",@"4.png",@"6.png", nil];
    
    for (int i = 0; i <  similarOfferImg.count; i ++)
    {
        UIButton *gnOffersBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        gnOffersBtn.tag = i;
      
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            gnOffersBtn.frame = CGRectMake((140 * i), 15, 134, 78);
            [[gnOffersBtn layer] setCornerRadius:5.0f];
            [gnOffersBtn.layer setMasksToBounds:YES];

        }
        else
        {
            
//            gnOffersBtn.frame = CGRectMake(5 + (280 * i), 16, 280, 146);
//            [[gnOffersBtn layer] setCornerRadius:5.0f];
//            [gnOffersBtn.layer setMasksToBounds:YES];
//            
            CGRect screenRect = [[UIScreen mainScreen] bounds];
            x_ratio = screenRect.size.width/320;
            y_ratio = screenRect.size.height/568;
            [[gnOffersBtn layer] setCornerRadius:5.0f];
            gnOffersBtn.frame = CGRectMake(((125 * i))*x_ratio, 10*y_ratio, 280,146);
            [gnOffersBtn.layer setMasksToBounds:YES];

        }
        
        
        
        UIActivityIndicatorView *activityview3 = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityview3.center = CGPointMake(gnOffersBtn.bounds.size.width / 2,gnOffersBtn.bounds.size.height /2);
        [activityview3 startAnimating];
        activityview3.tag = i;
        [gnOffersBtn addSubview:activityview3];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[similarOfferImg objectAtIndex:i] ]]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (imageData)
                {
                    NSArray *subviewArray = [gnOffersBtn subviews];
                    
                    for (UIView *view in subviewArray)
                    {
                        if([view isKindOfClass:[UIActivityIndicatorView class]])
                        {
                            UIActivityIndicatorView *activity = (UIActivityIndicatorView *)view;
                            [activity stopAnimating];
                            [activity removeFromSuperview];
                        }
                    }
                    
                    [gnOffersBtn setImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
                    
                    
                }
            });
        });

       
        [gnOffersBtn addTarget:self action:@selector(similarOffersMethod2:) forControlEvents:UIControlEventTouchUpInside];
        [dealsNearScrool addSubview:gnOffersBtn];
    }
    
    
    for (int i=0; i< [similarOfferTitle count ]; i++)
    {
        UIImageView *backView=[[UIImageView alloc]init];
        
        
        // backView.backgroundColor=[UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.8f];
        [dealsNearScrool addSubview:backView];
        // backView.layer.cornerRadius=5.0f;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = [similarOfferTitle objectAtIndex:i];
        titleLabel.textAlignment=NSTextAlignmentLeft;
        titleLabel.textColor=[UIColor whiteColor];
        titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
        [dealsNearScrool addSubview:titleLabel];
        
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            backView.image=[UIImage imageNamed:@"roundedRectiPhone.png"];
            titleLabel.numberOfLines=2;
            titleLabel.frame = CGRectMake((6+ (140 * i)) , 63 , 120 , 30 );
            backView.frame=CGRectMake(( (140 * i)), 63, 134, 30);
            titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:9];
            
     
            
        }
        else
        {
            backView.image=[UIImage imageNamed:@"roundedRectiPad"];
            CGRect screenRect = [[UIScreen mainScreen] bounds];
            x_ratio = screenRect.size.width/320;
            y_ratio = screenRect.size.height/568;
            titleLabel.numberOfLines=2;
            titleLabel.frame = CGRectMake((10+ (125 * i))*x_ratio, 62*y_ratio, 230, 60);
            backView.frame=CGRectMake(( (125 * i))*x_ratio, 68*y_ratio, 279, 42);
            titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:15];

            
//            backView.image=[UIImage imageNamed:@"roundedRectiPad"];
//            CGRect screenRect = [[UIScreen mainScreen] bounds];
//            x_ratio = screenRect.size.width/320;
//            y_ratio = screenRect.size.height/568;
//             titleLabel.numberOfLines=2;
//            titleLabel.frame = CGRectMake(30 + (280 * i), 62*y_ratio, 260, 60);//(50+ (240 * i)), 62*y_ratio, 230, 60);
//            backView.frame=CGRectMake( 20 + (280 * i), 69*y_ratio, 280, 42);
//            titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:15];
       
        }
        
        
    }
    
    

}

@end