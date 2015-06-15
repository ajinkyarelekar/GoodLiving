//
//  PreferencesController.m
//  Good Living
//
//  Created by Minakshi on 9/19/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import "PreferencesController.h"
#import "FilterThemeController.h"

@interface PreferencesController ()
{
    NSMutableDictionary *dictLocations;
    NSMutableArray *arrLocations;

}
@end

@implementation PreferencesController

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
    getPrefalert = [[UIAlertView alloc] initWithTitle:@"Please wait..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [getPrefalert show];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    x_ratio = screenRect.size.width/320;
    y_ratio = screenRect.size.height/568;
    
    
    [self loadLocationsAreas];
    _emiratesString=@"";
    
    delegate = [[UIApplication sharedApplication] delegate];
    
    self.view.backgroundColor=[UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:1.0f];
    
    //------------------------Navigation Bar
    UIImageView *navigationImage = [[UIImageView alloc] init];
    navigationImage.backgroundColor = [UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f];
    [self.view addSubview:navigationImage];
 
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];

    
    UILabel *topLable = [[UILabel alloc] init];
    topLable.text = @"Preferences";
 
    topLable.textAlignment = NSTextAlignmentCenter;
    topLable.textColor = [UIColor whiteColor];
    topLable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topLable];
    
    
    scrollview = [[UIScrollView alloc] init];
    scrollview.delegate = self;
    [self.view addSubview:scrollview];
    
    titleArray=[[NSMutableArray alloc]initWithObjects:@"Casual Dining" ,@"Shopping",@"Fine Dining",@"Beauty & Wellness",@"Home & Garden" ,@"Health & Fitness",@"Children",@"Adventure & Leisure",@"Services", nil];
    
    emiritesArray =[[NSMutableArray alloc]initWithObjects:@"Abu Dhabi" ,@"Dubai",@"Northern Emirates",@"Sharjah", nil];
    
    firstTimeAlert = [[UILabel alloc] init];
    firstTimeAlert.text = @"Set your preferences here for the notifications you want to receive.";
    firstTimeAlert.numberOfLines = 2;
    firstTimeAlert.textAlignment = NSTextAlignmentCenter;
    firstTimeAlert.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollview addSubview:firstTimeAlert];
    
    UILabel *filter=[[UILabel alloc]init];
    filter.text=@"PREFERRED THEMES";
    filter.textColor=[UIColor darkGrayColor];  
    [scrollview addSubview:filter];
    
    UILabel *emiritsLable=[[UILabel alloc]init];
    emiritsLable.text=@"PREFERRED EMIRATE";
    emiritsLable.textColor=[UIColor darkGrayColor];
    [scrollview addSubview:emiritsLable];
    
    UILabel *lblArea=[[UILabel alloc]init];
    lblArea.text=@"PREFERRED AREAS";
    lblArea.textColor=[UIColor darkGrayColor];
    [scrollview addSubview:lblArea];
    
    UILabel *descriptionDetails=[[UILabel alloc]init];
    descriptionDetails.text=@"Description and instruction for items listed above this.";
    descriptionDetails.numberOfLines=2;
    descriptionDetails.textColor=[UIColor darkGrayColor];
   // [scrollview addSubview:descriptionDetails];
    
    
    UILabel *Notificationslable = [[UILabel alloc] init];
    Notificationslable.backgroundColor = [UIColor whiteColor];
    [scrollview addSubview:Notificationslable];
    
    UISwitch *onOffBtn = [[UISwitch alloc] init];
    [onOffBtn addTarget:self action:@selector(onOffMethod) forControlEvents:UIControlEventTouchUpInside];
    [scrollview addSubview:onOffBtn];
    
    AreaTableView.frame=CGRectMake(10, 1426, 748, 76);

    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        Notificationslable.frame = CGRectMake(0, 820, 320, 40);
        Notificationslable.text = @"   Notification";
        Notificationslable.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
        
        onOffBtn.frame = CGRectMake(260, 825, 500, 40);
        firstTimeAlert.frame = CGRectMake(10, 5, 300, 45);
        firstTimeAlert.font = [UIFont fontWithName:@"Helvetica Neue" size:16];
    }
    else
    {
        Notificationslable.frame = CGRectMake(0, 1520, 768, 75);
        Notificationslable.text = @"   Notification";
        Notificationslable.font = [UIFont fontWithName:@"Helvetica Neue" size:26];

        onOffBtn.frame = CGRectMake(660, 1550, 150, 100);
        firstTimeAlert.frame = CGRectMake(30, 5, 708, 70);
        firstTimeAlert.font = [UIFont fontWithName:@"Helvetica Neue" size:30];
    }
    
    
    UIButton *saveButton=[UIButton buttonWithType:UIButtonTypeCustom];
    //[saveButton setBackgroundImage:[UIImage imageNamed:@"premiumoffer1.png"] forState:UIControlStateNormal];
    [saveButton setBackgroundColor:[UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f]];
    [saveButton setTitle:@"SAVE" forState:UIControlStateNormal];
     [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    saveButton.layer.cornerRadius = 5.0f;
    [scrollview  addSubview:saveButton];

    
    
    //-------------------OffersTableview
    offerstablevie = [[UITableView alloc] init];
    offerstablevie.delegate = self;
    offerstablevie.dataSource = self;
    offerstablevie.tag = 2;
    offerstablevie.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
    offerstablevie.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    offerstablevie.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    offerstablevie.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    offerstablevie.scrollEnabled = NO;
    [scrollview addSubview:offerstablevie];
    cellSelected = [NSMutableArray array];
    
    cellSelectedEM = [NSMutableArray array];

    //-------------------emiritaestablevie
    emiritaestablevie = [[UITableView alloc] init];
    emiritaestablevie.delegate = self;
    emiritaestablevie.dataSource = self;
    emiritaestablevie.tag = 4;
    emiritaestablevie.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
    emiritaestablevie.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    emiritaestablevie.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    emiritaestablevie.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    emiritaestablevie.scrollEnabled = NO;
    [scrollview addSubview:emiritaestablevie];
    
    //-------------------AreaTableView
    AreaTableView = [[UITableView alloc] init];
    AreaTableView.delegate = self;
    AreaTableView.dataSource = self;
    AreaTableView.tag = 6;
    AreaTableView.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
    AreaTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    AreaTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    AreaTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    AreaTableView.scrollEnabled = NO;
    [scrollview addSubview:AreaTableView];
    
    [self performSelector:@selector(GetPreference) withObject:nil afterDelay:0.1];
    
//    //Added by Ajinkya for mainataining status even after closing app
//    NSUserDefaults *UD=[NSUserDefaults standardUserDefaults];
//    if ([UD objectForKey:@"SelectedPreferrences"])
//    {
//        NSData *data =[UD objectForKey:@"SelectedPreferrences"];
//        cellSelected = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//    }
//    
//    if ([UD objectForKey:@"SelectedPreferrencesArea"])
//        _areaString=[UD objectForKey:@"SelectedPreferrencesArea"];
//    else
//        _areaString=@"All";
//    NSUserDefaults *UD1=[NSUserDefaults standardUserDefaults];
//    if ([UD1 objectForKey:@"SelectedPreferrencesEM"])
//    {
//        NSData *data1 =[UD1 objectForKey:@"SelectedPreferrencesEM"];
//        cellSelectedEM = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
//    }
        if(UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPhone)
        {
            topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
            
            filter.font=[UIFont fontWithName:@"Helvetica Neue" size:15];
            emiritsLable.font=[UIFont fontWithName:@"Helvetica Neue" size:15];
            lblArea.font=[UIFont fontWithName:@"Helvetica Neue" size:15];
            
            descriptionDetails.font=[UIFont fontWithName:@"Helvetica Neue" size:15];
            
            navigationImage.frame = CGRectMake(0, 0, 320, 64);
            backButton.frame = CGRectMake(5,25, 35, 35);
            topLable.frame = CGRectMake(0, 27, 320, 30);
            
            filter.frame=CGRectMake(15,50, 160,20);
            emiritsLable.frame=CGRectMake(15,495, 160,20);
            lblArea.frame=CGRectMake(15,725, 160,20);
            
            descriptionDetails.frame=CGRectMake(5,685, 300,60);
            
            offerstablevie.frame = CGRectMake(0, 85, 320,387);
            emiritaestablevie.frame = CGRectMake(0, 531, 320, 172);
            AreaTableView.frame=CGRectMake(0, 763, 320, 43);
            
            scrollview.frame = CGRectMake(0, 65, 320, self.view.frame.size.height-64);//64
            scrollview.contentSize = CGSizeMake(320, 950);
            saveButton.frame=CGRectMake(20, 870, 70, 30);//840
//            saveButton.center=CGPointMake(self.view.center.x, 915);//820
            saveButton.titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:14];

        }
    else
    {
            topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:25];
            filter.font=[UIFont fontWithName:@"Helvetica Neue" size:26];
            emiritsLable.font=[UIFont fontWithName:@"Helvetica Neue" size:26];
            descriptionDetails.font=[UIFont fontWithName:@"Helvetica Neue" size:26];
            lblArea.font=[UIFont fontWithName:@"Helvetica Neue" size:26];

            navigationImage.frame = CGRectMake(0, 0, 768, 64);
            backButton.frame = CGRectMake(5,22, 35, 35);
            topLable.frame = CGRectMake(0, 25, 768, 30);
            
            filter.frame=CGRectMake(25,96, 400,30);
            emiritsLable.frame=CGRectMake(25,926, 400,30);
            lblArea.frame=CGRectMake(25,1380, 400,30);


            offerstablevie.frame = CGRectMake(10, 146, 748,684);
            emiritaestablevie.frame = CGRectMake(10, 976, 748, 304);
            AreaTableView.frame=CGRectMake(10, 1426, 748, 76);

            descriptionDetails.frame=CGRectMake(20,1350, 700,30);

            scrollview.frame = CGRectMake(0, 64, 768, self.view.frame.size.height-64);
            scrollview.contentSize = CGSizeMake(768, 1700);
            saveButton.titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:20];
            saveButton.frame=CGRectMake(370, 1615, 140, 50);
