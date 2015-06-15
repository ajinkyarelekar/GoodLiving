//
//  SelectedThemesController.m
//  Good Living
//
//  Created by NanoStuffs on 05/09/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import "LandingfilterSubmitViewController.h"
#import "OfferDetailsController.h"
#import "MyAccountController.h"
#import "LeadingViewController.h"
#import "ViewController.h"
#import "MyVoucherController.h"
#import "FilterController.h"
#import "myPurchaseController.h"
#import "ContactusController.h"
#import "aboutGoodLivingController.h"
#import "notificationController.h"
#import "searchController.h"

@interface LandingfilterSubmitViewController ()
{
    NSString *TabString;
    NSMutableArray *tableDataArray,*tableDataArray1;
    NSMutableArray *NearByArray,*CuisineArray,*PremiumArray,*NewArray;
}
@end

@implementation LandingfilterSubmitViewController

@synthesize titleString
;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Theme_Listing
    if (titleString && delegate.userID)
    {
        [Flurry logEvent:[NSString stringWithFormat:@"%@",titleString]];
        [Flurry logPageView];
        
        //Google Analytics
        self.screenName = [NSString stringWithFormat:@"%@",titleString];
    }
    
    
    tableDataArray=[[NSMutableArray alloc]init];
    
    UIImageView *backImg=[[UIImageView alloc]init];
    backImg.image=[UIImage imageNamed:@"selectTheme.jpg"];
    backImg.frame=CGRectMake(0,0,768,1024);
    // [self.view addSubview:backImg];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    x_ratio = screenRect.size.width/320;
    y_ratio = screenRect.size.height/568;
    
    delegate = [[UIApplication sharedApplication] delegate];
    
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:1.0f];
    
    
    //----
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        NoResults=[[UILabel alloc]initWithFrame:CGRectMake(self.view.center.x-100, self.view.center.y, 200, 100)];
    else
        NoResults=[[UILabel alloc]initWithFrame:CGRectMake(174, self.view.center.y, 480, 100)];
    
    //--------- Swipe
    
    swipeGestureLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedScreenLeft:)];
    //swipeGestureLeft.delegate=self;
    swipeGestureLeft.numberOfTouchesRequired = 1;
    swipeGestureLeft.direction = (UISwipeGestureRecognizerDirectionRight);
    [self.view addGestureRecognizer:swipeGestureLeft];
    
    
    //------------------------Navigation Bar
    UIImageView *navigationImage = [[UIImageView alloc] init];
    [self.view addSubview:navigationImage];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UIButton *backButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton1 setBackgroundColor:[UIColor clearColor]];
    [backButton1 addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton1];
    
    
    UILabel *topLable = [[UILabel alloc] init];
    topLable.text = titleString;
    topLable.textAlignment = NSTextAlignmentCenter;
    topLable.textColor = [UIColor whiteColor];
    topLable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topLable];
    
    
    UIButton *filterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [filterButton setImage:[UIImage imageNamed:@"filter.png"] forState:UIControlStateNormal];
    [filterButton addTarget:self action:@selector(filterMethod) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:filterButton];
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        
        backButton.frame = CGRectMake(5, 26, 35, 35);
        topLable.frame = CGRectMake(0, 28, 320, 30);
        
        backButton1.frame= CGRectMake(0, 14, 50, 50);
        //  topLable.frame = CGRectMake(0, 25, 320, 30);
        topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
        navigationImage.frame = CGRectMake(0, 0, 320, 64);
        filterButton.frame = CGRectMake(288,27, 30, 30);
        // backButton.frame = CGRectMake(5,25, 35, 35);
    }
    else
    {
        backButton1.frame= CGRectMake(0, 14, 50, 50);
        
        filterButton.frame = CGRectMake(301*x_ratio,22, 40, 40);
        navigationImage.frame = CGRectMake(0, 0, 768, 64);
        backButton.frame = CGRectMake(5, 26, 35, 35);
        topLable.frame = CGRectMake(0, 28, 768, 30);
        topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:26];
        
    }
    
    //------------------------EmirateImage View
    mainScrollview = [[UIScrollView alloc] init];
    mainScrollview.delegate = self;
    [self.view addSubview:mainScrollview];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        mainScrollview.frame = CGRectMake(0, 64, 320,self.view.frame.size.height-64);
        mainScrollview.contentSize = CGSizeMake(320, 1500);//150 * row count
        
    }
    
    else
    {
        mainScrollview.frame = CGRectMake(0, 64, 768,self.view.frame.size.height-64);
        //mainScrollview.contentSize = CGSizeMake(768, 1500);//150 * row count
    }
    
    
    //------------------------EmirateImage View
    emirateImage = [[UIView alloc] init];
    emirateImage.backgroundColor = [UIColor colorWithRed:254/255.0f green:228/255.0f blue:186/255.0f alpha:1.0f];
    //[mainScrollview addSubview:emirateImage];
    
    arraowImage = [[UIImageView alloc] init];
    [emirateImage addSubview:arraowImage];
    //-----------------------Searchbar
    
    searchBar = [[UISearchBar alloc]init ];
    [searchBar setDelegate:self];
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
    
    
    
    //[emirateImage addSubview:searchBar];
    
    emirateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [emirateButton addTarget:self action:@selector(emitareMethod) forControlEvents:UIControlEventTouchUpInside];
    [emirateImage addSubview:emirateButton];
    
    emirateLable = [[UILabel alloc] init];
    if ([_emirateString length]==0)
        emirateLable.text = @"Dubai";
    else
        emirateLable.text = _emirateString;
    
    emirateLable.textColor = [UIColor colorWithRed:255/255.0f green:145/255.0f blue:14/255.0f alpha:1.0f];
    emirateLable.backgroundColor = [UIColor clearColor];
    emirateLable.textAlignment = NSTextAlignmentCenter;
    [emirateImage addSubview:emirateLable];
    
    
    
    if ([titleString isEqualToString:@"Casual Dining"] == TRUE)
    {
        navigationImage.backgroundColor = [UIColor colorWithRed:249/255.0f green:210/255.0f blue:20/255.0f alpha:1.0f];
        emirateImage.backgroundColor = [UIColor colorWithRed:254/255.0f green:246/255.0f blue:208/255.0f alpha:1.0f];
        
        
        searchBar.backgroundColor=[UIColor clearColor];
        searchBar.barTintColor =  [UIColor clearColor];
        searchBar.tintColor = [UIColor grayColor];
        
        emirateLable.textColor = [UIColor colorWithRed:249/255.0f green:210/255.0f blue:20/255.0f alpha:1.0f];
        arraowImage.image = [UIImage imageNamed:@"arrow_cd.png"];
        
    }
    else if([titleString isEqualToString:@"Shopping"] == TRUE)
    {
        navigationImage.backgroundColor = [UIColor colorWithRed:174/255.0f green:28/255.0f blue:89/255.0f alpha:1.0f];
        emirateImage.backgroundColor = [UIColor colorWithRed:239/255.0f green:210/255.0f blue:222/255.0f alpha:1.0f];
        
        
        searchBar.backgroundColor=[UIColor clearColor];
        searchBar.barTintColor =  [UIColor clearColor];
        searchBar.tintColor = [UIColor grayColor];
        
        
        emirateLable.textColor = [UIColor colorWithRed:174/255.0f green:28/255.0f blue:89/255.0f alpha:1.0f];
        arraowImage.image = [UIImage imageNamed:@"arrow_shopping.png"];
    }
    else if([titleString isEqualToString:@"Fine Dining"] == TRUE)
    {
        navigationImage.backgroundColor = [UIColor colorWithRed:240/255.0f green:90/255.0f blue:34/255.0f alpha:1.0f];
        emirateImage.backgroundColor = [UIColor colorWithRed:252/255.0f green:222/255.0f blue:211/255.0f alpha:1.0f];
        emirateLable.textColor = [UIColor colorWithRed:240/255.0f green:90/255.0f blue:34/255.0f alpha:1.0f];
        
        
        searchBar.backgroundColor=[UIColor clearColor];
        searchBar.barTintColor =  [UIColor clearColor];
        searchBar.tintColor = [UIColor grayColor];
        arraowImage.image = [UIImage imageNamed:@"down1.png"];
    }
    else if([titleString isEqualToString:@"Home & Garden"] == TRUE)
    {
        navigationImage.backgroundColor = [UIColor colorWithRed:141/255.0f green:198/255.0f blue:63/255.0f alpha:1.0f];
        emirateImage.backgroundColor = [UIColor colorWithRed:232/255.0f green:244/255.0f blue:217/255.0f alpha:1.0f];
        
        
        searchBar.backgroundColor=[UIColor clearColor];
        searchBar.barTintColor =  [UIColor clearColor];
        searchBar.tintColor = [UIColor grayColor];
        
        
        emirateLable.textColor = [UIColor colorWithRed:141/255.0f green:198/255.0f blue:63/255.0f alpha:1.0f];
        arraowImage.image = [UIImage imageNamed:@"down2.png"];
    }
    else if([titleString isEqualToString:@"Children"] == TRUE)
    {
        navigationImage.backgroundColor = [UIColor colorWithRed:0/255.0f green:173/255.0f blue:239/255.0f alpha:1.0f];
        emirateImage.backgroundColor = [UIColor colorWithRed:204/255.0f green:239/255.0f blue:252/255.0f alpha:1.0f];
        
        
        searchBar.backgroundColor=[UIColor clearColor];
        searchBar.barTintColor =  [UIColor clearColor];
        searchBar.tintColor = [UIColor grayColor];
        
        emirateLable.textColor = [UIColor colorWithRed:0/255.0f green:173/255.0f blue:239/255.0f alpha:1.0f];
        arraowImage.image = [UIImage imageNamed:@"arrow_children.png"];
        
    }
    else if([titleString isEqualToString:@"Beauty & Wellness"] == TRUE)
    {
        navigationImage.backgroundColor = [UIColor colorWithRed:212/255.0f green:108/255.0f blue:171/255.0f alpha:1.0f];
        emirateImage.backgroundColor = [UIColor colorWithRed:254/255.0f green:210/255.0f blue:237/255.0f alpha:1.0f];
        
        
        searchBar.backgroundColor=[UIColor clearColor];
        searchBar.barTintColor =  [UIColor clearColor];
        searchBar.tintColor = [UIColor grayColor];
        
        
        
        emirateLable.textColor = [UIColor colorWithRed:212/255.0f green:108/255.0f blue:171/255.0f alpha:1.0f];
        arraowImage.image = [UIImage imageNamed:@"arrow_beauty.png"];
    }
    else if([titleString isEqualToString:@"Health & Fitness"] == TRUE)
    {
        navigationImage.backgroundColor = [UIColor colorWithRed:108/255.0f green:200/255.0f blue:190/255.0f alpha:1.0f];
        emirateImage.backgroundColor = [UIColor colorWithRed:226/255.0f green:244/255.0f blue:242/255.0f alpha:1.0f];
        emirateLable.textColor = [UIColor colorWithRed:108/255.0f green:200/255.0f blue:190/255.0f alpha:1.0f];
        
        
        searchBar.backgroundColor=[UIColor clearColor];
        searchBar.barTintColor =  [UIColor clearColor];
        searchBar.tintColor = [UIColor grayColor];
        arraowImage.image = [UIImage imageNamed:@"arrow_hf.png"];
    }
    else if([titleString isEqualToString:@"Services"] == TRUE)
    {
        navigationImage.backgroundColor = [UIColor colorWithRed:39/255.0f green:30/255.0f blue:83/255.0f alpha:1.0f];
        emirateImage.backgroundColor = [UIColor colorWithRed:217/255.0f green:209/255.0f blue:254/255.0f alpha:1.0f];
        emirateLable.textColor = [UIColor colorWithRed:39/255.0f green:30/255.0f blue:83/255.0f alpha:1.0f];
        
        
        searchBar.backgroundColor=[UIColor clearColor];
        searchBar.barTintColor =  [UIColor clearColor];
        searchBar.tintColor = [UIColor grayColor];
        
        
        
        arraowImage.image = [UIImage imageNamed:@"arrow_services.png"];
    }
    else
    {
        navigationImage.backgroundColor = [UIColor colorWithRed:163.0f/255.0f green:79.0f/255.0f blue:37.0f/255.0f alpha:1.0f];
        emirateImage.backgroundColor = [UIColor colorWithRed:237/255.0f green:220/255.0f blue:211/255.0f alpha:1.0f];
        
        
        searchBar.backgroundColor=[UIColor clearColor];
        searchBar.barTintColor =  [UIColor clearColor];
        searchBar.tintColor = [UIColor grayColor];
        
        emirateLable.textColor = [UIColor colorWithRed:163/255.0f green:79/255.0f blue:37/255.0f alpha:1.0f];
        arraowImage.image = [UIImage imageNamed:@"arrow_al.png"];
    }
    
    
    
    //-------------------
    
    
    
    //------------------------Restorant
    restorantImagesScrool = [[UIScrollView alloc] init];
    restorantImagesScrool.delegate = self;
    restorantImagesScrool.backgroundColor = [UIColor clearColor];
    restorantImagesScrool.pagingEnabled = YES;
    [mainScrollview addSubview:restorantImagesScrool];
    
    pageControl = [[UIPageControl alloc] init];
    
    pageControl.currentPage = 0;
    [mainScrollview addSubview:pageControl];
    pageControl.backgroundColor = [UIColor clearColor];
    
    
    if(UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPhone)
    {
        pageControl.frame = CGRectMake(260,146,50,20);
        
        //       for (int i = 0; i < 3; i++)
        //       {
        //           UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(1+(i*320), 1, 318, restorantImagesScrool.frame.size.height-2)];
        //          // imageview.image = [UIImage imageNamed:@"scrolling1.png"];
        //           [restorantImagesScrool addSubview:imageview];
        //       }
        //
        
    }
    else
    {
        for (int i = 0; i < 3; i++)
        {
            pageControl.frame = CGRectMake(680,246,80,40);
            
            //            UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0+(i*768), 1,768, restorantImagesScrool.frame.size.height-2)];
            //           // imageview.image = [UIImage imageNamed:@"scrolling1.png"];
            //            [restorantImagesScrool addSubview:imageview];
        }
        
        
    }
    
    
    //-------------------Tabs Scrollview
    tabsScrool = [[UIScrollView alloc] init];
    tabsScrool.delegate = self;
    tabsScrool.backgroundColor = [UIColor clearColor];
    tabsScrool.pagingEnabled = NO;
    [mainScrollview addSubview:tabsScrool];
    
    lineImg=[[UIImageView alloc]init];
    lineImg.image=[UIImage imageNamed:@"menu_p.png"];
    
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        
        if ([titleString isEqualToString:@"Fine Dining"] == TRUE || [titleString isEqualToString:@"Casual Dining"] == TRUE)
        {
            tabsScrool.frame = CGRectMake(0, 171, 320, 42);
            tabsScrool.contentSize = CGSizeMake(320, 42);
            tabsarray = [NSArray arrayWithObjects:@"Premium",@"Cuisine",@"New",@"All", nil];
        }
        else
        {
            tabsScrool.frame = CGRectMake(0, 171, 320, 42);
            tabsScrool.contentSize = CGSizeMake(320, 42);
            tabsarray = [NSArray arrayWithObjects:@"Premium",@"New",@"All", nil];//Nearby
        }
        
    }
    else
    {
        if ([titleString isEqualToString:@"Fine Dining"] == TRUE || [titleString isEqualToString:@"Casual Dining"] == TRUE)
        {
            tabsScrool.frame = CGRectMake(0, 295, 768, 66);
            tabsScrool.contentSize = CGSizeMake(768, 66);
            tabsarray = [NSArray arrayWithObjects:@"Premium",@"Cuisine",@"New",@"All", nil];
        }
        else
        {
            tabsScrool.frame = CGRectMake(0, 295, 768, 66);
            tabsScrool.contentSize = CGSizeMake(768, 42);
            tabsarray = [NSArray arrayWithObjects:@"Premium",@"New",@"All", nil];
        }
        
    }
    
    for (int i = 0; i <[tabsarray count]; i++)
    {
        tabbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [tabbutton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [tabbutton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
        //
        tabbutton.tag = i;
        [tabbutton addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
        [tabbutton setTitle:[NSString stringWithFormat:@"%@",[tabsarray objectAtIndex:i]] forState:UIControlStateNormal];
        [tabbutton setBackgroundImage:[UIImage imageNamed:@"menu_n.png"] forState:UIControlStateNormal];
        
        [tabbutton setBackgroundImage:[UIImage imageNamed:@"menu_n1.png"] forState:UIControlStateSelected];
        [tabsScrool addSubview:tabbutton];
        [tabsScrool addSubview:lineImg];
        
        
        if(tabbutton.tag==0)
        {
            hidePremium=tabbutton;
        }
        
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            tabbutton.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
            if ([tabsarray count] == 4)
            {
                tabbutton.frame = CGRectMake((80*i), 0, 80, 42);
                if (i == 3)
                {
                    tabbutton.selected = TRUE;
                }
                else
                {
                    tabbutton.selected = FALSE;
                }
                lineImg.frame = CGRectMake(241, 40, 79, 2);//CGRectMake(245, 35, 70, 2);
            }
            else
            {
                lineImg.frame = CGRectMake(212, 40, 108, 2); //             lineImg.frame = CGRectMake(220, 40, 91, 2);
                
                counter=1;
                tabbutton.frame = CGRectMake((106*i), 0, 106, 42);
                if (i == 2)
                {
                    tabbutton.selected = TRUE;
                }
                else
                {
                    tabbutton.selected = FALSE;
                }
            }
            
            
            
        }
        else
        {
            tabbutton.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:25];
            // tabsScrool.frame = CGRectMake(300, 359, 768, 67);
            if ([tabsarray count] == 4)
            {
                tabbutton.frame = CGRectMake((192*i), 0, 192, 66);
                if (i == 3)
                {
                    tabbutton.selected = TRUE;
                }
                else
                {
                    tabbutton.selected = FALSE;
                }
                lineImg.frame = CGRectMake(576, 65, 192, 2);
            }
            else
            {
                lineImg.frame = CGRectMake(512, 65, 256, 2);
                counter =1;
                tabbutton.frame = CGRectMake((256*i), 0, 256, 67);
                if (i == 2)
                {
                    tabbutton.selected = TRUE;
                }
                else
                {
                    tabbutton.selected = FALSE;
                }
            }
            
        }
        
    }
    
    //-------------------Total offers Lable
    
    UIImageView *lableBackimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 279, 320, 35)];
    lableBackimg.backgroundColor = [UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:1.0f];
    
    //-------------------OffersTableview
    
    tableView=[[UIScrollView alloc]init];
    tableView.frame=CGRectMake(0,435, 768, 600);//
    tableView.contentSize=CGSizeMake(768, 170*10);
    tableView.scrollEnabled=NO;
    
    offerstablevie = [[UITableView alloc] init];
    offerstablevie.delegate = self;
    offerstablevie.dataSource = self;
    offerstablevie.tag = 2;
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        offerstablevie.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
        offerstablevie.separatorStyle = UITableViewCellSeparatorStyleNone;
        //offerstablevie.separatorColor = [UIColor orangeColor];
        [mainScrollview addSubview:offerstablevie];
        offerstablevie.scrollEnabled = NO;
    }
    else
    {
        offerstablevie.backgroundColor = [UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:1.0f];
        offerstablevie.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        //[self.view addSubview:tableView];
        [mainScrollview addSubview:tableView];
        
        [tableView addSubview:offerstablevie];
        
    }
    
    offerstablevie.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    offerstablevie.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        //        offerstablevie.frame = CGRectMake(0, 280, 320, self.view.frame.size.height-262);
        offerstablevie.frame = CGRectMake(0, 216, 320, 125*10);
        offerstablevie.contentSize = CGSizeMake(320, 125*10);
    }
    else
    {
        offerstablevie.scrollEnabled=NO;
        offerstablevie.frame = CGRectMake(10, 0, 369, 170*10);
        offerstablevie.contentSize = CGSizeMake(369, 170*10);
    }
    
    //--------- Offers tableview iPad
    
    offerstablevie1 = [[UITableView alloc] init];
    offerstablevie1.delegate = self;
    offerstablevie1.dataSource = self;
    offerstablevie1.tag = 5;
    
    offerstablevie1.backgroundColor = [UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:1.0f];
    offerstablevie1.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    offerstablevie1.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    offerstablevie1.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    offerstablevie1.separatorStyle = UITableViewCellSeparatorStyleNone;
    offerstablevie1.separatorColor = [UIColor orangeColor];
    offerstablevie1.scrollEnabled=NO;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [tableView addSubview:offerstablevie1];
        offerstablevie1.frame = CGRectMake(389, 0, 369, 170*10);
        offerstablevie1.contentSize = CGSizeMake(369, 170*10);
    }
    
    //[self initAndFetchData];
}


