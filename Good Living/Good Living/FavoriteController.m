//
//  FavoriteController.m
//  Good Living
//
//  Created by Nanostuffs's Macbook on 28/09/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import "FavoriteController.h"
#import "globalURL.h"
#import "AppDelegate.h"
#import "OfferDetailsController.h"

@interface FavoriteController ()

@end

@implementation FavoriteController

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
    
    NSUserDefaults *UserDefault=[NSUserDefaults standardUserDefaults];
    NSData *data;
    
    data= [UserDefault valueForKey:@"fname"];
    
    NSString * name=[NSKeyedUnarchiver unarchiveObjectWithData:[UserDefault valueForKey:@"fname"]];
    
    name=[name stringByAppendingString:[NSString stringWithFormat:@" %@",[NSKeyedUnarchiver unarchiveObjectWithData:[UserDefault valueForKey:@"lname"]]]];
    
    //Favourites
    if (name && delegate.userID)
    {
        [Flurry logEvent:@"Favourities"];
        self.screenName = @"Favourities";
    }
    else
    {
        [Flurry logEvent:@"Favorities"];
        self.screenName = @"Favourities";

    }
    [Flurry logPageView];
    
    self.view.backgroundColor =  [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f];
    
    //------------------------Navigation Bar
    UIImageView *navigationImage = [[UIImageView alloc] init];
    navigationImage.backgroundColor = [UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f];
    [self.view addSubview:navigationImage];
    
    delegate = [[UIApplication sharedApplication] delegate];
    
    getOffer = [[UIAlertView alloc] initWithTitle:@"Please wait..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [getOffer show];
    [self performSelector:@selector(getFavoriteOffer) withObject:nil afterDelay:0.1];

    UILabel *topLable = [[UILabel alloc] init];
    topLable.text = @"Favourites";
    
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
        backButton.frame = CGRectMake(5, 25, 35, 35);
        topLable.frame = CGRectMake(0, 25, 320, 30);
        topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
    }
    else
    {
        navigationImage.frame = CGRectMake(0, 0, 768, 64);
        backButton.frame = CGRectMake(5,22, 35, 35);
        topLable.frame = CGRectMake(0, 25, 768, 30);
        topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:26];
    }

    //-------- MainScrollView
    
    mainScrollview = [[UIScrollView alloc] init];
    mainScrollview.delegate = self;
    [self.view addSubview:mainScrollview];
    
