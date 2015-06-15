//
//  SelectGiftsOfTheWeekController.m
//  Good Living
//
//  Created by NanoStuffs on 11/09/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import "SelectGiftsOfTheWeekController.h"
#import "ViewController.h"
#import "MyVoucherController.h"
#import "MyAccountController.h"
#import "LeadingViewController.h"
#import "UILabel+FormattedText.h"
#import "myPurchaseController.h"
#import "ContactusController.h"
#import "aboutGoodLivingController.h"
#import "notificationController.h"

#import "Flurry.h"

@interface SelectGiftsOfTheWeekController ()

@end

@implementation SelectGiftsOfTheWeekController
@synthesize title,smsCode,smsTo,termsCond,winner,img,name,desc,participentsDateby,winnerAnaouncedBy,selectID,type;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //GL_Gifts_Detail//GL_Traveller_Detail//GL_Invites_Detail
    if (title && name)
    {
        [Flurry logEvent:[NSString stringWithFormat:@"%@",title]];
        [Flurry logPageView];
        
        //Google Analytics
        self.screenName = [NSString stringWithFormat:@"%@",title];
    }
    
    delegate = [[UIApplication sharedApplication] delegate];
    self.view.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f];
    
    UIImageView *backgroundImg=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,768,1024)];
    backgroundImg.image=[UIImage imageNamed:@"7-GiftOfTheWeek_Ipad1.jpg"];
//    [self.view addSubview:backgroundImg];
   
    
    UIImageView *navigationImage = [[UIImageView alloc] init];
    navigationImage.backgroundColor = [UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f];
    [self.view addSubview:navigationImage];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];

    UILabel *topLable = [[UILabel alloc] init];
    topLable.text = title;
    topLable.textAlignment = NSTextAlignmentCenter;
    topLable.textColor = [UIColor whiteColor];
    topLable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topLable];
    
    //------------------------Restorant
    mainscrollvertical = [[UIScrollView alloc] init];
    mainscrollvertical.delegate = self;
    mainscrollvertical.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f];
    [self.view addSubview:mainscrollvertical];
    
    UIButton *participanetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [participanetBtn addTarget:self action:@selector(clickHereMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:participanetBtn];

    UIScrollView *restorantImagesScrool = [[UIScrollView alloc] init];
    restorantImagesScrool.delegate = self;
    restorantImagesScrool.backgroundColor = [UIColor clearColor];
    restorantImagesScrool.tag = 100;
    restorantImagesScrool.pagingEnabled = YES;
    [mainscrollvertical addSubview:restorantImagesScrool];


    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        navigationImage.frame = CGRectMake(0, 0, 320, 64);
        backButton.frame = CGRectMake(5, 25, 35, 35);
        
        topLable.frame = CGRectMake(0, 25, 320, 30);
        topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:18];

        mainscrollvertical.frame = CGRectMake(0, 64, 320, (self.view.frame.size.height-64)-50);
        mainscrollvertical.contentSize = CGSizeMake(320, 940);//580
        
        //Changed by Gafar
        restorantImagesScrool.frame = CGRectMake(0, 0, 320, 145);
        restorantImagesScrool.contentSize = CGSizeMake(320, 145);
        
        participanetBtn.frame =CGRectMake(0, self.view.frame.size.height-55, 320, 55);
        [participanetBtn setImage:[UIImage imageNamed:@"participate.png"] forState:UIControlStateNormal];
    }
    else
    {
        navigationImage.frame = CGRectMake(0, 0, 768, 64);
        backButton.frame = CGRectMake(5, 25, 35, 35);

        topLable.frame = CGRectMake(0, 25, 768, 30);
        topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:22];

        mainscrollvertical.frame = CGRectMake(0, 64, 768, (self.view.frame.size.height-64)-100);
        mainscrollvertical.contentSize = CGSizeMake(768, 2000);//580
        
        //Changed by Gafar
        restorantImagesScrool.frame = CGRectMake(0, 0, 768, 293);
        restorantImagesScrool.contentSize = CGSizeMake(768, 293);
        
        participanetBtn.frame =CGRectMake(0, self.view.frame.size.height-89, 768, 89);
        [participanetBtn setImage:[UIImage imageNamed:@"participateiPad.png"] forState:UIControlStateNormal];
    }
    
    for (int i = 0; i < 1; i++)
    {
        UIImageView *imageview = [[UIImageView alloc] init];
        
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            imageview.frame = CGRectMake(1+(i*320), 1, 318, restorantImagesScrool.frame.size.height-2);
        }
        else
        {
            imageview.frame = CGRectMake(1+(i*768), 1, 766, restorantImagesScrool.frame.size.height-2);
        }
        
        imageview.image = img;
        [restorantImagesScrool addSubview:imageview];
        
