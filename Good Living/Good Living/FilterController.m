//
//  FilterController.m
//  Good Living
//
//  Created by NanoStuffs on 15/09/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import "FilterController.h"
#import "Customcell.h"
#import "FilterThemeController.h"
#import "SelectedThemesController.h"
@interface FilterController ()
{
    NSMutableDictionary *dictLocations,*dictThemesCatogories;
    NSMutableArray *arrLocations;
    NSArray *arrCatogories,*emiritsArray,*arrCuisine;
    UIView *emiritsBackView;
    Customcell *currentCell;
}
@end


@implementation FilterController

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
    
    delegate = [[UIApplication sharedApplication] delegate];
    
    //Added by ajinkya
    
    //Filter_Applied
    if (_themeString && delegate.userID)
    {
        [Flurry logEvent:[NSString stringWithFormat:@"Filter - %@",_themeString]];
        [Flurry logPageView];
        
        self.screenName = [NSString stringWithFormat:@"Filter - %@",_themeString];
    }

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
    
    dictThemesCatogories=[[NSMutableDictionary alloc]init];
    
    arrCatogories=@[@"All",@"Premium Restaurants",@"Premium Bars and Nightclubs",@"Premium Confectionary"];
    [dictThemesCatogories setObject:arrCatogories forKey:@"Fine Dining"];
    
    arrCatogories=@[@"All",@"Fast Food",@"Cafes",@"Restaurants",@"Confectionary",@"Bars and Nightclubs",@"Health Food"];
    [dictThemesCatogories setObject:arrCatogories forKey:@"Casual Dining"];
    
    arrCatogories=@[@"All",@"Apparel",@"Shoes – Bags – Accessories",@"Books and Stationery",@"Beauty Products",@"Electronics",@"Gifts and Flowers",@"misc"];
    [dictThemesCatogories setObject:arrCatogories forKey:@"Shopping"];
    
    arrCatogories=@[@"All",@"Safaris and Cruises",@"Limo and Yacht Rental services",@"Sports",@"hobbies",@"Theme parks"];
    [dictThemesCatogories setObject:arrCatogories forKey:@"Adventure and Leisure"];
    
    arrCatogories=@[@"All",@"Gym",@"Yoga",@"Alternate Fitness"];
    [dictThemesCatogories setObject:arrCatogories forKey:@"Health and Fitness"];
    
    arrCatogories=@[@"All",@"Salon",@"Spa",@"Wellness Centre"];
    [dictThemesCatogories setObject:arrCatogories forKey:@"Beauty and Wellness"];
    
    arrCatogories=@[@"All",@"Party",@"Grooming",@"Play Area",@"Hobby and Learning",@"Toys"];
    [dictThemesCatogories setObject:arrCatogories forKey:@"Children"];
    
    arrCatogories=@[@"All",@"Furniture and Accessories",@"Home Appliances",@"Garden and Landscaping"];
    [dictThemesCatogories setObject:arrCatogories forKey:@"Home and Garden"];
    
    arrCatogories=@[@"All",@"Maintenance and Repairs",@"Laundry",@"Cleaning",@"House Help",@"Tailoring",@"Pets",@"Visa"];
    [dictThemesCatogories setObject:arrCatogories forKey:@"Services"];
    
    arrCuisine=@[@"All",@"Afghani",@"African",@"American",@"Arabic",@"Argentinean",@"Asian",@"Australian",@"Bar Food",@"Brazilian",@"Cafes",@"Cakes & Desserts",@"Chinese",@"Continental",@"Cuban",@"Dim Sum",@"English",@"European",@"Far Eastern",@"Fast Food",@"Filipino",@"French",@"Fusion",@"German",@"Greek",@"Indian",@"Indonesian",@"Intercontinental",@"Internationl",@"Iranian",@"Irish",@"Italian",@"Japanese",@"Korean",@"Lebanese",@"Mediterranean",@"Mexican",@"Moroccan",@"Others",@"Pakistani",@"Persian",@"Pizzas",@"Portuguese",@"Russian",@"Seafood",@"South American",@"Spanish",@"Steakhouse",@"Sushi",@"Swedish",@"Tex-Mex",@"Thai",@"Turkish",@"Vegetarian",@"Vietnamese"];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    x_ratio = screenRect.size.width/320;
    y_ratio = screenRect.size.height/568;
 
    
    self.view.backgroundColor=[UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:1.0f];
    //------------------------Navigation Bar
    UIImageView *navigationImage = [[UIImageView alloc] init];
    navigationImage.backgroundColor = [UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f];
    [self.view addSubview:navigationImage];

    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:@"Cancel" forState:UIControlStateNormal];

    [backButton addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:backButton];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setTitle:@"Submit" forState:UIControlStateNormal];    [submitButton addTarget:self action:@selector(SubmitMethod) forControlEvents:UIControlEventTouchUpInside];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:submitButton];
    

    UILabel *topLable = [[UILabel alloc] init];
    topLable.text = @"Filter";

    topLable.textAlignment = NSTextAlignmentCenter;
    topLable.textColor = [UIColor whiteColor];
    topLable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topLable];

    titleArray=[[NSMutableArray alloc]initWithObjects:@"Emirate" ,@"Theme",@"Category",@"Area",@"Cuisine", nil];
    subTitleArray=[[NSMutableArray alloc]initWithObjects:@" " ,@"  ",@"All",@"All",@"All", nil];
    swipeGestureLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedScreenLeft:)];
    //swipeGestureLeft.delegate=self;
    swipeGestureLeft.numberOfTouchesRequired = 1;
    swipeGestureLeft.direction = (UISwipeGestureRecognizerDirectionRight);
    [self.view addGestureRecognizer:swipeGestureLeft];
    
    
    UILabel *filter=[[UILabel alloc]init];
    filter.text=@"SEARCH FILTERS";
    filter.textColor=[UIColor darkGrayColor];

    [self.view addSubview:filter];
    
    UILabel *descriptionDetails=[[UILabel alloc]init];
    descriptionDetails.text=@"Description and instruction for items listed above this.";
    descriptionDetails.numberOfLines=2;
    descriptionDetails.textColor=[UIColor darkGrayColor];
