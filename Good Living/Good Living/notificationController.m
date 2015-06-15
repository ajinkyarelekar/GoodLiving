//
//  notificationController.m
//  Good Living
//
//  Created by NanoStuffs on 16/09/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import "notificationController.h"
#import "LeadingViewController.h"
#import "MyAccountController.h"
#import "MyVoucherController.h"
#import "ViewController.h"
#import "myPurchaseController.h"
#import "ContactusController.h"
#import "aboutGoodLivingController.h"


@interface notificationController ()
{
    NSString *TabString;
    NSMutableArray *tableDataArray,*tableDataArray1;
    NSMutableArray *NearByArray,*CuisineArray,*PremiumArray,*NewArray;
    UILabel *NoResults;
    
    UITableView *offerstablevie,*offerstablevie1;
    
    NSMutableArray *CellSelected;
    UIButton *btnDelete;
    
    UIAlertView *waitingAlt;
    
    CGSize labelSize;
    
    NSString *strDeleteNotifIds;

}
@end

@implementation notificationController

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
    
    tableDataArray=[[NSMutableArray alloc]init];
    CellSelected=[[NSMutableArray alloc]init];
    strDeleteNotifIds=[[NSString alloc]init];
    
    delegate = [[UIApplication sharedApplication] delegate];
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:1.0f];
    //------------------------Navigation Bar
    UIImageView *navigationImage = [[UIImageView alloc] init];
    navigationImage.backgroundColor = [UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f];
    [self.view addSubview:navigationImage];
    
    UILabel *topLable = [[UILabel alloc] init];
    topLable.text = @"Notifications";

    topLable.textAlignment = NSTextAlignmentCenter;
    topLable.textColor = [UIColor whiteColor];
    topLable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topLable];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    btnDelete=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnDelete setBackgroundImage:[UIImage imageNamed:@"delete_iphone.png"] forState:UIControlStateNormal];
    btnDelete.hidden=YES;
    [btnDelete addTarget:self action:@selector(deleteNotificationMethod) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btnDelete];
    
    offerstablevie = [[UITableView alloc] init];
    offerstablevie.delegate = self;
    offerstablevie.dataSource = self;
    offerstablevie.tag = 2;
    offerstablevie.allowsMultipleSelection=YES;
    
//    [offerstablevie setBackgroundColor:[UIColor brownColor]];
    [self.view addSubview:offerstablevie];
    
    offerstablevie.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    offerstablevie.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    
    offerstablevie.frame=CGRectMake(0, 65, self.view.frame.size.width, self.view.frame.size.height-65);
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        navigationImage.frame = CGRectMake(0, 0, 320, 64);
        backButton.frame = CGRectMake(5,25, 35, 35);
        topLable.frame = CGRectMake(0, 25, 320, 30);
        topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
        
        btnDelete.frame=CGRectMake(280, 27, 30, 30);
        
        NoResults=[[UILabel alloc]initWithFrame:CGRectMake(self.view.center.x-100, self.view.center.y, 200, 100)];
        NoResults.font = [UIFont fontWithName:@"Helvetica Neue" size:18];

    }
    else
    {
        navigationImage.frame = CGRectMake(0, 0, 768, 64);
        backButton.frame = CGRectMake(5,22, 35, 35);
        topLable.frame = CGRectMake(0, 25, 768, 30);
        topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:26];
        
        btnDelete.frame=CGRectMake(720, 27, 30, 30);
        NoResults=[[UILabel alloc]initWithFrame:CGRectMake(174, self.view.center.y, 480, 100)];
        NoResults.font = [UIFont fontWithName:@"Helvetica Neue" size:26];
   }
    
    NoResults.text=@"New notifications are not available!";
    NoResults.hidden=YES;
    [self.view addSubview:NoResults];
    
    waitingAlt=[[UIAlertView alloc]initWithTitle:@"Please Wait" message:Nil delegate:Nil cancelButtonTitle:Nil otherButtonTitles:Nil, nil];
    [waitingAlt show];
    [self performSelectorInBackground:@selector(fetchNotificationsWithUrl) withObject:nil];
    
}