-(void)viewWillAppear:(BOOL)animated
{
    if ([_emirateString length]==0)
        emirateLable.text = @"Dubai";
    else
        emirateLable.text = _emirateString;
    
    if(UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPhone)
    {
        emirateImage.frame = CGRectMake(0, 0, 320 , 42 );
        emirateButton.frame = CGRectMake(240, 10 , 100 , 10 );
        emirateLable.frame = CGRectMake(85, 11, 320 , 20 );
        //       searchBar.frame=CGRectMake(10, 0.5, 180, 40);
        searchBar.frame=CGRectMake(2, 0.5, 180, 40);
        // [emirateButton setImage:arraowImage.image forState:UIControlStateNormal];
        emirateLable.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
        [searchBar setPlaceholder:@"Search                    "];
        if([emirateLable.text isEqualToString:@"Northern Emirates"])
        {
            arraowImage.frame= CGRectMake(305, 19 , 10 , 5 );
            //  emirateButton.frame = CGRectMake(305, 16 , 10 , 5 );
            
        }
        else if([emirateLable.text isEqualToString:@"Abu Dhabi"])
        {
            arraowImage.frame= CGRectMake(282, 19 , 10 , 5 );
            // emirateButton.frame = CGRectMake(282, 16 , 10 , 5 );
        }
        else if([emirateLable.text isEqualToString:@"Dubai"])
        {
            arraowImage.frame= CGRectMake(265, 19 , 10 , 5 );
            // emirateButton.frame = CGRectMake(265, 16 , 10 , 5 );
        }
        
        else if([emirateLable.text isEqualToString:@"Sharjah"])
        {
            arraowImage.frame = CGRectMake(270, 19 , 10 , 5 );
            
        }//     arraowImage.frame = CGRectMake(277, 97, 6, 3);
    }
    else
    {
        emirateImage.frame = CGRectMake(0, 0, 768, 58);
        emirateButton.frame = CGRectMake(640, 10, 200, 15);
        emirateLable.frame = CGRectMake(240, 16, 768, 25);
        //        searchBar.frame=CGRectMake(10, 3, 500, 50);
        //        [searchBar setPlaceholder:@"Search                                                                                               "];
        searchBar.frame=CGRectMake(20, 4, 500, 50);
        [searchBar setPlaceholder:@"Search                                                                                               "];
        
        if([emirateLable.text isEqualToString:@"Abu Dhabi"])
        {
            //  arraowImage.frame = CGRectMake(650, 105, 6*x_ratio, 5);
            arraowImage.frame = CGRectMake(685, 25, 18, 9);
        }
        else if([emirateLable.text isEqualToString:@"Northern Emirates"])
        {
            //arraowImage.frame = CGRectMake(650, 105, 6*x_ratio, 5);
            arraowImage.frame = CGRectMake(720, 25, 18, 9);
        }
        else
        {
            //arraowImage.frame = CGRectMake(650, 105, 6*x_ratio, 5);
            arraowImage.frame = CGRectMake(660, 25, 18, 9);
        }
        
        if ([titleString isEqualToString:@"Casual Dining"] == TRUE)
        {
            arraowImage.image=[UIImage imageNamed:@"Down_ipad4.png"];
            // [emirateButton setImage:[UIImage imageNamed:@"Down_ipad4.png"] forState:UIControlStateNormal];
            
        }
        else if([titleString isEqualToString:@"Shopping"] == TRUE)
        {
            arraowImage.image=[UIImage imageNamed:@"Down_ipad9.png"];
            //[emirateButton setImage:[UIImage imageNamed:@"Down_ipad9.png"] forState:UIControlStateNormal];
        }
        else if([titleString isEqualToString:@"Fine Dining"] == TRUE)
        {
            
            arraowImage.image=[UIImage imageNamed:@"Down_ipad10.png"];
            //[emirateButton setImage:[UIImage imageNamed:@"Down_ipad10.png"] forState:UIControlStateNormal];
            
        }
        
        else if([titleString isEqualToString:@"Home & Garden"] == TRUE)
        {
            arraowImage.image=[UIImage imageNamed:@"Down_ipad7.png"];
            // [emirateButton setImage:[UIImage imageNamed:@"Down_ipad7.png"] forState:UIControlStateNormal];
            
        }
        
        else if([titleString isEqualToString:@"Children"] == TRUE)
        {
            arraowImage.image=[UIImage imageNamed:@"Down_ipad5.png"];
            // [emirateButton setImage:[UIImage imageNamed:@"Down_ipad5.png"] forState:UIControlStateNormal];
            
        }
        
        else if([titleString isEqualToString:@"Beauty & Wellness"] == TRUE)
        {
            arraowImage.image=[UIImage imageNamed:@"Down_ipad3.png"];
            //  [emirateButton setImage:[UIImage imageNamed:@"Down_ipad3.png"] forState:UIControlStateNormal];
        }
        
        else if([titleString isEqualToString:@"Health & Fitness"] == TRUE)
        {
            arraowImage.image=[UIImage imageNamed:@"Down_ipad6.png"];
            //[emirateButton setImage:[UIImage imageNamed:@"Down_ipad6.png"] forState:UIControlStateNormal];
            
        }
        
        else if([titleString isEqualToString:@"Services"] == TRUE)
        {
            arraowImage.image=[UIImage imageNamed:@"Down_ipad8.png"];
            //[emirateButton setImage:[UIImage imageNamed:@"Down_ipad8.png"] forState:UIControlStateNormal];
            
            
        }
        
        else
        {
            arraowImage.image=[UIImage imageNamed:@"Down_ipad2.png"];
            // [emirateButton setImage:[UIImage imageNamed:@"Down_ipad2.png"] forState:UIControlStateNormal];
            
            
        }
        
        
        emirateLable.font = [UIFont fontWithName:@"Helvetica Neue" size:22];
        
        
    }
    
    
    
    
    if (!_IsFromSubmitBtn)
    {
        return;
    }
    else
        _IsFromSubmitBtn=NO;
    
    [self initAndFetchData];
}