//    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
//    {
//        mainScrollview.frame = CGRectMake(0, 64, 320,self.view.frame.size.height-64);
//        mainScrollview.contentSize = CGSizeMake(320, 1500);//150 * row count
//        
//    }
//    
//    else
//    {
//        mainScrollview.frame = CGRectMake(0, 64, 768,self.view.frame.size.height-64);
//        mainScrollview.contentSize = CGSizeMake(768, 1500);//150 * row count
//    }
//
    
    UIImageView *lableBackimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 279, 320, 35)];
    lableBackimg.backgroundColor = [UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:1.0f];
    
   	// Do any additional setup after loading the view.
}
-(void) backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TableView delegate and datasource methods
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    if (tableView.tag == 501)
        return [LEFTtitleArray count];
    else if(tableView.tag == 502)
        return [RIGHTtitleArray count];
    else
        return [DataArray count];
    
    
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
         if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            return 125;
            
        }
        else
        {
            return 185;
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
    
   if (tableView.tag == 2)
    {
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 124, 320, 1)];
        
        [line setBackgroundColor:[UIColor orangeColor]];
        
        [cell.contentView addSubview:line];
      
         UIImageView *pofferimg = [[UIImageView alloc] initWithFrame:CGRectMake(8, 14, 93, 93)];
           pofferimg.image = [UIImage imageNamed:@"11_186X186.png"];
            [cell.contentView addSubview:pofferimg];
            
            UIActivityIndicatorView *activityview1 = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            activityview1.center = CGPointMake(pofferimg.bounds.size.width / 2,pofferimg.bounds.size.height /2);
            [activityview1 startAnimating];
            
            [pofferimg addSubview:activityview1];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                
                NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[favImages objectAtIndex:indexPath.row] ]]];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (imageData)
                    {
                        NSArray *subviewArray = [pofferimg subviews];
                        
                        for (UIView *view in subviewArray)
                        {
                            if([view isKindOfClass:[UIActivityIndicatorView class]])
                            {
                                UIActivityIndicatorView *activity = (UIActivityIndicatorView *)view;
                                [activity stopAnimating];
                                [activity removeFromSuperview];
                            }
                        }
                        
                        [pofferimg setImage:[UIImage imageWithData:imageData]];
                    }
                });
            });

            
            UILabel *offerTitlelabel = [[UILabel alloc] initWithFrame:CGRectMake(109, 12, 160, 40)];
            offerTitlelabel.text =[NSString stringWithFormat:@"%@",[favMerchantName objectAtIndex:indexPath.row] ];
            offerTitlelabel.textColor = [UIColor darkGrayColor];
            offerTitlelabel.backgroundColor = [UIColor clearColor];
            offerTitlelabel.font = [UIFont fontWithName:@"Helvetica Neue" size:17];
            offerTitlelabel.numberOfLines = 2;
            offerTitlelabel.lineBreakMode = NSLineBreakByWordWrapping;
            [cell.contentView addSubview:offerTitlelabel];
            
            UILabel *countrylabel = [[UILabel alloc] initWithFrame:CGRectMake(255, 20, 50, 15)];
            countrylabel.text = @"Indian";
            countrylabel.textAlignment = NSTextAlignmentRight;
            countrylabel.textColor = [UIColor lightGrayColor];
            countrylabel.backgroundColor = [UIColor clearColor];
            countrylabel.font = [UIFont fontWithName:@"Helvetica Neue" size:10];
            countrylabel.font = [UIFont boldSystemFontOfSize:12];
           // [cell.contentView addSubview:countrylabel];
            
            
            UILabel *discountlabel = [[UILabel alloc] initWithFrame:CGRectMake(109, 48, 170, 30)];
            discountlabel.text = [NSString stringWithFormat:@"%@",[favTitles objectAtIndex:indexPath.row]];
            discountlabel.textColor = [UIColor colorWithRed:205/255.0f green:63/255.0f blue:59/255.0f alpha:1.0f];
            discountlabel.backgroundColor = [UIColor clearColor];
            discountlabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
            discountlabel.font = [UIFont boldSystemFontOfSize:12];
            [cell.contentView addSubview:discountlabel];
            
//            UIImageView *mapimg = [[UIImageView alloc] initWithFrame:CGRectMake(109, 75, 17, 17)];
//            mapimg.image = [UIImage imageNamed:@"map.png"];
//            [cell.contentView addSubview:mapimg];
//            
//            UILabel *distancelabel = [[UILabel alloc] initWithFrame:CGRectMake(129, 75, 170, 15)];
//            distancelabel.text = @"Al Barsha . Less than 2 Kms";
//            distancelabel.textColor = [UIColor grayColor];
//            distancelabel.backgroundColor = [UIColor clearColor];
//            distancelabel.font = [UIFont fontWithName:@"Helvetica Neue" size:10];
//            distancelabel.font = [UIFont boldSystemFontOfSize:12];
//            [cell.contentView addSubview:distancelabel];
        
            UIImageView *viewsimg = [[UIImageView alloc] initWithFrame:CGRectMake(109, 95, 17, 17)];
            viewsimg.image = [UIImage imageNamed:@"view.png"];
            //        [cell.contentView addSubview:viewsimg];
            
            UILabel *viewslabel = [[UILabel alloc] initWithFrame:CGRectMake(129, 95, 170, 15)];
            viewslabel.text = @"24 Views";
            viewslabel.textColor = [UIColor lightGrayColor];
            viewslabel.backgroundColor = [UIColor clearColor];
            viewslabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
            viewslabel.font = [UIFont boldSystemFontOfSize:12];
            //        [cell.contentView addSubview:viewslabel];
            
            UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(302, 50,17,17)];
            arrowImage.image = [UIImage imageNamed:@"nextarrow.png"];
            [cell.contentView addSubview:arrowImage];
            
            UIImageView *newOffer = [[UIImageView alloc] initWithFrame:CGRectMake(158, 100, 50, 18)];
            newOffer.image = [UIImage imageNamed:@"new.png"];
          //  [cell.contentView addSubview:newOffer];
            
            
            UIImageView *premiumoffer = [[UIImageView alloc] initWithFrame:CGRectMake(215, 100, 92, 18)];
            premiumoffer.image = [UIImage imageNamed:@"premiumoffer.png"];
           // [cell.contentView addSubview:premiumoffer];
       
        UIButton *premiumButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [premiumButton setBackgroundImage:[UIImage imageNamed:@"premiumoffer1.png"] forState:UIControlStateNormal];
        [premiumButton setTitle:@"PREMIUM" forState:UIControlStateNormal];
        premiumButton.userInteractionEnabled = NO;
        [premiumButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        premiumButton.titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:12];
        premiumButton.frame=CGRectMake(215, 100, 92, 18);
        [cell.contentView addSubview:premiumButton];
        
        UIButton *newButton=[UIButton buttonWithType:UIButtonTypeCustom];
               newButton.frame=CGRectMake(158, 100, 50, 18);
        
        [newButton setBackgroundImage:[UIImage imageNamed:@"new1.png"] forState:UIControlStateNormal];
        [newButton setTitle:@"NEW" forState:UIControlStateNormal];
        newButton.userInteractionEnabled = NO;
        [newButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        newButton.titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:12];
        [cell.contentView addSubview:newButton];
    }
    
   else if (tableView.tag == 501)
   {
       
       UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 170)];
