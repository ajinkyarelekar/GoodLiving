
 //
//  FilterThemeController.m
//  Good Living
//
//  Created by Minakshi on 9/19/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import "FilterThemeController.h"
#import "Customcell.h"
#import "FilterController.h"

@interface FilterThemeController ()
@end

@implementation FilterThemeController

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
//    DataString=[[NSString alloc]init];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    x_ratio = screenRect.size.width/320;
    y_ratio = screenRect.size.height/568;
    
    self.view.backgroundColor=[UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:1.0f];
    //------------------------Navigation Bar
    UIImageView *navigationImage = [[UIImageView alloc] init];
    navigationImage.backgroundColor = [UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f];
    [self.view addSubview:navigationImage];
    navigationImage.frame = CGRectMake(0, 0, 320, 64);
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    backButton.frame = CGRectMake(5,25, 35, 35);
    
    UILabel *filterLable = [[UILabel alloc] init];
    filterLable.text = @"Filter";
    filterLable.frame = CGRectMake(6, 27, 100, 30);
    filterLable.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
    filterLable.textAlignment = NSTextAlignmentCenter;
    filterLable.textColor = [UIColor whiteColor];
    filterLable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:filterLable];
    
    UILabel *topLable = [[UILabel alloc] init];
    topLable.text = [_TopText  length] > 0 ? _TopText : @"Theme";
    //topLable.text=[_tableFor isEqualToString:@"areas"] ? @"Area" : @"Catagories";
    topLable.frame = CGRectMake(0, 27, 320, 30);
    topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
    topLable.textAlignment = NSTextAlignmentCenter;
    topLable.textColor = [UIColor whiteColor];
    topLable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topLable];
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        navigationImage.frame = CGRectMake(0, 0, 768, 64);
        
        topLable.frame = CGRectMake(0, 25, 768, 30);
        topLable.font=[UIFont fontWithName:@"Helvetica Neue" size:26];
        
        navigationImage.frame = CGRectMake(0, 0, 768 , 64  );
        backButton.titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:26];
        
        backButton.frame = CGRectMake(5, 22  , 35 , 35  );
        filterLable.font=[UIFont fontWithName:@"Helvetica Neue" size:26];
        filterLable.frame=CGRectMake(15 ,25  , 100 ,30  );
    }

    
//    _titleArray=[[NSMutableArray alloc]initWithObjects:@"Casual Dining" ,@"Shopping",@"Fine Dining",@"Beauty & Wellness",@"Home & Garden" ,@"Health & Fitness",@"Children",@"Adventure & Leisure",@"Services", nil];
 
    //-------------------FilterThemeController
    filterThemeTable = [[UITableView alloc] init];
    filterThemeTable.delegate = self;
    filterThemeTable.dataSource = self;
    filterThemeTable.tag = 2;
   
    filterThemeTable.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
    filterThemeTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    filterThemeTable.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    filterThemeTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
      [self.view addSubview:filterThemeTable];
    filterThemeTable.frame = CGRectMake(0, 64, 320,520);
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        filterThemeTable.frame = CGRectMake(0, 64, 768,self.view.frame.size.height-64);

    
        cellSelected = [NSMutableArray array];
    
//    NSIndexPath *pathForAll=[NSIndexPath indexPathForRow:0 inSection:1];
//    
//    [cellSelected addObject:pathForAll];
    
    //Added by Ajinkya for mainataining status even after closing app
    NSUserDefaults *UD=[NSUserDefaults standardUserDefaults ];
    
    if ([_tableFor isEqualToString:@"catagories"])
    {
        if ([UD objectForKey:@"SelectedCatogories"])
        {
            NSData *data =[UD objectForKey:@"SelectedCatogories"];
            cellSelected=[NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
    }
    else if ([_tableFor isEqualToString:@"areas"])
    {
        if ([UD objectForKey:@"SelectedAreas"])
        {
            NSData *data =[UD objectForKey:@"SelectedAreas"];
            cellSelected=[NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
    }
//    else if ([_tableFor isEqualToString:@"PreferencesAreas"])
//    {
//        if ([UD objectForKey:@"PreferencesAreas"])
//        {
//            NSData *data =[UD objectForKey:@"PreferencesAreas"];
//            cellSelected=[NSKeyedUnarchiver unarchiveObjectWithData:data];
//        }
//    }
    else if ([_tableFor isEqualToString:@"Cuisine"])
    {
        if ([UD objectForKey:@"SelectedCuisine"])
        {
            NSData *data =[UD objectForKey:@"SelectedCuisine"];
            cellSelected=[NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
    }
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
//        navigationImage.backgroundColor = [UIColor colorWithRed:163.0f/255.0f green:79.0f/255.0f blue:37.0f/255.0f alpha:1.0f];
        navigationImage.backgroundColor = [UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f];
        [filterLable removeFromSuperview];

    }

}


#pragma mark - TableView delegate and datasource methods
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _titleArray.count;
    
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
 
    cell.textLabel.text=[_titleArray objectAtIndex:indexPath.row];
    cell.textLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:16];
    cell.textLabel.textColor= [UIColor blackColor];
    
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

    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        cell.textLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:26];
    }
    
    if ([cellSelected containsObject:indexPath]  || [_DataString rangeOfString:cell.textLabel.text].location!= NSNotFound)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    
    if (indexPath.row==0)
    {
        if ([_DataString rangeOfString:@"All"].location!= NSNotFound)
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            [cellSelected addObject:indexPath];
            ZeroIndexPath=indexPath;
        }
    }

    return cell;
    
}



- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{ if ([_tableFor isEqualToString:@"themes"])
{
    NSInteger numberOfViewControllers = self.navigationController.viewControllers.count;
    FilterController *obj=[self.navigationController.viewControllers objectAtIndex:numberOfViewControllers - 2];
    obj.themeString=[tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    obj.catagoryString=nil;
    
    [self.navigationController popViewControllerAnimated:YES];
    return;
}
    
    NSUserDefaults *UserDefault= [NSUserDefaults standardUserDefaults];
    
    if (indexPath.row==0)
    {
        [cellSelected removeAllObjects];
        [cellSelected addObject:indexPath];
        ZeroIndexPath=indexPath;
        _DataString=@"All,";
        [tableView reloadData];
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cellSelected];
        
        if ([_tableFor isEqualToString:@"catagories"])
            [UserDefault setObject:data forKey:@"SelectedCatogories"];
        else if ([_tableFor isEqualToString:@"areas"])
            [UserDefault setObject:data forKey:@"SelectedAreas"];
//        else if([_tableFor isEqualToString:@"PreferencesAreas"])
//            [UserDefault setObject:data forKey:@"PreferencesAreas"];
        else if ([_tableFor isEqualToString:@"Cuisine"])
            [UserDefault setObject:data forKey:@"SelectedCuisine"];
        return;
    }
    else
    {
        _DataString= [_DataString stringByReplacingOccurrencesOfString:@"All," withString:@""];
        
        [cellSelected removeObject:ZeroIndexPath];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //if you want only one cell to be selected use a local NSIndexPath property instead of array. and use the code below
    //self.selectedIndexPath = indexPath;
    
    //the below code will allow multiple selection
    if ([cellSelected containsObject:indexPath])
    {
        [cellSelected removeObject:indexPath];
        _DataString=[_DataString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@,",[tableView cellForRowAtIndexPath:indexPath].textLabel.text] withString:@""];
    }
    else
    {
        [cellSelected addObject:indexPath];
        _DataString=[_DataString stringByAppendingString:[NSString stringWithFormat:@"%@,",[tableView cellForRowAtIndexPath:indexPath].textLabel.text]];
    }
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cellSelected];
    
    if ([_tableFor isEqualToString:@"catagories"])
        [UserDefault setObject:data forKey:@"SelectedCatogories"];
    else if ([_tableFor isEqualToString:@"areas"])
        [UserDefault setObject:data forKey:@"SelectedAreas"];
//    else if([_tableFor isEqualToString:@"PreferencesAreas"])
//        [UserDefault setObject:data forKey:@"PreferencesAreas"];
    else if ([_tableFor isEqualToString:@"Cuisine"])
        [UserDefault setObject:data forKey:@"SelectedCuisine"];
    
    [tableView reloadData];}



- (void) filterBtns: (id) sender
{
    
}

-(void)backMethod
{
    NSInteger numberOfViewControllers = self.navigationController.viewControllers.count;
    FilterController *obj=[self.navigationController.viewControllers objectAtIndex:numberOfViewControllers - 2];
    
    if ([_DataString length]>0)
    {
        _DataString=[_DataString substringToIndex:[_DataString length]-1];
    }
    
    if ([_tableFor isEqualToString:@"catagories"])
        obj.catagoryString=_DataString;
    else if ([_tableFor isEqualToString:@"areas"] || [_tableFor isEqualToString:@"PreferencesAreas"])
        obj.areaString=_DataString;
    else if ([_tableFor isEqualToString:@"Cuisine"])
        obj.CuisineStrimg=_DataString;
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