//        UIActivityIndicatorView *activityview1 = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        activityview1.center = CGPointMake(imageview.bounds.size.width / 2,imageview.bounds.size.height /2);
//        [activityview1 startAnimating];
//        activityview1.tag = i;
//        [imageview addSubview:activityview1];
    }
    
    pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = 3;
    pageControl.currentPage = 0;
    pageControl.backgroundColor = [UIColor clearColor];
   // [mainscrollvertical addSubview:pageControl];
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        pageControl.frame = CGRectMake(260,87,50,20);
    }
    else
    {
        //pageControl.frame = CGRectMake(600,190,300,40);
        pageControl.frame = CGRectMake(660 ,190 ,120 ,36 );

    }
    
    //------------------------------------------------GiftsOftheWeekLabel
    
    UIScrollView *offersScrool = [[UIScrollView alloc] init];
    offersScrool.delegate = self;
    offersScrool.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.8f];
    offersScrool.pagingEnabled = NO;
    offersScrool.layer.cornerRadius = 0.0f;
    [mainscrollvertical addSubview:offersScrool];
    
    
    
    
    UILabel *winwithusLable = [[UILabel alloc] init];
    winwithusLable.text =name;// @"WIN AED 5000 worth shopping Voucher from NATURALIZER";
    winwithusLable.textColor = [UIColor whiteColor];
   // winwithusLable.backgroundColor = [UIColor blackColor];
    [offersScrool addSubview:winwithusLable];
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        offersScrool.frame = CGRectMake(1, 144, 318, 30);//115
        offersScrool.contentSize = CGSizeMake(320, 30);

        winwithusLable.frame = CGRectMake(10, 5, 306, 20);
        winwithusLable.font = [UIFont fontWithName:@"Helvetica Neue" size:11];
    }
    else
    {
        offersScrool.frame = CGRectMake(1, 290, 766, 60);//
        offersScrool.contentSize = CGSizeMake(766, 60);

        winwithusLable.frame = CGRectMake(15, 10, 608, 40);
        winwithusLable.font = [UIFont fontWithName:@"Helvetica Neue" size:22];
    }
    
    //Top lable Image-----------------------

    UIImageView *imageview = [[UIImageView alloc] init];
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        imageview.frame = CGRectMake(107, 174, 105, 105);
    }
    else
    {
        imageview.frame = CGRectMake(234, 300, 300, 300);//244
    }
    
   [mainscrollvertical addSubview:imageview];
    
    if ([title isEqualToString:@"GL Gifts"] == TRUE)
    {
        imageview.image = [UIImage imageNamed:@"1gift.png"];

    }
    else if([title isEqualToString:@"GL Traveller"] == TRUE)
    {
        imageview.image = [UIImage imageNamed:@"2trav.png"];
    }
    else
    {
        imageview.image = [UIImage imageNamed:@"3invi.png"];
    }
    
    //---------------------------------------------------------EventTableView
    
    titleArray = [[NSMutableArray alloc] init];
    subtitleArray  = [[NSMutableArray alloc] init];
    
    [titleArray addObject:@"To Participate"];
    [titleArray addObject:@"Description"];
    [titleArray addObject:@""];
    [titleArray addObject:@"Terms & Conditions"];
    [titleArray addObject:@"Previous Winner(s)"];
    
    //added by ajinkya
    //for converting date in numbers to date in word