//       img.backgroundColor =[UIColor whiteColor];
       [cell.contentView addSubview:img];
       
       UIImageView *pofferimg = [[UIImageView alloc] initWithFrame:CGRectMake(8, 20, 120, 120)];
      // pofferimg.image = [UIImage imageNamed:@"finediningimage1.png"];
       [cell.contentView addSubview:pofferimg];
       
       
       UIActivityIndicatorView *activityview1 = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
       activityview1.center = CGPointMake(pofferimg.bounds.size.width / 2,pofferimg.bounds.size.height /2);
       [activityview1 startAnimating];
       
       [pofferimg addSubview:activityview1];
       
       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
           
              NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[LEFTimagesArray objectAtIndex:indexPath.row] ]]];
           
           dispatch_async(dispatch_get_main_queue(), ^{
               
               if (imageData)
               {
                   NSArray *subviewArray = [pofferimg subviews];
                   
                   for (UIView *view in subviewArray)
                   {
                       if([view isKindOfClass:[UIActivityIndicatorView class]])
                       {
                           UIActivityIndicatorView *activity = (UIActivityIndicatorView *)view;
                           [activity stopAnimating];
                           [activity removeFromSuperview];
                       }
                   }
                   
                   [pofferimg setImage:[UIImage imageWithData:imageData]];
                   
                   
               }
           });
       });

       
       UILabel *offerTitlelabel =  [[UILabel alloc] initWithFrame:CGRectMake(135, 18, 170, 50)];
       offerTitlelabel.text = [NSString stringWithFormat:@"%@",[LEFTsubtitleArray objectAtIndex:indexPath.row] ];
       
       offerTitlelabel.textColor = [UIColor darkGrayColor];
       offerTitlelabel.backgroundColor = [UIColor clearColor];
       offerTitlelabel.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
       offerTitlelabel.numberOfLines = 2;
       offerTitlelabel.lineBreakMode = NSLineBreakByWordWrapping;
       [cell.contentView addSubview:offerTitlelabel];
       
       UILabel *countrylabel = [[UILabel alloc] initWithFrame:CGRectMake(285, 28, 60, 15)];
       countrylabel.text = @"Indian";
       countrylabel.textAlignment = NSTextAlignmentRight;
       countrylabel.textColor = [UIColor lightGrayColor];
       countrylabel.backgroundColor = [UIColor clearColor];
       countrylabel.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
       countrylabel.font = [UIFont boldSystemFontOfSize:12];
    //   [cell.contentView addSubview:countrylabel];
       
       
       UILabel *discountlabel = [[UILabel alloc] initWithFrame:CGRectMake(139, 67, 180, 30)];
       discountlabel.font = [UIFont fontWithName:@"Helvetica Neue" size:10];
       discountlabel.numberOfLines = 2;
       discountlabel.lineBreakMode = NSLineBreakByWordWrapping;
       
       // UILabel *discountlabel = [[UILabel alloc] initWithFrame:CGRectMake(139, 77, 180, 20)];
       discountlabel.text = [NSString stringWithFormat:@"%@",[LEFTtitleArray objectAtIndex:indexPath.row]];
       discountlabel.textColor = [UIColor colorWithRed:205/255.0f green:63/255.0f blue:59/255.0f alpha:1.0f];
       discountlabel.backgroundColor = [UIColor clearColor];
       //discountlabel.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
       discountlabel.font = [UIFont boldSystemFontOfSize:10];
       [cell.contentView addSubview:discountlabel];
       