//
   // [self.view addSubview:descriptionDetails];
    
    //-------------------OffersTableview
    offerstablevie = [[UITableView alloc] init];
    offerstablevie.delegate = self;
    offerstablevie.dataSource = self;
    offerstablevie.tag = 2;
    offerstablevie.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
    
    
    offerstablevie.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    offerstablevie.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    offerstablevie.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:offerstablevie];

    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        navigationImage.frame = CGRectMake(0, 0, 320 , 64  );
        backButton.titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:18];
        
        submitButton.titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:18];
        submitButton.frame = CGRectMake(230 ,27  , 100 , 30  );
        backButton.frame = CGRectMake(0, 27  , 100 , 30  );
        
        
        topLable.frame = CGRectMake(0, 27  , 320 , 30  );
        topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
        filter.font=[UIFont fontWithName:@"Helvetica Neue" size:15];
        filter.frame=CGRectMake(5 ,90  , 160 ,30  );
        descriptionDetails.font=[UIFont fontWithName:@"Helvetica Neue" size:15];
        descriptionDetails.frame=CGRectMake(5 ,290  , 300 ,60  );
        if ([_themeString isEqualToString:@"Fine Dining"] == TRUE || [_themeString isEqualToString:@"Casual Dining"] == TRUE)
            offerstablevie.frame = CGRectMake(0, 120  , 320 ,200  );
        else
            offerstablevie.frame = CGRectMake(0, 120  , 320 ,160  );

    }
    else
    {
        navigationImage.frame = CGRectMake(0, 0, 768, 64);
     
        topLable.frame = CGRectMake(0, 25, 768, 30);
        
        navigationImage.frame = CGRectMake(0, 0, 768 , 64  );
        backButton.titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:26];
        
        submitButton.titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:26];
        submitButton.frame = CGRectMake(650 ,27  , 100 , 30  );
        backButton.frame = CGRectMake(10, 27  , 100 , 30  );
        topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:26];
        filter.font=[UIFont fontWithName:@"Helvetica Neue" size:26];
        filter.frame=CGRectMake(10 ,160  , 300 ,30  );
        descriptionDetails.font=[UIFont fontWithName:@"Helvetica Neue" size:26];
        descriptionDetails.frame=CGRectMake(10 ,600  , 700 ,60  );
        if ([_themeString isEqualToString:@"Fine Dining"] == TRUE || [_themeString isEqualToString:@"Casual Dining"] == TRUE)
            offerstablevie.frame = CGRectMake(10, 200  , 748 ,380 );
        else
            offerstablevie.frame = CGRectMake(10, 200  , 748 ,304 );
    }
	// Do any additional setup after loading the view.
    
    if ([_themeString isEqualToString:@"Casual Dining"] == TRUE)
    {
        navigationImage.backgroundColor = [UIColor colorWithRed:249/255.0f green:210/255.0f blue:20/255.0f alpha:1.0f];
    }
    else if([_themeString isEqualToString:@"Shopping"] == TRUE)
    {
        navigationImage.backgroundColor = [UIColor colorWithRed:174/255.0f green:28/255.0f blue:89/255.0f alpha:1.0f];
    }
    else if([_themeString isEqualToString:@"Fine Dining"] == TRUE)
    {
        navigationImage.backgroundColor = [UIColor colorWithRed:240/255.0f green:90/255.0f blue:34/255.0f alpha:1.0f];
    }
    else if([_themeString isEqualToString:@"Home & Garden"] == TRUE)
    {
        navigationImage.backgroundColor = [UIColor colorWithRed:141/255.0f green:198/255.0f blue:63/255.0f alpha:1.0f];
    }
    else if([_themeString isEqualToString:@"Children"] == TRUE)
    {
        navigationImage.backgroundColor = [UIColor colorWithRed:0/255.0f green:173/255.0f blue:239/255.0f alpha:1.0f];
    }
    else if([_themeString isEqualToString:@"Beauty & Wellness"] == TRUE)
    {
        navigationImage.backgroundColor = [UIColor colorWithRed:212/255.0f green:108/255.0f blue:171/255.0f alpha:1.0f];
    }
    else if([_themeString isEqualToString:@"Health & Fitness"] == TRUE)
    {
        navigationImage.backgroundColor = [UIColor colorWithRed:108/255.0f green:200/255.0f blue:190/255.0f alpha:1.0f];
    }
    else if([_themeString isEqualToString:@"Services"] == TRUE)
    {
        navigationImage.backgroundColor = [UIColor colorWithRed:39/255.0f green:30/255.0f blue:83/255.0f alpha:1.0f];
    }
    else
    {
        navigationImage.backgroundColor = [UIColor colorWithRed:163.0f/255.0f green:79.0f/255.0f blue:37.0f/255.0f alpha:1.0f];
    }

}