//    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"dd-MM-yyyy"];//yyyy-MM-dd
//    NSDate* myDate = [dateFormatter dateFromString:participentsDateby];
//    
//    [dateFormatter setDateFormat:@"dd MMMM"];
//    NSString *stringFromDate = [dateFormatter stringFromDate:myDate];
//    NSArray *arr=[stringFromDate componentsSeparatedByString:@" "];
//    NSString *day=[arr firstObject];
//
//    if ([[day substringFromIndex:[day length]-1] isEqualToString:@"1"])
//        participentsDateby=[NSString stringWithFormat:@"%@st %@",[arr firstObject],[arr lastObject]];
//    else if ([[day substringFromIndex:[day length]-1] isEqualToString:@"2"])
//        participentsDateby=[NSString stringWithFormat:@"%@nd %@",[arr firstObject],[arr lastObject]];
//    else if ([[day substringFromIndex:[day length]-1] isEqualToString:@"3"])
//        participentsDateby=[NSString stringWithFormat:@"%@rd %@",[arr firstObject],[arr lastObject]];
//    else
//        participentsDateby=[NSString stringWithFormat:@"%@th %@",[arr firstObject],[arr lastObject]];
    
    [subtitleArray addObject:[NSString stringWithFormat:@"SMS '%@' To %@ by %@",smsCode,smsTo,participentsDateby]];//Participation_Last_Date__c
    [subtitleArray addObject:desc];
    
    wiinerDate=@"25-12-2014";
    [subtitleArray addObject:[NSString stringWithFormat:@"Winner to be announced on %@",wiinerDate]];//winnerAnaouncedBy Winner_Announced_On__c
    [subtitleArray addObject:termsCond];//winner
    [subtitleArray addObject:winner];//termsCond
    
    eventtableView = [[UITableView alloc] init];
    eventtableView.delegate = self;
    eventtableView.dataSource = self;
    eventtableView.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f];
    eventtableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    eventtableView.scrollEnabled = NO;
    eventtableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    eventtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        [mainscrollvertical addSubview:eventtableView];
    }
    else
    {
        [self ipadDesigns];
    }
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        eventtableView.frame = CGRectMake(0, 279, 320, 1200);
        eventtableView.contentSize= CGSizeMake(320, 1200);//900
    }
}
- (void)ipadDesigns
{
    UIView *descriptionBackView = [[UIView alloc] init];
    descriptionBackView.layer.cornerRadius = 5.0f;
    descriptionBackView.backgroundColor = [UIColor whiteColor];
    [mainscrollvertical addSubview:descriptionBackView];
    
    UILabel *DescriptionTitlelable = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 349, 35)];
    DescriptionTitlelable.text = @"Description";
    DescriptionTitlelable.textAlignment = NSTextAlignmentLeft;
    DescriptionTitlelable.font = [UIFont fontWithName:@"Helvetica Neue" size:28];
    DescriptionTitlelable.font = [UIFont boldSystemFontOfSize:28];
    DescriptionTitlelable.textColor = [UIColor blackColor];
    DescriptionTitlelable.backgroundColor = [UIColor clearColor];
    [descriptionBackView addSubview:DescriptionTitlelable];

    
    CGSize labelSize = [desc sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:25]
                                                   constrainedToSize:CGSizeMake(349, 9999)
                                                       lineBreakMode:NSLineBreakByWordWrapping];
    
    UILabel *DescriptionDetaillable = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 349, (labelSize.height/25)*27)];
    DescriptionDetaillable.text = desc;
    DescriptionDetaillable.textAlignment = NSTextAlignmentLeft;
    DescriptionDetaillable.font = [UIFont fontWithName:@"Helvetica Neue" size:25];
    
    DescriptionDetaillable.lineBreakMode = NSLineBreakByWordWrapping;
    DescriptionDetaillable.numberOfLines = 100;
    
    DescriptionDetaillable.textColor = [UIColor darkGrayColor];
    DescriptionDetaillable.backgroundColor = [UIColor clearColor];
    [descriptionBackView addSubview:DescriptionDetaillable];
    
    descriptionBackView.frame = CGRectMake(10, 560, 369, ((labelSize.height/20)*24)+60);
    
    
    //---------------
    UIView *rightBackView = [[UIView alloc] init];
    rightBackView.layer.cornerRadius = 5.0f;
    rightBackView.backgroundColor = [UIColor whiteColor];
    [mainscrollvertical addSubview:rightBackView];

    //------To participents
    UILabel *toparticipateTitlelable = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 349, 35)];
    toparticipateTitlelable.text = @"To Participate";
    toparticipateTitlelable.textAlignment = NSTextAlignmentLeft;
    toparticipateTitlelable.font = [UIFont fontWithName:@"Helvetica Neue" size:28];
    toparticipateTitlelable.font = [UIFont boldSystemFontOfSize:28];
    toparticipateTitlelable.textColor = [UIColor blackColor];
    toparticipateTitlelable.backgroundColor = [UIColor clearColor];
    [rightBackView addSubview:toparticipateTitlelable];
    
    
    UILabel *toparticipateDetaillable = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 349, 70)];
    toparticipateDetaillable.text =[NSString stringWithFormat:@"SMS '%@' To %@ by %@",smsCode,smsTo,participentsDateby];
    toparticipateDetaillable.textAlignment = NSTextAlignmentLeft;
    toparticipateDetaillable.font = [UIFont fontWithName:@"Helvetica Neue" size:25];
    toparticipateDetaillable.numberOfLines = 2;
    toparticipateDetaillable.lineBreakMode = NSLineBreakByWordWrapping;
    toparticipateDetaillable.textColor = [UIColor darkGrayColor];
    toparticipateDetaillable.backgroundColor = [UIColor clearColor];
    
    int length=smsCode.length;
    [toparticipateDetaillable setTextColor:[UIColor redColor] range:NSMakeRange(5, length)];

    [rightBackView addSubview:toparticipateDetaillable];
    
    
    //------Winner anounced
    UILabel *PreWinnerTitlelable = [[UILabel alloc] initWithFrame:CGRectMake(10, 160, 349, 70)];
    PreWinnerTitlelable.text = [NSString stringWithFormat:@"Winner to be announced on %@",wiinerDate];//winnerAnaouncedBy
    PreWinnerTitlelable.textAlignment = NSTextAlignmentLeft;
    PreWinnerTitlelable.numberOfLines = 2;
    PreWinnerTitlelable.lineBreakMode = NSLineBreakByWordWrapping;
    PreWinnerTitlelable.font = [UIFont fontWithName:@"Helvetica Neue" size:28];
    PreWinnerTitlelable.font = [UIFont boldSystemFontOfSize:28];
    PreWinnerTitlelable.textColor = [UIColor blackColor];
    PreWinnerTitlelable.backgroundColor = [UIColor clearColor];
    [rightBackView addSubview:PreWinnerTitlelable];
    
    //------previous Winner
    UILabel *PreWinnerTitlelable1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 270, 349, 35)];
    PreWinnerTitlelable1.text = @"Terms & Conditions";
    PreWinnerTitlelable1.lineBreakMode = NSLineBreakByWordWrapping;
    PreWinnerTitlelable1.font = [UIFont fontWithName:@"Helvetica Neue" size:28];
    PreWinnerTitlelable1.font = [UIFont boldSystemFontOfSize:28];
    PreWinnerTitlelable1.textColor = [UIColor blackColor];
    PreWinnerTitlelable1.backgroundColor = [UIColor clearColor];
    [rightBackView addSubview:PreWinnerTitlelable1];

    CGSize labelSize2 = [termsCond sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:25]
                        constrainedToSize:CGSizeMake(349, 9999)
                            lineBreakMode:NSLineBreakByWordWrapping];//winner

    
    UILabel *PreWinnerdetaillable1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 305, 349,(labelSize2.height/25)*25)];
    PreWinnerdetaillable1.text = termsCond;//winner
    PreWinnerdetaillable1.lineBreakMode = NSLineBreakByWordWrapping;
    PreWinnerdetaillable1.numberOfLines = 100;
    PreWinnerdetaillable1.font = [UIFont fontWithName:@"Helvetica Neue" size:25];
    PreWinnerdetaillable1.textColor = [UIColor darkGrayColor];
    PreWinnerdetaillable1.backgroundColor = [UIColor clearColor];
    [rightBackView addSubview:PreWinnerdetaillable1];
    
    
    //------previous Winner
    UILabel *tANDcTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, (PreWinnerdetaillable1.frame.origin.y+PreWinnerdetaillable1.frame.size.height)+40, 349, 35)];
    tANDcTitle.text = @"Previous Winners";
    tANDcTitle.lineBreakMode = NSLineBreakByWordWrapping;
    tANDcTitle.font = [UIFont fontWithName:@"Helvetica Neue" size:28];
    tANDcTitle.font = [UIFont boldSystemFontOfSize:28];
    tANDcTitle.textColor = [UIColor blackColor];
    tANDcTitle.backgroundColor = [UIColor clearColor];
    [rightBackView addSubview:tANDcTitle];
    
    CGSize labelSize3 = [winner sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:25]
                           constrainedToSize:CGSizeMake(349, 9999)
                               lineBreakMode:NSLineBreakByWordWrapping];//termsCond
    
    
    UILabel *tANDcDetail = [[UILabel alloc] initWithFrame:CGRectMake(10, tANDcTitle.frame.origin.y+tANDcTitle.frame.size.height, 349,(labelSize3.height/25)*25)];
    tANDcDetail.text = winner;//termsCond
    tANDcDetail.lineBreakMode = NSLineBreakByWordWrapping;
    tANDcDetail.numberOfLines = 100;
    tANDcDetail.font = [UIFont fontWithName:@"Helvetica Neue" size:25];
    tANDcDetail.textColor = [UIColor darkGrayColor];
    tANDcDetail.backgroundColor = [UIColor clearColor];
    [rightBackView addSubview:tANDcDetail];
    
    rightBackView.frame = CGRectMake(389, 560, 369, (tANDcDetail.frame.size.height+tANDcDetail.frame.origin.y)+40);
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        mainscrollvertical.contentSize = CGSizeMake(768, (rightBackView.frame.size.height+rightBackView.frame.origin.y));//580
    }
}

