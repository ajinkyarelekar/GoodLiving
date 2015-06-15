//
//  LeadingViewController.m
//  Good Living
//
//  Created by NanoStuffs on 04/09/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import "LeadingViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "GNoffersController.h"
#import "SelectedThemesController.h"
#import "EventInviteesController.h"
#import "GifsOfTheWeekController.h"
#import "MyVoucherController.h"
#import "OfferDetailsController.h"
#import "myPurchaseController.h"
#import "GNTravellerController.h"
#import "GNViewController.h"
#import "LeftPanelViewController.h"
#import "searchController.h"
#import "SelectGiftsOfTheWeekController.h"
#import "LandingFilterThemeControllerViewController.h"

#import "globalURL.h"

#import "Flurry.h"

@interface LeadingViewController ()
@end

@implementation LeadingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    
    //App_Landing
    [Flurry logEvent:@"App Landing"];
    [Flurry logPageView];
 
    self.screenName = @"App Landing";
    
     delegate = [[UIApplication sharedApplication] delegate];
    
     self.navigationController.navigationBarHidden = YES;
    
    
    
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(HidePanel)];
    tap.cancelsTouchesInView=NO;
    
    [self.view addGestureRecognizer:tap];

    
//   [self performSelectorOnMainThread:@selector(getnewestOffer) withObject:nil waitUntilDone:YES];

    UIImageView *backImg=[[UIImageView alloc]init];
    backImg.image=[UIImage imageNamed:@"Back_Landing"];
    backImg.frame=CGRectMake(0,0,768, 1024);
    [self.view addSubview:backImg];
   
    getNewestAlert = [[UIAlertView alloc] initWithTitle:@"Please wait..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [getNewestAlert show];
    [self performSelector:@selector(getnewestOffer) withObject:nil afterDelay:0.1];
    [self performSelector:@selector(getPromotionImg) withObject:nil afterDelay:0.1];
    [self performSelector:@selector(getNearestOffer) withObject:nil afterDelay:0.1];

    
    self.view.backgroundColor=[UIColor colorWithRed:209/255.0f green:209/255.0f blue:209/255.0f alpha:1.0f];
    
    //------------------------Navigation Bar
    UIImageView *navigationImage = [[UIImageView alloc] init];
    navigationImage.backgroundColor = [UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f];
    [self.view addSubview:navigationImage];
  
    UIImageView *topLogo = [[UIImageView alloc] init];
    topLogo.image=[UIImage imageNamed:@"GLtext.png"];
    [self.view addSubview:topLogo];
       
    menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
 
    [menuButton addTarget:self action:@selector(menuMethod:) forControlEvents:UIControlEventTouchUpInside];
    menuButton.selected = NO;
    [self.view addSubview:menuButton];
    
    UIButton *filterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [filterButton setImage:[UIImage imageNamed:@"filter.png"] forState:UIControlStateNormal];
    [filterButton addTarget:self action:@selector(filterMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:filterButton];
    
    //------------------------Main scrollview View
    mainscrollvertical = [[UIScrollView alloc] init];
    mainscrollvertical.delegate = self;
    mainscrollvertical.tag=200;
    
     if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        filterButton.frame = CGRectMake(288,27, 30, 30);

        navigationImage.frame = CGRectMake(0, 0, 320 , 64 );
        topLogo.frame=CGRectMake(93 ,35 ,134 ,16 );
        mainscrollvertical.frame = CGRectMake(0, 64 , 320 , self.view.frame.size.height-64 );
        mainscrollvertical.contentSize = CGSizeMake(320 , 650 );
        [menuButton setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
         menuButton.frame = CGRectMake(5 ,27 , 30 , 30 );
 
    }
    else
    {
        filterButton.frame = CGRectMake(688,22, 40, 40);

        navigationImage.frame = CGRectMake(0, 0, 768 , 64 );
        topLogo.frame=CGRectMake(292 ,27 ,200 ,25 );
        mainscrollvertical.frame = CGRectMake(0, 64 , 768 , self.view.frame.size.height-64);
        mainscrollvertical.contentSize = CGSizeMake(768 , 1450 );
        [menuButton setImage:[UIImage imageNamed:@"menu-ipad.png"] forState:UIControlStateNormal];
        menuButton.frame = CGRectMake(20 ,27 , 30 , 30 );

    }
    mainscrollvertical.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f];
   [self.view addSubview:mainscrollvertical];
    
    
    //-----------------------Searchbar
    
    searchBar = [[UISearchBar alloc]init ];
//    [searchBar setDelegate:self];
    searchBar.delegate = self;
    [searchBar setBarStyle:UIBarStyleDefault];
    [searchBar setKeyboardType:UIKeyboardTypeDefault];
    
   
    for (UIView *searchBarSubview in [searchBar subviews]) {
        
        if([searchBarSubview isKindOfClass:[UITextField class]]){
            UITextField *textField = (UITextField*)searchBarSubview;
            textField.leftView = nil;
        }
        
        if ([searchBarSubview conformsToProtocol:@protocol(UITextInputTraits)]) {
            [(UITextField *)searchBarSubview setReturnKeyType:UIReturnKeySend];
            [(UITextField *)searchBarSubview setKeyboardAppearance:UIKeyboardAppearanceAlert];
        }
    }
    

  
    searchBar.backgroundColor=[UIColor clearColor];
    searchBar.barTintColor =  [UIColor clearColor];
    searchBar.tintColor = [UIColor grayColor];
    
    //------------------------EmirateImage View
    UIView *emirateImage = [[UIView alloc] init];
    emirateImage.backgroundColor = [UIColor colorWithRed:254/255.0f green:228/255.0f blue:186/255.0f alpha:1.0f];
    [mainscrollvertical addSubview:emirateImage];
    
      [emirateImage addSubview:searchBar];
    
    emirateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [emirateButton addTarget:self action:@selector(emitareMethod:) forControlEvents:UIControlEventTouchUpInside];
    [emirateImage addSubview:emirateButton];
    
    emirateLable = [[UILabel alloc] init];
    emirateLable.text = @"Dubai";
    emirateLable.textColor = [UIColor colorWithRed:255/255.0f green:145/255.0f blue:14/255.0f alpha:1.0f];
    emirateLable.backgroundColor = [UIColor clearColor];
    emirateLable.textAlignment = NSTextAlignmentCenter;
    [emirateImage addSubview:emirateLable];
    
    arraowImage = [[UIImageView alloc] init];
    [emirateImage addSubview:arraowImage];

    
    if(UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPhone)
    {
        emirateImage.frame = CGRectMake(0, 0, 320 , 42 );
        arraowImage.frame=CGRectMake(265, 19 , 10 , 5 );
        emirateButton.frame = CGRectMake(240, 10 , 100 , 20 );
        emirateLable.frame = CGRectMake(85, 11, 320 , 20 );
        searchBar.frame=CGRectMake(2, 0.5, 180, 40);
        arraowImage.image=[UIImage imageNamed:@"Down.png"];
        //[emirateButton setImage:[UIImage imageNamed:@"Down.png"] forState:UIControlStateNormal];
         emirateLable.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
       // [searchBar setPlaceholder:@"Search"];
      [searchBar setPlaceholder:@"Search                    "];

    }
    else
    {
        emirateImage.frame = CGRectMake(0, 0, 768, 58);
        emirateButton.frame = CGRectMake(520, 10, 400, 20);
        emirateLable.frame = CGRectMake(240, 16, 768, 25);
        searchBar.frame=CGRectMake(20, 8, 500, 50);
      arraowImage.frame=CGRectMake(657, 25, 18, 9);
        arraowImage.image=[UIImage imageNamed:@"Down_ipad.png"];
        
        //[emirateButton setImage:[UIImage imageNamed:@"Down_ipad.png"] forState:UIControlStateNormal];
        emirateLable.font = [UIFont fontWithName:@"Helvetica Neue" size:22];
        
[searchBar setPlaceholder:@"Search                                                                                               "];
    }
    
    //-----------------------------------offers list
    UIView *winWithOffer = [[UIView alloc] init];
    winWithOffer.backgroundColor = [UIColor orangeColor];
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        winWithOffer.frame = CGRectMake(0 , 138 , 320 , 102 );
    }
    else
    {
        winWithOffer.frame = CGRectMake(0 , 274 , 768 , 234 );
    }
    
    [mainscrollvertical addSubview:winWithOffer];
    
    UILabel *winwithusLable = [[UILabel alloc] init];
    winwithusLable.text = @"Win With Us";
    winwithusLable.textColor = [UIColor blackColor];
     winwithusLable.backgroundColor = [UIColor clearColor];
    [winWithOffer addSubview:winwithusLable];
    
    UIImageView *winLine = [[UIImageView alloc] init];
    winLine.image = [UIImage imageNamed:@"newline.png"];
   // [winWithOffer addSubview:winLine];
    
    UIScrollView *offersScrool = [[UIScrollView alloc] init];
    offersScrool.delegate = self;
    offersScrool.backgroundColor = [UIColor blueColor];//whiteColor
    offersScrool.pagingEnabled = NO;
    offersScrool.layer.cornerRadius = 5.0f;
    [winWithOffer addSubview:offersScrool];
    
    UIButton *offer1Button = [UIButton buttonWithType:UIButtonTypeCustom];
    offer1Button.tag = 1;
    [offer1Button addTarget:self action:@selector(offermethod:) forControlEvents:
     UIControlEventTouchUpInside];
    [offersScrool addSubview:offer1Button];
    
    UIButton *offer2Button = [UIButton buttonWithType:UIButtonTypeCustom];
    offer2Button.tag = 3;
    [offer2Button addTarget:self action:@selector(offermethod:) forControlEvents:
     UIControlEventTouchUpInside];
    [offersScrool addSubview:offer2Button];
    
    UIButton *offer3Button = [UIButton buttonWithType:UIButtonTypeCustom];
     offer3Button.tag = 2;
    [offer3Button addTarget:self action:@selector(offermethod:) forControlEvents:
     UIControlEventTouchUpInside];
   [offersScrool addSubview:offer3Button];
    
    UILabel *offer3Label = [[UILabel alloc] init];
    offer3Label.text = @"Be Invited";
    offer3Label.textColor = [UIColor grayColor];
    offer3Label.backgroundColor = [UIColor clearColor];
   // [offersScrool addSubview:offer3Label];
    UIButton *offer4Button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    offer4Button.tag = 4;
    [offer4Button addTarget:self action:@selector(offermethod:) forControlEvents:
     UIControlEventTouchUpInside];
    // [offersScrool addSubview:offer4Button];

    
    UILabel *offer4Label = [[UILabel alloc] init];
    offer4Label.text = @"Celebrate";
    offer4Label.textColor = [UIColor grayColor];
    offer4Label.backgroundColor = [UIColor clearColor];
    //[offersScrool addSubview:offer4Label];
    
    winWithOffer.backgroundColor=[UIColor colorWithRed:209/255.0f green:209/255.0f blue:209/255.0f alpha:1.0f];
     offersScrool.backgroundColor=[UIColor colorWithRed:209/255.0f green:209/255.0f blue:209/255.0f alpha:1.0f];
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        [offer1Button setImage:[UIImage imageNamed:@"gow.png"] forState:UIControlStateNormal];
        [offer2Button setImage:[UIImage imageNamed:@"ei.png"] forState:UIControlStateNormal];
        [offer3Button setImage:[UIImage imageNamed:@"gnt.png"] forState:UIControlStateNormal];
        [offer4Button setImage:[UIImage imageNamed:@"celebration.png"] forState:UIControlStateNormal];
    
        winwithusLable.frame = CGRectMake(10 , 4 , 150 , 20 );
        winLine.frame=CGRectMake(0, 29 , 320 , 1);
        offersScrool.frame = CGRectMake(5 , 24 , 310 , 75 );//316
      //  offersScrool.contentSize = CGSizeMake(108*3 , 75 );
        
        offer1Button.frame = CGRectMake(0 , 5 , 102 , 67 );
       
        
        offer2Button.frame = CGRectMake(104 , 5 , 102 , 67 );

        
        offer3Button.frame = CGRectMake(208 , 5 , 102 , 67 );

        offer4Button.frame = CGRectMake(306 , 5 , 97 , 64 );
  
        CGRect screenRect = [[UIScreen mainScreen] bounds];

        if(screenRect.size.height==568)
        {
//            offer1Label.frame = CGRectMake(17 , 81 , 72 , 20 );
//            offer2Label.frame = CGRectMake(121 , 81 , 72 , 20 );
//            offer3Label.frame = CGRectMake(223 , 81 , 72 , 20 );
            
            offer4Label.frame = CGRectMake(325 , 81 , 72 , 20 );
            
        }
        else
            
        {
//            offer1Label.frame = CGRectMake(17 , 75 , 72 , 20 );
//            offer2Label.frame = CGRectMake(121 , 75 , 72 , 20 );
//            offer3Label.frame = CGRectMake(223 , 75 , 72 , 20 );
            
            offer4Label.frame = CGRectMake(325 , 75 , 72 , 20 );
        }
        