-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *UD=[NSUserDefaults standardUserDefaults ];
    
    if ([UD objectForKey:@"FilterSubTitleArray"])
    {
        subTitleArray=[UD objectForKey:@"FilterSubTitleArray"];
    }
    

    [offerstablevie reloadData];
}

#pragma mark - TableView delegate and datasource methods
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if ([_themeString isEqualToString:@"Fine Dining"] == TRUE || [_themeString isEqualToString:@"Casual Dining"] == TRUE)
        return titleArray.count;


    return titleArray.count-1;
   
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    // Cell isn't selected so return single height
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        return 40  ;
    }
    else
    {
        return 76;
    }
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    Customcell *cell =(Customcell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[Customcell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
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

    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        cell.str.font=[UIFont fontWithName:@"Helvetica Neue" size:16];
        cell.str1.font=[UIFont fontWithName:@"Helvetica Neue" size:17];
    }
    else{
        cell.str.font=[UIFont fontWithName:@"Helvetica Neue" size:26];
        cell.str1.font=[UIFont fontWithName:@"Helvetica Neue" size:26];
    }
  
    cell.str.text=[titleArray objectAtIndex:indexPath.row];

    cell.str.textColor= [UIColor blackColor];
    

    switch (indexPath.row)
    {
        case 0:
            cell.str1.text=_emiratesString;
            break;
            
        case 1:
            if ([_themeString length]>0)
                cell.str1.text=_themeString;
            else
                _themeString=cell.str1.text=[subTitleArray objectAtIndex:indexPath.row];
            break;
        case 2:
            if ([_catagoryString length]>0)
            {
                if ([_catagoryString rangeOfString:@"All"].location!=NSNotFound)
                    _catagoryString=cell.str1.text=@"All";
                else
                    cell.str1.text=_catagoryString;
            }
            else
            {
                if ([[subTitleArray objectAtIndex:indexPath.row] rangeOfString:@"All"].location!=NSNotFound)
                {
                    cell.str1.text=@"All";
                    _catagoryString=[subTitleArray objectAtIndex:indexPath.row];
                }
                else
                    _catagoryString=cell.str1.text=[subTitleArray objectAtIndex:indexPath.row];
            }
            break;

        case 3:
            if ([_areaString length]>0)
            {
                if ([_areaString rangeOfString:@"All"].location!=NSNotFound)
                    cell.str1.text=@"All";
                else
                    cell.str1.text=_areaString;
            }

            else
            {
                if ([[subTitleArray objectAtIndex:indexPath.row] rangeOfString:@"All"].location!=NSNotFound)
                {
                    cell.str1.text=@"All";
                _areaString=[subTitleArray objectAtIndex:indexPath.row];
                }
                else
                    _areaString=cell.str1.text=[subTitleArray objectAtIndex:indexPath.row];
            }
            break;
            
            case 4:
            if ([_CuisineStrimg length]>0)
            {
                if ([_CuisineStrimg rangeOfString:@"All"].location!=NSNotFound)
                    cell.str1.text=@"All";
                else
                    cell.str1.text=_CuisineStrimg;
            }
            
            else
            {
                if ([[subTitleArray objectAtIndex:indexPath.row] rangeOfString:@"All"].location!=NSNotFound)
                {
                    cell.str1.text=@"All";
                    _CuisineStrimg=[subTitleArray objectAtIndex:indexPath.row];
                }
                else
                    _CuisineStrimg=cell.str1.text=[subTitleArray objectAtIndex:indexPath.row];
            }

            break;
        default:
            break;
    }
    cell.str1.textColor= [UIColor grayColor];
    if(indexPath.row==1)
    {
        cell.str1.textColor=[UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.3f];
        cell.str.textColor=[UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.3f];
        cell.userInteractionEnabled=NO;
    }
    else
    {
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }

    return cell;
}