- (void) clickHereMethod
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    // getting an dictionary
    NSDictionary *mydictionary=(NSDictionary *) [prefs objectForKey:@"Registration"];
    
     NSString *subType=[mydictionary valueForKey:@"subType"];
   
    if(delegate.loginFlag==0)
    {
      showAlert1 = [[UIAlertView alloc] initWithTitle:@"Like this offer?" message:@"Sign in / Register to access our Gulf News subscriber exclusive Premium offers." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [showAlert1 show];
        showAlert1.tag=1;
        
        
    }
    
    else if([[NSString stringWithFormat:@"%@",subType] isEqualToString:@"0"]== TRUE)
    {
    showAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Sorry, participation is open only to Gulf News Subscribers. Wish to win with us? Click to Subscribe or call 8004585" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
     [showAlert show];//Sorry, participation is open only to Gulf News subscribers. Wish to win with us? Subscribe now!
   }
    else
    {
        
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        if(![MFMessageComposeViewController canSendText]) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device cannot send text messages" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            return;
        }
        
        //set receipients
        NSArray *recipients = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",smsTo], nil];
        
        //set message text
        NSString * message = [NSString stringWithFormat:@"%@",smsCode];
        
        MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
        messageController.messageComposeDelegate = self;
        [messageController setRecipients:recipients];
        [messageController setBody:message];
        
        // Present message view controller on screen
        [self presentViewController:messageController animated:YES completion:nil];
       
    });
        
    }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(alertView.tag==1)
    {
        ViewController *nextView=[[ViewController alloc]init];
        [self.navigationController pushViewController:nextView animated:YES];
        delegate.loginFlag=1;
    }
}