//        offer1Label.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
//        offer2Label.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
//        offer3Label.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
//        offer4Label.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
        winwithusLable.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    }
    else
    {
//        offer3Label.textAlignment=NSTextAlignmentCenter;
//        offer2Label.textAlignment=NSTextAlignmentCenter;
//        offer4Label.textAlignment=NSTextAlignmentCenter;
//        offer1Label.textAlignment=NSTextAlignmentCenter;
        
        [offer1Button setImage:[UIImage imageNamed:@"gow-ipad.png"] forState:UIControlStateNormal];
        [offer2Button setImage:[UIImage imageNamed:@"gnt-ipad.png"] forState:UIControlStateNormal];
        [offer3Button setImage:[UIImage imageNamed:@"ei-ipad.png"] forState:UIControlStateNormal];
        [offer4Button setImage:[UIImage imageNamed:@"celebration-ipad.png"] forState:UIControlStateNormal];
        
        winwithusLable.frame = CGRectMake(24 , 13 , 360 , 36 );
        winLine.frame=CGRectMake(10, 52 , 748 , 1);
        
        offersScrool.frame = CGRectMake(10 , 45 , 750 , 175 );
       // offersScrool.contentSize = CGSizeMake(1040 , 175 );
        
        offer1Button.frame = CGRectMake(0 , 12 , 239 , 164 );//CGRectMake(10 , 12 , 239 , 164 )
//        offer1Label.frame = CGRectMake(5 , 130 , 179 , 36 );
        
        offer2Button.frame = CGRectMake(256 , 12 , 239 , 164 );// CGRectMake(255 , 12 , 239 , 164 )
//        offer2Label.frame = CGRectMake(190 , 130 , 179 , 36 );
        
        offer3Button.frame = CGRectMake(512 , 12 , 239 , 164 );// CGRectMake(500 , 12 , 239 , 164 )
//        offer3Label.frame = CGRectMake(376 , 130 , 179 , 36 );
        
        offer4Button.frame = CGRectMake(560 , 12 , 179 , 118 );
//        offer4Label.frame = CGRectMake(560 , 130 , 179 , 36 );
        
//        offer1Label.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
//        offer2Label.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
//        offer3Label.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
//        offer4Label.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
        winwithusLable.font = [UIFont fontWithName:@"Helvetica Neue" size:25];
    }
    
    //----------------------GNOffers
    UIView *gnoffersView = [[UIView alloc] init];
      gnoffersView.backgroundColor = [UIColor whiteColor];
    gnoffersView.layer.cornerRadius = 5.0f;
    [mainscrollvertical addSubview:gnoffersView];
    
    UILabel *gnofferLable = [[UILabel alloc] init];
    gnofferLable.text = @"Save With Us";
    gnofferLable.textColor = [UIColor blackColor];
    gnofferLable.backgroundColor = [UIColor clearColor];
    [gnoffersView addSubview:gnofferLable];
    
    UIImageView *saveLine = [[UIImageView alloc] init];
    saveLine.image = [UIImage imageNamed:@"newline.png"];
    [gnoffersView addSubview:saveLine];
    
    UIButton *viewAll = [UIButton buttonWithType:UIButtonTypeCustom];
    [viewAll setTitle:@"view all themes" forState:UIControlStateNormal];
       viewAll.tintColor =  [UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f];
    [viewAll setTitleColor: [UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f] forState:UIControlStateNormal];
    viewAll.backgroundColor = [UIColor clearColor];
    [viewAll addTarget:self action:@selector(nextMethod:) forControlEvents:UIControlEventTouchUpInside];
    viewAll.tag=1;

    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
         gnoffersView.frame = CGRectMake(5 , 248 , 310 , 120 );
         gnofferLable.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
         viewAll.titleLabel.font= [UIFont fontWithName:@"Helvetica Neue" size:15];
         gnofferLable.frame = CGRectMake(6 , 10 , 150 , 20 );
         saveLine.frame=CGRectMake(7, 31 , 300, 1);
         viewAll.frame = CGRectMake(190 , 5 , 130 , 30 );
        [gnoffersView addSubview:viewAll];

    }
    else
    {
        gnoffersView.frame = CGRectMake(10 , 530 , 748 , 345 );//CGRectMake(20 , 530 , 728 , 345 )
        gnofferLable.font = [UIFont fontWithName:@"Helvetica Neue" size:25];
        viewAll.titleLabel.font= [UIFont fontWithName:@"Helvetica Neue" size:25];
        gnofferLable.frame = CGRectMake(12 , 12 , 360 , 36 );
        saveLine.frame=CGRectMake(11, 52 , 726, 1);
//        viewAll.frame = CGRectMake(480 , 7 , 312 , 52 );
 
    }
   
    
    UIScrollView *gnoffersScrool = [[UIScrollView alloc] init];
    gnoffersScrool.delegate = self;
    gnoffersScrool.backgroundColor = [UIColor clearColor];
    gnoffersScrool.pagingEnabled = NO;
    [gnoffersView addSubview:gnoffersScrool];
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        gnoffersScrool.frame = CGRectMake(5, 24 , 300 , 95 );
        gnoffersScrool.contentSize = CGSizeMake(1255 , 95 );
        
    }
    else
    {
        gnoffersScrool.frame = CGRectMake(10, 50, 728, 288);//728
        gnoffersScrool.contentSize = CGSizeMake(960, 180);
        
    }
    
    NSArray *arrwithImagesname ;
    NSArray *gnOfferimages;
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        arrwithImagesname = [NSArray arrayWithObjects:@"gloffers1.png",@"casual-dining.png",@"finedining.png",@"shopping.png",@"beauty.png",@"health&fitness.png",@"home.png",@"Adventure-&-Leisure.png",@"children.png",@"services.png" ,nil];//fd.png
    }
    else
    {
        arrwithImagesname = [NSArray arrayWithObjects:@"4offers.png",@"casual-dining_ipad.png",@"fd_ipad.png",@"shopping_ipad.png",@"beauty_ipad.png", nil];
        gnOfferimages=[NSArray arrayWithObjects:@"health&fitness_ipad.png",@"home_ipad.png",@"Adventure-&-Leisure_ipad.png",@"children_ipad.png",@"services_ipad.png", nil];
    }
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        int xOffset=100;
        for (int i = 0; i < 10; i ++)
        {
                UIButton *gnOffersBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                gnOffersBtn.tag = i;
                [gnOffersBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[arrwithImagesname objectAtIndex:i]]] forState:UIControlStateNormal];
            [gnOffersBtn addTarget:self action:@selector(gnOffersMethod:) forControlEvents:UIControlEventTouchUpInside];
                [gnoffersScrool addSubview:gnOffersBtn];
            if (i==0)
                gnOffersBtn.frame = CGRectMake(0 , 15 , 95 , 75 );
            else
            {
                gnOffersBtn.frame = CGRectMake(xOffset , 15 , 120 , 75 );
                xOffset+=125;
            }        }
    }
    else
    {
            CGRect screenRect = [[UIScreen mainScreen] bounds];
            x_ratio = screenRect.size.width/320;
            y_ratio = screenRect.size.height/568;
        for (int i = 0; i < 5; i ++)
        {
            UIButton *gnOffersBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            gnOffersBtn.tag = i;
            gnOffersBtn.frame = CGRectMake(((77 * i))*x_ratio, 10*y_ratio, 179, 125);
            [gnOffersBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[arrwithImagesname objectAtIndex:i]]] forState:UIControlStateNormal];
            [gnOffersBtn addTarget:self action:@selector(gnOffersMethod:) forControlEvents:UIControlEventTouchUpInside];
            [gnoffersScrool addSubview:gnOffersBtn];
        }
        
        for (int i = 0; i < 5; i ++)
        {
            UIButton *gnOffersBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            gnOffersBtn.tag = i+5;
            
            gnOffersBtn.frame = CGRectMake(((77 * i))*x_ratio, 85*y_ratio, 179, 125);
            [gnOffersBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[gnOfferimages objectAtIndex:i]]] forState:UIControlStateNormal];
            [gnOffersBtn addTarget:self action:@selector(gnOffersMethod:) forControlEvents:UIControlEventTouchUpInside];
            [gnoffersScrool addSubview:gnOffersBtn];
        }
        
    }
  
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [self CurrentLocationIdentifier];
    [self performSelector:@selector(getnewestOffer) withObject:nil afterDelay:0.1];
}