-(void)btnSelected:(id)sender
{
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    currentCell=(Customcell*)[tableView cellForRowAtIndexPath:indexPath];
    
    FilterThemeController *theme=[[FilterThemeController alloc]init];
    
    theme.themeString=_themeString;
    NSString *key= [_themeString stringByReplacingOccurrencesOfString:@"&" withString:@"and"];
    switch (indexPath.row)
    {
        case 0:
            [self emitareMethod:nil];
            return;
            break;
            
        case 1:
            [tableView deselectRowAtIndexPath:indexPath animated:NO];
            return;
            theme.tableFor=@"themes";
            theme.titleArray=[dictThemesCatogories allKeys];
            break;
            
        case 2:
            theme.tableFor=@"catagories";
            theme.DataString=[_catagoryString stringByAppendingString:@","];
           // theme.titleArray=[dictThemesCatogories objectForKey:_themeString];
            
            theme.titleArray=[dictThemesCatogories objectForKey:key];
            
          //  theme.titleArray=[dictThemesCatogories objectForKey:key];
            
            break;
        case 3:
            theme.tableFor=@"areas";
            theme.DataString=[_areaString stringByAppendingString:@","];
            theme.titleArray=[dictLocations objectForKey:_emiratesString];
            break;
        case 4:
            theme.tableFor=@"Cuisine";
            theme.DataString=[_CuisineStrimg stringByAppendingString:@","];
            theme.titleArray=arrCuisine;
            break;

            
        default:
            break;
    }
    [self.navigationController pushViewController:theme animated:YES];
    
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
    NSUserDefaults *UserDefault= [NSUserDefaults standardUserDefaults];
    subTitleArray=[NSMutableArray arrayWithObjects:_emiratesString,_themeString,_catagoryString,_areaString,_CuisineStrimg, nil];
    [UserDefault setObject:subTitleArray forKey:@"FilterSubTitleArray"];
    
    NSInteger numberOfViewControllers = self.navigationController.viewControllers.count;
    SelectedThemesController *obj=[self.navigationController.viewControllers objectAtIndex:numberOfViewControllers - 2];
    obj.emirateString=_emiratesString;
    obj.IsFromSubmitBtn=YES;
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

- (void) emitareMethod : (id) sender
{
    emiritsArray = [[NSArray alloc] init];
    emiritsArray=@[@"Abu Dhabi",@"Dubai",@"Northern Emirates",@"Sharjah"];

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
        myPickerView.frame=CGRectMake(35 , 230 , emiritsviewLocal.frame.size.width, 162 );
        
        
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
    
    
    _emiratesString=currentCell.str1.text=[NSString stringWithFormat:@"%@",[emiritsArray objectAtIndex:[pickerView selectedRowInComponent:0]]];
    _areaString=@"All";
    
    NSUserDefaults *UD=[NSUserDefaults standardUserDefaults];
    
    [UD removeObjectForKey:@"SelectedAreas"];
    
    [UD synchronize];
    
    [myPickerView removeFromSuperview];
    [emiritsBackView removeFromSuperview];
    [offerstablevie reloadData];
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
