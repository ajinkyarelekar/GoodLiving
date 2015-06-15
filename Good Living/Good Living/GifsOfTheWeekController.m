//
//  GifsOfTheWeekController.m
//  Good Living
//
//  Created by NanoStuffs on 09/09/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import "GifsOfTheWeekController.h"
#import "LeadingViewController.h"
#import "MyAccountController.h"
#import "ViewController.h"
#import "MyVoucherController.h"
#import "SelectGiftsOfTheWeekController.h"
#import "myPurchaseController.h"
#import "ContactusController.h"
#import "aboutGoodLivingController.h"
#import "notificationController.h"
#import "globalURL.h"

#import "Flurry.h"

@interface GifsOfTheWeekController ()

@end

@implementation GifsOfTheWeekController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //GL_Gifts_Listing
    [Flurry logEvent:@"GL Gifts"];
    [Flurry logPageView];
    
    self.screenName = @"GL Gifts";
    
    delegate = [[UIApplication sharedApplication] delegate];
    
    self.view.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f];
    
      type=@"GOW";
    //------------------------Web Service
    
    getOfferAlert = [[UIAlertView alloc] initWithTitle:@"Please wait.." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [getOfferAlert show];
    [self performSelector:@selector(getTheGiftOfWeek) withObject:nil afterDelay:0.1];
    
    //------------------------ Swipe
    
    swipeGestureLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedScreenLeft:)];
    //swipeGestureLeft.delegate=self;
    swipeGestureLeft.numberOfTouchesRequired = 1;
    swipeGestureLeft.direction = (UISwipeGestureRecognizerDirectionRight);
    [self.view addGestureRecognizer:swipeGestureLeft];
    
    
    //------------------------Navigation Bar
    UIImageView *navigationImage = [[UIImageView alloc] init];
    navigationImage.backgroundColor = [UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f];
    [self.view addSubview:navigationImage];
    
    topLable = [[UILabel alloc] init];
    topLable.text = @"GL Gifts";
    topLable.textAlignment = NSTextAlignmentCenter;
    topLable.textColor = [UIColor whiteColor];
    topLable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topLable];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        navigationImage.frame = CGRectMake(0, 0, 320, 64);
        backButton.frame = CGRectMake(5,25, 35, 35);
        topLable.frame = CGRectMake(0, 25, 320, 30);
        topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
    }
    else
    {
        navigationImage.frame = CGRectMake(0, 0, 768, 64);
        backButton.frame = CGRectMake(5,22, 35, 35);
        topLable.frame = CGRectMake(0, 25, 768, 30);
        topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:22];
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


- (void) backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView delegate and datasource methods
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 501)
        return [LEFTtitleArray count];
    else if(tableView.tag == 502)
        return [RIGHTtitleArray count];
    else
        return [titleArray count];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 145;
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
    
    UIView *cellview = [[UIView alloc] init];
    if (tableView.tag == 501 || tableView.tag == 502)
    {
        cellview.frame = CGRectMake(0, 5, 369, 130);
    }
    else
    {
        cellview.frame = CGRectMake(5, 5, 310, 130);
    }
    cellview.layer.cornerRadius = 5.0f;
    cellview.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:cellview];
    
    //------ Cropping Images
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
    [cellview addSubview:imageview];
    
    UIActivityIndicatorView *activityview1 = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityview1.center = CGPointMake(imageview.bounds.size.width / 2,imageview.bounds.size.height /2);
    [activityview1 startAnimating];
    activityview1.tag = indexPath.row;
    [imageview addSubview:activityview1];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        NSData *imageData;
        
        if (tableView.tag == 501)
            imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[LEFTimagesArray objectAtIndex:indexPath.row] ]]];
        else if(tableView.tag == 502)
            imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[RIGHTimagesArray objectAtIndex:indexPath.row] ]]];
        else
            imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[giftImages objectAtIndex:indexPath.row] ]]];
        
        
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
                //                [gnOffersBtn setImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
                UIImage *imageGNoff = [UIImage imageWithData:imageData];
                
                CGSize imageSize = imageGNoff.size;
                CGFloat width = imageSize.width;
                CGFloat height = imageSize.height;
                if (width != height) {
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
                imageview.image =imageGNoff;
            }
            else
                imageview.image =[UIImage imageNamed:@"11.png"];
        });
    });
    
    UILabel *nameLable =[[UILabel alloc] init];
    nameLable.frame = CGRectMake(115, 10, 200, 50);
    nameLable.numberOfLines=2;
    
    if (tableView.tag == 501)
        nameLable.text = [LEFTtitleArray objectAtIndex:indexPath.row];
    if (tableView.tag == 502)
        nameLable.text = [RIGHTtitleArray objectAtIndex:indexPath.row];
    else
        nameLable.text = [titleArray objectAtIndex:indexPath.row];
    
    
    
    nameLable.textAlignment = NSTextAlignmentLeft;
    nameLable.textColor = [UIColor blackColor];
    nameLable.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    nameLable.backgroundColor = [UIColor clearColor];
    [cellview addSubview:nameLable];
    
    UITextView *detailLable =[[UITextView alloc] init];
    detailLable.frame = CGRectMake(115, 58, 200, 36);
    
    if (tableView.tag == 501)
        detailLable.text = [LEFTsubtitleArray objectAtIndex:indexPath.row];
    else if(tableView.tag == 502)
        detailLable.text = [RIGHTsubtitleArray objectAtIndex:indexPath.row];
    else
        detailLable.text = [subtitleArray objectAtIndex:indexPath.row];
    
    detailLable.textAlignment = NSTextAlignmentLeft;
    detailLable.textColor = [UIColor darkGrayColor];
    detailLable.font = [UIFont fontWithName:@"Helvetica Neue" size:10];
    detailLable.backgroundColor = [UIColor clearColor];
    detailLable.editable=NO;