-(void)HidePanel
{
    if (isPanelVisible)
    {
        [_delegate movePanelToOriginalPosition];
        [searchBar setUserInteractionEnabled:YES];

        menuButton.tag=0;
    }
}


- (void) nextMethod : (id) sender
{
    UIButton *btn = (UIButton *)sender;
    
    if (btn.tag == 1)
    {
        GNoffersController *nextView = [[GNoffersController alloc] init];
        [self.navigationController pushViewController:nextView animated:YES];
    }
}

- (void) gnOffersMethod :(id) sender
{
    UIButton *btn = (UIButton *)sender;
    
    
    if(btn.tag==0)
    {
        GNoffersController *nextView = [[GNoffersController alloc] init];
        [self.navigationController pushViewController:nextView animated:YES];

    }
    SelectedThemesController *nextView = [[SelectedThemesController alloc] init];
    
    if (btn.tag == 1)
        nextView.titleString = @"Casual Dining";
    
    else if(btn.tag == 2)
        nextView.titleString = @"Fine Dining";//
    
    else if(btn.tag == 3)
        nextView.titleString = @"Shopping";//
    
    else if(btn.tag == 4)
        nextView.titleString = @"Beauty & Wellness";//
    
    else if(btn.tag == 5)
        nextView.titleString = @"Health & Fitness";//
    
    else if(btn.tag == 6)
        nextView.titleString = @"Home & Garden";//
    
    else if(btn.tag == 7)
        nextView.titleString = @"Adventure & Leisure";//Health & Fitness
    
    else if(btn.tag == 8)
        nextView.titleString = @"Children";//
    
    else if(btn.tag == 9)
        nextView.titleString = @"Services";//
    else
        nextView.titleString = @"";
    
    if ([nextView.titleString length] > 0)
    {
        nextView.emirateString=emirateLable.text;
        [self.navigationController pushViewController:nextView animated:YES];        
    }
}

- (void) gnOffersMethod1 :(id) sender
{
    
    OfferDetailsController *nextView = [[OfferDetailsController alloc] init];
    
 
    
    UIButton *btn = (UIButton *)sender;
    
    for(int i=0; i<[nearestOfferID count];i++)
    {
    
    if(btn.tag==i)
      {
        nextView.newestOfferID= [nearestOfferID objectAtIndex:i];
        break;
      }
    
    }
        nextView.Preaddress = [nearestLoc1 objectAtIndex:btn.tag];
       [self.navigationController pushViewController:nextView animated:YES];

}
- (void) gnOffersMethod2 :(id) sender
{
   UIButton *btn = (UIButton *)sender;
   
    OfferDetailsController *nextView = [[OfferDetailsController alloc] init];
   
    
    
    for(int i=0; i<[newestOfferID count];i++)
    {
        
        if(btn.tag==i)
        {
            nextView.newestOfferID= [newestOfferID objectAtIndex:i];
            break;
        }
        
    }
    
     nextView.Preaddress = [nearestLoc objectAtIndex:btn.tag];
    [self.navigationController pushViewController:nextView animated:YES];

}