-(void)initAndFetchData
{
    filtersArray=[[NSMutableArray alloc]init];
    NearByArray=[[NSMutableArray alloc]init];
    NewArray=[[NSMutableArray alloc]init];
    CuisineArray=[[NSMutableArray alloc]init];
    PremiumArray=[[NSMutableArray alloc]init];
    
    
    NSUserDefaults *UD=[NSUserDefaults standardUserDefaults ];
    NSArray *ParamArray;
    if ([UD objectForKey:@"LandingFilterSubTitleArray"])
        ParamArray=[UD objectForKey:@"LandingFilterSubTitleArray"];
    
    if (![[ParamArray objectAtIndex:1] isEqualToString:titleString])
    {
        ParamArray=Nil;
        [UD removeObjectForKey:@"LandingFilterSubTitleArray"];
        [UD removeObjectForKey:@"LandingSelectedCatogories"];
        [UD removeObjectForKey:@"LandingSelectedAreas"];
        [UD synchronize];
    }
    
    NSString *urlstr;
    if ([ParamArray count]>0)
    {
        urlstr=[NSString stringWithFormat:@"http://testws.goodliving.ae/api/index.php/offer/returnOffers/%@/%@/%@/%@/%@",[ParamArray objectAtIndex:0],[ParamArray objectAtIndex:1],[ParamArray objectAtIndex:2],delegate.lattitude,delegate.longitude];
        areaString=[ParamArray objectAtIndex:3];
        if ([ParamArray count]>4)
            CuisineStrimg=[ParamArray objectAtIndex:4];
    }
    else
    {
        urlstr=[NSString stringWithFormat:@"https://testws.goodliving.ae/api/index.php/offer/returnOffers/%@/%@/All/%@/%@",emirateLable.text,titleString,delegate.lattitude,delegate.longitude];
        areaString=@"All";
        CuisineStrimg=@"All";
        
    }
    
    waitingAlt=[[UIAlertView alloc]initWithTitle:@"Please Wait" message:Nil delegate:Nil cancelButtonTitle:Nil otherButtonTitles:Nil, nil];
    [waitingAlt show];
    [self performSelectorInBackground:@selector(fetchOfferswithUrl:) withObject:urlstr];
}

- (void) selectedTab : (id) sender
{
    NSArray *subviews = [[NSArray alloc] initWithArray:tabsScrool.subviews];
    for (UIButton *subview in subviews)
    {
        if ([subview isKindOfClass:[UIButton class]])
        {
            subview.selected = FALSE;
        }
    }
    
    UIButton *btn = (UIButton *)sender;
    btn.selected = TRUE;
    
    //    [waitingAlt show];
    
    if ([titleString isEqualToString:@"Fine Dining"] == TRUE || [titleString isEqualToString:@"Casual Dining"] == TRUE)
    {
        if (btn.tag==0)
            //            [self performSelectorInBackground:@selector(sortDataForPremiumOffers) withObject:Nil];
            [self performSelectorInBackground:@selector(ShowPremiumOffers) withObject:Nil];
        else if (btn.tag==1)
            //            [self performSelectorInBackground:@selector(SortDataForCuisines) withObject:Nil];
            [self performSelectorInBackground:@selector(ShowCuisineOffers) withObject:Nil];
        else if (btn.tag==2)
            //            [self performSelectorInBackground:@selector(sortDataForNewOffers) withObject:Nil];
            [self performSelectorInBackground:@selector(ShownewOffers) withObject:Nil];
        else if (btn.tag==3)
            //            [self performSelectorInBackground:@selector(SortDataFromArray:) withObject:filtersArray];
            [self performSelectorInBackground:@selector(ShowOffersNearby) withObject:filtersArray];
    }
    else
    {
        if (btn.tag==0)
            //            [self performSelectorInBackground:@selector(sortDataForPremiumOffers) withObject:Nil];
            [self performSelectorInBackground:@selector(ShowPremiumOffers) withObject:Nil];
        else if (btn.tag==1)
            //            [self performSelectorInBackground:@selector(sortDataForNewOffers) withObject:Nil];
            [self performSelectorInBackground:@selector(ShownewOffers) withObject:Nil];
        else if (btn.tag==2)
            //            [self performSelectorInBackground:@selector(SortDataFromArray:) withObject:filtersArray];
            [self performSelectorInBackground:@selector(ShowOffersNearby) withObject:filtersArray];
        
    }
    
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        if(btn.tag==0)
        {
            
            if (counter==1) {
                lineImg.frame = CGRectMake(0, 0, 0, 0);
                [btn setBackgroundImage:[UIImage imageNamed:@"menu_p.png"] forState:UIControlStateSelected];
                
            }
            else
            {
                lineImg.frame = CGRectMake(0, 0, 0, 0);
                
                [btn setBackgroundImage:[UIImage imageNamed:@"menu_p.png"] forState:UIControlStateSelected];
                //(0, 40, 80, 2)
            }
        }
        
        else  if(btn.tag==1)
        {
            if (counter==1) {
                lineImg.frame = CGRectMake(256, 65, 256, 2);
            }
            else
            {
                lineImg.frame = CGRectMake(192, 65, 192, 2);
                
            }
        }
        else  if(btn.tag==2)
        {
            
            if (counter==1) {
                lineImg.frame = CGRectMake(512, 65, 256, 2);
            }
            else
            {
                lineImg.frame = CGRectMake(384, 65, 192, 2);
            }
        }
        else  if(btn.tag==3)
        {
            lineImg.frame = CGRectMake(576, 65, 192, 2);
        }
    }
    else
        
    {
        if(btn.tag==0)
        {
            
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            if (counter==1) {
                lineImg.frame = CGRectMake(0, 0, 0, 0);
                [btn setBackgroundImage:[UIImage imageNamed:@"menu_p.png"] forState:UIControlStateSelected];
                
            }
            else
            {
                lineImg.frame = CGRectMake(0, 0, 0, 0);
                
                [btn setBackgroundImage:[UIImage imageNamed:@"menu_p.png"] forState:UIControlStateSelected];
                //(0, 40, 80, 2)
            }
        }
        
        else  if(btn.tag==1)
        {
            if (counter==1) {
                lineImg.frame = CGRectMake(106, 40, 108, 2);
            }
            else
            {
                lineImg.frame = CGRectMake(79, 40, 81, 2);
                
            }
        }
        else  if(btn.tag==2)
        {
            
            if (counter==1) {
                lineImg.frame = CGRectMake(212, 40, 108, 2);
            }
            else
            {
                lineImg.frame = CGRectMake(159, 40, 81, 2);
            }
        }
        else  if(btn.tag==3)
        {
            lineImg.frame = CGRectMake(241, 40, 81, 2);
        }
    }
}

