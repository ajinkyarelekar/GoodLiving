//
//  mySubscription.m
//  Good Living
//
//  Created by NanoStuffs on 07/10/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import "mySubscription.h"
#import "AuthenticatedController.h"
@interface mySubscription ()

@end

@implementation mySubscription

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
    delegate=[[UIApplication sharedApplication] delegate];
    
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:1.0f];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    x_ratio = screenRect.size.width/320;
    y_ratio = screenRect.size.height/568;
    
    
    //------------------------Navigation Bar
    UIImageView *navigationImage = [[UIImageView alloc] init];
    navigationImage.backgroundColor = [UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f];
    [self.view addSubview:navigationImage];
    
    
    UILabel *topLable = [[UILabel alloc] init];
    topLable.text = @"Subscription Details";
    
    
    topLable.textAlignment = NSTextAlignmentCenter;
    topLable.textColor = [UIColor whiteColor];
    topLable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topLable];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    [self GetTableDat];
    
    UILabel *firstTimeAlert = [[UILabel alloc] init];
    firstTimeAlert.text = @"If you are a Gulf News Subscriber, you can enter your subscription details below.";
    firstTimeAlert.numberOfLines = 2;
    firstTimeAlert.textAlignment = NSTextAlignmentCenter;
    firstTimeAlert.lineBreakMode = NSLineBreakByWordWrapping;
    [self.view addSubview:firstTimeAlert];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone )
    {
        firstTimeAlert.frame = CGRectMake(10, 65, 300, 45);
        firstTimeAlert.font = [UIFont fontWithName:@"Helvetica Neue" size:16];
    }
    else
    {
        firstTimeAlert.frame = CGRectMake(20, 65, 720, 70);
        firstTimeAlert.font = [UIFont fontWithName:@"Helvetica Neue" size:26];
    }
    

    //If you are a Gulf News Subscriber, you can enter your subscription details below.
    
    //-------------------MyProfileView
    myProfileTableView = [[UITableView alloc] init];
    myProfileTableView.delegate = self;
    myProfileTableView.dataSource = self;
    myProfileTableView.tag = 2;
    myProfileTableView.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
    myProfileTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    myProfileTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    myProfileTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myProfileTableView.scrollEnabled=NO;
    [self.view addSubview:myProfileTableView];
    


    
    
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        navigationImage.frame = CGRectMake(0, 0, 320    , 64     );
        topLable.frame = CGRectMake(0, 25     , 320    , 30     );
        topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
        backButton.frame = CGRectMake(5    ,25     , 35    , 35     );
        
        myProfileTableView.frame = CGRectMake(0, 115   , 320    ,(40*titleArray.count));
    }
    
    else
    {
        topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:25];
        navigationImage.frame = CGRectMake(0, 0, 768, 64);
        backButton.frame = CGRectMake(5,22, 35, 35);
        topLable.frame = CGRectMake(0, 25, 768, 30);
        myProfileTableView.frame = CGRectMake(10, 150     , 748    ,76*titleArray.count);
    }
}