- (void) offermethod : (id) sender
{
    UIButton *btn = (UIButton *)sender;
    
    NSString *urlString;
    
    @try {
       
        if (btn.tag == 1)
        {
            urlString = giftOfTheWeekURL;
            type=@"GOW";
        }
        else if(btn.tag == 2)
        {
            urlString = glInvitesURL;
            type=@"GLI";
        }
        else
        {
            urlString = glTravellerURL;
            type=@"GLT";
        }
        
        
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
            if ([DataArray count] > 1)
            {
                if (btn.tag == 1)
                {
                    GifsOfTheWeekController *nextView = [[GifsOfTheWeekController alloc] init];
                    [self.navigationController pushViewController:nextView animated:YES];
                }
                if(btn.tag == 2)
                {
                    EventInviteesController *nextView = [[EventInviteesController alloc] init];
                    [self.navigationController pushViewController:nextView animated:YES];
                    
                }
                if (btn.tag == 3)
                {
                    GNViewController *nextView=[[GNViewController alloc]init];
                    [self.navigationController pushViewController:nextView animated:YES];
                    
                }
            
            }
            else if ([DataArray count] == 1)
            {
                SelectGiftsOfTheWeekController *selctGiftOfWeek=[[SelectGiftsOfTheWeekController alloc]init];
                
                if (btn.tag == 1)
                {
                    selctGiftOfWeek.title = @"GL Gifts";
                }
                else if(btn.tag == 2)
                {
                    selctGiftOfWeek.title = @"GL Invites";
                }
                else
                {
                    selctGiftOfWeek.title = @"GL Traveller";
                }
                
                
                selctGiftOfWeek.smsCode=[[DataArray objectAtIndex:0] valueForKey:@"SMS_Code__c"];
                selctGiftOfWeek.smsTo=[[DataArray objectAtIndex:0] valueForKey:@"SMS_To__c"];
                selctGiftOfWeek.winner=[[DataArray objectAtIndex:0] valueForKey:@"Previous_Winners__c"];
                selctGiftOfWeek.termsCond=[[DataArray objectAtIndex:0] valueForKey:@"Terms_Conditions__c"];
                selctGiftOfWeek.name=[[DataArray objectAtIndex:0] valueForKey:@"Name"];
                selctGiftOfWeek.desc=[[DataArray objectAtIndex:0] valueForKey:@"Description__c"];
                selctGiftOfWeek.participentsDateby = [[DataArray objectAtIndex:0] valueForKey:@"Participation_Last_Date__c"];
                selctGiftOfWeek.winnerAnaouncedBy = [[DataArray objectAtIndex:0] valueForKey:@"Winner_Announced_On__c"];
                
                
                selctGiftOfWeek.selectID=[[DataArray objectAtIndex:0] valueForKey:@"Id"];
                selctGiftOfWeek.type=type;
                
                NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[DataArray objectAtIndex:0] valueForKey:@"Image_1__c"] ]]];
                selctGiftOfWeek.img=[UIImage imageWithData:imageData];
                [self.navigationController pushViewController:selctGiftOfWeek animated:YES];
            }
            else if ([DataArray count] == 0)
            {
                if (btn.tag == 1)
                {
                    GifsOfTheWeekController *nextView = [[GifsOfTheWeekController alloc] init];
                    [self.navigationController pushViewController:nextView animated:YES];
                }
                if(btn.tag == 2)
                {
                    EventInviteesController *nextView = [[EventInviteesController alloc] init];
                    [self.navigationController pushViewController:nextView animated:YES];
                    
                }
                if (btn.tag == 3)
                {
                    GNViewController *nextView=[[GNViewController alloc]init];
                    [self.navigationController pushViewController:nextView animated:YES];
                    
                }
            }

        }

        
    }
    @catch (NSException *exception)
    {
        
    }
  
}
//- (void) offermethod : (id) sender
//{
//    UIButton *btn = (UIButton *)sender;
//    
//    
//    if (btn.tag == 1)
//    {
//        GifsOfTheWeekController *nextView = [[GifsOfTheWeekController alloc] init];
//        [self.navigationController pushViewController:nextView animated:YES];
//    }
//    if(btn.tag == 2)
//    {
//        GNViewController *nextView=[[GNViewController alloc]init];
//        [self.navigationController pushViewController:nextView animated:YES];
//  
//    }
//    if (btn.tag == 3)
//    {
//        EventInviteesController *nextView = [[EventInviteesController alloc] init];
//        [self.navigationController pushViewController:nextView animated:YES];
//    }
//}


- (void) emitareMethod : (id) sender
{
    emiritsArray = [[NSMutableArray alloc] init];
    [emiritsArray addObject:@"Abu Dhabi"];
    [emiritsArray addObject:@"Dubai"];
    [emiritsArray addObject:@"Northern Emirates"];
    [emiritsArray addObject:@"Sharjah"];
    
    
    
    emiritsBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    emiritsBackView.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.5f];
    [self.view addSubview:emiritsBackView];
   
    UIView *emiritsviewLocal = [[UIView alloc] init];
   
    emiritsviewLocal.backgroundColor  = [UIColor whiteColor];
    emiritsviewLocal.layer.cornerRadius = 5.0f;
    [emiritsBackView addSubview:emiritsviewLocal];
    
    myPickerView = [[UIPickerView alloc] init];
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
        emiritsviewLocal.frame = CGRectMake(35 , 200 , 250 , 50 );
       myPickerView.frame=CGRectMake(35 , 230 , emiritsviewLocal.frame.size.width, 100 );
     
        
        }
    else
    {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        x_ratio = screenRect.size.width/320;
        y_ratio = screenRect.size.height/568;
        
        emiritsviewLocal.frame = CGRectMake(35*x_ratio, 200*y_ratio, 250*x_ratio, 30*y_ratio);
        myPickerView.frame=CGRectMake(84, 410, emiritsviewLocal.frame.size.width, 400);
    }
    
    [emiritsBackView addSubview:myPickerView];
    myPickerView.delegate = self;
    myPickerView.showsSelectionIndicator = YES;
    myPickerView.backgroundColor=[UIColor whiteColor];
    
    UILabel *emiritsLable = [[UILabel alloc] init ];
        emiritsLable.text = @"Choose your Emirate";
    emiritsLable.textColor = [UIColor blackColor];
    emiritsLable.backgroundColor = [UIColor clearColor];
    emiritsLable.textAlignment = NSTextAlignmentCenter;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if (self.view.frame.size.height == 568)
        {
            emiritsLable.frame= CGRectMake(0, 5 , emiritsviewLocal.frame.size.width,24);

            emiritsLable.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
            emiritsLable.font = [UIFont boldSystemFontOfSize:20];
        }
        else
        {
            emiritsLable.frame= CGRectMake(0, 5 , emiritsviewLocal.frame.size.width,24);

            emiritsLable.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
            emiritsLable.font = [UIFont boldSystemFontOfSize:18];
        }
    }
    else
    {
        emiritsLable.frame= CGRectMake(0, 10 , emiritsviewLocal.frame.size.width,40);

        emiritsLable.font = [UIFont fontWithName:@"Helvetica Neue" size:30];
        emiritsLable.font = [UIFont boldSystemFontOfSize:30];

    }
    
    [emiritsviewLocal addSubview:emiritsLable];
    

}

