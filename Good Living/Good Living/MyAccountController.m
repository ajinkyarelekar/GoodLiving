//
//  MyAccountController.m
//  Good Living
//
//  Created by NanoStuffs on 08/09/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import "MyAccountController.h"
#import "myProfileController.h"
#import "ChangePasswordViewController.h"

@interface MyAccountController ()

@end

@implementation MyAccountController

- (void)viewDidLoad
{
    delegate = [[UIApplication sharedApplication] delegate];
    
    NSUserDefaults *UserDefault=[NSUserDefaults standardUserDefaults];
    NSData *data;
    
    data= [UserDefault valueForKey:@"fname"];
    
    NSString * name=[NSKeyedUnarchiver unarchiveObjectWithData:[UserDefault valueForKey:@"fname"]];
    
    name=[name stringByAppendingString:[NSString stringWithFormat:@" %@",[NSKeyedUnarchiver unarchiveObjectWithData:[UserDefault valueForKey:@"lname"]]]];
    
    //My_Account
    if (name)
    {
        [Flurry logEvent:@"My Account"];
        [Flurry logPageView];
        self.screenName = @"My Account";
    }
    
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    x_ratio = screenRect.size.width/320;
    y_ratio = screenRect.size.height/568;
    
    
    self.view.backgroundColor=[UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:1.0f];
    //------------------------Navigation Bar
    UIImageView *navigationImage = [[UIImageView alloc] init];
    navigationImage.backgroundColor = [UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f];
    [self.view addSubview:navigationImage];
   
    
    
    UILabel *topLable = [[UILabel alloc] init];
    topLable.text = @"My Account";

    topLable.textAlignment = NSTextAlignmentCenter;
    topLable.textColor = [UIColor whiteColor];
    topLable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topLable];
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];

    
    titleArray=[[NSMutableArray alloc]initWithObjects:@"My Profile" ,@"Subscription Details",@"Change Password", nil];
    offersTbleviewArray=[[NSMutableArray alloc]initWithObjects:@"View Downloaded Vouchers" ,@"Redeem Vouchers",@"View Shared Offers", nil];
    
    UILabel *descriptionDetails=[[UILabel alloc]init];
    descriptionDetails.text=@"Description and instruction for items listed above this.";
    descriptionDetails.numberOfLines=2;
    descriptionDetails.textColor=[UIColor darkGrayColor];


   // [self.view addSubview:descriptionDetails];
    
 //--------------------- mProfile Table view
    profiletableview = [[UITableView alloc] init];
    profiletableview.delegate = self;
    profiletableview.dataSource = self;
    profiletableview.tag = 1;
    profiletableview.scrollEnabled=NO;
    profiletableview.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
    profiletableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    profiletableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    profiletableview.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.view addSubview:profiletableview];

    
  //------------------------------ OffersTableview
    offerstablevie = [[UITableView alloc] init];
    offerstablevie.delegate = self;
    offerstablevie.dataSource = self;
    offerstablevie.tag = 2;
    offerstablevie.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
    offerstablevie.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    offerstablevie.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    offerstablevie.separatorStyle = UITableViewCellSeparatorStyleNone;
   // [self.view addSubview:offerstablevie];


    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        navigationImage.frame = CGRectMake(0, 0, 320 , 64   );
        topLable.frame = CGRectMake(0, 27   , 320  , 30   );
        backButton.frame = CGRectMake(5  ,25   , 35  , 35   );
        descriptionDetails.frame=CGRectMake(5  ,385   , 300  ,60   );
        profiletableview.frame = CGRectMake(0, 100   , 320  ,120   );
        offerstablevie.frame = CGRectMake(0, 260   , 320  ,120   );
            topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
            descriptionDetails.font=[UIFont fontWithName:@"Helvetica Neue" size:15];
    }
    else
    {
            topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:25];
            descriptionDetails.font=[UIFont fontWithName:@"Helvetica Neue" size:26];
            navigationImage.frame = CGRectMake(0, 0, 768, 64);
            backButton.frame = CGRectMake(5,22, 35, 35);
            topLable.frame = CGRectMake(0, 25, 768, 30);
            profiletableview.frame = CGRectMake(10, 150   , 748  ,216   );
            offerstablevie.frame = CGRectMake(10, 420   , 748  ,216   );
    descriptionDetails.frame=CGRectMake(20,680, 700,60);
        
    }
	// Do any additional setup after loading the view.
}


#pragma mark - TableView delegate and datasource methods
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag==1)
    {
    return titleArray.count;
    }
    else
    {
      return offersTbleviewArray.count;
    }
    
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
    return 40   ;
    }
    else
        return 76;
    
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 39, 320, 1)];
        
        [line setBackgroundColor:[UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:0.8f]];
        
        [cell.contentView addSubview:line];
        
    }
    else
    {
               cell.textLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:26];
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 75, 768, 1)];
        
        [line setBackgroundColor:[UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:0.8f]];
        
        [cell.contentView addSubview:line];
        
    }
    
if(tableView.tag==1)
  
   {
       cell.textLabel.text=[titleArray objectAtIndex:indexPath.row];
       if(indexPath.row==0)
       {
           cell.detailTextLabel.text=@"John Appleseed";
           cell.detailTextLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:16];
           cell.detailTextLabel.textColor= [UIColor blackColor];
       }
       if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
           cell.textLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:16];
       else
       { cell.textLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:26]; }
       cell.textLabel.textColor= [UIColor blackColor];
       cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;;

   }
    else
    {
        cell.textLabel.text=[offersTbleviewArray objectAtIndex:indexPath.row];
        if(indexPath.row==0)
        {
            cell.detailTextLabel.text=@"John Appleseed";
            cell.detailTextLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:16];
            cell.detailTextLabel.textColor= [UIColor blackColor];
        }
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
            cell.textLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:16];
        else
        { cell.textLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:26]; }
        cell.textLabel.textColor= [UIColor blackColor];
          }
    
    return cell;
    
}


-(void)btnSelected:(id)sender
{
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
if(tableView.tag==1)
{
    if(indexPath.row==0)
    {
        myProfileController *myProfile=[[myProfileController alloc]init];
        [self.navigationController pushViewController:myProfile animated:YES];
    }
    else if (indexPath.row==1)
    {
        mySubscription *myProfile=[[mySubscription alloc]init];
        [self.navigationController pushViewController:myProfile animated:YES];
    }
    else if (indexPath.row==2)
    {
        ChangePasswordViewController *obj=[[ChangePasswordViewController alloc]init];
        [self.navigationController pushViewController:obj animated:YES];
    }
}
}



- (void) filterBtns: (id) sender
{
    
}

-(void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)SubmitMethod
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)resetFilter
{
    
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end