- (void) GetTableDat
{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    // getting an dictionary
    mydictionary=(NSDictionary *) [prefs objectForKey:@"Registration"];
    
    bpcode=[mydictionary valueForKey:@"bpcode"];
    if([bpcode isEqualToString:@"0"])
        bpcode=@"";
    
    email=[mydictionary valueForKey:@"email"];
    mobile=[mydictionary valueForKey:@"mobile"];
    
    NSString *status;
//    if (![bpcode isEqualToString:@""])
//        status=@"Active";//[mydictionary valueForKey:@"status"];
//    else
//        status=@"0";

//    if ([[mydictionary valueForKey:@"subscrptionStatus"] isEqualToString:@""] || ![[mydictionary valueForKey:@"subscrptionStatus"] isEqualToString:@""])
//        status = @"";
//    else
//        status = @"Active";
    status=[mydictionary valueForKey:@"subscrptionStatus"];
    
    NSString *startDate=[mydictionary valueForKey:@"startdate"];
    if([mobile isEqualToString:@"0"])
        mobile=@"";
    
    if([email isEqualToString:@"0"])
        email=@"";
    
    
    if([status isEqualToString:@"0"])
        status=@"";
    if([startDate isEqualToString:@"0"])
        startDate=@"";
    NSString *endDate=[mydictionary valueForKey:@"enddate"];
    if([endDate isEqualToString:@"0"])
        endDate=@"";
    NSString *productCode=[mydictionary valueForKey:@"prodcode"];
    if([productCode isEqualToString:@"0"])
        productCode=@"";
    NSString *SubType=[mydictionary valueForKey:@"subType"];
    if([SubType isEqualToString:@"0"])
        SubType=@"";
    
    // show a single value
    titleArray=[[NSMutableArray alloc]initWithObjects:@"Subscription No." ,@"Email",@"Mobile",@"Status",@"Start Date",@"End Date",@"Product",@"Subscription Type", nil];
    
    if (!bpcode)
        bpcode = @"";
    if (!email)
        email = @"";
    if (!mobile)
        mobile = @"";
    if (!status)
        status = @"";
    if (!startDate)
        startDate = @"";
    if (!endDate)
        endDate = @"";
    if (!productCode)
        productCode = @"";
    if (!SubType)
        SubType = @"";
    
    subTitleArray=[[NSMutableArray alloc]initWithObjects:bpcode ,email,mobile,status,startDate,endDate,productCode,SubType, nil];
    
    ////////updateButton
    updatebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [updatebutton addTarget:self action:@selector(upDateMethod) forControlEvents:UIControlEventTouchUpInside];
    [updatebutton setTitle:@"EDIT" forState:UIControlStateNormal];
    [updatebutton setBackgroundColor:[UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f]];
    updatebutton.layer.cornerRadius = 5.0f;
        
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        updatebutton.frame = CGRectMake(20, 445, 100, 30);
        updatebutton.titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:16];
    }
    
    else
    {
        updatebutton.titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:25];
        updatebutton.frame = CGRectMake(40, 778, 200, 60);
    }
    
    if([bpcode isEqualToString:@""] && [email isEqualToString:@""] && [mobile isEqualToString:@""])
    {
        [self.view addSubview:updatebutton];
        updatebutton.hidden = NO;
    }
    else
    {
        updatebutton.hidden = YES;
        [updatebutton removeFromSuperview];
    }
    
    
    
    ////////updateButton
    removebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [removebutton addTarget:self action:@selector(removeMethod) forControlEvents:UIControlEventTouchUpInside];
    [removebutton setTitle:@"REMOVE" forState:UIControlStateNormal];
    [removebutton setBackgroundColor:[UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f]];
    removebutton.layer.cornerRadius = 5.0f;
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
      removebutton.frame = CGRectMake(20, 445, 100, 30);
        removebutton.titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:16];
    }
    
    else
    {
           removebutton.titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:25];
          removebutton.frame = CGRectMake(40, 778, 200, 60);
    }
    

    
    if(bpcode.length > 0 || email.length > 0 || mobile.length > 0)
    {
    
        removebutton.hidden = NO;
        [self.view addSubview:removebutton];
    }
    else
    {
        removebutton.hidden = YES;
        [removebutton removeFromSuperview];
    }
    
   
    [myProfileTableView reloadData];
}

- (void) removeMethod
{
    //removeMethod
    NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc]init];
    [mutableDict setObject: @"0" forKey:@"subType"];
    
    NSUserDefaults *UserDefault=[NSUserDefaults standardUserDefaults];
    [UserDefault setObject:mutableDict forKey:@"Registration"];
    [UserDefault synchronize];
    [self GetTableDat];
}

-(void)upDateMethod
{
    AuthenticatedController *nextView=[[AuthenticatedController alloc]init];
    delegate.subUpdateFlag = 1;
    [self.navigationController pushViewController:nextView animated:YES];
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
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        
        return 40     ;
    }
    else
        return 76;
    
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    Customcell *cell =(Customcell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[Customcell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    
    cell.str.text=[titleArray objectAtIndex:indexPath.row];
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        cell.str.font=[UIFont fontWithName:@"Helvetica Neue" size:16];
    else
    { cell.str.font=[UIFont fontWithName:@"Helvetica Neue" size:26]; }
    
    cell.str.textColor= [UIColor blackColor];
    
    cell.str1.text=[subTitleArray objectAtIndex:indexPath.row];
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        cell.str1.font=[UIFont fontWithName:@"Helvetica Neue" size:16];
    }
    else
    {
        cell.str1.font=[UIFont fontWithName:@"Helvetica Neue" size:26];
    }
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        UIView *line;
        
        line=[[UIView alloc]initWithFrame:CGRectMake(0, 39, 320, 1)];
    
        
        [line setBackgroundColor:[UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:0.7f]];
        
        [cell.contentView addSubview:line];
        
    }
    else
    {
      
        cell.textLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:26];
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 75, 768, 1)];
        
        [line setBackgroundColor:[UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:0.7f]];
        
        [cell.contentView addSubview:line];
        
    }
    
    cell.str1.textColor= [UIColor grayColor];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

-(void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end