- (void) menuMethod : (id) sender
{
    UIButton *button = sender;
    switch (button.tag) {
        case 0: {
            [_delegate movePanelRight];
            button.tag=1;
            isPanelVisible=YES;
            [searchBar setUserInteractionEnabled:NO];
                //  ;
            break;
        }
            
        case 1: {
          [_delegate movePanelToOriginalPosition];
             [searchBar setUserInteractionEnabled:YES];
            isPanelVisible=NO;
            button.tag=0;
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - Pickerview Delegate

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger numRows = emiritsArray.count;
    return numRows;
}
// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [emiritsBackView removeFromSuperview];
    pickerView.hidden=YES;
    
    [emirateLable setText:[NSString stringWithFormat:@"%@",[emiritsArray objectAtIndex:[pickerView selectedRowInComponent:0]]]];
   if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
   {
       
       if([emirateLable.text isEqualToString:@"Northern Emirates"])
       {
           arraowImage.frame = CGRectMake(305, 19 , 10 , 5 );
      
           dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
               [self getnewestOffer];
               [self getNearestOffer];
           });

        }
       else if([emirateLable.text isEqualToString:@"Abu Dhabi"])
       {
           arraowImage.frame = CGRectMake(282, 19 , 10 , 5 );

           dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
               [self getnewestOffer];
               [self getNearestOffer];
           });

           
       }
       else if([emirateLable.text isEqualToString:@"Sharjah"])
       {
           arraowImage.frame = CGRectMake(270, 19 , 10 , 5 );
       
           
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self getnewestOffer];
                [self getNearestOffer];
          });
           
           
    
       }
       else if([emirateLable.text isEqualToString:@"Dubai"])
       {
           arraowImage.frame = CGRectMake(265, 19 , 10 , 5 );
       
           dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
               [self getnewestOffer];
               [self getNearestOffer];
           });
        }
   }
    else
    {
        if([emirateLable.text isEqualToString:@"Northern Emirates"])
        {
            arraowImage.frame = CGRectMake(720, 25, 18, 9);
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self getnewestOffer];
                [self getNearestOffer];
            });
        
        }
        else if([emirateLable.text isEqualToString:@"Abu Dhabi"])
        {
            arraowImage.frame = CGRectMake(685, 25, 18, 9);

            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self getnewestOffer];
                [self getNearestOffer];
            });
          
        }
        else if([emirateLable.text isEqualToString:@"Sharjah"])
        {
            arraowImage.frame = CGRectMake(667, 25, 18, 9);
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self getnewestOffer];
                [self getNearestOffer];
            });
        }
        else if([emirateLable.text isEqualToString:@"Dubai"])
        {
            arraowImage.frame = CGRectMake(657, 25, 18, 9);
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self getnewestOffer];
                [self getNearestOffer];
            });
        }
    }
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [emiritsArray objectAtIndex:row];
    
    [emiritsBackView removeFromSuperview];

}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    CGFloat componentWidth = 0.0;
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
  
        componentWidth = 200.0;
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
                [tView setFont:[UIFont fontWithName:@"Helvetica" size:18]];
            }
            else
            {
                [tView setFont:[UIFont fontWithName:@"Helvetica" size:14]];
                
            }
        }
        else
        {
             [tView setFont:[UIFont fontWithName:@"Helvetica" size:30]];
        }
    }
    // Fill the label text here
    tView.text=[emiritsArray objectAtIndex:row];
    tView.textAlignment = NSTextAlignmentCenter;
    return tView;
}



#pragma mark - Scroll delegate methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   
    // ScrollView Referesh
    
  /*  if(scrollView.tag==200)
    {
        if(scrollView.contentOffset.y <= -105)
        {
            getNewestAlert = [[UIAlertView alloc] initWithTitle:@"Please wait" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [getNewestAlert show];
            
            [self performSelectorOnMainThread:@selector(getnewestOffer) withObject:nil waitUntilDone:YES];
        }
    }
    */
    if (scrollView.tag == 100)
    {
        CGFloat pageWidth = scrollView.frame.size.width;
        float fractionalPage = scrollView.contentOffset.x / pageWidth;
        NSInteger page = lround(fractionalPage);
        pageControl.currentPage = page;
    }
}



#pragma mark -- Searchbar Delegate Method



- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
   overlayButton = [[UIButton alloc] initWithFrame:self.view.frame];
    
    // set the background to black and have some transparency
    overlayButton.backgroundColor = [UIColor clearColor];
    
    // add an event listener to the button
    [overlayButton addTarget:self action:@selector(hideKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    
    // add to main view
    [self.view addSubview:overlayButton];
}

- (void)hideKeyboard:(UIButton *)sender
{
    [searchBar clearsContextBeforeDrawing];
    // hide the keyboard
    searchBar.text = @"";
    [searchBar resignFirstResponder];
    // remove the overlay button
    [overlayButton removeFromSuperview];
    [sender removeFromSuperview];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    // [searchBar resignFirstResponder];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar1
{
    [overlayButton removeFromSuperview];

    
    if ([searchBar1.text length]<3)
    {
        return;
    }
    
        waitingAlt=[[UIAlertView alloc]initWithTitle:@"Please Wait..." message:Nil delegate:Nil cancelButtonTitle:Nil otherButtonTitles:Nil, nil];
        [waitingAlt show];
        NSString *UrlStr=[NSString stringWithFormat:@"https://testws.goodliving.ae/api/index.php/offer/searchOffers/%@/%@/%@/%@",emirateLable.text,searchBar1.text,delegate.lattitude,delegate.longitude] ;
        
        UrlStr=[UrlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url=[NSURL URLWithString:UrlStr];
        NSURLRequest *req=[NSURLRequest requestWithURL:url];
        
        [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if (data)
            {
                NSError *err;
                
                NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                
                NSMutableArray *filtersArray= (NSMutableArray*)[dict objectForKey:@"data"];
                
                [waitingAlt dismissWithClickedButtonIndex:0 animated:YES];
                
                searchController *objsearchController=[[searchController alloc]init];
                
                objsearchController.filtersArray=filtersArray;
                
                objsearchController.titleString=searchBar1.text;
                
                searchBar1.text=@"";
                
                [searchBar1 performSelectorOnMainThread:@selector(resignFirstResponder) withObject:Nil waitUntilDone:YES];
                [self.navigationController pushViewController:objsearchController animated:YES];
                
            }
        }];
        
        
//        [searchBar1 resignFirstResponder];
   


}


#pragma mark - Menu Methods



- (void) filterMethod
{
    filterdelay=[[UIAlertView alloc]initWithTitle:@"Please wait..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [filterdelay show];
    
    [self performSelector:@selector(filtermethodDelay) withObject:nil afterDelay:0.1];
    
}

-(void)filtermethodDelay
{
    [filterdelay dismissWithClickedButtonIndex:0 animated:YES];
    
    LandingFilterThemeControllerViewController *filter=[[LandingFilterThemeControllerViewController alloc]init];
    filter.emiratesString=emirateLable.text;
    filter.themeString=@"Casual Dining";
    [self.navigationController pushViewController:filter animated:YES];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [mainscrollvertical endEditing:YES];
    [searchBar resignFirstResponder];
    [emiritsBackView removeFromSuperview];
    [_delegate movePanelToOriginalPosition];
    [searchBar setUserInteractionEnabled:YES];

    
}


#pragma Mark Lattitude& Longitude

-(void)CurrentLocationIdentifier
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = 100; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyBest; // 100 m
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    latitude=[NSString stringWithFormat:@"%f", locationManager.location.coordinate.latitude];
    longitude=[NSString stringWithFormat:@"%f",locationManager.location.coordinate.longitude];
 
    delegate.lattitude=latitude;
    delegate.longitude=longitude;
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    latitude=[NSString stringWithFormat:@"%f", locationManager.location.coordinate.latitude];
    longitude=[NSString stringWithFormat:@"%f",locationManager.location.coordinate.longitude];
    delegate.lattitude=latitude;
    delegate.longitude=longitude;

    
}



- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"Error %@",[error localizedDescription]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//---------- Webservice for Promotion Images

-(void) getPromotionImg
{
    @try {
        
        NSString *urlString =promotionURL;
        
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
            
            promotionImgArr=[[NSMutableArray alloc]init];
            promotionImgId=[[NSMutableArray alloc]init];
            promotionType =[[NSMutableArray alloc]init];
            
            for (int i=0; i<[DataArray count]; i++)
            {
                [promotionImgArr addObject:[[DataArray objectAtIndex:i] valueForKey:@"Image_1__c"]];
                [promotionImgId addObject:[[DataArray objectAtIndex:i] valueForKey:@"Id"]];
                [promotionType addObject:[[DataArray objectAtIndex:i] valueForKey:@"type"]];
                
            }
            
        }
        
        [getNewestAlert dismissWithClickedButtonIndex:0 animated:YES];
        
        [self performSelector:@selector(promotionImgaes) withObject:nil afterDelay:0.1];
    }
    @catch (NSException *exception) {
  
    }
  
}

-(void)promotionImgaes
{
   
    //------------------------Restorant
    UIScrollView *restorantImagesScrool = [[UIScrollView alloc] init];
    restorantImagesScrool.delegate = self;
    restorantImagesScrool.backgroundColor = [UIColor clearColor];
    restorantImagesScrool.tag = 100;
    restorantImagesScrool.pagingEnabled = YES;
    [mainscrollvertical addSubview:restorantImagesScrool];
    
    pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = promotionImgArr.count;
    pageControl.currentPage = 0;
    pageControl.backgroundColor = [UIColor clearColor];
    [mainscrollvertical addSubview:pageControl];
    
   // UIImageView *imageview;
    
    
    for (int i = 0; i < promotionImgArr.count; i++)
    {
        UIButton *imageview=[UIButton buttonWithType:UIButtonTypeCustom];

        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            restorantImagesScrool.frame = CGRectMake(0, 39 , 320 , 100 );
            restorantImagesScrool.contentSize = CGSizeMake(320*promotionImgArr.count , 100 );
            pageControl.frame = CGRectMake(260 ,111 ,50 ,20 );
            imageview .Frame=CGRectMake((1+(i*320)) , 1 , 318 , restorantImagesScrool.frame.size.height-2 );
            imageview.tag=i;
       }
        else
        {
            restorantImagesScrool.frame = CGRectMake(0, 58 , 768 , 217 );
            restorantImagesScrool.contentSize = CGSizeMake(768*promotionImgArr.count , 217 );
            pageControl.frame = CGRectMake(660 ,240 ,120 ,36 );
            imageview.tag=i;
            imageview .frame=CGRectMake((0+(i*768)) , 1 , 768 , restorantImagesScrool.frame.size.height-2);
        }
        
        UIActivityIndicatorView *activityview1 = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityview1.center = CGPointMake(imageview.bounds.size.width / 2,imageview.bounds.size.height /2);
        [activityview1 startAnimating];
        activityview1.tag = i;
        [imageview addSubview:activityview1];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[promotionImgArr objectAtIndex:i] ]]];
            
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
                    }
                    else
                    {
//                        [imageview setImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
                        [imageview setBackgroundImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
                    }
                }
            });
        });

        [imageview addTarget:self action:@selector(promotionMethod:) forControlEvents:UIControlEventTouchUpInside];
     [restorantImagesScrool addSubview:imageview];
    }
}