//       UILabel *distancelabel = [[UILabel alloc] initWithFrame:CGRectMake(159, 99, 180, 20)];
//       distancelabel.text = @"Al Barsha . Less than 2 Kms";
//       distancelabel.textColor = [UIColor grayColor];
//       distancelabel.backgroundColor = [UIColor clearColor];
//       distancelabel.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
//       distancelabel.font = [UIFont boldSystemFontOfSize:12];
//       [cell.contentView addSubview:distancelabel];
       
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
       
       UIImageView *newOffer = [[UIImageView alloc] initWithFrame:CGRectMake(190, 124, 54, 25)];
       newOffer.image = [UIImage imageNamed:@"new.png"];
      // [cell.contentView addSubview:newOffer];
       
       
       UIImageView *premiumoffer = [[UIImageView alloc] initWithFrame:CGRectMake(255, 124, 106, 25)];
       premiumoffer.image = [UIImage imageNamed:@"premiumoffer.png"];
      // [cell.contentView addSubview:premiumoffer];
       
       UIButton *premiumButton=[UIButton buttonWithType:UIButtonTypeCustom];
       [premiumButton setBackgroundImage:[UIImage imageNamed:@"premiumoffer1.png"] forState:UIControlStateNormal];
       [premiumButton setTitle:@"PREMIUM" forState:UIControlStateNormal];
       premiumButton.userInteractionEnabled = NO;
       [premiumButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       premiumButton.titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:16];
       premiumButton.frame=CGRectMake(255, 138, 106, 25);
       [cell.contentView addSubview:premiumButton];
       
       
       UIButton *newButton=[UIButton buttonWithType:UIButtonTypeCustom];
       newButton.frame=CGRectMake(190, 138, 54, 25);
       [newButton setBackgroundImage:[UIImage imageNamed:@"new1.png"] forState:UIControlStateNormal];
       [newButton setTitle:@"NEW" forState:UIControlStateNormal];
       newButton.userInteractionEnabled = NO;
       [newButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       newButton.titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:16];
       //            newButton.frame=CGRectMake(190, 138, 54, 25);
       [cell.contentView addSubview:newButton];


   
   }

   else if (tableView.tag == 502)
   {
       
       UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 170)];