-(void)fetchOfferswithUrl:(NSString*)UrlStr
{
    
    //UrlStr=(NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)UrlStr, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8));
    
    UrlStr=[UrlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:UrlStr];
    NSURLRequest *req=[NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data)
        {
            NSError *err;
            
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
            [filtersArray removeAllObjects];
            
            [filtersArray addObjectsFromArray:[dict objectForKey:@"data"]];
            
            if ([areaString rangeOfString:@"All"].location == NSNotFound)
            {
                NSMutableArray *arrArea=[NSMutableArray array];
                NSMutableArray *tempTableArray=[NSMutableArray array];
                if ([areaString rangeOfString:@","].location == NSNotFound)
                {
                    [arrArea addObject:areaString];
                }
                else
                {
                    arrArea=(NSMutableArray*) [areaString componentsSeparatedByString:@","];
                }
                NSMutableSet* set1 = [NSMutableSet setWithArray:arrArea];
                
                for (NSDictionary *Dict in filtersArray)
                {
                    NSArray *tempArr= [Dict objectForKey:@"location"];
                    NSMutableSet* set2 = [NSMutableSet setWithArray:tempArr];
                    if ([set1 intersectsSet:set2])
                    {
                        [tempTableArray addObject:Dict];
                    }
                }
                [filtersArray removeAllObjects];
                [filtersArray addObjectsFromArray:tempTableArray];
            }
            if ([titleString isEqualToString:@"Fine Dining"] == TRUE || [titleString isEqualToString:@"Casual Dining"] == TRUE)
            {
                if ([CuisineStrimg rangeOfString:@"All"].location == NSNotFound)
                {
                    NSMutableArray *arrCuisine=[NSMutableArray array];
                    NSMutableArray *tempTableArray=[NSMutableArray array];
                    if ([CuisineStrimg rangeOfString:@","].location == NSNotFound)
                    {
                        [arrCuisine addObject:CuisineStrimg];
                    }
                    else
                    {
                        arrCuisine=(NSMutableArray*) [CuisineStrimg componentsSeparatedByString:@","];
                    }
                    NSMutableSet* set1 = [NSMutableSet setWithArray:arrCuisine];
                    
                    for (NSDictionary *Dict in filtersArray)
                    {
                        NSMutableArray *tempArr=[NSMutableArray array];
                        [tempArr addObject:[Dict objectForKey:@"Cuisine__c"]];
                        NSMutableSet* set2 = [NSMutableSet setWithArray:tempArr];
                        if ([set1 intersectsSet:set2])
                        {
                            [tempTableArray addObject:Dict];
                        }
                    }
                    [filtersArray removeAllObjects];
                    [filtersArray addObjectsFromArray:tempTableArray];
                    
                }
            }
            TabString=@"all";
            
            int count=0;
            for (NSDictionary *dict in filtersArray)
            {
                if ([[dict valueForKey:@"Offer_Category__c"] isEqualToString:@"Premium"])
                {
                    count++;
                }
            }
            
            if (count==0)
            {
                hidePremium.enabled=NO;
                [hidePremium setTitleColor:[UIColor colorWithRed:155/255.0f green:155/255.0f blue:155/255.0f alpha:0.5f] forState:UIControlStateNormal];
                
                [hidePremium setTitleColor:[UIColor colorWithRed:155/255.0f green:155/255.0f blue:155/255.0f alpha:0.5f] forState:UIControlStateSelected];
            }
            else
            {
                hidePremium.enabled=YES;
                [hidePremium setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
                [hidePremium setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
            }
            
            [self performSelectorOnMainThread:@selector(SortDataFromArray:) withObject:filtersArray waitUntilDone:YES];
            
        }
        
        [waitingAlt dismissWithClickedButtonIndex:0 animated:YES];
        [waitingAlt dismissWithClickedButtonIndex:0 animated:YES];
        [waitingAlt dismissWithClickedButtonIndex:0 animated:YES];

    }];
}

-(void)SortDataFromArray:(NSMutableArray*)dataArray
{
    [NearByArray removeAllObjects];
    NSMutableArray *distanceArray=[[NSMutableArray alloc]init];
    for (NSDictionary *dict in dataArray)
    {
        NSNumber *num=[NSNumber numberWithFloat:[[dict valueForKey:@"Distance"] floatValue]];
        [distanceArray addObject:num];
    }
    
    //    NSSortDescriptor *Sd=[[NSSortDescriptor alloc]initWithKey:Nil ascending:YES];
    //    distanceArray =(NSMutableArray *)[distanceArray sortedArrayUsingDescriptors:@[Sd]];
    
    NSArray *sortedArray = [distanceArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
        
        if ([obj1 floatValue] == 0 && [obj2 floatValue] == 0)
        {
            return (NSComparisonResult)NSOrderedSame;
        }
        if ([obj1 floatValue] == 0)
        {
            return (NSComparisonResult)NSOrderedDescending;
        }
        if ([obj2 floatValue] == 0)
        {
            return (NSComparisonResult)NSOrderedAscending;
        }
        
        if ([obj1 floatValue] > [obj2 floatValue])
        {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 floatValue] < [obj2 floatValue])
        {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    
    [distanceArray removeAllObjects];
    
    [distanceArray addObjectsFromArray:sortedArray];
    
    for (int i=0; i<[distanceArray count]; i++)
    {
        //NSString *distance=[NSString stringWithFormat:@"%.2f",[[distanceArray objectAtIndex:i] floatValue]];
        float distance=[[distanceArray objectAtIndex:i] floatValue];
        for (NSDictionary *dict in dataArray)
        {
            //if ([[dict valueForKey:@"Distance"] isEqualToString:distance] && ![NearByArray containsObject:dict])
            if ([[dict valueForKey:@"Distance"] floatValue]==distance && ![NearByArray containsObject:dict])
            {
                [NearByArray addObject:dict];
                break;
            }
        }
    }
    if ([delegate.lattitude intValue]==0 && [delegate.longitude intValue]==0)
    {
        [NearByArray removeAllObjects];
        [NearByArray addObjectsFromArray:filtersArray];
    }
    if ([titleString isEqualToString:@"Fine Dining"] == TRUE || [titleString isEqualToString:@"Casual Dining"] == TRUE)
        [self SortDataForCuisines];
    else
        [self sortDataForPremiumOffers];
    [self ShowOffersNearby];
    
    UIButton *tabbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    if ([titleString isEqualToString:@"Fine Dining"] == TRUE || [titleString isEqualToString:@"Casual Dining"] == TRUE)
        tabbtn.tag=3;
    else
        tabbtn.tag=2;
    
    [self selectedTab:tabbtn];
}

-(void)ShowOffersNearby
{
    NSMutableArray *temp=[NSMutableArray array];
    [temp addObjectsFromArray:NearByArray];
    tableDataArray=temp;
    
    [self checkForArea];
}

-(void)SortDataForCuisines
{
    [CuisineArray removeAllObjects];
    NSMutableArray *CuisineArray1=[[NSMutableArray alloc]init];
    
    for (NSDictionary *dict in filtersArray)
    {
        [CuisineArray1 addObject:[dict valueForKey:@"Cuisine__c"]];
    }
    
    NSSortDescriptor *Sd=[[NSSortDescriptor alloc]initWithKey:Nil ascending:YES];
    NSArray *Arrsorted=[CuisineArray1 sortedArrayUsingDescriptors:@[Sd]];
    [CuisineArray1 removeAllObjects];
    [CuisineArray1 addObjectsFromArray:Arrsorted];
    
    NSMutableArray *arrtemp=[NSMutableArray array];
    
    while (CuisineArray1.count>=1)
    {
        if (![[CuisineArray1 objectAtIndex:0] isEqualToString:@""])
            break;
        [arrtemp addObject:[CuisineArray1 objectAtIndex:0]];
        [CuisineArray1 removeObjectAtIndex:0];
    }
    
    [CuisineArray1 addObjectsFromArray:arrtemp];
    //    NSSortDescriptor *Sd=[[NSSortDescriptor alloc]initWithKey:Nil ascending:YES];
    //    CuisineArray1 =(NSMutableArray *)[CuisineArray1 sortedArrayUsingDescriptors:@[Sd]];
    for (int i=0; i<[CuisineArray1 count]; i++)
    {
        NSString *Cuisine=[NSString stringWithFormat:@"%@",[CuisineArray1 objectAtIndex:i]];
        for (NSDictionary *dict in filtersArray)
        {
            if ([[dict valueForKey:@"Cuisine__c"] isEqualToString:Cuisine] && ![CuisineArray containsObject:dict])
            {
                [CuisineArray addObject:dict];
                break;
            }
        }
    }
    
    [self sortDataForPremiumOffers];
}

-(void)ShowCuisineOffers
{
    NSMutableArray *temp=[NSMutableArray array];
    [temp addObjectsFromArray:CuisineArray];
    tableDataArray=temp;
    
    [self checkForArea];
}


-(void)sortDataForPremiumOffers
{
    [PremiumArray removeAllObjects];
    
    for (NSDictionary *dict in filtersArray)
    {
        if ([[dict valueForKey:@"Offer_Category__c"] isEqualToString:@"Premium"] && ![PremiumArray containsObject:dict])
        {
            [PremiumArray addObject:dict];
        }
    }
    [self sortDataForNewOffers];
    
}

-(void)ShowPremiumOffers
{
    NSMutableArray *temp=[NSMutableArray array];
    [temp addObjectsFromArray:PremiumArray];
    tableDataArray=temp;
    
    [self checkForArea];
}


-(void)sortDataForNewOffers
{
    [NewArray removeAllObjects];
    
    for (NSDictionary *dict in filtersArray)
    {
        if ([[dict valueForKey:@"New"] isEqualToString:@"1"] && ![NewArray containsObject:dict])
        {
            [NewArray addObject:dict];
        }
    }
}

-(void)ShownewOffers
{
    NSMutableArray *temp=[NSMutableArray array];
    [temp addObjectsFromArray:NewArray];
    tableDataArray=temp;
    
    [self checkForArea];
}

-(void)checkForArea
{
    
    if ([tableDataArray count]==0)
    {
        
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            
            NoResults.numberOfLines=5;
            NoResults.lineBreakMode=NSLineBreakByWordWrapping;
            [NoResults setFont:[UIFont fontWithName:@"Helvetica Neue" size:16]];
            NoResults.text=[NSString stringWithFormat:@"No offers available for %@ in %@ with this criteria.",titleString,emirateLable.text];
            [mainScrollview addSubview:NoResults];
        }
        else
        {
            
            NoResults.numberOfLines=5;
            NoResults.lineBreakMode=NSLineBreakByWordWrapping;
            [NoResults setFont:[UIFont fontWithName:@"Helvetica Neue" size:20]];
            NoResults.text=[NSString stringWithFormat:@"No offers available for %@ in %@ with this criteria.",titleString,emirateLable.text];
            [self.view addSubview:NoResults];
            
            
        }
        
        
    }
    
    else
    {
        [NoResults removeFromSuperview];
    }
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        // mainScrollview.contentSize=CGSizeMake(320, 140*[tableDataArray count]);
        restorantImagesScrool.frame = CGRectMake(0, 42, 320, 129);
        restorantImagesScrool.contentSize = CGSizeMake(320*3, 129);
        pageControl.numberOfPages = 3;
        
        for (int i = 0; i < 3 && i<[tableDataArray count] ; i++)
        {
            UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(1+(i*320), 1, 318, restorantImagesScrool.frame.size.height-2)];
            
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag=i;
            btn.frame=imageview.frame;
            [restorantImagesScrool addSubview:btn];
            [btn addTarget:self action:@selector(promotionImgaesMethod:) forControlEvents:UIControlEventTouchUpInside];
            
            NSURL *url = [NSURL URLWithString:[[tableDataArray objectAtIndex:i] valueForKey:@"Offer_Image_1__c"]];
            
            
            NSURLRequest *req=[NSURLRequest requestWithURL:url];
            
            
            UIActivityIndicatorView *activityview1 = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            activityview1.center = CGPointMake(restorantImagesScrool.bounds.size.width / 2,restorantImagesScrool.bounds.size.height /2);
            [activityview1 startAnimating];
            activityview1.tag = i;
            NSArray *subviewArray = [restorantImagesScrool subviews];
            
            [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                if (data)
                {
                    
                    for (UIView *view in subviewArray)
                    {
                        if([view isKindOfClass:[UIActivityIndicatorView class]])
                        {
                            UIActivityIndicatorView *activity = (UIActivityIndicatorView *)view;
                            [activity stopAnimating];
                            [activity removeFromSuperview];
                        }
                    }
                    
                    [imageview setImage:[UIImage imageWithData:data]];
                }
                
                else
                    imageview.image =[UIImage imageNamed:@"11.png"];
            }];
            
            [restorantImagesScrool addSubview:imageview];
        }
    }
    else
    {
        tableDataArray1=[NSMutableArray array];
        
        NSMutableArray *temp=[NSMutableArray array];
        for (int i=0; i<[tableDataArray count]; i++)
        {
            if (i%2==0)
                [temp addObject:[tableDataArray objectAtIndex:i]];
            else
                [tableDataArray1 addObject:[tableDataArray objectAtIndex:i]];
        }
        
        [tableDataArray removeAllObjects];
        tableDataArray=temp;
        
        
        
        mainScrollview.contentSize=CGSizeMake(768, (185*([tableDataArray count]))+365);
        tableView.contentSize=CGSizeMake(768, (185*[tableDataArray count])+365);
        tableView.frame = CGRectMake(0,365, 768, (185*[tableDataArray count]) + 365);
        
        
        restorantImagesScrool.frame = CGRectMake(0, 54,768, 240);
        restorantImagesScrool.contentSize = CGSizeMake(768*3, 240);
        pageControl.numberOfPages = 3;
        
        
        for (int i = 0; i <  3 && i<[tableDataArray count] ; i++)
        {
            UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0+(i*768), 1,768, restorantImagesScrool.frame.size.height-2)];
            // imageview.image = [UIImage imageNamed:@"scrolling1.png"];
            
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag=i;
            btn.frame=imageview.frame;
            [restorantImagesScrool addSubview:btn];
            [btn addTarget:self action:@selector(promotionImgaesMethod:) forControlEvents:UIControlEventTouchUpInside];
            
            
            NSURL *url = [NSURL URLWithString:[[tableDataArray objectAtIndex:i] valueForKey:@"Offer_Image_1__c"]];
            
            
            NSURLRequest *req=[NSURLRequest requestWithURL:url];
            
            
            UIActivityIndicatorView *activityview1 = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            activityview1.center = CGPointMake(restorantImagesScrool.bounds.size.width / 2,restorantImagesScrool.bounds.size.height /2);
            [activityview1 startAnimating];
            activityview1.tag = i;
            [restorantImagesScrool addSubview:activityview1];
            
            [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                if (data)
                {
                    NSArray *subviewArray = [restorantImagesScrool subviews];
                    
                    for (UIView *view in subviewArray)
                    {
                        if([view isKindOfClass:[UIActivityIndicatorView class]])
                        {
                            UIActivityIndicatorView *activity = (UIActivityIndicatorView *)view;
                            [activity stopAnimating];
                            [activity removeFromSuperview];
                        }
                    }
                    
                    [imageview setImage:[UIImage imageWithData:data]];
                }
                
                else
                    imageview.image =[UIImage imageNamed:@"11.png"];
            }];
            
            [restorantImagesScrool addSubview:imageview];
        }
        
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        //        offerstablevie.frame = CGRectMake(0, 280, 320, self.view.frame.size.height-262);
        offerstablevie.frame = CGRectMake(0, 216, 320, 140*[tableDataArray count]);
        offerstablevie.contentSize = CGSizeMake(320, 140*([tableDataArray count]));
        mainScrollview.contentSize=CGSizeMake(320,216 + (140*([tableDataArray count]+1)));
        
        [offerstablevie performSelectorOnMainThread:@selector(reloadData) withObject:Nil waitUntilDone:YES];
        
    }
    else
    {
        offerstablevie.scrollEnabled=NO;
        offerstablevie.frame = CGRectMake(0, 0, 376, 185*[tableDataArray count]);
        offerstablevie.contentSize = CGSizeMake(374, 185*[tableDataArray count]);
        
        // mainScrollview.contentSize=CGSizeMake(768, 185*[tableDataArray1 count]);
        offerstablevie1.frame = CGRectMake(390, 0, 376, 185*[tableDataArray1 count]);
        offerstablevie1.contentSize = CGSizeMake(374, 185*[tableDataArray1 count]);
        
        [offerstablevie performSelectorOnMainThread:@selector(reloadData) withObject:Nil waitUntilDone:YES];
        [offerstablevie1 performSelectorOnMainThread:@selector(reloadData) withObject:Nil waitUntilDone:YES];
    }
    
    
    [waitingAlt dismissWithClickedButtonIndex:0 animated:NO];
    
    
}