-(void)promotionMethod : (id) sender
{
    UIButton *btn=(UIButton *)sender;
    
  btnType=[NSString stringWithFormat:@"%@",[promotionType objectAtIndex:btn.tag]];
   btnID=[NSString stringWithFormat:@"%@",[promotionImgId objectAtIndex:btn.tag]];

    
@try {
    
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSString *url = [NSString stringWithFormat:@"https://testws.goodliving.ae/api/index.php/offer/returnCompetitionDetails/%@/%@",btnID,btnType];
        
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
            
            NSMutableArray *DataArray = [json objectForKey:@"data"];
            if (DataArray) {
                
            SelectGiftsOfTheWeekController *selctGiftOfWeek=[[SelectGiftsOfTheWeekController alloc]init];
            selctGiftOfWeek.smsCode=[[DataArray objectAtIndex:0] valueForKey:@"SMS_Code__c"];
            selctGiftOfWeek.smsTo=[[DataArray objectAtIndex:0] valueForKey:@"SMS_To__c"];
            selctGiftOfWeek.winner=[[DataArray objectAtIndex:0] valueForKey:@"Previous_Winners__c"];
            selctGiftOfWeek.termsCond=[[DataArray objectAtIndex:0] valueForKey:@"Terms_Conditions__c"];
            selctGiftOfWeek.name=[[DataArray objectAtIndex:0] valueForKey:@"Name"];
            selctGiftOfWeek.desc=[[DataArray objectAtIndex:0] valueForKey:@"Description__c"];
            selctGiftOfWeek.participentsDateby = [[DataArray objectAtIndex:0] valueForKey:@"Participation_Last_Date__c"];
            selctGiftOfWeek.winnerAnaouncedBy = [[DataArray objectAtIndex:0] valueForKey:@"Winner_Announced_On__c"];
            
            
            selctGiftOfWeek.selectID=[[DataArray objectAtIndex:0] valueForKey:@"Id"];
            selctGiftOfWeek.type=type;
            
                
                if([btnType isEqualToString:@"GOW"])
                {
                    selctGiftOfWeek.title = @"GL Gifts";
                }
                else if([btnType isEqualToString:@"GNT"])
                {
                    selctGiftOfWeek.title = @"GL Traveller";

                }
                
              else if([btnType isEqualToString:@"GLInv"])
                {
                selctGiftOfWeek.title = @"GL Invites";
   
                }
                
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[DataArray objectAtIndex:0] valueForKey:@"Image_1__c"] ]]];
            selctGiftOfWeek.img=[UIImage imageWithData:imageData];
            [self.navigationController pushViewController:selctGiftOfWeek animated:YES];
                
            }
 
        }
    });
    
  
}


@catch (NSException *exception) {
  
}


}

//------- WebService for NewestOffer
- (void)getnewestOffer
{
    @try {
        
        
        NSString *cLat;
        NSString *cLong;
        
        
        if([CLLocationManager locationServicesEnabled] &&
           [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied)
        {
            cLat=latitude;
            cLong=longitude;
            
        }
        else
        {
            latitude=@"0";
            longitude=@"0";
            cLat=latitude;
            cLong=longitude;
            
        }

        
        NSString *emiratesLbl=emirateLable.text;
        
        delegate.emiratesLbl=emiratesLbl;
        NSString *emiratesWithCount=@"/10";
        emiratesLbl=[emiratesLbl stringByAppendingString:emiratesWithCount];
        NSString *url=newestOfferURL;
        
       
        
        url=[url stringByAppendingString:emiratesLbl];
         NSString *lastString=[NSString stringWithFormat:@"/%@/%@",cLat,cLong];
        url=[url stringByAppendingString:lastString];
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
            
            newestOfferID=[[NSMutableArray alloc]init];
            newestOfferImg=[[NSMutableArray alloc]init];
            newestOfferTitle=[[NSMutableArray alloc]init];
            nearestLoc=[[NSMutableArray alloc]init];
            for (int i = 0; i < [DataArray count]; i++)
            {
                [newestOfferID addObject:[[DataArray objectAtIndex:i] valueForKey:@"OfferId"]];
                [newestOfferImg addObject:[[DataArray objectAtIndex:i] valueForKey:@"Offer_Image_1__c"]];
                [newestOfferTitle addObject:[[DataArray objectAtIndex:i] valueForKey:@"Title"]];
                [nearestLoc addObject:[[DataArray objectAtIndex:i] valueForKey:@"nearestLoc"]];

            }
        }
        
        [getNewestAlert dismissWithClickedButtonIndex:0 animated:YES];
        
        [activity1 stopAnimating];
        [activity1 removeFromSuperview];
        
        //    [self performSelector:@selector(newestOfferContent) withObject:nil afterDelay:0.1];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self newestOfferContent];
        });

    }
    @catch (NSException *exception) {
   
    }

}

