//
//  LeftPanelViewController.m
//  Good Living
//
//  Created by Minakshi on 9/20/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import "LeftPanelViewController.h"
#import "MyAccountController.h"
#import "ViewController.h"
#import "myPurchaseController.h"
#import "ContactusController.h"
#import "aboutGoodLivingController.h"
#import "notificationController.h"
#import "PreferencesController.h"
#import "MyVoucherController.h"
#import "LeadingViewController.h"
#import "MainLeadingController.h"
#import "FavoriteController.h"
#import "MyCompetationController.h"

@interface LeftPanelViewController ()

@end

@implementation LeftPanelViewController

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
    
    self.view .backgroundColor=[UIColor colorWithRed:63/255.0f green:66/255.0f blue:67/255.0f alpha:1.0f];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    x_ratio = screenRect.size.width/320;
    y_ratio = screenRect.size.height/568;
    delegate = [[UIApplication sharedApplication] delegate];
    
    delegate.leftPannelflag = -1;
    
    //------------------------------------------------------------------Menu Start
    menuView = [[UIView alloc] init];
    [self.view addSubview:menuView];
    menuView.backgroundColor=[UIColor colorWithRed:63/255.0f green:66/255.0f blue:67/255.0f alpha:1.0f];
    menuView.frame = CGRectMake(0, 0, 240*x_ratio, 568*y_ratio);
    
    
//    menuScreenScrool = [[UIScrollView alloc] init];
//    menuScreenScrool.delegate = self;
//    menuScreenScrool.backgroundColor = [UIColor clearColor];
//
//    [menuView addSubview:menuScreenScrool];
    
//    menuScreenScrool.frame = CGRectMake(0, 0, 262*x_ratio, self.view.frame.size.height);
//    menuScreenScrool.contentSize = CGSizeMake(262*x_ratio, self.view.frame.size.height);
    
    accountHolderName=[[UILabel alloc]init];
    accountHolderName.textColor=[UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f];
  
    [menuView addSubview:accountHolderName];
//    [menuScreenScrool addSubview:accountHolderName];
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        accountHolderName.font=[UIFont fontWithName:@"Helvetica Neue" size:15];
    }
    else
    {
        accountHolderName.font=[UIFont fontWithName:@"Helvetica Neue" size:25];
    }
    
    if(delegate.loginSuccessfulFLAG == 0)
    {
        accountHolderName.text=@"Welcome - Guest";
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            accountHolderName.frame=CGRectMake(15*x_ratio,54*y_ratio, 200*x_ratio,30*y_ratio);
        }
        else
        {
            accountHolderName.frame=CGRectMake(7*x_ratio,54*y_ratio, 200*x_ratio,30*y_ratio);
            
        }
        titleArray=[[NSMutableArray alloc]initWithObjects:@"About Good Living",@"Contact Us",@"Login", nil];//,@"",@"",@"",@"",@"",@""
    }
    else
    {
       fname1=delegate.fname;
        lname1=delegate.laname;
        
        accountHolderName.text=[NSString stringWithFormat:@"%@ %@",fname1,lname1];
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            accountHolderName.frame=CGRectMake(15*x_ratio,54*y_ratio, 200*x_ratio,30*y_ratio);
        }
        else
        {
            accountHolderName.frame=CGRectMake(7*x_ratio,54*y_ratio, 200*x_ratio,30*y_ratio);
        }
        
        titleArray=[[NSMutableArray alloc]initWithObjects:@"My Account",@"My Vouchers",@"My Competitions" ,@"Favourites",@"Preferences",@"",@"About Good Living",@"Contact Us",@"Notifications",@"",@"Logout", nil];
        //My Purchases 3r number
    }
    
    
    //-------------------FilterThemeController
    mainMenuTable = [[UITableView alloc] init];
    mainMenuTable.delegate = self;
    mainMenuTable.dataSource = self;
    mainMenuTable.tag = 1;
    mainMenuTable.backgroundColor =[UIColor colorWithRed:63/255.0f green:66/255.0f blue:67/255.0f alpha:1.0f];
    mainMenuTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    mainMenuTable.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    mainMenuTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

    [menuView addSubview:mainMenuTable];