//    [cellview addSubview:detailLable];
    
    UIButton *participateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    participateBtn.frame = CGRectMake(225, 100, 80, 25);
    [participateBtn setTitle:@"PARTICIPATE" forState:UIControlStateNormal];
    [participateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [participateBtn setBackgroundImage:[UIImage imageNamed:@"btn1.png"] forState:UIControlStateNormal];
    [participateBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:10]];
    [participateBtn addTarget:self action:@selector(participateMethod:) forControlEvents:UIControlEventTouchUpInside];
    
    if (tableView.tag == 501)
    {
        participateBtn.tag = [titleArray indexOfObject:[LEFTtitleArray objectAtIndex:indexPath.row]];
    }
    else if (tableView.tag == 502)
    {
        participateBtn.tag = [titleArray indexOfObject:[RIGHTtitleArray objectAtIndex:indexPath.row]];;
    }
    else
    {
        participateBtn.tag = indexPath.row;
    }
    
//    [cellview addSubview:participateBtn];
    
    [cell setBackgroundColor:[UIColor clearColor]];
    
    return cell;
}

- (void) participateMethod : (id) sender
{
    UIButton *btn = (UIButton *) sender;
    
    SelectGiftsOfTheWeekController *selctGiftOfWeek=[[SelectGiftsOfTheWeekController alloc]init];
    
    selctGiftOfWeek.title=topLable.text;
    selctGiftOfWeek.smsCode= [smsCodeArray objectAtIndex:btn.tag];// smsCode;
    selctGiftOfWeek.smsTo=[smsToArray objectAtIndex:btn.tag];
    selctGiftOfWeek.winner=[termsCondArray objectAtIndex:btn.tag];//winnerArray
    selctGiftOfWeek.termsCond=[winnerArray objectAtIndex:btn.tag];//termsCondArray
    selctGiftOfWeek.name= [titleArray objectAtIndex:btn.tag];// giftName;
    selctGiftOfWeek.desc=[subtitleArray objectAtIndex:btn.tag];//giftDesc;
    selctGiftOfWeek.participentsDateby = [Participation_Last_DateArray objectAtIndex:btn.tag];
    
    
    selctGiftOfWeek.selectID=[selectIDArray objectAtIndex:btn.tag];
    selctGiftOfWeek.type=type;


    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[giftImages objectAtIndex:0] ]]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            selctGiftOfWeek.img=[UIImage imageWithData:imageData];
            [self.navigationController pushViewController:selctGiftOfWeek animated:YES];
        });
    });
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int participateBtn;
    if (tableView.tag == 501)
    {
        participateBtn = [titleArray indexOfObject:[LEFTtitleArray objectAtIndex:indexPath.row]];
    }
    else if (tableView.tag == 502)
    {
        participateBtn = [titleArray indexOfObject:[RIGHTtitleArray objectAtIndex:indexPath.row]];;
    }
    else
    {
        participateBtn = indexPath.row;
    }

    
    SelectGiftsOfTheWeekController *selctGiftOfWeek=[[SelectGiftsOfTheWeekController alloc]init];
    selctGiftOfWeek.title=topLable.text;
    selctGiftOfWeek.smsCode= [smsCodeArray objectAtIndex:participateBtn];// smsCode;
    selctGiftOfWeek.smsTo=[smsToArray objectAtIndex:participateBtn];
    selctGiftOfWeek.winner=[termsCondArray objectAtIndex:participateBtn];//winnerArray
    selctGiftOfWeek.termsCond=[winnerArray objectAtIndex:participateBtn];//termsCondArray
    selctGiftOfWeek.name= [titleArray objectAtIndex:participateBtn];// giftName;
    selctGiftOfWeek.desc=[subtitleArray objectAtIndex:participateBtn];//giftDesc;
    selctGiftOfWeek.participentsDateby = [Participation_Last_DateArray objectAtIndex:participateBtn];
    selctGiftOfWeek.winnerAnaouncedBy = [Winner_AnnouncedArray objectAtIndex:participateBtn];
    
    selctGiftOfWeek.selectID=[selectIDArray objectAtIndex:participateBtn];
    selctGiftOfWeek.type=type;
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[giftImages objectAtIndex:0] ]]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            selctGiftOfWeek.img=[UIImage imageWithData:imageData];
            [self.navigationController pushViewController:selctGiftOfWeek animated:YES];
        });
    });
    
    
    //    emirateLable.text = [emiritsArray objectAtIndex:indexPath.row];
    //    [tableView removeFromSuperview];
    //    [emiritsBackView removeFromSuperview];
}