-(void)newestOfferContent
{
  
   
    //-----------------------------Newest Deal
    UIView *newestdealsView = [[UIView alloc] init];
    newestdealsView.backgroundColor = [UIColor whiteColor];
    newestdealsView.layer.cornerRadius = 5.0f;
    [mainscrollvertical addSubview:newestdealsView];
    
    UILabel *newestdealsLable = [[UILabel alloc] init];
    newestdealsLable.text = @"Newest Offers";
    newestdealsLable.textColor = [UIColor blackColor];
    newestdealsLable.backgroundColor = [UIColor clearColor];
    [newestdealsView addSubview:newestdealsLable];
    
    UIImageView *newOffer1 = [[UIImageView alloc] init ];
    newOffer1.image = [UIImage imageNamed:@"newline.png"];
    [newestdealsView addSubview:newOffer1];
    
    UIButton *nextBtnnewest = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtnnewest.tag = 3;
    
    [nextBtnnewest addTarget:self action:@selector(nextMethod:) forControlEvents:UIControlEventTouchUpInside];
    //[newestdealsView addSubview:nextBtnnewest];
    
    UIScrollView *newestdealsScrool = [[UIScrollView alloc] init];
    newestdealsScrool.delegate = self;
    newestdealsScrool.backgroundColor = [UIColor clearColor];
    newestdealsScrool.pagingEnabled = NO;
    [newestdealsView addSubview:newestdealsScrool];
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        newestdealsView.frame = CGRectMake(5 , 372 , 310 , 125 );//CGRectMake(5 , 507 , 310 , 125 );
        nextBtnnewest.frame = CGRectMake(278 , 8 , 20 , 20 );
        newestdealsLable.frame = CGRectMake(6 , 10 , 150 , 20 );
        newOffer1.frame=CGRectMake(7, 31 , 300, 1);
        newestdealsScrool.frame = CGRectMake(5 , 24 , 300 , 93 );
        newestdealsScrool.contentSize = CGSizeMake(140*newestOfferImg.count , 93 );
        newestdealsLable.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
        [nextBtnnewest setImage:[UIImage imageNamed:@"next.png"] forState:UIControlStateNormal];
        
    }
    else
    {
        
        newestdealsView.frame = CGRectMake(10 , 895 , 748 , 240 );//CGRectMake(20 , 895 , 728 , 240 );
        nextBtnnewest.frame = CGRectMake(680 , 8 , 40 , 40 );
        newestdealsLable.frame = CGRectMake(12 , 12 , 360 , 36 );
        newOffer1.frame=CGRectMake(11, 52 , 726, 1);
        newestdealsScrool.frame = CGRectMake(10 , 55 , 728 , 175 );//708
        newestdealsScrool.contentSize = CGSizeMake(300*newestOfferImg.count, 175 );
        newestdealsLable.font = [UIFont fontWithName:@"Helvetica Neue" size:25];
        [nextBtnnewest setImage:[UIImage imageNamed:@"next.png"] forState:UIControlStateNormal];
        
        
    }
    
    
    NSArray *arrwithImagesname2;
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        
        arrwithImagesname2 =  [NSArray arrayWithObjects:@"4.png",@"5.png",@"6.png",@"4.png",@"5.png",@"6.png",@"5.png",@"6.png", nil];
    }
    else
    {
        
        arrwithImagesname2 = [NSArray arrayWithObjects:@"4-ipad.png",@"5-ipad.png",@"6-ipad.png",@"4-ipad.png",@"5-ipad.png",@"6-ipad.png",@"5-ipad.png",@"4-ipad.png", nil];
    }
    
    if(newestOfferImg.count==0)
    {
        
        UILabel *lbl=[[UILabel alloc]init];
        lbl.text=[NSString stringWithFormat:@"There are no new offers in the emirate You have chosen. Please try another Emirate."];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.textColor = [UIColor blackColor];
        [newestdealsView addSubview:lbl];
        lbl.numberOfLines=5;
        lbl.lineBreakMode=NSLineBreakByWordWrapping;
        
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
        lbl.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
        lbl.frame=CGRectMake(5 , 40 , 280 , 80);
        }
        else
            
        {
            lbl.font = [UIFont fontWithName:@"Helvetica Neue" size:22];
          
    
            CGRect screenRect = [[UIScreen mainScreen] bounds];
            x_ratio = screenRect.size.width/320;
            y_ratio = screenRect.size.height/568;
            lbl.frame = CGRectMake(20 , 10, 600, 280);
        }
     
     
    }
  
    for (int i = 0; i < [newestOfferImg count]; i ++)
    {
        
        UIButton *gnOffersBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        gnOffersBtn.tag = i;
    
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            gnOffersBtn.frame = CGRectMake(( (140 * i)) , 15 , 134 , 78 );
            [[gnOffersBtn layer] setCornerRadius:5.0f];
            [gnOffersBtn.layer setMasksToBounds:YES];
        }
        else
            
        {
            CGRect screenRect = [[UIScreen mainScreen] bounds];
            x_ratio = screenRect.size.width/320;
            y_ratio = screenRect.size.height/568;
            gnOffersBtn.frame = CGRectMake(((125 * i))*x_ratio, 10*y_ratio, 280,146);
            [[gnOffersBtn layer] setCornerRadius:5.0f];
            [gnOffersBtn.layer setMasksToBounds:YES];
           
        }
        
        UIActivityIndicatorView *activityview1 = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityview1.center = CGPointMake(gnOffersBtn.bounds.size.width / 2,gnOffersBtn.bounds.size.height /2);
        [activityview1 startAnimating];
        activityview1.tag = i;
        [gnOffersBtn addSubview:activityview1];
        
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                
                NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[newestOfferImg objectAtIndex:i] ]]];
                
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
        
        [gnOffersBtn addTarget:self action:@selector(gnOffersMethod2:) forControlEvents:UIControlEventTouchUpInside];
        [newestdealsScrool addSubview:gnOffersBtn];
    }
    
    for (int i=0; i< [newestOfferTitle count ]; i++)
    {
        UIImageView *backView=[[UIImageView alloc]init];
        
        
        // backView.backgroundColor=[UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.8f];
        [newestdealsScrool addSubview:backView];
        // backView.layer.cornerRadius=5.0f;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        
        titleLabel.text = [newestOfferTitle objectAtIndex:i];
        titleLabel.textAlignment=NSTextAlignmentLeft;
        titleLabel.textColor=[UIColor whiteColor];
        [newestdealsScrool addSubview:titleLabel];
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            backView.image=[UIImage imageNamed:@"roundedRectiPhone.png"];
            titleLabel.numberOfLines=2;
            titleLabel.frame = CGRectMake(( 6+ (140 * i)) , 63 , 130 , 30 );
            backView.frame=CGRectMake(( (140 * i)), 63, 134, 30);
            titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:8];
            
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
        }
        
        
        
    }


}

//----- Webservice for Nearest Offer

- (void) getNearestOfferDelay
{
    refreshAlert=[[UIAlertView alloc]initWithTitle:@"Please Wait..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [refreshAlert show];
    [self performSelector:@selector(getNearestOffer) withObject:nil afterDelay:0.1];
}

-(void)getNearestOffer
{

    @try {
        
        // NSString stringWithFormat:@"SMS '%@' To %@",smsCode,smsTo]
        NSString *cLat;
        NSString *cLong;
        
        
        if([CLLocationManager locationServicesEnabled] &&
           [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied)
        {
            cLat=latitude;
            cLong=longitude;
            
        }
        else
        {
            latitude=@"0";
            longitude=@"0";
            cLat=latitude;
            cLong=longitude;
            
        }
        NSString *emiratesLbl=emirateLable.text;
        
        
        NSString *lastString=[NSString stringWithFormat:@"%@/%@/20.0/%@",cLat,cLong,emiratesLbl]; //@"25.141975/55.186147/20.0/Dubai";
        
        NSString *url=nearestOfferURL;
        
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
            
            nearestOfferID=[[NSMutableArray alloc]init];
            nearestOfferImg=[[NSMutableArray alloc]init];
            nearestOfferTitle=[[NSMutableArray alloc]init];
            nearestLoc1=[[NSMutableArray alloc]init];
           

            for (int i = 0; i < [DataArray count]; i++)
            {
                [nearestOfferID addObject:[[DataArray objectAtIndex:i] valueForKey:@"OfferId"]];
                [nearestOfferImg addObject:[[DataArray objectAtIndex:i] valueForKey:@"Offer_Image_1__c"]];
                [nearestOfferTitle addObject:[[DataArray objectAtIndex:i] valueForKey:@"Title"]];
                [nearestLoc1 addObject:[[DataArray objectAtIndex:i] valueForKey:@"nearestLoc"]];
            }
        }
        
        [getNewestAlert dismissWithClickedButtonIndex:0 animated:YES];
        
        [refreshAlert dismissWithClickedButtonIndex:0 animated:YES];
        
        // [activity1 stopAnimating];
        // [activity1 removeFromSuperview];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self nearestOffers];
        });
        
        // [self performSelector:@selector(nearestOffers) withObject:nil afterDelay:0.1];

    }
    @catch (NSException *exception) {
   
    }
}