-(void)promotionImgaesMethod:(id)sender
{
    UIButton * btn=(UIButton *)sender;
    OfferDetailsController *nextView = [[OfferDetailsController alloc] init];
    nextView.newestOfferID=[[tableDataArray objectAtIndex:btn.tag] valueForKey:@"offerId"];
    [self.navigationController pushViewController:nextView animated:YES];
}

- (void) emitareMethod
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
    emiritsviewLocal.frame = CGRectMake(35*x_ratio, 200*y_ratio, 250*x_ratio, 130*y_ratio);
    emiritsviewLocal.backgroundColor  = [UIColor whiteColor];
    emiritsviewLocal.layer.cornerRadius = 5.0f;
    [emiritsBackView addSubview:emiritsviewLocal];
    
    myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(35*x_ratio, 230*y_ratio, emiritsviewLocal.frame.size.width, 100*y_ratio)];
    [emiritsBackView addSubview:myPickerView];
    myPickerView.delegate = self;
    myPickerView.showsSelectionIndicator = YES;
    myPickerView.backgroundColor=[UIColor whiteColor];
    
    UITapGestureRecognizer* gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerViewTapGestureRecognized:)];
    [myPickerView addGestureRecognizer:gestureRecognizer];
    
    UILabel *emiritsLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 5*y_ratio, emiritsviewLocal.frame.size.width,24*y_ratio)];
    emiritsLable.text = @"Change Emirate";
    emiritsLable.textColor = [UIColor blackColor];
    emiritsLable.backgroundColor = [UIColor clearColor];
    emiritsLable.textAlignment = NSTextAlignmentCenter;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if (self.view.frame.size.height == 568)
        {
            emiritsLable.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
            emiritsLable.font = [UIFont boldSystemFontOfSize:20];
        }
        else
        {
            emiritsLable.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
            emiritsLable.font = [UIFont boldSystemFontOfSize:18];
        }
    }
    
    [emiritsviewLocal addSubview:emiritsLable];
    
}

#pragma mark - Pickerview Delegate

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
            arraowImage.frame= CGRectMake(305, 19 , 10 , 5 );
            //  emirateButton.frame = CGRectMake(305, 16 , 10 , 5 );
            
        }
        else if([emirateLable.text isEqualToString:@"Abu Dhabi"])
        {
            arraowImage.frame= CGRectMake(282, 19 , 10 , 5 );
            // emirateButton.frame = CGRectMake(282, 16 , 10 , 5 );
        }
        else if([emirateLable.text isEqualToString:@"Dubai"])
        {
            arraowImage.frame= CGRectMake(265, 19 , 10 , 5 );
            // emirateButton.frame = CGRectMake(265, 16 , 10 , 5 );
        }
        else
        {
            arraowImage.frame= CGRectMake(270, 19 , 10 , 5 );
            // emirateButton.frame = CGRectMake(300, 16 , 10 , 5 );
        }
        
    }
    else
    {
        //        if([emirateLable.text isEqualToString:@"Northern Emirates"])
        //        {
        //          arraowImage.frame = CGRectMake(650, 105, 6*x_ratio, 5);
        //        }
        //        else
        //        {
        //            arraowImage.frame = CGRectMake(650, 105, 6*x_ratio, 5);
        //        }
        
        if([emirateLable.text isEqualToString:@"Abu Dhabi"])
        {
            //  arraowImage.frame = CGRectMake(650, 105, 6*x_ratio, 5);
            arraowImage.frame = CGRectMake(685, 25, 18, 9);
        }
        else if([emirateLable.text isEqualToString:@"Northern Emirates"])
        {
            //arraowImage.frame = CGRectMake(650, 105, 6*x_ratio, 5);
            arraowImage.frame = CGRectMake(720, 25, 18, 9);
        }
        else
        {
            //arraowImage.frame = CGRectMake(650, 105, 6*x_ratio, 5);
            arraowImage.frame = CGRectMake(660, 25, 18, 9);
        }
        
    }
    
    _emirateString=emirateLable.text;
    // [self viewWillAppear:YES];
    [self initAndFetchData];
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [emiritsArray objectAtIndex:row];
    
    [emiritsBackView removeFromSuperview];
    
}
// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    CGFloat componentWidth = 0.0;
    componentWidth = 200.0;
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
        //[tView setTextAlignment:uitexta];
        //tView.numberOfLines=3;
    }
    // Fill the label text here
    tView.text=[emiritsArray objectAtIndex:row];
    tView.textAlignment = NSTextAlignmentCenter;
    return tView;
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