#pragma Mark Web Service

-(void)getTheGiftOfWeek
{
    @try {
        
        
        
        NSString *urlString = giftOfTheWeekURL;
        
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
            
            selectIDArray= [[NSMutableArray alloc] init];
            
            
            titleArray = [[NSMutableArray alloc] init];
            subtitleArray = [[NSMutableArray alloc] init];
            
            smsCodeArray = [[NSMutableArray alloc] init];
            smsToArray = [[NSMutableArray alloc] init];
            winnerArray = [[NSMutableArray alloc] init];
            termsCondArray = [[NSMutableArray alloc] init];
            
            giftImages=[[NSMutableArray alloc]init];
            
            Participation_Last_DateArray = [[NSMutableArray alloc] init];
            Winner_AnnouncedArray = [[NSMutableArray alloc] init];
            
            for (int i = 0; i < [DataArray count]; i++)
            {
                giftDesc=[[DataArray objectAtIndex:i] valueForKey:@"Description__c"];
                giftName=[[DataArray objectAtIndex:i] valueForKey:@"Name"];
                
                [titleArray addObject:[NSString stringWithFormat:@"%@",giftName]];
                [subtitleArray addObject:[NSString stringWithFormat:@"%@",giftDesc]];
                
                giftImg1=[[DataArray objectAtIndex:i] valueForKey:@"Image_1__c"];
                giftImg2=[[DataArray objectAtIndex:i] valueForKey:@"Image_2__c"];
                giftImg3=[[DataArray objectAtIndex:i] valueForKey:@"Image_3__c"];
                giftImg4=[[DataArray objectAtIndex:i] valueForKey:@"Image_4__c"];
                
                smsCode=[[DataArray objectAtIndex:i] valueForKey:@"SMS_Code__c"];
                smsTo=[[DataArray objectAtIndex:i] valueForKey:@"SMS_To__c"];
                termsCond=[[DataArray objectAtIndex:i] valueForKey:@"Terms_Conditions__c"];
                winner=[[DataArray objectAtIndex:i] valueForKey:@"Previous_Winners__c"];
                
                [Participation_Last_DateArray addObject:[[DataArray objectAtIndex:i] valueForKey:@"Participation_Last_Date__c"]];
                [Winner_AnnouncedArray addObject:[[DataArray objectAtIndex:i] valueForKey:@"Winner_Announced_On__c"]];
                
                selectID=[[DataArray objectAtIndex:i] valueForKey:@"Id"];
                
                [smsCodeArray addObject:smsCode];
                [smsToArray addObject:smsTo];
                [winnerArray addObject:termsCond];
                [termsCondArray addObject:winner];
                
                [selectIDArray addObject:selectID];
                
                if (giftImg1)
                {
                    [giftImages addObject:giftImg1];
                }
            }
            
            
            if ([selectIDArray count]==0)
            {
                UILabel *Nodata=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 100)];
                Nodata.numberOfLines=4;
                Nodata.lineBreakMode=NSLineBreakByWordWrapping;
                Nodata.text=@"We’re sorry! There are no competitions at this time.  Check back again soon!";
                Nodata.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
                Nodata.textAlignment=NSTextAlignmentCenter;
                
                UIImageView *Logoimage = [[UIImageView alloc] init];
                Logoimage.image = [UIImage imageNamed:@"1gift.png"];
                [self.view addSubview:Logoimage];
                
                UILabel *lable = [[UILabel alloc] init];
                lable.text = @"Win free shopping up to AED 5000, every week.";
                lable.textAlignment = NSTextAlignmentCenter;
                lable.textColor = [UIColor grayColor];
                lable.backgroundColor = [UIColor clearColor];
                [self.view addSubview:lable];
                
                
                Logoimage.frame = CGRectMake(110, 54, 100, 100);
                lable.frame = CGRectMake(10, 144, 300, 20);
                lable.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
                
                if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
                {
                    Nodata.frame=CGRectMake(0, 0, 600, 80);
                    Nodata.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
                    Logoimage.frame = CGRectMake(309, 54, 150, 150);
                    lable.frame = CGRectMake(10, 190, 748, 25);
                    lable.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
                }
                Nodata.center=self.view.center;
                [self.view addSubview:Nodata];
                [getOfferAlert dismissWithClickedButtonIndex:0 animated:YES];
                
                return;
            }

        }
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            LEFTtitleArray = [[NSMutableArray alloc] init];
            LEFTsubtitleArray = [[NSMutableArray alloc] init];
            RIGHTtitleArray = [[NSMutableArray alloc] init];
            RIGHTsubtitleArray = [[NSMutableArray alloc] init];
            LEFTimagesArray = [[NSMutableArray alloc] init];
            RIGHTimagesArray = [[NSMutableArray alloc] init];
            
            for (int i = 0; i < [titleArray count];i++)
            {
                if ((i%2) == 0)
                {
                    [LEFTtitleArray addObject:[titleArray objectAtIndex:i]];
                    [LEFTsubtitleArray addObject:[subtitleArray objectAtIndex:i]];
                    [LEFTimagesArray addObject:[giftImages objectAtIndex:i]];
                }
                else
                {
                    [RIGHTtitleArray addObject:[titleArray objectAtIndex:i]];
                    [RIGHTsubtitleArray addObject:[subtitleArray objectAtIndex:i]];
                    [RIGHTimagesArray addObject:[giftImages objectAtIndex:i]];
                }
            }
        }
        
        [getOfferAlert dismissWithClickedButtonIndex:0 animated:YES];
        [self performSelector:@selector(giftOfWeek) withObject:nil afterDelay:0.1];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            [self giftOfWeekiPad];
        }

           }
    @catch (NSException *exception) {
       
    }
    
}