//       img.backgroundColor =[UIColor whiteColor];
       [cell.contentView addSubview:img];
       
       UIImageView *pofferimg = [[UIImageView alloc] initWithFrame:CGRectMake(8, 20, 120, 120)];
       // pofferimg.image = [UIImage imageNamed:@"finediningimage1.png"];
       [cell.contentView addSubview:pofferimg];
       
       
       UIActivityIndicatorView *activityview1 = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
       activityview1.center = CGPointMake(pofferimg.bounds.size.width / 2,pofferimg.bounds.size.height /2);
       [activityview1 startAnimating];
       
       [pofferimg addSubview:activityview1];
       
       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
           
           NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[RIGHTimagesArray objectAtIndex:indexPath.row] ]]];
           
           dispatch_async(dispatch_get_main_queue(), ^{
               
               if (imageData)
               {
                   NSArray *subviewArray = [pofferimg subviews];
                   
                   for (UIView *view in subviewArray)
                   {
                       if([view isKindOfClass:[UIActivityIndicatorView class]])
                       {
                           UIActivityIndicatorView *activity = (UIActivityIndicatorView *)view;
                           [activity stopAnimating];
                           [activity removeFromSuperview];
                       }
                   }
                   
                   [pofferimg setImage:[UIImage imageWithData:imageData]];
                   
                   
               }
           });
       });
       
       
       //UILabel *offerTitlelabel = [[UILabel alloc] initWithFrame:CGRectMake(135, 18, 170, 50)];
     UILabel *offerTitlelabel =  [[UILabel alloc] initWithFrame:CGRectMake(135, 18, 170, 50)];
       offerTitlelabel.text = [NSString stringWithFormat:@"%@",[RIGHTsubtitleArray objectAtIndex:indexPath.row] ];
       
       offerTitlelabel.textColor = [UIColor darkGrayColor];
       offerTitlelabel.backgroundColor = [UIColor clearColor];
       offerTitlelabel.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
       offerTitlelabel.numberOfLines = 2;
       offerTitlelabel.lineBreakMode = NSLineBreakByWordWrapping;
       [cell.contentView addSubview:offerTitlelabel];
       
      UILabel *countrylabel = [[UILabel alloc] initWithFrame:CGRectMake(285, 28, 60, 15)];
       countrylabel.text = @"Indian";
       countrylabel.textAlignment = NSTextAlignmentRight;
       countrylabel.textColor = [UIColor lightGrayColor];
       countrylabel.backgroundColor = [UIColor clearColor];
       countrylabel.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
       countrylabel.font = [UIFont boldSystemFontOfSize:12];
      // [cell.contentView addSubview:countrylabel];
       
       
       UILabel *discountlabel = [[UILabel alloc] initWithFrame:CGRectMake(139, 67, 180, 30)];
       discountlabel.font = [UIFont fontWithName:@"Helvetica Neue" size:10];
       discountlabel.numberOfLines = 2;
       discountlabel.lineBreakMode = NSLineBreakByWordWrapping;
       
      // UILabel *discountlabel = [[UILabel alloc] initWithFrame:CGRectMake(139, 77, 180, 20)];
       discountlabel.text = [NSString stringWithFormat:@"%@",[RIGHTtitleArray objectAtIndex:indexPath.row]];
       discountlabel.textColor = [UIColor colorWithRed:205/255.0f green:63/255.0f blue:59/255.0f alpha:1.0f];
       discountlabel.backgroundColor = [UIColor clearColor];
       //discountlabel.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
       discountlabel.font = [UIFont boldSystemFontOfSize:10];
       [cell.contentView addSubview:discountlabel];
       
        UIImageView *mapimg = [[UIImageView alloc] initWithFrame:CGRectMake(139, 99, 20, 20)];
       mapimg.image = [UIImage imageNamed:@"map.png"];
     //  [cell.contentView addSubview:mapimg];
       
       
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
       
       UIImageView *newOffer = [[UIImageView alloc] initWithFrame:CGRectMake(190, 124, 54, 25)];
       newOffer.image = [UIImage imageNamed:@"new.png"];
      // [cell.contentView addSubview:newOffer];
       
       
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
       
       
       UIButton *newButton=[UIButton buttonWithType:UIButtonTypeCustom];
       newButton.frame=CGRectMake(190, 138, 54, 25);
       [newButton setBackgroundImage:[UIImage imageNamed:@"new1.png"] forState:UIControlStateNormal];
       [newButton setTitle:@"NEW" forState:UIControlStateNormal];
       newButton.userInteractionEnabled = NO;
       [newButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       newButton.titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:16];
       //            newButton.frame=CGRectMake(190, 138, 54, 25);
       [cell.contentView addSubview:newButton];

   
   }

    
    
    nameLable.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:nameLable];
    
    cell.backgroundColor = [UIColor clearColor];
    
    
    cell.tag = indexPath.row;
    UISwipeGestureRecognizer* recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [recognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [cell addGestureRecognizer:recognizer];
    
    return cell;
}


-(void)handleSwipe:(UISwipeGestureRecognizer *) sender
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:sender.view];
    [array addObject:[NSString stringWithFormat:@"%d",sender.view.tag]];
    
    [self performSelector:@selector(delayBtn:) withObject:array afterDelay:0.1];
}

- (void) delayBtn : (NSArray *) array
{
    [deletebtn removeFromSuperview];
    deletebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deletebtn.frame = CGRectMake(300, 56, 100, 30);
    deletebtn.tag = [[NSString stringWithFormat:@"%@",[array objectAtIndex:1]]intValue];
    deletebtn.layer.cornerRadius = 5.0f;
    deletebtn.backgroundColor = [UIColor colorWithRed:250.0f/255.0f green:165.0f/255.0f blue:25.0f/255.0f alpha:1.0f];
    [deletebtn setTitle:@"Delete" forState:UIControlStateNormal];
    [deletebtn addTarget:self action:@selector(DeleteMethod:) forControlEvents:UIControlEventTouchUpInside];
    [[array objectAtIndex:0] addSubview:deletebtn];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0f];
    [deletebtn setFrame:CGRectMake(200, 56, 100, 30)];
    [UIView commitAnimations];
}