- (void) filterMethod
{
    filterdelay=[[UIAlertView alloc]initWithTitle:@"Please wait..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [filterdelay show];
    
    [self performSelector:@selector(filtermethodDelay) withObject:nil afterDelay:0.1];
    
}

-(void)filtermethodDelay
{
    [filterdelay dismissWithClickedButtonIndex:0 animated:YES];
    
    FilterController *filter=[[FilterController alloc]init];
    filter.emiratesString=emirateLable.text;
    filter.themeString=titleString;
    [self.navigationController pushViewController:filter animated:YES];
}
#pragma mark - TableView delegate and datasource methods
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 1)
        return [emiritsArray count];
    else if (tableView.tag == 2)
    {
        if(UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPhone)
        {
            return [tableDataArray count];
        }
        else
        {
            return [tableDataArray count];
        }
    }
    else if (tableView.tag == 5)
        return [tableDataArray1 count];
    
    else
        return [filtersArray count];
    
    
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1)
    {
        return 20;
    }
    else if (tableView.tag == 2)
    {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            return 140;
            
        }
        else
        {
            return 185;
        }
    }
    else if (tableView.tag == 5)
    {
        return 185;
        
    }
    else
    {
        return 45;
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
    UIView *backView;
    if (cell.selected==YES)
    {
        cell.selected=NO;
        backView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    
    if(UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPhone)
    {
        [UIColor colorWithRed:255/255.0f green:250/255.0f blue:242/255.0f alpha:1.0f];
    }
    else
    {
        backView.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"cellback.png"]];
        
    }
    
    cell.selectedBackgroundView=backView;
    
    UILabel *nameLable =[[UILabel alloc] init];
    
    if (tableView.tag == 1)
    {
        nameLable.frame = CGRectMake(20, 0, 210, 18);
        nameLable.text = [emiritsArray objectAtIndex:indexPath.row];
        nameLable.textAlignment = NSTextAlignmentCenter;
        nameLable.textColor = [UIColor blackColor];
        nameLable.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    }
    else if (tableView.tag == 2)
    {
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 170)];
            img.backgroundColor =[UIColor whiteColor];
            //            img.image = [UIImage imageNamed:@"11.png"];
            [cell.contentView addSubview:img];
            
            UIImageView *pofferimg = [[UIImageView alloc] initWithFrame:CGRectMake(8, 20, 120, 120)];
            pofferimg.image = [UIImage imageNamed:@"11_240X240.png"];
            
            NSURL *url = [NSURL URLWithString:[[tableDataArray objectAtIndex:indexPath.row] valueForKey:@"Offer_Image_1__c"]];
            
            
            NSURLRequest *req=[NSURLRequest requestWithURL:url];
            
            [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                if (data)
                {
                    
                    UIImage *imageGNoff = [UIImage imageWithData:data];
                    
                    CGSize imageSize = imageGNoff.size;
                    CGFloat width = imageSize.width;
                    CGFloat height = imageSize.height;
                    if (width != height)
                    {
                        CGFloat newDimension = MIN(width, height);
                        CGFloat widthOffset = (width - newDimension) / 2;
                        CGFloat heightOffset = (height - newDimension) / 2;
                        UIGraphicsBeginImageContextWithOptions(CGSizeMake(newDimension, newDimension), NO, 0.);
                        [imageGNoff drawAtPoint:CGPointMake(-widthOffset, -heightOffset)
                                      blendMode:kCGBlendModeCopy
                                          alpha:1.];
                        imageGNoff = UIGraphicsGetImageFromCurrentImageContext();
                        UIGraphicsEndImageContext();
                    }
                    pofferimg.image =imageGNoff;
                    
                    //                  [pofferimg setImage:[UIImage imageWithData:data]];
                }
            }];
            //          [pofferimg performSelectorInBackground:@selector(setImage:) withObject:[UIImage imageWithData:[NSData dataWithContentsOfURL:url]]];
            [cell.contentView addSubview:pofferimg];
            
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            NSDictionary *mydictionary=(NSDictionary *) [prefs objectForKey:@"Registration"];
            NSString *subType=[mydictionary valueForKey:@"subType"];
            if(delegate.loginFlag==1)
            {
                if ([[NSString stringWithFormat:@"%@",subType] isEqualToString:@"0"]==TRUE && [[[tableDataArray objectAtIndex:indexPath.row] valueForKey:@"For_Non_Subscribers__c"] isEqualToString:@"0"] == TRUE )
                {
                    UIImageView *imageLocal = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, pofferimg.frame.size.width, pofferimg.frame.size.height)];
                    imageLocal.image = [UIImage imageNamed:@"lock_120.png"];
                    [pofferimg addSubview:imageLocal];
                }
            }
            
            
            CGSize labelSize = [[[tableDataArray objectAtIndex:indexPath.row] valueForKey:@"Merchant_Name"] sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:20]
                                                                                                       constrainedToSize:CGSizeMake(180, 9999)
                                                                                                           lineBreakMode:NSLineBreakByWordWrapping];
            
            if (labelSize.height > 47)
                labelSize.height = 47;
            
            UILabel *offerTitlelabel = [[UILabel alloc] initWithFrame:CGRectMake(135, 18, 220, labelSize.height)];//labelSize.height)];
            offerTitlelabel.text = [[tableDataArray objectAtIndex:indexPath.row] valueForKey:@"Merchant_Name"];
            offerTitlelabel.textColor =  [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
            offerTitlelabel.backgroundColor = [UIColor clearColor];
            offerTitlelabel.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
            offerTitlelabel.numberOfLines = 2;
            offerTitlelabel.lineBreakMode = NSLineBreakByWordWrapping;
            [cell.contentView addSubview:offerTitlelabel];
            
            //            UILabel *countrylabel = [[UILabel alloc] initWithFrame:CGRectMake(300, 28, 60, 15)];
            //            countrylabel.text = [[tableDataArray objectAtIndex:indexPath.row] valueForKey:@"Cuisine__c"];
            //            countrylabel.textAlignment = NSTextAlignmentRight;
            //            countrylabel.textColor = [UIColor lightGrayColor];
            //            countrylabel.backgroundColor = [UIColor clearColor];
            //            countrylabel.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
            //            countrylabel.font = [UIFont boldSystemFontOfSize:12];
            //            [cell.contentView addSubview:countrylabel];
            
            
            UILabel *discountlabel = [[UILabel alloc] initWithFrame:CGRectMake(137, offerTitlelabel.frame.size.height+15, 180, 30)];
            discountlabel.text = [[tableDataArray objectAtIndex:indexPath.row] valueForKey:@"Title"];
            discountlabel.textColor =  [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
            discountlabel.backgroundColor = [UIColor clearColor];
            discountlabel.font = [UIFont fontWithName:@"Helvetica Neue" size:10];
            discountlabel.numberOfLines = 2;
            discountlabel.lineBreakMode = NSLineBreakByWordWrapping;
            discountlabel.font = [UIFont boldSystemFontOfSize:10];
            [cell.contentView addSubview:discountlabel];
            
            UIImageView *mapimg = [[UIImageView alloc] initWithFrame:CGRectMake(139, 99, 20, 20)];
            mapimg.image = [UIImage imageNamed:@"map.png"];
            [cell.contentView addSubview:mapimg];
            
            UILabel *distancelabel = [[UILabel alloc] initWithFrame:CGRectMake(159, 99, 180, 20)];
            distancelabel.text = [NSString stringWithFormat:@"%@",[[tableDataArray objectAtIndex:indexPath.row] valueForKey:@"Nearest_location"]];
            distancelabel.textColor = [UIColor colorWithRed:136.0f/255.0f green:136.0f/255.0f blue:136.0f/255.0f alpha:1.0f];
            distancelabel.backgroundColor = [UIColor clearColor];
            distancelabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
            //            distancelabel.font = [UIFont boldSystemFontOfSize:12];
            [cell.contentView addSubview:distancelabel];
            
            
            UILabel *distancelabel1 = [[UILabel alloc] initWithFrame:CGRectMake(159, 115, 180, 20)];
            
            float distance=[[[tableDataArray objectAtIndex:indexPath.row] valueForKey:@"Distance"] floatValue];
            
            if(distance > 50)
            {
                distancelabel1.text = [NSString stringWithFormat:@"Greater than 50 kms."];
            }
            else if(distance >1  && distance <50)
            {
                distancelabel1.text = [NSString stringWithFormat:@"%.1f kms.",distance] ;
                
            }
            else if(distance != 0.0f)
            {
                distancelabel1.text = [NSString stringWithFormat:@"Less than 1 kms." ] ;
                
            }
            
            distancelabel1.textColor = [UIColor colorWithRed:136.0f/255.0f green:136.0f/255.0f blue:136.0f/255.0f alpha:1.0f];
            distancelabel1.backgroundColor = [UIColor clearColor];
            distancelabel1.font = [UIFont fontWithName:@"Helvetica Neue" size:9];
            //            distancelabel1.font = [UIFont boldSystemFontOfSize:9];
            [cell.contentView addSubview:distancelabel1];
            
            UIImageView *viewsimg = [[UIImageView alloc] initWithFrame:CGRectMake(139, 109, 17, 17)];
            viewsimg.image = [UIImage imageNamed:@"view.png"];
            //        [cell.contentView addSubview:viewsimg];
            
            UILabel *viewslabel = [[UILabel alloc] initWithFrame:CGRectMake(139, 95, 184, 15)];
            viewslabel.text = @"24 Views";
            viewslabel.textColor = [UIColor lightGrayColor];
            viewslabel.backgroundColor = [UIColor clearColor];
            viewslabel.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
            viewslabel.font = [UIFont boldSystemFontOfSize:12];
            //        [cell.contentView addSubview:viewslabel];
            
            UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(352, 87,17,17)];
            arrowImage.image = [UIImage imageNamed:@"nextarrow.png"];
            [cell.contentView addSubview:arrowImage];
            
            BOOL IsPremiumOffer=NO;
            BOOL IsNewOffer=NO;
            
            if ([[[tableDataArray objectAtIndex:indexPath.row] valueForKey:@"Offer_Category__c"] isEqualToString:@"Premium"])
            {
                UIImageView *premiumoffer = [[UIImageView alloc] initWithFrame:CGRectMake(255, 124, 106, 25)];
                premiumoffer.image = [UIImage imageNamed:@"premiumoffer.png"];
                //[cell.contentView addSubview:premiumoffer];
                
                UIButton *premiumButton=[UIButton buttonWithType:UIButtonTypeCustom];
                [premiumButton setBackgroundImage:[UIImage imageNamed:@"premiumoffer1.png"] forState:UIControlStateNormal];
                [premiumButton setTitle:@"PREMIUM" forState:UIControlStateNormal];
                premiumButton.userInteractionEnabled = NO;
                [premiumButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                premiumButton.titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:16];
                premiumButton.frame=CGRectMake(255, 138, 106, 25);
                [cell.contentView addSubview:premiumButton];
                IsPremiumOffer=YES;
            }
            
            if ([[[tableDataArray objectAtIndex:indexPath.row] valueForKey:@"New"] isEqualToString:@"1"])
            {
                UIButton *newButton=[UIButton buttonWithType:UIButtonTypeCustom];
                
                if (IsPremiumOffer)
                    newButton.frame=CGRectMake(190, 138, 54, 25);
                else
                    newButton.frame=CGRectMake(290, 138, 54, 25);
                
                [newButton setBackgroundImage:[UIImage imageNamed:@"new1.png"] forState:UIControlStateNormal];
                [newButton setTitle:@"NEW" forState:UIControlStateNormal];
                newButton.userInteractionEnabled = NO;
                [newButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                newButton.titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:16];
                [cell.contentView addSubview:newButton];
                IsNewOffer=YES;
                
            }
            
            // for Cuisine LAble
            UILabel *countrylabel = [[UILabel alloc] init ];//]WithFrame:CGRectMake(265, 20, 50, 15)];
            countrylabel.text = [[tableDataArray objectAtIndex:indexPath.row] valueForKey:@"Cuisine__c"];
            countrylabel.textAlignment = NSTextAlignmentRight;
            countrylabel.textColor = [UIColor colorWithRed:136.0f/255.0f green:136.0f/255.0f blue:136.0f/255.0f alpha:1.0f];
            countrylabel.backgroundColor = [UIColor clearColor];
            countrylabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
            //            countrylabel.font = [UIFont boldSystemFontOfSize:14];
            [cell.contentView addSubview:countrylabel];
            
            if (IsPremiumOffer && IsNewOffer)
                countrylabel.frame=CGRectMake(80, 142, 100, 18);
            else if (IsPremiumOffer && !IsNewOffer)
                countrylabel.frame=CGRectMake(130, 142, 100, 18);
            else if (IsNewOffer && !IsPremiumOffer)
                countrylabel.frame=CGRectMake(180, 142, 100, 18);
            else
                countrylabel.frame=CGRectMake(230, 142, 100, 18);
            
            
        }
        else
        {
            
            UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 139, 320, 1)];
            
            // [line setBackgroundColor:[UIColor lightGrayColor]];
            
            [line setBackgroundColor:[UIColor colorWithRed:190/255.0f green:190/255.0f blue:190/255.0f alpha:1.0f]];
            [cell.contentView addSubview:line];
            
            UIImageView *pofferimg = [[UIImageView alloc] initWithFrame:CGRectMake(8, 14, 93, 93)];
            pofferimg.image = [UIImage imageNamed:@"11_186X186.png"];
            
            [cell.contentView addSubview:pofferimg];
            
            NSURL *url = [NSURL URLWithString:[[tableDataArray objectAtIndex:indexPath.row] valueForKey:@"Offer_Image_1__c"]];
            //[pofferimg performSelectorInBackground:@selector(setImage:) withObject:[UIImage imageWithData:[NSData dataWithContentsOfURL:url]]];
            NSURLRequest *req=[NSURLRequest requestWithURL:url];
            [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                if (data)
                {
                    
                    UIImage *imageGNoff = [UIImage imageWithData:data];
                    
                    CGSize imageSize = imageGNoff.size;
                    CGFloat width = imageSize.width;
                    CGFloat height = imageSize.height;
                    if (width != height)
                    {
                        CGFloat newDimension = MIN(width, height);
                        CGFloat widthOffset = (width - newDimension) / 2;
                        CGFloat heightOffset = (height - newDimension) / 2;
                        UIGraphicsBeginImageContextWithOptions(CGSizeMake(newDimension, newDimension), NO, 0.);
                        [imageGNoff drawAtPoint:CGPointMake(-widthOffset, -heightOffset)
                                      blendMode:kCGBlendModeCopy
                                          alpha:1.];
                        imageGNoff = UIGraphicsGetImageFromCurrentImageContext();
                        UIGraphicsEndImageContext();
                    }
                    pofferimg.image =imageGNoff;
                    
                    //                  [pofferimg setImage:[UIImage imageWithData:data]];
                }
            }];
            
            
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            NSDictionary *mydictionary=(NSDictionary *) [prefs objectForKey:@"Registration"];
            NSString *subType=[mydictionary valueForKey:@"subType"];
            
            if(delegate.loginFlag==1)
            {
                if ([[NSString stringWithFormat:@"%@",subType] isEqualToString:@"0"]==TRUE && [[[tableDataArray objectAtIndex:indexPath.row] valueForKey:@"For_Non_Subscribers__c"] isEqualToString:@"0"] == TRUE )//|| delegate.loginFlag==0
                {
                    UIImageView *imageLocal = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, pofferimg.frame.size.width, pofferimg.frame.size.height)];
                    imageLocal.image = [UIImage imageNamed:@"lock_93.png"];
                    [pofferimg addSubview:imageLocal];
                    
                }
                
            }
            CGSize labelSize = [[[tableDataArray objectAtIndex:indexPath.row] valueForKey:@"Merchant_Name"] sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:17]
                                                                                                       constrainedToSize:CGSizeMake(180, 9999)
                                                                                                           lineBreakMode:NSLineBreakByWordWrapping];
            if (labelSize.height > 40)
                labelSize.height = 40;
            
            UILabel *offerTitlelabel = [[UILabel alloc] initWithFrame:CGRectMake(109, 12, 180, labelSize.height)];//labelSize.height)];
            offerTitlelabel.text = [[tableDataArray objectAtIndex:indexPath.row] valueForKey:@"Merchant_Name"];
            offerTitlelabel.textColor =  [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
            offerTitlelabel.backgroundColor = [UIColor clearColor];
            offerTitlelabel.font = [UIFont fontWithName:@"Helvetica Neue" size:17];
            offerTitlelabel.numberOfLines = 2;
            offerTitlelabel.lineBreakMode = NSLineBreakByWordWrapping;
            [cell.contentView addSubview:offerTitlelabel];
            
            UILabel *discountlabel = [[UILabel alloc] initWithFrame:CGRectMake(109, offerTitlelabel.frame.size.height+10, 170, 30)];
            discountlabel.text = [[tableDataArray objectAtIndex:indexPath.row] valueForKey:@"Title"];
            discountlabel.textColor =  [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
            discountlabel.backgroundColor = [UIColor clearColor];
            discountlabel.font = [UIFont fontWithName:@"Helvetica Neue" size:10];
            discountlabel.font = [UIFont boldSystemFontOfSize:10];
            discountlabel.numberOfLines = 2;
            discountlabel.lineBreakMode = NSLineBreakByWordWrapping;
            [cell.contentView addSubview:discountlabel];
            
            UIImageView *mapimg = [[UIImageView alloc] initWithFrame:CGRectMake(109, 77, 17, 17)];
            mapimg.image = [UIImage imageNamed:@"map.png"];
            [cell.contentView addSubview:mapimg];
            
            UILabel *distancelabel = [[UILabel alloc] initWithFrame:CGRectMake(129, 77, 170, 15)];
            distancelabel.text = [NSString stringWithFormat:@"%@",[[tableDataArray objectAtIndex:indexPath.row] valueForKey:@"Nearest_location"]];
            distancelabel.textColor = [UIColor colorWithRed:136.0f/255.0f green:136.0f/255.0f blue:136.0f/255.0f alpha:1.0f];
            distancelabel.backgroundColor = [UIColor clearColor];
            distancelabel.font = [UIFont fontWithName:@"Helvetica Neue" size:10];
            //            distancelabel.font = [UIFont boldSystemFontOfSize:12];
            [cell.contentView addSubview:distancelabel];
            
            
            UILabel *distancelabel1 = [[UILabel alloc] initWithFrame:CGRectMake(129, 95, 170, 15)];
            
            float distance=[[[tableDataArray objectAtIndex:indexPath.row] valueForKey:@"Distance"] floatValue];
            
            
            if(distance > 50)
            {
                distancelabel1.text = [NSString stringWithFormat:@"Greater than 50 kms."];
            }
            else if(distance >1  && distance <50)
            {
                distancelabel1.text = [NSString stringWithFormat:@"%.1f kms.",distance] ;
                
            }
            
            else if(distance != 0.0f)
            {
                distancelabel1.text = [NSString stringWithFormat:@"Less than 1 kms." ] ;
            }
            
            distancelabel1.textColor = [UIColor colorWithRed:136.0f/255.0f green:136.0f/255.0f blue:136.0f/255.0f alpha:1.0f];
            distancelabel1.backgroundColor = [UIColor clearColor];
            distancelabel1.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
            //            distancelabel1.font = [UIFont boldSystemFontOfSize:12];
            [cell.contentView addSubview:distancelabel1];
            
            
            
            UIImageView *viewsimg = [[UIImageView alloc] initWithFrame:CGRectMake(109, 95, 17, 17)];
            viewsimg.image = [UIImage imageNamed:@"view.png"];
            //        [cell.contentView addSubview:viewsimg];
            
            UILabel *viewslabel = [[UILabel alloc] initWithFrame:CGRectMake(129, 95, 170, 15)];
            viewslabel.text = @"24 Views";
            viewslabel.textColor = [UIColor colorWithRed:136.0f/255.0f green:136.0f/255.0f blue:136.0f/255.0f alpha:1.0f];
            viewslabel.backgroundColor = [UIColor clearColor];
            viewslabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
            viewslabel.font = [UIFont boldSystemFontOfSize:12];
            //        [cell.contentView addSubview:viewslabel];
            
            UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(302, 50,17,17)];
            arrowImage.image = [UIImage imageNamed:@"nextarrow.png"];
            [cell.contentView addSubview:arrowImage];
            
            
            BOOL IsPremiumOffer=NO;
            BOOL IsNewOffer=NO;
            
            if ([[[tableDataArray objectAtIndex:indexPath.row] valueForKey:@"Offer_Category__c"] isEqualToString:@"Premium"])
            {
                
                [line setBackgroundColor:[UIColor colorWithRed:249/255.0f green:185/255.0f blue:79/255.0f alpha:1.0f]];
                
                UIButton *premiumButton=[UIButton buttonWithType:UIButtonTypeCustom];
                [premiumButton setBackgroundImage:[UIImage imageNamed:@"premiumoffer1.png"] forState:UIControlStateNormal];
                [premiumButton setTitle:@"PREMIUM" forState:UIControlStateNormal];
                premiumButton.userInteractionEnabled = NO;
                [premiumButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                premiumButton.titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:12];
                premiumButton.frame=CGRectMake(215, 115, 92, 18);
                [cell.contentView addSubview:premiumButton];
                
                UIImageView *premiumoffer = [[UIImageView alloc] initWithFrame:CGRectMake(215, 100, 92, 18)];
                premiumoffer.image = [UIImage imageNamed:@"premiumoffer.png"];
                
                IsPremiumOffer=YES;
            }
            
            if ([[[tableDataArray objectAtIndex:indexPath.row] valueForKey:@"New"] isEqualToString:@"1"])
            {
                UIButton *newButton=[UIButton buttonWithType:UIButtonTypeCustom];
                
                if (IsPremiumOffer)
                    newButton.frame=CGRectMake(158, 115, 50, 18);
                else
                    newButton.frame=CGRectMake(260, 115, 50, 18);
                
                [newButton setBackgroundImage:[UIImage imageNamed:@"new1.png"] forState:UIControlStateNormal];
                [newButton setTitle:@"NEW" forState:UIControlStateNormal];
                newButton.userInteractionEnabled = NO;
                [newButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                newButton.titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:12];
                [cell.contentView addSubview:newButton];
                
                IsNewOffer=YES;
                
                UIImageView *newOffer = [[UIImageView alloc] initWithFrame:CGRectMake(158, 100, 40, 18)];
                newOffer.image = [UIImage imageNamed:@"new.png"];
                //[cell.contentView addSubview:newOffer];
            }
            
            // for Cuisine LAble
            UILabel *countrylabel = [[UILabel alloc] init ];//]WithFrame:CGRectMake(265, 20, 50, 15)];
            countrylabel.text = [[tableDataArray objectAtIndex:indexPath.row] valueForKey:@"Cuisine__c"];
            countrylabel.textAlignment = NSTextAlignmentRight;
            countrylabel.textColor = [UIColor colorWithRed:136.0f/255.0f green:136.0f/255.0f blue:136.0f/255.0f alpha:1.0f];
            countrylabel.backgroundColor = [UIColor clearColor];
            countrylabel.font = [UIFont fontWithName:@"Helvetica Neue" size:11];
            //            countrylabel.font = [UIFont boldSystemFontOfSize:11];
            [cell.contentView addSubview:countrylabel];
            
            if (IsPremiumOffer && IsNewOffer)
                countrylabel.frame=CGRectMake(50, 115, 100, 18);
            else if (IsPremiumOffer && !IsNewOffer)
                countrylabel.frame=CGRectMake(100, 115, 100, 18);
            else if (IsNewOffer && !IsPremiumOffer)
                countrylabel.frame=CGRectMake(150, 115, 100, 18);
            else
                countrylabel.frame=CGRectMake(210, 115, 100, 18);
            
            
        }
    }
    
    else if (tableView.tag == 5)
    {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 170)];
        img.backgroundColor =[UIColor whiteColor];
        //        img.image = [UIImage imageNamed:@"11.png"];
        
        [cell.contentView addSubview:img];
        
        UIImageView *pofferimg = [[UIImageView alloc] initWithFrame:CGRectMake(8, 20, 120, 120)];
        pofferimg.image = [UIImage imageNamed:@"11_240X240.png"];
        NSURL *url = [NSURL URLWithString:[[tableDataArray1 objectAtIndex:indexPath.row] valueForKey:@"Offer_Image_1__c"]];
        //[pofferimg performSelectorInBackground:@selector(setImage:) withObject:[UIImage imageWithData:[NSData dataWithContentsOfURL:url]]];
        NSURLRequest *req=[NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if (data)
            {
                UIImage *imageGNoff = [UIImage imageWithData:data];
                
                CGSize imageSize = imageGNoff.size;
                CGFloat width = imageSize.width;
                CGFloat height = imageSize.height;
                if (width != height)
                {
                    CGFloat newDimension = MIN(width, height);
                    CGFloat widthOffset = (width - newDimension) / 2;
                    CGFloat heightOffset = (height - newDimension) / 2;
                    UIGraphicsBeginImageContextWithOptions(CGSizeMake(newDimension, newDimension), NO, 0.);
                    [imageGNoff drawAtPoint:CGPointMake(-widthOffset, -heightOffset)
                                  blendMode:kCGBlendModeCopy
                                      alpha:1.];
                    imageGNoff = UIGraphicsGetImageFromCurrentImageContext();
                    UIGraphicsEndImageContext();
                }
                pofferimg.image =imageGNoff;
                
                //                  [pofferimg setImage:[UIImage imageWithData:data]];
            }
        }];
        [cell.contentView addSubview:pofferimg];
        
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSDictionary *mydictionary=(NSDictionary *) [prefs objectForKey:@"Registration"];
        NSString *subType=[mydictionary valueForKey:@"subType"];
        
        
        if(delegate.loginFlag==1)
        {
            if ([[NSString stringWithFormat:@"%@",subType] isEqualToString:@"0"]==TRUE && [[[tableDataArray1 objectAtIndex:indexPath.row] valueForKey:@"For_Non_Subscribers__c"] isEqualToString:@"0"] == TRUE)
            {
                UIImageView *imageLocal = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, pofferimg.frame.size.width, pofferimg.frame.size.height)];
                imageLocal.image = [UIImage imageNamed:@"lock_120.png"];
                [pofferimg addSubview:imageLocal];
            }
        }
        
        CGSize labelSize = [[[tableDataArray1 objectAtIndex:indexPath.row] valueForKey:@"Merchant_Name"] sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:20]
                                                                                                    constrainedToSize:CGSizeMake(180, 9999)
                                                                                                        lineBreakMode:NSLineBreakByWordWrapping];
        
        if (labelSize.height > 47)
            labelSize.height = 47;
        
        UILabel *offerTitlelabel = [[UILabel alloc] initWithFrame:CGRectMake(135, 18, 220, labelSize.height)];//labelSize.height)];
        offerTitlelabel.text = [[tableDataArray1 objectAtIndex:indexPath.row] valueForKey:@"Merchant_Name"];
        offerTitlelabel.textColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
        offerTitlelabel.backgroundColor = [UIColor clearColor];
        offerTitlelabel.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
        offerTitlelabel.numberOfLines = 2;
        offerTitlelabel.lineBreakMode = NSLineBreakByWordWrapping;
        [cell.contentView addSubview:offerTitlelabel];
        
        
        
        
        UILabel *discountlabel = [[UILabel alloc] initWithFrame:CGRectMake(137, offerTitlelabel.frame.size.height+15, 180, 30)];
        discountlabel.text = [[tableDataArray1 objectAtIndex:indexPath.row] valueForKey:@"Title"];
        discountlabel.textColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
        discountlabel.backgroundColor = [UIColor clearColor];
        discountlabel.font = [UIFont fontWithName:@"Helvetica Neue" size:10];
        discountlabel.font = [UIFont boldSystemFontOfSize:10];
        discountlabel.numberOfLines=2;
        discountlabel.lineBreakMode=NSLineBreakByWordWrapping;
        
        [cell.contentView addSubview:discountlabel];
        
        UIImageView *mapimg = [[UIImageView alloc] initWithFrame:CGRectMake(139, 99, 20, 20)];
        mapimg.image = [UIImage imageNamed:@"map.png"];
        [cell.contentView addSubview:mapimg];
        
        UILabel *distancelabel = [[UILabel alloc] initWithFrame:CGRectMake(159, 99, 180, 20)];
        distancelabel.text = [NSString stringWithFormat:@"%@",[[tableDataArray1 objectAtIndex:indexPath.row] valueForKey:@"Nearest_location"]];
        distancelabel.textColor = [UIColor colorWithRed:136.0f/255.0f green:136.0f/255.0f blue:136.0f/255.0f alpha:1.0f];
        distancelabel.backgroundColor = [UIColor clearColor];
        distancelabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
        //        distancelabel.font = [UIFont boldSystemFontOfSize:12];
        [cell.contentView addSubview:distancelabel];
        
        
        UILabel *distancelabel1 = [[UILabel alloc] initWithFrame:CGRectMake(159, 115, 180, 20)];
        
        float distance=[[[tableDataArray1 objectAtIndex:indexPath.row] valueForKey:@"Distance"] floatValue];
        
        if(distance > 50)
        {
            distancelabel1.text = [NSString stringWithFormat:@"Greater than 50 kms."];
        }
        else if(distance >1  && distance <50)
        {
            distancelabel1.text = [NSString stringWithFormat:@"%.1f kms.",distance] ;
            
        }
        else if(distance != 0.0f)
        {
            distancelabel1.text = [NSString stringWithFormat:@"Less than 1 kms." ] ;
        }
        
        distancelabel1.textColor = [UIColor colorWithRed:136.0f/255.0f green:136.0f/255.0f blue:136.0f/255.0f alpha:1.0f];
        distancelabel1.backgroundColor = [UIColor clearColor];
        distancelabel1.font = [UIFont fontWithName:@"Helvetica Neue" size:9];
        //        distancelabel1.font = [UIFont boldSystemFontOfSize:9];
        [cell.contentView addSubview:distancelabel1];
        
        
        UIImageView *viewsimg = [[UIImageView alloc] initWithFrame:CGRectMake(139, 109, 17, 17)];
        viewsimg.image = [UIImage imageNamed:@"view.png"];
        //        [cell.contentView addSubview:viewsimg];
        
        UILabel *viewslabel = [[UILabel alloc] initWithFrame:CGRectMake(139, 95, 184, 15)];
        viewslabel.text = @"24 Views";
        viewslabel.textColor = [UIColor lightGrayColor];
        viewslabel.backgroundColor = [UIColor clearColor];
        viewslabel.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
        viewslabel.font = [UIFont boldSystemFontOfSize:12];
        //        [cell.contentView addSubview:viewslabel];
        
        
        
        BOOL IsPremiumOffer=NO;
        BOOL IsNewOffer=NO;
        if ([[[tableDataArray1 objectAtIndex:indexPath.row] valueForKey:@"Offer_Category__c"] isEqualToString:@"Premium"])
        {
            UIImageView *premiumoffer = [[UIImageView alloc] initWithFrame:CGRectMake(255, 124, 106, 25)];
            premiumoffer.image = [UIImage imageNamed:@"premiumoffer.png"];
            //[cell.contentView addSubview:premiumoffer];
            
            
            UIButton *premiumButton=[UIButton buttonWithType:UIButtonTypeCustom];
            [premiumButton setBackgroundImage:[UIImage imageNamed:@"premiumoffer1.png"] forState:UIControlStateNormal];
            [premiumButton setTitle:@"PREMIUM" forState:UIControlStateNormal];
            premiumButton.userInteractionEnabled = NO;
            [premiumButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            premiumButton.titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:16];
            premiumButton.frame=CGRectMake(255, 138, 106, 25);
            [cell.contentView addSubview:premiumButton];
            IsPremiumOffer=YES;
        }
        
        if ([[[tableDataArray1 objectAtIndex:indexPath.row] valueForKey:@"New"] isEqualToString:@"1"])
        {
            UIImageView *newOffer = [[UIImageView alloc] initWithFrame:CGRectMake(190, 124, 54, 25)];
            newOffer.image = [UIImage imageNamed:@"new.png"];
            //[cell.contentView addSubview:newOffer];
            
            UIButton *newButton=[UIButton buttonWithType:UIButtonTypeCustom];
            
            if (IsPremiumOffer)
                newButton.frame=CGRectMake(190, 138, 54, 25);
            else
                newButton.frame=CGRectMake(290, 134, 54, 25);
            
            [newButton setBackgroundImage:[UIImage imageNamed:@"new1.png"] forState:UIControlStateNormal];
            [newButton setTitle:@"NEW" forState:UIControlStateNormal];
            newButton.userInteractionEnabled = NO;
            [newButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            newButton.titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:16];
            //            newButton.frame=CGRectMake(190, 138, 54, 25);
            [cell.contentView addSubview:newButton];
            IsNewOffer=YES;
        }
        
        // for Cuisine LAble
        UILabel *countrylabel = [[UILabel alloc] init ];//]WithFrame:CGRectMake(265, 20, 50, 15)];
        countrylabel.text = [[tableDataArray objectAtIndex:indexPath.row] valueForKey:@"Cuisine__c"];
        countrylabel.textAlignment = NSTextAlignmentRight;
        countrylabel.textColor = [UIColor colorWithRed:136.0f/255.0f green:136.0f/255.0f blue:136.0f/255.0f alpha:1.0f];
        countrylabel.backgroundColor = [UIColor clearColor];
        countrylabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
        //        countrylabel.font = [UIFont boldSystemFontOfSize:14];
        [cell.contentView addSubview:countrylabel];
        
        if (IsPremiumOffer && IsNewOffer)
            countrylabel.frame=CGRectMake(80, 142, 100, 18);
        else if (IsPremiumOffer && !IsNewOffer)
            countrylabel.frame=CGRectMake(130, 142, 100, 18);
        else if (IsNewOffer && !IsPremiumOffer)
            countrylabel.frame=CGRectMake(180, 142, 100, 18);
        else
            countrylabel.frame=CGRectMake(230, 142, 100, 18);
        
        
        UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(352, 87,17,17)];
        arrowImage.image = [UIImage imageNamed:@"nextarrow.png"];
        [cell.contentView addSubview:arrowImage];
        
    }
    
    else
    {
        nameLable.frame = CGRectMake(20, 0, 210, 45);
        nameLable.text = [filtersArray objectAtIndex:indexPath.row];
        nameLable.textAlignment = NSTextAlignmentCenter;
        nameLable.textColor = [UIColor colorWithRed:37/255.0f green:115/255.0f blue:203/255.0f alpha:1.0];//[UIColor blackColor];
        nameLable.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
    }
    
    nameLable.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:nameLable];
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
    
}



- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (tableView.tag == 1)
    {
        emirateLable.text = [emiritsArray objectAtIndex:indexPath.row];
        
        if ([emirateLable.text isEqualToString:@"Northern Emirates"] == TRUE)
        {
            arraowImage.frame= CGRectMake(270, 19 , 10 , 5 );
        }
        else
        {
            arraowImage.frame= CGRectMake(270, 19 , 6 , 3 );
        }
        
        
        [tableView removeFromSuperview];
        [emiritsBackView removeFromSuperview];
    }
    if (tableView.tag == 2)
    {
        OfferDetailsController *nextView = [[OfferDetailsController alloc] init];
        nextView.newestOfferID=[[tableDataArray objectAtIndex:indexPath.row] valueForKey:@"offerId"];
        nextView.Preaddress = [[tableDataArray objectAtIndex:indexPath.row] valueForKey:@"Nearest_location"];
        [self.navigationController pushViewController:nextView animated:YES];
    }
    else  if (tableView.tag == 5)
    {
        
        OfferDetailsController *nextView = [[OfferDetailsController alloc] init];
        nextView.newestOfferID=[[tableDataArray1 objectAtIndex:indexPath.row] valueForKey:@"offerId"];
        nextView.Preaddress = [[tableDataArray1 objectAtIndex:indexPath.row] valueForKey:@"Nearest_location"];
        [self.navigationController pushViewController:nextView animated:YES];
    }
    else
    {
        if(filterSeleted == 1)
        {
            [emiratesbtn setTitle:[filtersArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        }
        else if (filterSeleted == 2)
            [categorybtn setTitle:[filtersArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        else if (filterSeleted == 3)
            [Subcategorybtn setTitle:[filtersArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        else if (filterSeleted == 4)
            [storeNmbtn setTitle:[filtersArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        else
            [areabtn setTitle:[filtersArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        
        tableView.hidden = TRUE;
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

#pragma mark - Scroll delegate methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    float fractionalPage = scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    pageControl.currentPage = page;
}

- (BOOL) textFieldShouldReturn:(UITextField*)textField
{
    
    [textField resignFirstResponder];
    return TRUE;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [searchBar resignFirstResponder];
    [emiritsBackView removeFromSuperview];
    [self.view endEditing:YES];
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
            
            NSMutableArray *searchfiltersArray= (NSMutableArray*)[dict objectForKey:@"data"];
            
            [waitingAlt dismissWithClickedButtonIndex:0 animated:YES];
            
            searchController *objsearchController=[[searchController alloc]init];
            
            objsearchController.filtersArray=searchfiltersArray;
            
            objsearchController.titleString=searchBar1.text;
            
            searchBar1.text=@"";
            
            [searchBar1 performSelectorOnMainThread:@selector(resignFirstResponder) withObject:Nil waitUntilDone:YES];
            [self.navigationController pushViewController:objsearchController animated:YES];
            
        }
    }];
    
    
    //        [searchBar1 resignFirstResponder];
    
    
    
}



@end