//            saveButton.center=CGPointMake(self.view.center.x, 1650);

        
    
    }
	// Do any additional setup after loading the view.
}

- (void) onOffMethod
{
}

-(void)viewWillAppear:(BOOL)animated
{
    [AreaTableView reloadData];
}

-(void)loadLocationsAreas
{
    dictLocations=[[NSMutableDictionary alloc]init];
    arrLocations=[[NSMutableArray alloc]init];
    NSString *FilePath = [[NSBundle mainBundle] pathForResource:@"Locations" ofType:@"csv"];
    
    NSString* contents = [NSString stringWithContentsOfFile:FilePath
                                                   encoding:NSUTF8StringEncoding
                                                      error:nil];
    
    NSArray* lines = [contents componentsSeparatedByString:@"\r"];
    
    for (NSString* line in lines)
    {
        NSArray* fields = [line componentsSeparatedByString:@","];
        if ([dictLocations objectForKey:[fields firstObject]])
        {
            arrLocations=[dictLocations objectForKey:[fields firstObject]];
            [arrLocations addObject:[fields objectAtIndex:1]];
            NSMutableArray *temp=[[NSMutableArray alloc]initWithArray:arrLocations];
            [dictLocations setObject:temp forKey:[fields firstObject]];
            temp=nil;
        }
        else
        {
            [arrLocations removeAllObjects];
            [arrLocations addObject:[fields objectAtIndex:1]];
            NSMutableArray *temp=[[NSMutableArray alloc]initWithArray:arrLocations];
            [dictLocations setObject:temp forKey:[fields firstObject]];
        }
    }

}
-(void)saveBtnMethod
{
    //    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Saved" message:@"Thank you for saving your preference. You can now look forward to saving on offers relevant to you!" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
    //      [alertView show];
 
    Savealert = [[UIAlertView alloc] initWithTitle:@"Please wait..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [Savealert show];
    [self performSelector:@selector(saveDelay) withObject:nil afterDelay:0.1];
    
    //    NSUserDefaults *UserDefault=[NSUserDefaults standardUserDefaults];
    //    [UserDefault setObject:_areaString forKey:@"SelectedPreferrencesArea"];
}

- (void) saveDelay
{
    @try {
        NSString *themeString;
        themeString = @"";
        for (int i = 0; i < [cellSelected count]; i++)
        {
            if ([themeString length] > 0)
            {
                NSIndexPath *IP=[cellSelected objectAtIndex:i];
                
                if (IP.row < 10)
                {
                    themeString = [themeString stringByAppendingString:[NSString stringWithFormat:@",%@",[titleArray objectAtIndex:IP.row]]];
                }
            }
            else
            {
                NSIndexPath *IP=[cellSelected objectAtIndex:i];
                if (IP.row < 10)
                {
                    themeString = [themeString stringByAppendingString:[NSString stringWithFormat:@"%@",[titleArray objectAtIndex:IP.row]]];
                }
            }
        }
        
        NSString *emiritString;
        emiritString = @"";
        
        NSIndexPath *IP1=[cellSelectedEM objectAtIndex:0];
        
        if (IP1.row < 10)
        {
            emiritString = [NSString stringWithFormat:@"%@",[emiritesArray objectAtIndex:IP1.row]];
        }

        NSString *url = [NSString stringWithFormat:@"https://testws.goodliving.ae/api/index.php/user/addPreferences/%@/%@/%@/%@",delegate.userID,emiritString,themeString,_areaString];
        
        url=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
        [request setURL:[NSURL URLWithString:url]];
        [request setHTTPMethod:@"POST"];
        NSHTTPURLResponse *response = nil;
        NSError *error = [[NSError alloc] init];
        NSData *data= [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        NSDictionary*json;
        if (data)
        {
            NSError* error;
            json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSMutableArray *DataArray = [json objectForKey:@"data"];
            NSLog(@"%@",[[DataArray objectAtIndex:0] valueForKey:@"msg"]);
            
            [Savealert dismissWithClickedButtonIndex:0 animated:YES];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:[[DataArray objectAtIndex:0] valueForKey:@"msg"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
                [Savealert dismissWithClickedButtonIndex:0 animated:YES];
        }
    }
    @catch (NSException *exception)
    {
        [Savealert dismissWithClickedButtonIndex:0 animated:YES];
    }
}
- (void) GetPreference
{
    
    @try {
        NSString *url = [NSString stringWithFormat:@"https://testws.goodliving.ae/api/index.php/user/returnMyPreferences/%@",delegate.userID];
        
        url=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
        [request setURL:[NSURL URLWithString:url]];
        [request setHTTPMethod:@"POST"];
        NSHTTPURLResponse *response = nil;
        NSError *error = [[NSError alloc] init];
        NSData *data= [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        NSDictionary*json;
        if (data)
        {
            NSError* error;
            json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSMutableArray *DataArray = [json objectForKey:@"data"];
            
//            NSLog(@"%d",[DataArray count]);
//            if ([DataArray count]<=0)
//            {
//                firstTimeAlert.hidden = FALSE;
//                scrollview.frame = CGRectMake(0, 105, 320, self.view.frame.size.height-64);
//            }
            
            NSArray *categoryArray = [[[DataArray objectAtIndex:0]valueForKey:@"Category"] componentsSeparatedByString:@","];
            
            for (int i = 0; i < [categoryArray count]; i ++)
            {
                NSUInteger categoryrow = [titleArray indexOfObject:[categoryArray objectAtIndex:i]];
                NSIndexPath *indexpath1 = [NSIndexPath indexPathForRow:categoryrow inSection:0];
                [cellSelected addObject:indexpath1];
            }
            
            
            NSUInteger emiriterow = [emiritesArray indexOfObject:[[DataArray objectAtIndex:0] valueForKey:@"Emirate"]];
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:emiriterow inSection:0];
            [cellSelectedEM addObject:indexpath];
            
            _areaString=[NSString stringWithFormat:@"%@",[[DataArray objectAtIndex:0] valueForKey:@"Area"]];
        }
        else
        {
        }
        
        [emiritaestablevie reloadData];
        [offerstablevie reloadData];
        [AreaTableView reloadData];
        
                 }
    @catch (NSException *exception) {
          }
    [getPrefalert dismissWithClickedButtonIndex:0 animated:YES];

    
    
    //    //Added by Ajinkya for mainataining status even after closing app
    //    NSUserDefaults *UD=[NSUserDefaults standardUserDefaults];
    //    if ([UD objectForKey:@"SelectedPreferrences"])
    //    {
    //        NSData *data =[UD objectForKey:@"SelectedPreferrences"];
    //        cellSelected = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    //    }
    //
    //    if ([UD objectForKey:@"SelectedPreferrencesArea"])
    //        _areaString=[UD objectForKey:@"SelectedPreferrencesArea"];
    //    else
    //        _areaString=@"All";
    //
    //
    //    NSUserDefaults *UD1=[NSUserDefaults standardUserDefaults];
    //    if ([UD1 objectForKey:@"SelectedPreferrencesEM"])
    //    {
    //        NSData *data1 =[UD1 objectForKey:@"SelectedPreferrencesEM"];
    //        cellSelectedEM = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    //    }
}

#pragma mark - TableView delegate and datasource methods
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 2)
        return titleArray.count;
    else if (tableView.tag == 4)
        return emiritesArray.count;
    else
        return 1;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Cell isn't selected so return single height
    if(UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPhone)
        return 43;
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
    
    if (tableView.tag == 2)
        cell.textLabel.text=[titleArray objectAtIndex:indexPath.row];
    else if (tableView.tag == 4)
        cell.textLabel.text=[emiritesArray objectAtIndex:indexPath.row];
    else
        cell.textLabel.text=[_areaString stringByReplacingOccurrencesOfString:@"," withString:@", "];
    
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        cell.textLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:16];
    else
        cell.textLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:26];
    
    if (indexPath.row== [self tableView:tableView numberOfRowsInSection:0]-1)
    {
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 42, 320, 1)];
            
            [line setBackgroundColor:[UIColor lightGrayColor]];//[UIColor colorWithRed:10 green:10 blue:10 alpha:1]];
            
            [cell.contentView addSubview:line];
            
        }
        else
        {
            UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 75, 768, 1)];
            
            [line setBackgroundColor:[UIColor lightGrayColor ]];//[UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:0.7f]];
            
            [cell.contentView addSubview:line];
            
        }
        
    }    cell.textLabel.textColor= [UIColor blackColor];
    
    if (tableView.tag == 2)
    {
        if ([cellSelected containsObject:indexPath])
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    else if (tableView.tag == 4)
    {
        if ([cellSelectedEM containsObject:indexPath])
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            _emiratesString=[_emiratesString stringByAppendingString:[NSString stringWithFormat:@"%@,",cell.textLabel.text]];

        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            _emiratesString=[_emiratesString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@,",cell.textLabel.text] withString:@""];
        }
    }
    else if (tableView.tag == 6)
    {
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
    
}



- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //if you want only one cell to be selected use a local NSIndexPath property instead of array. and use the code below
    //self.selectedIndexPath = indexPath;
    
    NSUserDefaults *UserDefault= [NSUserDefaults standardUserDefaults];
    
    if (tableView.tag == 2)
    {
        //the below code will allow multiple selection
        if ([cellSelected containsObject:indexPath])
        {
            [cellSelected removeObject:indexPath];
        }
        else
        {
            [cellSelected addObject:indexPath];
        }
    }
    else if (tableView.tag == 4)
    {
        if ([cellSelectedEM containsObject:indexPath])
        {
            _areaString=@"All";
            [AreaTableView reloadData];
            [UserDefault removeObjectForKey:@"PreferencesAreas"];
        
            [cellSelectedEM removeAllObjects];
            //[cellSelectedEM addObject:indexPath];
        }
        else
        {
            [cellSelectedEM removeAllObjects];
            [cellSelectedEM addObject:indexPath];
            [UserDefault removeObjectForKey:@"PreferencesAreas"];
            _areaString=@"All";
            [AreaTableView reloadData];
        }
    }
    else if (tableView.tag==6)
    {
        FilterThemeController *theme=[[FilterThemeController alloc]init];
        theme.tableFor=@"PreferencesAreas";
        
        if ([_areaString length]>2)
            theme.DataString=[_areaString stringByAppendingString:@","];
        else
            theme.DataString=[_areaString stringByAppendingString:@"All,"];

        if ([[_emiratesString componentsSeparatedByString:@","] count]>1)
        {
            NSMutableArray *tempArr=(NSMutableArray*)[_emiratesString componentsSeparatedByString:@","];
            [tempArr removeLastObject];
            
            NSMutableArray *areaarr=[[NSMutableArray alloc]init];
            
            for (NSString *emirate in tempArr)
            {
                [areaarr addObjectsFromArray:[dictLocations objectForKey:emirate]];
            }
            
            theme.titleArray=(NSArray*)areaarr;
        }
        theme.TopText=@"Areas";
        [self.navigationController pushViewController:theme animated:YES];
    }
    
    //Added by Ajinkya for mainataining status even after closing app

    
    if (tableView.tag == 2)
    {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cellSelected];
        [UserDefault setObject:data forKey:@"SelectedPreferrences"];
    }
    else
    {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cellSelectedEM];
        [UserDefault setObject:data forKey:@"SelectedPreferrencesEM"];
    }
    
    [tableView reloadData];
}



- (void) filterBtns: (id) sender
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