#pragma mark - UITableView Data Source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableDataArray count];;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        labelSize = [[[tableDataArray objectAtIndex:indexPath.row] valueForKey:@"Message"] sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]
                                                   constrainedToSize:CGSizeMake(300, 9999)
                                                       lineBreakMode:NSLineBreakByWordWrapping];
        labelSize.height+=30;
    }
    else
    {
        labelSize = [[[tableDataArray objectAtIndex:indexPath.row] valueForKey:@"Message"] sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:26]
                                                                                      constrainedToSize:CGSizeMake(720, 9999)
                                                                                          lineBreakMode:NSLineBreakByWordWrapping];
        labelSize.height+=50;
    }
    return labelSize.height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellReuseIdentifier = @"cellIdentifer";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    UILabel *lblDate=[[UILabel alloc]initWithFrame:CGRectMake(16, 5, 300, 20)];
    //for converting date in numbers to date in word
    
    lblDate.font=[UIFont fontWithName:@"Helvetica Neue" size:13];
    
    NSString *NotificationDate=[[tableDataArray objectAtIndex:indexPath.row] valueForKey:@"Notification_Received_On"];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//yyyy-MM-dd
    NSDate* myDate = [dateFormatter dateFromString:NotificationDate];
    
    [dateFormatter setDateFormat:@"dd MMMM yyyy"];
    NSString *stringFromDate = [dateFormatter stringFromDate:myDate];
    NSArray *arr=[stringFromDate componentsSeparatedByString:@" "];
    NSString *day=[arr firstObject];
    
    [dateFormatter setDateFormat:@"hh:mm a"];
    NSString *strTime=[dateFormatter stringFromDate:myDate];
    
    NSString *NotificationDateDisplay;
    if ([[day substringFromIndex:[day length]-1] isEqualToString:@"1"])
        NotificationDateDisplay=[NSString stringWithFormat:@"%@st %@ %@",[arr firstObject],[arr objectAtIndex:1],[arr lastObject]];
    else if ([[day substringFromIndex:[day length]-1] isEqualToString:@"2"])
        NotificationDateDisplay=[NSString stringWithFormat:@"%@nd %@ %@",[arr firstObject],[arr objectAtIndex:1],[arr lastObject]];
    else if ([[day substringFromIndex:[day length]-1] isEqualToString:@"3"])
        NotificationDateDisplay=[NSString stringWithFormat:@"%@rd %@ %@",[arr firstObject],[arr objectAtIndex:1],[arr lastObject]];
    else
        NotificationDateDisplay=[NSString stringWithFormat:@"%@th %@ %@",[arr firstObject],[arr objectAtIndex:1],[arr lastObject]];
    
    NotificationDateDisplay=[NotificationDateDisplay stringByAppendingString:[NSString stringWithFormat:@", %@",strTime]];
    
    lblDate.text=NotificationDateDisplay;
    
    [cell.contentView addSubview:lblDate];
    
    
    labelSize = [[[tableDataArray objectAtIndex:indexPath.row] valueForKey:@"Message"] sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:13]
                                                                                  constrainedToSize:CGSizeMake(300, 9999)
                                                                                      lineBreakMode:NSLineBreakByWordWrapping];

    UILabel *lblMessage=[[UILabel alloc]initWithFrame:CGRectMake(16, 26, 300, labelSize.height)];
    lblMessage.font=[UIFont fontWithName:@"Helvetica Neue" size:13];
    lblMessage.textColor=[UIColor lightGrayColor];
    lblMessage.text=[[tableDataArray objectAtIndex:indexPath.row] valueForKey:@"Message"];
    lblMessage.numberOfLines=10;
    
    [cell.contentView addSubview:lblMessage];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        lblDate.frame=CGRectMake(16, 5, 720, 40);
        lblDate.font=[UIFont fontWithName:@"Helvetica Neue" size:26];
        
        labelSize = [[[tableDataArray objectAtIndex:indexPath.row] valueForKey:@"Message"] sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:26]
                                                                                      constrainedToSize:CGSizeMake(720, 9999)
                                                                                          lineBreakMode:NSLineBreakByWordWrapping];
        lblMessage.frame=CGRectMake(16, 46, 720, labelSize.height);
        lblMessage.font=[UIFont fontWithName:@"Helvetica Neue" size:26];
    }

    if([CellSelected containsObject:indexPath])
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
    else
        cell.accessoryType=UITableViewCellAccessoryNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([CellSelected containsObject:indexPath])
    {
        [CellSelected removeObject:indexPath];
        strDeleteNotifIds=[strDeleteNotifIds stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@,",[[tableDataArray objectAtIndex:indexPath.row] valueForKey:@"Id"]] withString:@""];
    }
    else
    {
        [CellSelected addObject:indexPath];
        strDeleteNotifIds=[strDeleteNotifIds stringByAppendingString:[NSString stringWithFormat:@"%@,",[[tableDataArray objectAtIndex:indexPath.row] valueForKey:@"Id"]]];
    }
    
    if([CellSelected count]>0)
        btnDelete.hidden=NO;
    else
        btnDelete.hidden=YES;
    
    [offerstablevie reloadData];
}

#pragma mark - Custome methods
-(void)fetchNotificationsWithUrl
{
    
    NSString *UrlStr=[NSString stringWithFormat:@"https://testws.goodliving.ae/api/index.php/user/returnMyNotifications/%@",delegate.userID];
    
    UrlStr=[UrlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:UrlStr];
    NSURLRequest *req=[NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data)
        {
            NSError *err;
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
            tableDataArray=[dict valueForKey:@"data"];
            [waitingAlt dismissWithClickedButtonIndex:0 animated:YES];
            
            if ([tableDataArray count]>0)
                [offerstablevie reloadData];
            else
                NoResults.hidden=NO;
        }
        else
        [waitingAlt dismissWithClickedButtonIndex:0 animated:YES];
    }];
}

-(void)deleteNotificationMethod
{
    if ([strDeleteNotifIds length]>0)
    {
        strDeleteNotifIds=[strDeleteNotifIds substringToIndex:[strDeleteNotifIds length]-1];
    }

    NSString *URLStr=[NSString stringWithFormat:@"https://testws.goodliving.ae/api/index.php/user/deleteMyNotifications/%@",strDeleteNotifIds];
    NSURL *URL=[NSURL URLWithString:URLStr];
    [waitingAlt show];
    
    [self performSelectorInBackground:@selector(DeleteNotifications:) withObject:URL];
}

-(void)DeleteNotifications:(NSURL*)URL
{
    NSURLRequest *req=[NSURLRequest requestWithURL:URL];
    
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data)
        {
            NSError *err;
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
            dict=[[dict valueForKey:@"data"] firstObject];
            if ([[dict valueForKey:@"Message"] isEqualToString:@"success"])
            {
                [self fetchNotificationsWithUrl];
            }
        }
        else
            [waitingAlt dismissWithClickedButtonIndex:0 animated:YES];
    }];

}
-(void) backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