-(void)nearestOffers
{
    //-----------------------------deals near me
    
    UIView *dealsnearView = [[UIView alloc] init];
    dealsnearView.backgroundColor = [UIColor whiteColor];
    dealsnearView.layer.cornerRadius = 5.0f;
    [mainscrollvertical addSubview:dealsnearView];
    
    UILabel *dealsnearLable = [[UILabel alloc] init];
    dealsnearLable.text = @"Offers Near Me";
    dealsnearLable.textColor = [UIColor blackColor];
    dealsnearLable.backgroundColor = [UIColor clearColor];
    [dealsnearView addSubview:dealsnearLable];
    
    UIImageView *offersLine = [[UIImageView alloc] init ];
    offersLine.image = [UIImage imageNamed:@"newline.png"];
    [dealsnearView addSubview:offersLine];
    
    UIButton *RefreshOffers = [UIButton buttonWithType:UIButtonTypeCustom];
    [RefreshOffers setTitle:@"refresh offers" forState:UIControlStateNormal];
    RefreshOffers.tintColor =  [UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f];
    [RefreshOffers setTitleColor: [UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f] forState:UIControlStateNormal];
    RefreshOffers.backgroundColor = [UIColor clearColor];
    [RefreshOffers addTarget:self action:@selector(getNearestOfferDelay) forControlEvents:UIControlEventTouchUpInside];
    RefreshOffers.tag=2;
    [dealsnearView addSubview:RefreshOffers];
    
    UIButton *RefreshOffersImag = [UIButton buttonWithType:UIButtonTypeCustom];
    //[RefreshOffersImag setTitle:@"Refresh offers" forState:UIControlStateNormal];
    RefreshOffersImag.tintColor =  [UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f];
    [RefreshOffersImag setTitleColor: [UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f] forState:UIControlStateNormal];
    RefreshOffersImag.backgroundColor = [UIColor clearColor];
    [RefreshOffersImag addTarget:self action:@selector(getNearestOffer) forControlEvents:UIControlEventTouchUpInside];
    RefreshOffersImag.tag=21;
    [dealsnearView addSubview:RefreshOffersImag];

    
    
    
    
    UIScrollView *dealsNearScrool = [[UIScrollView alloc] init];
    dealsNearScrool.delegate = self;
    dealsNearScrool.backgroundColor = [UIColor clearColor];
    dealsNearScrool.pagingEnabled = NO;
    [dealsnearView addSubview:dealsNearScrool];
    
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        dealsnearView.frame =CGRectMake(5 , 507 , 310 , 125 );// CGRectMake(5 , 372 , 310 , 131 );
        dealsnearLable.frame = CGRectMake(6 , 10 , 150 , 20 );
        RefreshOffers.frame = CGRectMake(196 , 5 , 130 , 30 );
        [RefreshOffersImag setBackgroundImage:[UIImage imageNamed:@"refresh.png"] forState:UIControlStateNormal];
        RefreshOffersImag.frame=CGRectMake(198 , 13 , 15 , 15 );
        dealsNearScrool.frame = CGRectMake(5 , 24 , 300 , 93 );
        dealsNearScrool.contentSize = CGSizeMake(140*nearestOfferImg.count , 93 );
        offersLine.frame=CGRectMake(7, 31 , 300, 1);
        
        dealsnearLable.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
        RefreshOffers.titleLabel.font= [UIFont fontWithName:@"Helvetica Neue" size:15];
    }
    else
    {
        dealsnearView.frame = CGRectMake(10 , 1155 , 748 , 240 );//CGRectMake(20 , 895 , 728 , 240 );
        dealsnearLable.frame = CGRectMake(12 , 12 , 360 , 36 );
        RefreshOffers.frame = CGRectMake(490 , 12 , 312 , 36 );
        [RefreshOffersImag setBackgroundImage:[UIImage imageNamed:@"refreshiPad.png"] forState:UIControlStateNormal];
        RefreshOffersImag.frame=CGRectMake(542 , 17 , 25 , 25 );
        dealsNearScrool.frame = CGRectMake(10 , 55 , 728 , 175 );//708
        dealsNearScrool.contentSize = CGSizeMake(300*nearestOfferImg.count , 175 );
        offersLine.frame=CGRectMake(11, 52 , 726, 1);
        
        dealsnearLable.font = [UIFont fontWithName:@"Helvetica Neue" size:25];
        RefreshOffers.titleLabel.font= [UIFont fontWithName:@"Helvetica Neue" size:25];
    }
    
  
    if(nearestOfferImg.count==0)
    {
        
        UILabel *lbl=[[UILabel alloc]init];
        lbl.text=@"Sorry, could not find any offers near you. Please check if your ‘location’ service is on and the app has permission assigned.";//We could not find any offers within 20 kms  from your location. Please check if your location services are on.If not, please switch it on.
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.textColor = [UIColor blackColor];
        lbl.numberOfLines=5;
        lbl.lineBreakMode=NSLineBreakByWordWrapping;
        [dealsnearView addSubview:lbl];
        
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            lbl.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
            lbl.frame=CGRectMake(20  , 20 , 270 , 120);
        }
        else
            
        {
            lbl.font = [UIFont fontWithName:@"Helvetica Neue" size:22];
            
            CGRect screenRect = [[UIScreen mainScreen] bounds];
            x_ratio = screenRect.size.width/320;
            y_ratio = screenRect.size.height/568;
            lbl.frame = CGRectMake(60 , 0 ,600, 300);
        }
        
        
    }

    
    
    for (int i = 0; i < nearestOfferImg.count; i ++)
    {
        UIButton *gnOffersBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        gnOffersBtn.tag = i;
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            gnOffersBtn.frame = CGRectMake(( (140 * i)) , 15 , 134 , 78 );
                [[gnOffersBtn layer] setCornerRadius:5.0f];
               [gnOffersBtn.layer setMasksToBounds:YES];
        }
        else
        {
            CGRect screenRect = [[UIScreen mainScreen] bounds];
            x_ratio = screenRect.size.width/320;
            y_ratio = screenRect.size.height/568;
            [[gnOffersBtn layer] setCornerRadius:5.0f];
            gnOffersBtn.frame = CGRectMake(((125 * i))*x_ratio, 10*y_ratio, 280,146);
           [gnOffersBtn.layer setMasksToBounds:YES];
        }
        
        UIActivityIndicatorView *activityview1 = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityview1.center = CGPointMake(gnOffersBtn.bounds.size.width / 2,gnOffersBtn.bounds.size.height /2);
        [activityview1 startAnimating];
        activityview1.tag = i;
        [gnOffersBtn addSubview:activityview1];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[nearestOfferImg objectAtIndex:i] ]]];
            
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

        
       [gnOffersBtn addTarget:self action:@selector(gnOffersMethod1:) forControlEvents:UIControlEventTouchUpInside];
        [dealsNearScrool addSubview:gnOffersBtn];
    }
    
    for (int i=0; i< [nearestOfferTitle count ]; i++)
    {
        UIImageView *backView=[[UIImageView alloc]init];

      
       // backView.backgroundColor=[UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.8f];
        [dealsNearScrool addSubview:backView];
       // backView.layer.cornerRadius=5.0f;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        
        titleLabel.text = [nearestOfferTitle objectAtIndex:i];
        titleLabel.textAlignment=NSTextAlignmentLeft;
        titleLabel.textColor=[UIColor whiteColor];
        [dealsNearScrool addSubview:titleLabel];
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
              backView.image=[UIImage imageNamed:@"roundedRectiPhone.png"];
            titleLabel.numberOfLines=2;
            titleLabel.frame = CGRectMake(( 6+ (140 * i)) , 63 , 130 , 30 );
            backView.frame=CGRectMake(( (140 * i)), 63, 134, 30);
            titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:8];
            
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
        }
        
     
      
    }

    
    
}

@end