- (void) DeleteMethod : (id) sender
{
    UIButton *btn = (UIButton *) sender;
    
    NSString *url = [NSString stringWithFormat:@"https://testws.goodliving.ae/api/index.php/offer/removeFavOffer/%@/%@",delegate.userID,[favID objectAtIndex:btn.tag]];
      url=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    
    NSHTTPURLResponse *response = nil;
    NSError *error = [[NSError alloc] init];
    NSData *data= [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    
    getOffer = [[UIAlertView alloc] initWithTitle:@"Please wait..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [getOffer show];
    [self performSelector:@selector(getFavoriteOffer) withObject:nil afterDelay:0.1];
}



- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    OfferDetailsController *objOfferDetailsController=[[OfferDetailsController alloc]init];
    
    switch (tableView.tag)
    {
        case 2:
            objOfferDetailsController.newestOfferID=[favID objectAtIndex:indexPath.row];
            break;
        case 501:
            objOfferDetailsController.newestOfferID=[favIDLeft objectAtIndex:indexPath.row];
            break;
        case 502:
            objOfferDetailsController.newestOfferID=[favIDRight objectAtIndex:indexPath.row];
            break;
            
        default:
            break;
}
    [self.navigationController pushViewController:objOfferDetailsController animated:YES];
}


-(void)getFavoriteOffer
{
    @try {
        NSString *url=FavoriteURl;
        if(delegate.userID!=nil)
            url=[url stringByAppendingString:delegate.userID];
        
        NSString *urlString =url;
        
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *Final_Url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",urlString]];
        
        NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:Final_Url];
        [request setValue:@"Basic Z2xvYnVzdXNlcjpHbDBidVMyMDE0" forHTTPHeaderField:@"Authorization"];
        
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        favID=[[NSMutableArray alloc]init];
        favImages=[[NSMutableArray alloc]init];
        favMerchantName=[[NSMutableArray alloc]init];
        favTitles=[[NSMutableArray alloc]init];
        dateAdded=[[NSMutableArray alloc]init];
        
        NSDictionary*json;
        if (data)
        {
            NSError* error;
            json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            DataArray = [json objectForKey:@"data"];
            NSLog(@"%d",DataArray.count);

            for (int i = 0; i < [DataArray count]; i++)
            {
                [favID addObject:[[DataArray objectAtIndex:i] valueForKey:@"Offer__c"]];
                [favImages addObject:[[DataArray objectAtIndex:i] valueForKey:@"Offer_Image_1__c"]];
                [favMerchantName addObject:[[DataArray objectAtIndex:i] valueForKey:@"Merchant_Name"]];
                [favTitles addObject:[[DataArray objectAtIndex:i] valueForKey:@"Title"]];
                [dateAdded addObject:[[DataArray objectAtIndex:i] valueForKey:@"DateAdded"]];
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
            favIDLeft=[NSMutableArray array];
            favIDRight=[NSMutableArray array];
            
            for (int i = 0; i < [DataArray count];i++)
            {
                if ((i%2) == 0)
                {
                    [LEFTtitleArray addObject:[favTitles  objectAtIndex:i]];
                    [LEFTsubtitleArray addObject:[favMerchantName objectAtIndex:i]];
                    [LEFTimagesArray addObject:[favImages objectAtIndex:i]];
                    [favIDLeft addObject:[favID objectAtIndex:i]];
                }
                else
                {
                    [RIGHTtitleArray addObject:[favTitles objectAtIndex:i]];
                    [RIGHTsubtitleArray addObject:[favMerchantName objectAtIndex:i]];
                    [RIGHTimagesArray addObject:[favImages  objectAtIndex:i]];
                    [favIDRight addObject:[favID objectAtIndex:i]];
                }
            }
        }
        
        
        [getOffer dismissWithClickedButtonIndex:0 animated:YES];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                [self displayFavoriteiPad];
                
            }
            else
            {
                [self displayFavorite];
            }
        });

           }
    @catch (NSException *exception) {
     
    }
   
    
}