-(void)addMyCompetation
{
    UIAlertView *PLeaseWait=[[UIAlertView alloc]initWithTitle:@"Please Wait...!" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil , nil];
    [PLeaseWait show];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSString *userId1=delegate.userID;
        NSString *offerID1=selectID;//offerID;
        
        NSString *url = [NSString stringWithFormat:@"https://testws.goodliving.ae/api/index.php/offer/addMyCompetition/%@/%@/%@",userId1,type,offerID1];
          url=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
        [request setURL:[NSURL URLWithString:url]];
        [request setHTTPMethod:@"POST"];
        
        NSHTTPURLResponse *response = nil;
        NSError *error = [[NSError alloc] init];
        NSData *data= [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        NSString *returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
         
    });
    [PLeaseWait dismissWithClickedButtonIndex:0 animated:YES];
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Thank you!" message:@"You are now part of the draw. Watch this space for results!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}


//-------- BackMethods
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
    if (indexPath.row == 0)
    {
        return 100;
    }
    else if (indexPath.row == 1)
    {
        CGSize labelSize = [[subtitleArray objectAtIndex:1] sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]
                                                       constrainedToSize:CGSizeMake(300, 9999)
                                                           lineBreakMode:NSLineBreakByWordWrapping];
        descHeight = (labelSize.height/13)*15;
        
        return ((labelSize.height/13)*15)+40;
    }
    else if (indexPath.row == 2)
    {
        return 50;

        
    }
    else if (indexPath.row == 3)
    {
        CGSize labelSize = [[subtitleArray objectAtIndex:3] sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]
                                                       constrainedToSize:CGSizeMake(295, 9999)
                                                           lineBreakMode:NSLineBreakByWordWrapping];
        
        TandCHeight = (labelSize.height/13)*15;
        return ((labelSize.height/13)*15)+40;
    }
    else
    {
        CGSize labelSize = [[subtitleArray objectAtIndex:4] sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]
                                                       constrainedToSize:CGSizeMake(300, 9999)
                                                           lineBreakMode:NSLineBreakByWordWrapping];
        
        previousWinnerHeight = (labelSize.height/13)*15;
        return ((labelSize.height/13)*15)+40;
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
   
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone]; 
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectZero];
    backView.backgroundColor = [UIColor clearColor];
    cell.backgroundView = backView;
    
    UIView *cellview = [[UIView alloc] initWithFrame:CGRectMake(7, 5, 306, 500)];
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
    
    UILabel *textView = [[UILabel alloc] init];
    textView.lineBreakMode = NSLineBreakByWordWrapping;
    textView.backgroundColor = [UIColor clearColor];
    textView.numberOfLines = 15;
    textView.text = NSTextAlignmentLeft;
    
    if(indexPath.row==0)
    {
        [cellview addSubview:nameLable];

        UILabel *detailLable =[[UILabel alloc] init];

        detailLable.text=[subtitleArray objectAtIndex:indexPath.row];
        detailLable.numberOfLines=2;
        [detailLable setBackgroundColor:[UIColor clearColor]];
        [detailLable setTextAlignment:NSTextAlignmentCenter];
        detailLable.textColor = [UIColor darkGrayColor];
        
        detailLable.textAlignment = NSTextAlignmentLeft;
        
        detailLable.lineBreakMode = NSLineBreakByWordWrapping;
        detailLable.textAlignment = NSTextAlignmentCenter;
        [cellview addSubview:detailLable];

        int length=smsCode.length;
        [detailLable setTextColor:[UIColor redColor] range:NSMakeRange(5, length)];
        
        detailLable.frame = CGRectMake(2, 30, 302, 60);
        detailLable.font = [UIFont fontWithName:@"Helvetica Neue" size:16];
      
    }
    else if(indexPath.row == 2)
    {
        UILabel *detailLable =[[UILabel alloc] init];
        
        detailLable.text=[subtitleArray objectAtIndex:indexPath.row];
        [detailLable setBackgroundColor:[UIColor clearColor]];
        [detailLable setTextAlignment:NSTextAlignmentCenter];
        detailLable.textColor = [UIColor darkGrayColor];
        detailLable.frame = CGRectMake(2, 12, 302, 25);
        detailLable.font = [UIFont fontWithName:@"Helvetica Neue" size:16];
        detailLable.font = [UIFont boldSystemFontOfSize:16];
        [cellview addSubview:detailLable];
    }
    else
    {
        [cellview addSubview:nameLable];

        textView.text = [subtitleArray objectAtIndex:indexPath.row];
        textView.textColor = [UIColor darkGrayColor];
    }
    
    
    
    if(indexPath.row==0)
    {
        textView.frame = CGRectMake(10, 20, 300, 80);
        textView.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    }
    if(indexPath.row==1)
    {
        textView.frame = CGRectMake(10, 30, 300, descHeight);
        textView.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    }
    else  if(indexPath.row==2)
    {
        textView.frame = CGRectMake(10, 20, 300, 50);
        textView.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
        
        
    }
    else  if(indexPath.row==3)
    {
        textView.frame = CGRectMake(10, 30, 295,TandCHeight);
        textView.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    }
    else
    {
        textView.frame = CGRectMake(10, 30, 300,previousWinnerHeight);
        textView.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    }
    
    [cellview addSubview:textView];
    
    [cell setBackgroundColor:[UIColor clearColor]];
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        mainscrollvertical.contentSize = CGSizeMake(320, (descHeight+TandCHeight+previousWinnerHeight)+580);
        
//        mainscrollvertical.backgroundColor = [UIColor redColor];
//        tableView.backgroundColor = [UIColor blueColor];
    }
    
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

#pragma mark - SMS 
#pragma mark - MFMailComposeViewControllerDelegate methods
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result)
    {
        case MessageComposeResultCancelled: break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Oops, error while sendind SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            break;
        }
        case MessageComposeResultSent:
            [self addMyCompetation];
            break;
            
        default: break;
    }
    
    ;

    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