//    [menuScreenScrool addSubview:mainMenuTable];
    
    
    [mainMenuTable setSeparatorColor:[UIColor colorWithRed:77/255.0f green:80/255.0f blue:81/255.0f alpha:1.0f]];
    mainMenuTable.frame = CGRectMake(0, 90*y_ratio, 262*x_ratio,480*y_ratio);
    
    
    UISwipeGestureRecognizer *recognizer1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer1 setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:recognizer1];
    
    UISwipeGestureRecognizer *recognizer2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer2 setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:recognizer2];
    //------------------------------------------------------------------Menu End
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
       if([[NSUserDefaults standardUserDefaults] boolForKey:@"SignUpSuccess"]==YES)
    {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"SignUpSuccess"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        if(delegate.loginSuccessfulFLAG == 0)
        {
            accountHolderName.text=@"Welcome - Guest";
            titleArray=[[NSMutableArray alloc]initWithObjects:@"About Good Living",@"Contact Us",@"Login", nil];
        }
        else
        {
           fname1=delegate.fname;
           lname1=delegate.laname;
            
            accountHolderName.text=[NSString stringWithFormat:@"%@ %@",fname1,lname1];
            
            titleArray=[[NSMutableArray alloc]initWithObjects:@"My Account",@"My Vouchers",@"My Competitions",@"Favourites",@"Preferences",@"",@"About Good Living",@"Contact Us",@"Notifications",@"",@"Logout", nil];
        }
        
        [mainMenuTable reloadData];
    }
  
}

#pragma mark - TableView delegate and datasource methods
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titleArray.count;
    
    
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    // Cell isn't selected so return single height
    return 40*y_ratio;
    
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    //Aded by Gafar
    if([[titleArray objectAtIndex:indexPath.row] length]>0)
        backView.backgroundColor =  [UIColor colorWithRed:106/255.0f green:81/255.0f blue:39/255.0f alpha:1.0f];
    
    
    //cell.backgroundView = backView;
    cell.selectedBackgroundView=backView;
    
    cell.textLabel.text=[titleArray objectAtIndex:indexPath.row];
    
    
    cell.backgroundColor=[UIColor colorWithRed:63/255.0f green:66/255.0f blue:67/255.0f alpha:1.0f];
    
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        cell.textLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:16];
    }
    else
    {
        cell.textLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:26];
    }
    cell.textLabel.textColor= [UIColor colorWithRed:234/255.0f green:234/255.0f blue:234/255.0f alpha:1.0f];
    
    
    //Aded by Gafar
    if (delegate.leftPannelflag >= 0)
    {
        if (delegate.leftPannelflag == indexPath.row)
        {
            [cell.contentView setBackgroundColor:[UIColor colorWithRed:205.0f/255.0f green:139.0f/255.0f blue:31.0f/255.0f alpha:1.0f]];
        }
        else
        {
            [cell.contentView setBackgroundColor:[UIColor clearColor]];
        }
    }
    
    return cell;
    
}



- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    delegate.leftPannelflag = indexPath.row;
    if([[titleArray objectAtIndex:indexPath.row] length]==0)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
    
    if(delegate.loginSuccessfulFLAG == 0)
    {
        // [myString setValue:@"isLoginSelect" forKey:@"keyToLookupString"];
        if(indexPath.row==0)
        {
            //            PreferencesController *nextView = [[PreferencesController alloc] init];
            //            [self.navigationController pushViewController:nextView animated:YES];
            //        }
            //
            //        else if(indexPath.row==2)
            //        {
            aboutGoodLivingController *about=[[aboutGoodLivingController alloc]init];
            [self.navigationController pushViewController:about animated:YES];
        }
        else if(indexPath.row==1)
        {
            ContactusController *contact;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                contact = [[ContactusController alloc]initWithNibName:@"ContactusController" bundle:nil];
            else
                contact = [[ContactusController alloc]initWithNibName:@"ContactusControlleriPad" bundle:nil];
            
            [self.navigationController pushViewController:contact animated:YES];
            
        }
        //        else if(indexPath.row==4)
        //        {
        //            notificationController *not=[[notificationController alloc]init];
        //            [self.navigationController pushViewController:not animated:YES];
        //
        //        }
        else if(indexPath.row==2)
            
        {
            delegate.loginFlag = 1;
            ViewController *nextView = [[ViewController alloc] init];
            [self.navigationController pushViewController:nextView animated:YES];
        }
    }
    else
    {
        if(indexPath.row==0)
        {
            MyAccountController *nextView = [[MyAccountController alloc] init];
            [self.navigationController pushViewController:nextView animated:YES];
        }
        else if(indexPath.row==1)
        {
            MyVoucherController *nextView = [[MyVoucherController alloc] init];
            [self.navigationController pushViewController:nextView animated:YES];
        }
        
//        else if(indexPath.row==2)
//        {
//            myPurchaseController *purchae=[[myPurchaseController alloc]init];
//            //[self.navigationController pushViewController:purchae animated:YES];
//        }
        else if(indexPath.row==2)
        {
            MyCompetationController *mycomp=[[MyCompetationController alloc]init];
            [self.navigationController pushViewController:mycomp animated:YES];
        }
        
        else if(indexPath.row==3)
        {
            FavoriteController *fav=[[FavoriteController alloc]init];
            [self.navigationController pushViewController:fav animated:YES];
        }
        
        else if(indexPath.row==4)
        {
            PreferencesController *nextView = [[PreferencesController alloc] init];
            [self.navigationController pushViewController:nextView animated:YES];
            
        }
        else if(indexPath.row==6)
        {
            aboutGoodLivingController *about=[[aboutGoodLivingController alloc]init];
            [self.navigationController pushViewController:about animated:YES];
        }
        else if(indexPath.row==7)
        {
            ContactusController *contact;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                contact = [[ContactusController alloc]initWithNibName:@"ContactusController" bundle:nil];
            else
                contact = [[ContactusController alloc]initWithNibName:@"ContactusControlleriPad" bundle:nil];
            
            [self.navigationController pushViewController:contact animated:YES];
            
        }
        else if(indexPath.row==8)
        {
            notificationController *not=[[notificationController alloc]init];
            [self.navigationController pushViewController:not animated:YES];
            
            
        }
        else if(indexPath.row==10)
        {
            delegate.loginFlag = 0;
            delegate.loginSuccessfulFLAG=0;
            delegate.subUpdateFlag = 0;
            MainLeadingController *nextView = [[MainLeadingController alloc] init];
            [self.navigationController pushViewController:nextView animated:YES];
        }
    }
}

- (void) menuMethod : (id) sender
{
    
    UIButton *btn = (UIButton *) sender;
    
    if (btn.selected == YES)
    {
        menuButton.selected = NO;
        menuView.hidden = TRUE;
        CATransition *animation = [CATransition animation];
        [animation setDelegate:self];
        [animation setType:kCATransitionPush];
        [animation setSubtype:kCATransitionFromRight];
        [animation setDuration:0.50];
        [animation setTimingFunction:
         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [menuView.layer addAnimation:animation forKey:kCATransition];
        
        
    }
    else
    {
        menuButton.selected = YES;
        menuView.hidden = FALSE;
        
        CATransition *animation = [CATransition animation];
        [animation setDelegate:self];
        [animation setType:kCATransitionPush];
        [animation setSubtype:kCATransitionFromLeft];
        [animation setDuration:0.50];
        [animation setTimingFunction:
         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [menuView.layer addAnimation:animation forKey:kCATransition];
        
        [UIView animateWithDuration:0.5 animations:^{
            
            
        }];
    }
}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer
{
    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight)
    {
        if (menuButton.selected == YES)
        {
            menuButton.selected = NO;
            
            menuView.hidden = TRUE;
            CATransition *animation = [CATransition animation];
            [animation setDelegate:self];
            [animation setType:kCATransitionPush];
            [animation setSubtype:kCATransitionFromRight];
            [animation setDuration:0.50];
            [animation setTimingFunction:
             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [menuView.layer addAnimation:animation forKey:kCATransition];
        }
    }
    else
    {
        if (menuButton.selected == NO)
        {
            menuButton.selected = YES;
            menuView.hidden = FALSE;
            
            CATransition *animation = [CATransition animation];
            [animation setDelegate:self];
            [animation setType:kCATransitionPush];
            [animation setSubtype:kCATransitionFromLeft];
            [animation setDuration:0.50];
            [animation setTimingFunction:
             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [menuView.layer addAnimation:animation forKey:kCATransition];
        }
    }
}

- (void) homeMethod : (id) sender
{
    //  UIButton *btn = (UIButton *)sender;
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