-(void)displayFavorite
{
    //-------- MainScrollView
    
    
    mainScrollview = [[UIScrollView alloc] init];
    mainScrollview.delegate = self;
    [self.view addSubview:mainScrollview];
   
    mainScrollview.frame = CGRectMake(0, 64, 320,self.view.frame.size.height-64);
    mainScrollview.contentSize = CGSizeMake(320, 150*DataArray.count);//150 * row count
   
    offerstablevie = [[UITableView alloc] init];
    offerstablevie.delegate = self;
    offerstablevie.dataSource = self;
    offerstablevie.tag = 2;
    
    offerstablevie.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f];
    offerstablevie.separatorStyle = UITableViewCellSeparatorStyleNone;
 //   offerstablevie.separatorColor = [UIColor orangeColor];
    [mainScrollview addSubview:offerstablevie];
    offerstablevie.scrollEnabled = NO;
    offerstablevie.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    offerstablevie.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
   
    offerstablevie.frame = CGRectMake(0, 0, 320, 125*10);
    offerstablevie.contentSize = CGSizeMake(320, 125*10);

    if(DataArray.count == 0)
    {
        UILabel*  NoResults=[[UILabel alloc]initWithFrame:CGRectMake(10, 65, 300, 70)];
        
        NoResults.numberOfLines=5;
        NoResults.lineBreakMode=NSLineBreakByWordWrapping;
        NoResults.textAlignment = NSTextAlignmentCenter;
        [NoResults setFont:[UIFont fontWithName:@"Helvetica Neue" size:16]];
        NoResults.text=[NSString stringWithFormat:@"Select the ‘Star’ symbol under an offer to mark it as favourite and view / access it here."];
        [self.view addSubview:NoResults];
        //        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Select the ‘Star’ symbol under an offer to mark it as favourite and view / access it here." delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        //
        //        [alertView show];
    }
}

-(void)displayFavoriteiPad
{

    mainScrollview.frame = CGRectMake(0, 100, 768,self.view.frame.size.height-100);
    mainScrollview.contentSize = CGSizeMake(768, 185*(DataArray.count/2));//150 * row count
    //-------------------OffersTableview
    
    UIScrollView *tableView=[[UIScrollView alloc]init];
    tableView.frame=CGRectMake(0,2, 758, self.view.frame.size.height-64);
    tableView.contentSize=CGSizeMake(758, 185*(DataArray.count/2));
    
    offerstablevie2 = [[UITableView alloc] init];
    offerstablevie2.delegate = self;
    offerstablevie2.dataSource = self;
    offerstablevie2.tag = 501;
    offerstablevie2.backgroundColor =  [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f];
    offerstablevie2.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [mainScrollview addSubview:tableView];
    
    [tableView addSubview:offerstablevie2];
    
    offerstablevie2.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    offerstablevie2.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    offerstablevie2.scrollEnabled=NO;
    offerstablevie2.frame = CGRectMake(10, 0, 369, self.view.frame.size.height-64);
    offerstablevie2.contentSize = CGSizeMake(369, 185*(DataArray.count/2));
    //--------- Offers tableview iPad
    
    offerstablevie1 = [[UITableView alloc] init];
    offerstablevie1.delegate = self;
    offerstablevie1.dataSource = self;
    offerstablevie1.tag = 502;
    
    offerstablevie1.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f];
    offerstablevie1.separatorStyle = UITableViewCellSeparatorStyleNone;
    offerstablevie1.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    offerstablevie1.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    offerstablevie1.separatorStyle = UITableViewCellSeparatorStyleNone;
    offerstablevie1.separatorColor = [UIColor orangeColor];
    offerstablevie1.scrollEnabled=NO;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [tableView addSubview:offerstablevie1];
        offerstablevie1.frame = CGRectMake(389, 0, 369, 185*(DataArray.count/2));
        offerstablevie1.contentSize = CGSizeMake(369, 185*(DataArray.count/2));
        
    }

    if(DataArray.count == 0)
    {
        UILabel *NoResults=[[UILabel alloc]initWithFrame:CGRectMake(24, 65, 720, 90)];
        NoResults.numberOfLines=5;
        NoResults.lineBreakMode=NSLineBreakByWordWrapping;
                NoResults.textAlignment = NSTextAlignmentCenter;
        [NoResults setFont:[UIFont fontWithName:@"Helvetica Neue" size:20]];
        NoResults.text=[NSString stringWithFormat:@"Select the ‘Star’ symbol under an offer to mark it as favourite and view / access it here."];
        [self.view addSubview:NoResults];
        
        //        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Select the ‘Star’ symbol under an offer to mark it as favourite and view / access it here." delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        //
        //        [alertView show];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