-(void)giftOfWeek
{
    UIImageView *Logoimage = [[UIImageView alloc] init];
    Logoimage.image = [UIImage imageNamed:@"1gift.png"];
    [self.view addSubview:Logoimage];
    
    UILabel *lable = [[UILabel alloc] init];
    lable.text = @"Win free shopping up to AED 5000, every week.";
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor grayColor];
    lable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lable];
    
    eventtableView = [[UITableView alloc] init];
    eventtableView.delegate = self;
    eventtableView.dataSource = self;
    eventtableView.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f];
    eventtableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    eventtableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    eventtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        Logoimage.frame = CGRectMake(110, 54, 100, 100);
        lable.frame = CGRectMake(10, 144, 300, 20);
        lable.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
        
        eventtableView.frame = CGRectMake(0, 170, 320, self.view.frame.size.height-170);
        [self.view addSubview:eventtableView];
    }
    else
    {
        Logoimage.frame = CGRectMake(309, 54, 150, 150);
        lable.frame = CGRectMake(10, 190, 748, 25);
        lable.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
    }
}

-(void)giftOfWeekiPad
{
    
    
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 220, 768, 1024-220)];
    scrollview.contentSize = CGSizeMake(768, 1000);
    scrollview.delegate = self;
    [self.view addSubview:scrollview];
    
    UITableView *leftTableView = [[UITableView alloc] init];
    leftTableView.delegate = self;
    leftTableView.dataSource = self;
    leftTableView.tag = 501;
    leftTableView.scrollEnabled = NO;
    leftTableView.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f];
    leftTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    leftTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    leftTableView.frame = CGRectMake(10, 0, 369, 1000);
    [scrollview addSubview:leftTableView];
    
    UITableView *rightTableView = [[UITableView alloc] init];
    rightTableView.delegate = self;
    rightTableView.dataSource = self;
    rightTableView.tag = 502;
    rightTableView.scrollEnabled = NO;
    rightTableView.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f];
    rightTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    rightTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    rightTableView.frame = CGRectMake(389, 0, 369, 1000);
    [scrollview addSubview:rightTableView];
}

@end
