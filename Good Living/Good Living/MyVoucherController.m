//
//  MyVoucherController.m
//  Good Living
//
//  Created by NanoStuffs on 10/09/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import "MyVoucherController.h"
#import "LeadingViewController.h"
#import "MyAccountController.h"
#import "ViewController.h"
#import "myPurchaseController.h"
#import "ContactusController.h"
#import "aboutGoodLivingController.h"
#import "notificationController.h"
#import "globalURL.h"
#import "DownlaodVoucherController.h"
#import "OfferDetailsController.h"
#import "Flurry.h"

@interface MyVoucherController ()
{
    NSString *selectedtab;
}
@end

@implementation MyVoucherController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    delegate = [[UIApplication sharedApplication] delegate];
    
    self.view.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f];
    
    getMyVoucher = [[UIAlertView alloc] initWithTitle:@"Please wait..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [getMyVoucher show];
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        NoResults=[[UILabel alloc]initWithFrame:CGRectMake(self.view.center.x-100, 150, 200, 40)];
    else
        NoResults=[[UILabel alloc]initWithFrame:CGRectMake(174, 160, 480, 50)];
   // [self performSelector:@selector(getMyvoucher) withObject:nil afterDelay:0.1];

    
    //------------------------Navigation Bar
    UIImageView *navigationImage = [[UIImageView alloc] init];
    navigationImage.backgroundColor = [UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f];
    [self.view addSubview:navigationImage];
    
    UILabel *topLable = [[UILabel alloc] init];
    topLable.text = @"My Vouchers";

    topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
    topLable.textAlignment = NSTextAlignmentCenter;
    topLable.textColor = [UIColor whiteColor];
    topLable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topLable];
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    //-----------------------Searchbar
    
    searchBar = [[UISearchBar alloc]init ];
    [searchBar setDelegate:self];
    [searchBar setBarStyle:UIBarStyleDefault];
    [searchBar setKeyboardType:UIKeyboardTypeDefault];
    
    for (UIView *searchBarSubview in [searchBar subviews]) {
        
        if([searchBarSubview isKindOfClass:[UITextField class]]){
            UITextField *textField = (UITextField*)searchBarSubview;
            textField.leftView = nil;
        }
        
        if ([searchBarSubview conformsToProtocol:@protocol(UITextInputTraits)]) {
            [(UITextField *)searchBarSubview setReturnKeyType:UIReturnKeySend];
            [(UITextField *)searchBarSubview setKeyboardAppearance:UIKeyboardAppearanceAlert];
        }
    }
    
    searchBar.backgroundColor=[UIColor clearColor];
    searchBar.barTintColor =  [UIColor clearColor];
    searchBar.tintColor = [UIColor grayColor];
   
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        //searchBar.placeholder=@"Search                                                    ";
        [searchBar setPlaceholder:@"Search                                                     "];
    }
    else
[searchBar setPlaceholder:@"Search                                                                                                                                              "];
    
    [self.view addSubview:searchBar];
    
    
    NSArray *mySegments = [[NSArray alloc] initWithObjects: @"Downloaded",
                           @"Redeemed",@"Shared", nil];

    
    mySegmentedControl = [[UISegmentedControl alloc] initWithItems:mySegments];
  
    [mySegmentedControl setSelectedSegmentIndex:0];
    [mySegmentedControl addTarget:self
                           action:@selector(selectSegment:)
                 forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:mySegmentedControl];
    
    mySegmentedControl.backgroundColor=[UIColor whiteColor];

    mySegmentedControl.tintColor=[UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f];
      
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        navigationImage.frame = CGRectMake(0, 0, 320, 64);
        backButton.frame = CGRectMake(5,25, 35, 35);
        topLable.frame = CGRectMake(0, 25, 320, 30);
        searchBar.frame=CGRectMake(2, 65, 316, 40);
        mySegmentedControl.frame = CGRectMake(30, 110, 260, 30);
    }
    
    else
    {
        navigationImage.frame = CGRectMake(0, 0, 768, 64);
        backButton.frame = CGRectMake(5,22, 35, 35);
        topLable.frame = CGRectMake(0, 25, 768, 30);
        searchBar.frame=CGRectMake(40, 65, 688, 50);
        
        mySegmentedControl.frame = CGRectMake(134, 125, 500, 50);
    }
    
   selectedtab=@"downloaded";
  
}

-(void)viewWillAppear:(BOOL)animated
{
   //   [NoResults removeFromSuperview];
    [mearchantName removeAllObjects];
    [logo removeAllObjects];
    [voucherCode removeAllObjects];
    [Title removeAllObjects];
   
    
    [merchantNameUnused removeAllObjects];
    [logoUnused removeAllObjects];
    [voucherCodeUnused removeAllObjects];
    [titleUnused removeAllObjects];
    
    [offerImages removeAllObjects];
    [redemptionMethod removeAllObjects];
    [redemptionLocation removeAllObjects];
    [Date_Downloaded removeAllObjects];
    [Date_Redeemed removeAllObjects];
    [VoucherId removeAllObjects] ;
    [RedeemedOutlet removeAllObjects];
    [Platform removeAllObjects];
    
    [logoShared removeAllObjects];
    [merchantShared removeAllObjects];
    [voucherCodeShared removeAllObjects];
    [titleShared removeAllObjects];
    [self performSelector:@selector(getMyvoucher) withObject:nil afterDelay:0.1];
    UISegmentedControl *seg=[[UISegmentedControl alloc]init];
    seg.selectedSegmentIndex=0;
    
    NSLog(@"%ld",(long)seg.selectedSegmentIndex);
    [self selectSegment:seg];

}


#pragma mark- SearchBar Delegates
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSMutableArray *arrLogo=[NSMutableArray array];
    NSMutableArray *DateRedeemed=[NSMutableArray array];
    if ([selectedtab isEqualToString:@"downloaded"])
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            [titleArray removeAllObjects];
            [subtitleArray removeAllObjects];
            [voucherIdArray removeAllObjects];
            
            [titleArray addObjectsFromArray:merchantNameUnused];
            [subtitleArray addObjectsFromArray:titleUnused];
            [voucherIdArray addObjectsFromArray:voucherCodeUnused];
            [DateRedeemed addObjectsFromArray:Date_Redeemed];
            [arrLogo addObjectsFromArray:logoUnused];
        }
        else
        {
            subtitleArray=titleUnused;
            titleArray=merchantNameUnused;
            voucherIdArray=voucherCodeUnused;
        }
    }
    else if ([selectedtab isEqualToString:@"redeemed"])
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            [titleArray removeAllObjects];
            [subtitleArray removeAllObjects];
            [voucherIdArray removeAllObjects];
            
            [titleArray addObjectsFromArray:mearchantName];
            [subtitleArray addObjectsFromArray:Title];
            [voucherIdArray addObjectsFromArray:VoucherId];
            [DateRedeemed addObjectsFromArray:Date_Redeemed];
            [arrLogo addObjectsFromArray:logo];
        }
        else
        {
            subtitleArray=Title;
            titleArray=mearchantName;
            voucherIdArray=VoucherId;
        }
    }
    
    else if ([selectedtab isEqualToString:@"shared"])
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            [titleArray removeAllObjects];
            [subtitleArray removeAllObjects];
            [voucherIdArray removeAllObjects];
            
            [titleArray addObjectsFromArray:merchantShared];
            [subtitleArray addObjectsFromArray:titleShared];
            [voucherIdArray addObjectsFromArray:voucherCodeShared];
            [DateRedeemed addObjectsFromArray:Date_Redeemed];
            [arrLogo addObjectsFromArray:logoShared];
        }
        else
        {
            subtitleArray=titleShared;
            titleArray=merchantShared;
            voucherIdArray=voucherCodeShared;
        }
    }

    
    NSMutableArray *arrSearchTitle,*arrSearchSubTitle,*arrSearchVourcherCode,*arrSearchLogo,*arrSearchDateRedeemed;
    arrSearchTitle=[NSMutableArray array];
    arrSearchSubTitle=[NSMutableArray array];
    arrSearchVourcherCode=[NSMutableArray array];
    arrSearchLogo=[NSMutableArray array];
    arrSearchDateRedeemed=[NSMutableArray array];
    if ([searchText length]>0)
    {
        for (int i=0; i<[titleArray count]; i++)
        {
            if ([[titleArray objectAtIndex:i] rangeOfString:searchText options:NSCaseInsensitiveSearch].location!=NSNotFound || [[subtitleArray objectAtIndex:i] rangeOfString:searchText options:NSCaseInsensitiveSearch].location!=NSNotFound || [[voucherIdArray objectAtIndex:i] rangeOfString:searchText options:NSCaseInsensitiveSearch].location!=NSNotFound)
            {
                [arrSearchTitle addObject:[titleArray objectAtIndex:i]];
                [arrSearchSubTitle addObject:[subtitleArray objectAtIndex:i]];
                [arrSearchVourcherCode addObject:[voucherIdArray objectAtIndex:i]];
                
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                {
                    [arrSearchDateRedeemed addObject:[DateRedeemed objectAtIndex:i]];
                    [arrSearchLogo addObject:[arrLogo objectAtIndex:i]];
                }
            }
        }
    }
    else
    {
        arrSearchTitle=titleArray;
        arrSearchSubTitle=subtitleArray;
        arrSearchVourcherCode=voucherIdArray;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            arrSearchDateRedeemed = DateRedeemed;
            arrSearchLogo = arrLogo;
        }
        
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [LEFTtitleArray removeAllObjects];
        [LEFTsubtitleArray removeAllObjects];
        [LEFTimagesArray removeAllObjects];
        
        [LeftDateRedeemedArray removeAllObjects];
        [leftLogoArray removeAllObjects];
        
        [RIGHTtitleArray removeAllObjects];
        
        [RIGHTsubtitleArray removeAllObjects];
        [RIGHTimagesArray removeAllObjects];
        
        [RightDateRedeemedArray removeAllObjects];
        [rightLogoArray removeAllObjects];
        
        [LeftLogoUsedArray removeAllObjects];
        [RightLogoUsedArray removeAllObjects];
        
        [LeftLogoSharedArray removeAllObjects];
        [RightLogoSharedArray removeAllObjects];
        
        for (int i = 0; i < [arrSearchTitle count];i++)
        {
            if ((i%2) == 0)
            {
                [LEFTtitleArray addObject:[arrSearchTitle objectAtIndex:i]];
                [LEFTsubtitleArray addObject:[arrSearchSubTitle objectAtIndex:i]];
                [LEFTimagesArray addObject:[arrSearchVourcherCode objectAtIndex:i]];
                [LeftDateRedeemedArray addObject:[arrSearchDateRedeemed objectAtIndex:i]];
                [leftLogoArray addObject:[arrLogo objectAtIndex:i]];
                [LeftLogoUsedArray addObject:[arrLogo objectAtIndex:i]];
                [LeftLogoSharedArray addObject:[arrLogo objectAtIndex:i]];
            }
            else
            {
                [RIGHTtitleArray addObject:[arrSearchTitle objectAtIndex:i]];
                [RIGHTsubtitleArray addObject:[arrSearchSubTitle objectAtIndex:i]];
                [RIGHTimagesArray addObject:[arrSearchVourcherCode objectAtIndex:i]];
                [RightDateRedeemedArray addObject:[arrSearchDateRedeemed objectAtIndex:i]];
                [rightLogoArray addObject:[arrLogo objectAtIndex:i]];
                [RightLogoUsedArray addObject:[arrLogo objectAtIndex:i]];
                [RightLogoSharedArray addObject:[arrLogo objectAtIndex:i]];
            }
        }
        [leftTableView performSelectorOnMainThread:@selector(reloadData) withObject:Nil waitUntilDone:YES];
        [rightTableView performSelectorOnMainThread:@selector(reloadData) withObject:Nil waitUntilDone:YES];
    }
    else
    {
        subtitleArray=arrSearchSubTitle;
        titleArray=arrSearchTitle;
        voucherIdArray=arrSearchVourcherCode;
        [eventtableView performSelectorOnMainThread:@selector(reloadData) withObject:Nil waitUntilDone:YES];
    }
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar1
{
    [searchBar1 resignFirstResponder];
}



- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar1
{
      overlayButton = [[UIButton alloc] initWithFrame:searchBar.frame];
  
    // set the background to black and have some transparency
    overlayButton.backgroundColor = [UIColor clearColor];

   // add an event listener to the button
    [overlayButton addTarget:self action:@selector(hideKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    //
    //    // add to main view
       [self.view addSubview:overlayButton];
}

- (void)hideKeyboard:(UIButton *)sender
{
    
    [self searchBar:searchBar textDidChange:@""];
    [searchBar clearsContextBeforeDrawing];
    // hide the keyboard
    searchBar.text = @"";
    [searchBar resignFirstResponder];
    // remove the overlay button
    [overlayButton removeFromSuperview];
    [sender removeFromSuperview];
}


#pragma mark- segment control


- (void) selectSegment:(UISegmentedControl *)paramSender
{
    
   if (paramSender.selectedSegmentIndex==0 || paramSender.selectedSegmentIndex==-1 )
   {
       selectedtab=@"downloaded";
       flag=1;
       if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
       {
      [eventtableView setHidden:NO];
           
       subtitleArray=titleUnused;
       titleArray=merchantNameUnused;
       voucherIdArray=voucherCodeUnused;
       offerIDArrayiPhone=offerIDDownloaded;
           
        mainscrollview.contentSize = CGSizeMake(320, (titleArray.count)*127);
        eventtableView.frame = CGRectMake(0, 0, 320,(titleArray.count)*127);
        [eventtableView reloadData];
   
       }
       else
       {
           [leftTableView setHidden:NO];
           [rightTableView setHidden:NO];
           
           [leftOfferID removeAllObjects];
           [rightOfferID removeAllObjects];
           
           [LEFTtitleArray removeAllObjects];
           [LEFTsubtitleArray removeAllObjects];
           [LEFTimagesArray removeAllObjects];
           
           [LeftDateRedeemedArray removeAllObjects];
           [leftLogoArray removeAllObjects];
           
           [RIGHTtitleArray removeAllObjects];
           [RIGHTsubtitleArray removeAllObjects];
           [RIGHTimagesArray removeAllObjects];
           
           [RightDateRedeemedArray removeAllObjects];
           [rightLogoArray removeAllObjects];
           
           for (int i = 0; i < [merchantNameUnused count] ;i++)
           {
               if ((i%2) == 0)
               {
                   [leftOfferID addObject:[offerIDDownloaded objectAtIndex:i]];
           
                   
                   [LEFTtitleArray addObject:[merchantNameUnused objectAtIndex:i]];
                   [LEFTsubtitleArray addObject:[titleArray objectAtIndex:i]];
                   [LEFTimagesArray addObject:[voucherCodeUnused objectAtIndex:i]];
                   [LeftDateRedeemedArray addObject:[Date_Redeemed objectAtIndex:i]];
                   [leftLogoArray addObject:[logoUnused objectAtIndex:i]];
               }
               else
               {
                  [rightOfferID addObject:[offerIDDownloaded objectAtIndex:i]];
                   
                   [RIGHTtitleArray addObject:[merchantNameUnused objectAtIndex:i]];
                   [RIGHTsubtitleArray addObject:[titleArray objectAtIndex:i]];
                   [RIGHTimagesArray addObject:[voucherCodeUnused objectAtIndex:i]];
                   [RightDateRedeemedArray addObject:[Date_Redeemed objectAtIndex:i]];
                   [rightLogoArray addObject:[logoUnused objectAtIndex:i]];
               }
           }
           
           scrollview.contentSize = CGSizeMake(768, (titleArray.count/2)*170);//1024-100
           leftTableView.frame = CGRectMake(10, 0, 369, (titleArray.count/2)*170);
           rightTableView.frame = CGRectMake(389, 0, 369, (titleArray.count/2)*170);
           [leftTableView reloadData];
           [rightTableView reloadData];
       }
       
       
       if(titleArray.count==0)
       {
           if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
           {
               
               NoResults.numberOfLines=5;
               NoResults.lineBreakMode=NSLineBreakByWordWrapping;
               [NoResults setFont:[UIFont fontWithName:@"Helvetica Neue" size:16]];
               NoResults.text=@"You have not downloaded any Voucher.";
               [self.view addSubview:NoResults];
           }
           else
           {
               
               NoResults.numberOfLines=5;
               NoResults.lineBreakMode=NSLineBreakByWordWrapping;
               [NoResults setFont:[UIFont fontWithName:@"Helvetica Neue" size:20]];
               NoResults.text=@"You have not downloaded any Voucher";
               [self.view addSubview:NoResults];
               
               
           }
           
       }
       
       else
       {
           [NoResults removeFromSuperview];
       }

       
   }
    else if (paramSender.selectedSegmentIndex==1)
        
    {
        selectedtab=@"redeemed";

        flag=2;
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
             [eventtableView setHidden:NO];
                 subtitleArray=Title;
            titleArray=mearchantName;
            voucherIdArray=VoucherId;
            offerIDArrayiPhone=offerIDRedem;

            mainscrollview.contentSize = CGSizeMake(320, (titleArray.count)*127);
            eventtableView.frame = CGRectMake(0, 0, 320,(titleArray.count)*127);
             [eventtableView reloadData];
        }
        else
        {
            [leftTableView setHidden:NO];
            [rightTableView setHidden:NO];
            
            [leftOfferID removeAllObjects];
            [rightOfferID removeAllObjects];
            
            [LEFTtitleArray removeAllObjects];
            [LEFTsubtitleArray removeAllObjects];
            [LEFTimagesArray removeAllObjects];
            
            [LeftDateRedeemedArray removeAllObjects];
            [leftLogoArray removeAllObjects];
            
            [RIGHTtitleArray removeAllObjects];
            
            [RIGHTsubtitleArray removeAllObjects];
            [RIGHTimagesArray removeAllObjects];
            
            [RightDateRedeemedArray removeAllObjects];
            [rightLogoArray removeAllObjects];
            [LeftLogoUsedArray removeAllObjects];
            [RightLogoUsedArray removeAllObjects];
            
            for (int i = 0; i < [mearchantName count];i++)
            {
                if ((i%2) == 0)
                {
                    [leftOfferID addObject:[offerIDRedem objectAtIndex:i]];
                    
                    [LEFTtitleArray addObject:[mearchantName objectAtIndex:i]];
                    [LEFTsubtitleArray addObject:[Title objectAtIndex:i]];
                    [LEFTimagesArray addObject:[VoucherId objectAtIndex:i]];
                    [LeftDateRedeemedArray addObject:[Date_Redeemed objectAtIndex:i]];
                    [LeftLogoUsedArray addObject:[logo objectAtIndex:i]];
                }
                else
                {
                    [rightOfferID addObject:[offerIDRedem objectAtIndex:i]];

                    [RIGHTtitleArray addObject:[mearchantName objectAtIndex:i]];
                    [RIGHTsubtitleArray addObject:[Title objectAtIndex:i]];
                    [RIGHTimagesArray addObject:[VoucherId objectAtIndex:i]];
                    [RightDateRedeemedArray addObject:[Date_Redeemed objectAtIndex:i]];
                    [RightLogoUsedArray addObject:[logo objectAtIndex:i]];
                }
            }
            
            scrollview.contentSize = CGSizeMake(768, (titleArray.count/2)*170);//1024-100
            leftTableView.frame = CGRectMake(10, 0, 369, (titleArray.count/2)*170);
            rightTableView.frame = CGRectMake(389, 0, 369, (titleArray.count/2)*170);
            [leftTableView reloadData];
            [rightTableView reloadData];
        }
        
        if(mearchantName.count==0)
        {
            if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
            {
                
                NoResults.numberOfLines=5;
                NoResults.lineBreakMode=NSLineBreakByWordWrapping;
                [NoResults setFont:[UIFont fontWithName:@"Helvetica Neue" size:16]];
                NoResults.text=@"You have not redeemed any Voucher.";
                [self.view addSubview:NoResults];
            }
            else
            {
                
                NoResults.numberOfLines=5;
                NoResults.lineBreakMode=NSLineBreakByWordWrapping;
                [NoResults setFont:[UIFont fontWithName:@"Helvetica Neue" size:20]];
                NoResults.text=@"You have not redeemed any Voucher.";
                [self.view addSubview:NoResults];
                
                
            }
            
        }
        
        else
        {
            [NoResults removeFromSuperview];
        }
    
    }
    
    else if(paramSender.selectedSegmentIndex==2)
    {
        selectedtab=@"shared";
        
     
      
        flag=3;
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            [eventtableView setHidden:NO];
                 subtitleArray=titleShared;
            titleArray=merchantShared;
            voucherIdArray=voucherCodeShared;
              offerIDArrayiPhone=offerIDshared;
            
            mainscrollview.contentSize = CGSizeMake(320, (titleArray.count)*127);
            eventtableView.frame = CGRectMake(0, 0, 320,(titleArray.count)*127);

            [eventtableView reloadData];
    }
        else
        {
            [leftTableView setHidden:NO];
            [rightTableView setHidden:NO];
            
            [leftOfferID removeAllObjects];
            [rightOfferID removeAllObjects];
            
            [LEFTtitleArray removeAllObjects];
            [LEFTsubtitleArray removeAllObjects];
            [LEFTimagesArray removeAllObjects];
            
            [LeftDateRedeemedArray removeAllObjects];
            [leftLogoArray removeAllObjects];
            
            [RIGHTtitleArray removeAllObjects];
            
            [RIGHTsubtitleArray removeAllObjects];
            [RIGHTimagesArray removeAllObjects];
            
            [RightDateRedeemedArray removeAllObjects];
            [rightLogoArray removeAllObjects];
            [LeftLogoSharedArray removeAllObjects];
            [RightLogoSharedArray removeAllObjects];
            
            for (int i = 0; i < [merchantShared count];i++)
            {
                if ((i%2) == 0)
                {
                    [leftOfferID addObject:[offerIDshared objectAtIndex:i]];
                    
                    [LEFTtitleArray addObject:[merchantShared objectAtIndex:i]];
                    [LEFTsubtitleArray addObject:[titleShared objectAtIndex:i]];
                    [LEFTimagesArray addObject:[voucherCodeShared objectAtIndex:i]];
                    [LeftDateRedeemedArray addObject:[Date_Redeemed objectAtIndex:i]];
                    [LeftLogoSharedArray addObject:[logoShared objectAtIndex:i]];
                }
                else
                {
                    [rightOfferID addObject:[offerIDshared objectAtIndex:i]];

                    [RIGHTtitleArray addObject:[merchantShared objectAtIndex:i]];
                    [RIGHTsubtitleArray addObject:[titleShared objectAtIndex:i]];
                    [RIGHTimagesArray addObject:[VoucherId objectAtIndex:i]];
                    [RightDateRedeemedArray addObject:[Date_Redeemed objectAtIndex:i]];
                    [RightLogoSharedArray addObject:[logoShared objectAtIndex:i]];
                }
            }
            
            scrollview.contentSize = CGSizeMake(768, (titleArray.count/2)*170);//1024-100
            leftTableView.frame = CGRectMake(10, 0, 369, (titleArray.count/2)*170);
            rightTableView.frame = CGRectMake(389, 0, 369, (titleArray.count/2)*170);
            [leftTableView reloadData];
            [rightTableView reloadData];
        }
        
        if(mearchantName.count==0)
        {
            if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
            {
                
                NoResults.numberOfLines=5;
                NoResults.lineBreakMode=NSLineBreakByWordWrapping;
                [NoResults setFont:[UIFont fontWithName:@"Helvetica Neue" size:16]];
                NoResults.text=@"You have not shared any Voucher.";
                [self.view addSubview:NoResults];
            }
            else
            {
                
                NoResults.numberOfLines=5;
                NoResults.lineBreakMode=NSLineBreakByWordWrapping;
                [NoResults setFont:[UIFont fontWithName:@"Helvetica Neue" size:20]];
                NoResults.text=@"You have not redeemed any Voucher.";
                [self.view addSubview:NoResults];
                
                
            }
            
        }
        
        else
        {
            [NoResults removeFromSuperview];
        }
        
     }
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void) backMethod
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
          
            NSData *imageData;
            
            if(flag==1)
            {
            imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[logoUnused objectAtIndex:indexPath.row] ]]];
            }
            
            else if(flag==2)
            {
              imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[logo objectAtIndex:indexPath.row] ]]];
            }
            
            else if(flag==3)
            {
                imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[logoShared objectAtIndex:indexPath.row] ]]];
            }
            
            
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
                    
                    UIImage *imageGNoff = [UIImage imageWithData:imageData];
                    
                    CGSize imageSize = imageGNoff.size;
                    CGFloat width = imageSize.width;
                    CGFloat height = imageSize.height;
                    if (width != height)
                    {
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
                    pofferimg.image =imageGNoff;
                    
                    //pofferimg.image= [UIImage imageWithData:imageData];
                }
                else
                    pofferimg.image =[UIImage imageNamed:@"11_186X186.png"];
            });
        });
        
        
        
        UILabel *nameLable =[[UILabel alloc] init];
        nameLable.text = [titleArray objectAtIndex:indexPath.row];
        nameLable.textAlignment = NSTextAlignmentLeft;
        nameLable.textColor = [UIColor blackColor];
        nameLable.numberOfLines=2;
        nameLable.lineBreakMode=NSLineBreakByWordWrapping;
        nameLable.backgroundColor = [UIColor clearColor];
        nameLable.frame = CGRectMake(109, 12, 160, 40);
        nameLable.font = [UIFont fontWithName:@"Helvetica Neue" size:17];
        [cell.contentView addSubview:nameLable];

        UILabel *detailLable =[[UILabel alloc] init];
        detailLable.text = [subtitleArray objectAtIndex:indexPath.row];
        detailLable.textAlignment = NSTextAlignmentLeft;
        detailLable.textColor = [UIColor colorWithRed:205/255.0f green:63/255.0f blue:59/255.0f alpha:1.0f];
        detailLable.font = [UIFont boldSystemFontOfSize:10];
        detailLable.numberOfLines = 2;
        detailLable.lineBreakMode = NSLineBreakByWordWrapping;
        detailLable.backgroundColor = [UIColor clearColor];
        detailLable.frame = CGRectMake(109, 48, 170, 30);
        detailLable.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
        [cell.contentView addSubview:detailLable];

        UILabel *vLable =[[UILabel alloc] init];
        vLable.text = @"Voucher Code:";
        vLable.textAlignment = NSTextAlignmentLeft;
        vLable.textColor = [UIColor darkGrayColor];
        [cell.contentView addSubview:vLable];
        vLable.frame= CGRectMake(115, 80, 100, 15);
        vLable.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
        
        
        UILabel *voucheridLable =[[UILabel alloc] init];
        voucheridLable.text = [voucherIdArray objectAtIndex:indexPath.row];
        voucheridLable.textAlignment = NSTextAlignmentLeft;
        voucheridLable.textColor = [UIColor darkGrayColor];
        voucheridLable.backgroundColor = [UIColor clearColor];
        voucheridLable.frame = CGRectMake(195, 80, 100, 15);
        voucheridLable.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
        [cell.contentView addSubview:voucheridLable];

        UILabel *usedOn =[[UILabel alloc] init];
        usedOn.text = @"Used On:";
        usedOn.textAlignment = NSTextAlignmentLeft;
        usedOn.textColor = [UIColor darkGrayColor];
        
        UILabel *usedOnLabel =[[UILabel alloc] init];
        usedOnLabel.text = [Date_Redeemed objectAtIndex:indexPath.row];
        usedOnLabel.textAlignment = NSTextAlignmentLeft;
        usedOnLabel.textColor = [UIColor darkGrayColor];

        usedOnLabel.frame = CGRectMake(170, 100, 150, 15);
        usedOn.frame= CGRectMake(115, 100, 100, 15);
        usedOnLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
        usedOn.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
        
        if (flag==2)
        {
            [cell.contentView addSubview:usedOn];
            [cell.contentView addSubview:usedOnLabel];
        }
        
        UIImageView *arrowImage = [[UIImageView alloc] init ];//WithFrame:
        arrowImage.image = [UIImage imageNamed:@"nextarrow.png"];
        arrowImage.frame=CGRectMake(302, 50,17,17);
        [cell.contentView addSubview:arrowImage];
    
        UIButton *participateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        participateBtn.frame = CGRectMake(270, 40, 40, 40);
       // [participateBtn setTitle:@"View" forState:UIControlStateNormal];
        [participateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [participateBtn setImage:[UIImage imageNamed:@"info.png"] forState:UIControlStateNormal];
       // [participateBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:10]];
        [participateBtn addTarget:self action:@selector(participateMethod:) forControlEvents:UIControlEventTouchUpInside];
        
        if(flag==1)
        {
            participateBtn.tag = [offerIDArrayiPhone indexOfObject:[offerIDDownloaded objectAtIndex:indexPath.row]];
        }
        else if(flag==2)
        {
              participateBtn.tag = [offerIDArrayiPhone indexOfObject:[offerIDRedem objectAtIndex:indexPath.row]];
        }
        
        else if(flag==3)
        {
            participateBtn.tag = [offerIDArrayiPhone indexOfObject:[offerIDshared objectAtIndex:indexPath.row]];
        }
        
        [cell.contentView addSubview:participateBtn];

    
    }
    
    else if(tableView.tag==501)
    {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 170)];
        img.backgroundColor =[UIColor whiteColor];
        [cell.contentView addSubview:img];
       
        
        UIImageView *pofferimg = [[UIImageView alloc] initWithFrame:CGRectMake(8, 20, 120, 120)];
       pofferimg.image = [UIImage imageNamed:@"11_240X240.png"];
        [cell.contentView addSubview:pofferimg];
        
        UIActivityIndicatorView *activityview1 = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityview1.center = CGPointMake(pofferimg.bounds.size.width / 2,pofferimg.bounds.size.height /2);
        [activityview1 startAnimating];
        
        [pofferimg addSubview:activityview1];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            
            NSData *imageData;
            
            if(flag==1)
            {
                imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[leftLogoArray objectAtIndex:indexPath.row] ]]];
            }
            
            else if(flag==2)
            {
                imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[LeftLogoUsedArray objectAtIndex:indexPath.row] ]]];
            }
            
            else if(flag==3)
            {
                imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[LeftLogoSharedArray objectAtIndex:indexPath.row] ]]];
            }
            
            
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
                    
                    UIImage *imageGNoff = [UIImage imageWithData:imageData];
                    
                    CGSize imageSize = imageGNoff.size;
                    CGFloat width = imageSize.width;
                    CGFloat height = imageSize.height;
                    if (width != height)
                    {
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
                    pofferimg.image =imageGNoff;
                    
                    //pofferimg.image= [UIImage imageWithData:imageData];
                }
                else
                  pofferimg.image = [UIImage imageNamed:@"11_240X240.png"];
            });
        });
        
        
        
        UILabel *nameLable =[[UILabel alloc] init];
        nameLable.text = [LEFTtitleArray objectAtIndex:indexPath.row];
        nameLable.textAlignment = NSTextAlignmentLeft;
        nameLable.textColor = [UIColor darkGrayColor];
        nameLable.numberOfLines=2;
        nameLable.lineBreakMode=NSLineBreakByWordWrapping;
        nameLable.backgroundColor = [UIColor clearColor];
        nameLable.frame = CGRectMake(135, 18, 170, 50);
        nameLable.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
        [cell.contentView addSubview:nameLable];
        
        UILabel *detailLable =[[UILabel alloc] init];
        detailLable.text = [LEFTsubtitleArray objectAtIndex:indexPath.row];
        detailLable.textAlignment = NSTextAlignmentLeft;
        detailLable.textColor = [UIColor colorWithRed:205/255.0f green:63/255.0f blue:59/255.0f alpha:1.0f];
        detailLable.font = [UIFont boldSystemFontOfSize:10];
        detailLable.numberOfLines = 2;
        detailLable.lineBreakMode = NSLineBreakByWordWrapping;
        detailLable.backgroundColor = [UIColor clearColor];
        detailLable.frame = CGRectMake(139, 67, 180, 30);
        detailLable.font = [UIFont fontWithName:@"Helvetica Neue" size:10];
        [cell.contentView addSubview:detailLable];
        
        UILabel *vLable =[[UILabel alloc] init];
        vLable.text = @"Voucher Code:";
        vLable.textAlignment = NSTextAlignmentLeft;
        vLable.textColor = [UIColor darkGrayColor];
        [cell.contentView addSubview:vLable];
        vLable.frame= CGRectMake(139, 107, 100, 15);
        vLable.font = [UIFont fontWithName:@"Helvetica Neue" size:10];
        
        
        UILabel *voucheridLable =[[UILabel alloc] init];
        voucheridLable.text = [LEFTimagesArray objectAtIndex:indexPath.row];
        voucheridLable.textAlignment = NSTextAlignmentLeft;
        voucheridLable.textColor = [UIColor darkGrayColor];
        voucheridLable.backgroundColor = [UIColor clearColor];
        voucheridLable.frame = CGRectMake(210, 107, 100, 15);
        voucheridLable.font = [UIFont fontWithName:@"Helvetica Neue" size:10];
        [cell.contentView addSubview:voucheridLable];
        
        UILabel *usedOn =[[UILabel alloc] init];
        usedOn.text = @"Used On:";
        usedOn.textAlignment = NSTextAlignmentLeft;
        usedOn.textColor = [UIColor darkGrayColor];
        
        UILabel *usedOnLabel =[[UILabel alloc] init];
        usedOnLabel.text = [LeftDateRedeemedArray objectAtIndex:indexPath.row];
        usedOnLabel.textAlignment = NSTextAlignmentLeft;
        usedOnLabel.textColor = [UIColor darkGrayColor];
        
        usedOnLabel.frame = CGRectMake(249, 137, 150, 15);
        usedOn.frame= CGRectMake(139, 137, 100, 15);
        usedOnLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:10];
        usedOn.font = [UIFont fontWithName:@"Helvetica Neue" size:10];
        
        if (flag==2)
        {
            [cell.contentView addSubview:usedOn];
            [cell.contentView addSubview:usedOnLabel];
        }
        
        UIImageView *arrowImage = [[UIImageView alloc] init ];//WithFrame:
        arrowImage.image = [UIImage imageNamed:@"nextarrow.png"];
        arrowImage.frame=CGRectMake(352, 87,17,17);
        [cell.contentView addSubview:arrowImage];
        
        
        UIButton *participateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        participateBtn.frame = CGRectMake(315, 75, 40, 40); // arrowImage.frame=CGRectMake(302, 50,17,17);
      //  [participateBtn setTitle:@"PARTICIPATE" forState:UIControlStateNormal];
        [participateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       [participateBtn setImage:[UIImage imageNamed:@"info.png"] forState:UIControlStateNormal];       // [participateBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:10]];
        [participateBtn addTarget:self action:@selector(participateMethod:) forControlEvents:UIControlEventTouchUpInside];
        
        if(flag==1)
        {
        participateBtn.tag = [offerIDArrayiPhone indexOfObject:[leftOfferID objectAtIndex:indexPath.row]];

        }
        else if(flag==2)
        {
        participateBtn.tag = [offerIDRedem indexOfObject:[leftOfferID objectAtIndex:indexPath.row]];
        }
        else if(flag==3)
        {
        participateBtn.tag = [offerIDshared indexOfObject:[leftOfferID objectAtIndex:indexPath.row]];
        }
        
        
     [cell.contentView addSubview:participateBtn];
    
    }
    
    else if(tableView.tag==502)
    {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 170)];
        img.backgroundColor =[UIColor whiteColor];
        [cell.contentView addSubview:img];
        
        
        UIImageView *pofferimg = [[UIImageView alloc] initWithFrame:CGRectMake(8, 20, 120, 120)];
        pofferimg.image = [UIImage imageNamed:@"11_240X240.png"];
        [cell.contentView addSubview:pofferimg];
        
        UIActivityIndicatorView *activityview1 = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityview1.center = CGPointMake(pofferimg.bounds.size.width / 2,pofferimg.bounds.size.height /2);
        [activityview1 startAnimating];
        
        [pofferimg addSubview:activityview1];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            
            NSData *imageData;
            
            if(flag==1)
            {
                imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[rightLogoArray objectAtIndex:indexPath.row] ]]];
            }
            
            else if(flag==2)
            {
                imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[RightLogoUsedArray objectAtIndex:indexPath.row] ]]];
            }
            
            else if(flag==3)
            {
                imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[RightLogoSharedArray objectAtIndex:indexPath.row] ]]];
            }
            
            
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
                    
                    UIImage *imageGNoff = [UIImage imageWithData:imageData];
                    
                    CGSize imageSize = imageGNoff.size;
                    CGFloat width = imageSize.width;
                    CGFloat height = imageSize.height;
                    if (width != height)
                    {
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
                    pofferimg.image =imageGNoff;
                    
                    //pofferimg.image= [UIImage imageWithData:imageData];
                }
                else
                     pofferimg.image = [UIImage imageNamed:@"11_240X240.png"];
            });
        });
        
        
        
        UILabel *nameLable =[[UILabel alloc] init];
        nameLable.text = [RIGHTtitleArray objectAtIndex:indexPath.row];
        nameLable.textAlignment = NSTextAlignmentLeft;
        nameLable.textColor = [UIColor darkGrayColor];
        nameLable.numberOfLines=2;
        nameLable.lineBreakMode=NSLineBreakByWordWrapping;
        nameLable.backgroundColor = [UIColor clearColor];
        nameLable.frame = CGRectMake(135, 18, 170, 50);
        nameLable.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
        [cell.contentView addSubview:nameLable];
        
        UILabel *detailLable =[[UILabel alloc] init];
        detailLable.text = [RIGHTsubtitleArray objectAtIndex:indexPath.row];
        detailLable.textAlignment = NSTextAlignmentLeft;
        detailLable.textColor = [UIColor colorWithRed:205/255.0f green:63/255.0f blue:59/255.0f alpha:1.0f];
        detailLable.font = [UIFont boldSystemFontOfSize:10];
        detailLable.numberOfLines = 2;
        detailLable.lineBreakMode = NSLineBreakByWordWrapping;
        detailLable.backgroundColor = [UIColor clearColor];
        detailLable.frame = CGRectMake(139, 67, 180, 30);
        detailLable.font = [UIFont fontWithName:@"Helvetica Neue" size:10];
        [cell.contentView addSubview:detailLable];
        
        UILabel *vLable =[[UILabel alloc] init];
        vLable.text = @"Voucher Code:";
        vLable.textAlignment = NSTextAlignmentLeft;
        vLable.textColor = [UIColor darkGrayColor];
        [cell.contentView addSubview:vLable];
        vLable.frame= CGRectMake(139, 107, 100, 15);
        vLable.font = [UIFont fontWithName:@"Helvetica Neue" size:10];
        
        
        UILabel *voucheridLable =[[UILabel alloc] init];
        voucheridLable.text = [RIGHTimagesArray objectAtIndex:indexPath.row];
        voucheridLable.textAlignment = NSTextAlignmentLeft;
        voucheridLable.textColor = [UIColor darkGrayColor];
        voucheridLable.backgroundColor = [UIColor clearColor];
        voucheridLable.frame = CGRectMake(210, 107, 100, 15);
        voucheridLable.font = [UIFont fontWithName:@"Helvetica Neue" size:10];
        [cell.contentView addSubview:voucheridLable];
        
        UILabel *usedOn =[[UILabel alloc] init];
        usedOn.text = @"Used On:";
        usedOn.textAlignment = NSTextAlignmentLeft;
        usedOn.textColor = [UIColor darkGrayColor];
        
        UILabel *usedOnLabel =[[UILabel alloc] init];
        usedOnLabel.text = [RightDateRedeemedArray objectAtIndex:indexPath.row];
        usedOnLabel.textAlignment = NSTextAlignmentLeft;
        usedOnLabel.textColor = [UIColor darkGrayColor];
        
        usedOnLabel.frame = CGRectMake(249, 137, 150, 15);
        usedOn.frame= CGRectMake(139, 137, 100, 15);
        usedOnLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:10];
        usedOn.font = [UIFont fontWithName:@"Helvetica Neue" size:10];
        
        if (flag==2)
        {
            [cell.contentView addSubview:usedOn];
            [cell.contentView addSubview:usedOnLabel];
        }
        
        UIImageView *arrowImage = [[UIImageView alloc] init ];//WithFrame:
        arrowImage.image = [UIImage imageNamed:@"nextarrow.png"];
        arrowImage.frame=CGRectMake(352, 87,17,17);
        [cell.contentView addSubview:arrowImage];
        
        UIButton *participateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        participateBtn.frame = CGRectMake(315, 75, 40, 40);
        //[participateBtn setTitle:@"PARTICIPATE" forState:UIControlStateNormal];
        [participateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [participateBtn setImage:[UIImage imageNamed:@"info.png"] forState:UIControlStateNormal];
        // [participateBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:10]];
        [participateBtn addTarget:self action:@selector(participateMethod:) forControlEvents:UIControlEventTouchUpInside];
        
        if(flag==1)
        {
            participateBtn.tag = [offerIDDownloaded indexOfObject:[rightOfferID objectAtIndex:indexPath.row]];
            
        }
        else if(flag==2)
        {
            participateBtn.tag = [offerIDRedem indexOfObject:[rightOfferID objectAtIndex:indexPath.row]];
        }
        else if(flag==3)
        {
            participateBtn.tag = [offerIDshared indexOfObject:[rightOfferID objectAtIndex:indexPath.row]];
        }
        
        [cell.contentView addSubview:participateBtn];

    
    }
    
    
    
    cell.backgroundColor = [UIColor clearColor];
    
    
    cell.tag = indexPath.row;
    UISwipeGestureRecognizer* recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [recognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [cell addGestureRecognizer:recognizer];
    
    return cell;
}




- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
 NSURL *imageData;
     DownlaodVoucherController *nextView = [[DownlaodVoucherController alloc] init];
    if(flag==1)
    {
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            imageData  = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[logoUnused objectAtIndex:indexPath.row] ]];
        nextView.titleName= [subtitleArray objectAtIndex:indexPath.row];
        nextView.merchantName=[titleArray objectAtIndex:indexPath.row];
        nextView.voucherCode=[voucherIdArray objectAtIndex:indexPath.row];
        nextView.logoImg=imageData;
        }
        else
        {
            if(tableView.tag==501)
            {
                //imageData  = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[leftLogoArray objectAtIndex:indexPath.row] ]]];
                nextView.titleName= [LEFTsubtitleArray objectAtIndex:indexPath.row];
                nextView.merchantName=[LEFTtitleArray objectAtIndex:indexPath.row];
                nextView.voucherCode=[LEFTimagesArray objectAtIndex:indexPath.row];
                nextView.logoImg=[NSURL URLWithString:[NSString stringWithFormat:@"%@",[leftLogoArray objectAtIndex:indexPath.row] ]];
 
            }
            else
            {
               // imageData  = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[rightLogoArray objectAtIndex:indexPath.row] ]]];
                nextView.titleName= [RIGHTsubtitleArray objectAtIndex:indexPath.row];
                nextView.merchantName=[RIGHTtitleArray objectAtIndex:indexPath.row];
                nextView.voucherCode=[RIGHTimagesArray objectAtIndex:indexPath.row];
                nextView.logoImg=[NSURL URLWithString:[NSString stringWithFormat:@"%@",[rightLogoArray objectAtIndex:indexPath.row] ]];

            }
        }
        
    }
    else if(flag==2)
    {
        if(UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPhone)
        {
        if ([voucherIdArray objectAtIndex:indexPath.row])
        {
            [Flurry logEvent:[NSString stringWithFormat:@"Redeem Voucher - %@",[voucherIdArray objectAtIndex:indexPath.row]]];
            [Flurry logPageView];
            
            self.screenName = [NSString stringWithFormat:@"Redeem Voucher - %@",[voucherIdArray objectAtIndex:indexPath.row]];
            return;
        }
        }
        
        else
        {
            
        }

    }
    else if(flag==3)
    {
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
           if([[Date_Redeemed objectAtIndex:indexPath.row] isEqualToString:@"0"])
           {
            //imageData  = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[logoShared objectAtIndex:indexPath.row] ]]];
            nextView.titleName= [subtitleArray objectAtIndex:indexPath.row];
            nextView.merchantName=[titleArray objectAtIndex:indexPath.row];
            nextView.voucherCode=[voucherIdArray objectAtIndex:indexPath.row];
            nextView.logoImg=[NSURL URLWithString:[NSString stringWithFormat:@"%@",[logoShared objectAtIndex:indexPath.row] ]];
           }

        }
        else
        {
            if(tableView.tag==501 && [[LeftDateRedeemedArray objectAtIndex:indexPath.row] isEqualToString:@"0"])
              
            {
                
                //imageData  = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[LeftLogoSharedArray objectAtIndex:indexPath.row] ]]];
                nextView.titleName= [LEFTsubtitleArray objectAtIndex:indexPath.row];
                nextView.merchantName=[LEFTtitleArray objectAtIndex:indexPath.row];
                nextView.voucherCode=[LEFTimagesArray objectAtIndex:indexPath.row];
                nextView.logoImg=[NSURL URLWithString:[NSString stringWithFormat:@"%@",[LeftLogoSharedArray objectAtIndex:indexPath.row] ]];

            }
            else  if(tableView.tag==502 && [[RightDateRedeemedArray objectAtIndex:indexPath.row] isEqualToString:@"0"])

            {
                //imageData  = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[RightLogoSharedArray objectAtIndex:indexPath.row] ]]];
                nextView.titleName= [RIGHTsubtitleArray objectAtIndex:indexPath.row];
                nextView.merchantName=[RIGHTtitleArray objectAtIndex:indexPath.row];
                nextView.voucherCode=[RIGHTimagesArray objectAtIndex:indexPath.row];
                nextView.logoImg=[NSURL URLWithString:[NSString stringWithFormat:@"%@",[RightLogoSharedArray objectAtIndex:indexPath.row] ]];

            }
        }
        
      

    }
           [self.navigationController pushViewController:nextView animated:YES];

  
}


//--------------------- WebService

-(void)getMyvoucher
{
    @try {
        
        
        NSString *userID=delegate.userID;
        
        NSString *url=getDownloadVoucher;
        if(userID)
            url=[url stringByAppendingString:userID];
        
        NSString *urlString = url;
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *Final_Url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",urlString]];
        
        NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:Final_Url];
        [request setValue:@"Basic Z2xvYnVzdXNlcjpHbDBidVMyMDE0" forHTTPHeaderField:@"Authorization"];
        
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        
        mearchantName=[[NSMutableArray alloc]init];
        logo=[[NSMutableArray alloc]init];
        voucherCode=[[NSMutableArray alloc]init];
        Title=[[NSMutableArray alloc]init];
        
        merchantNameUnused=[[NSMutableArray alloc]init];
        logoUnused=[[NSMutableArray alloc]init];
        voucherCodeUnused=[[NSMutableArray alloc]init];
        titleUnused=[[NSMutableArray alloc]init];
        
        offerImages=[[NSMutableArray alloc]init];
        redemptionMethod=[[NSMutableArray alloc]init];
        redemptionLocation=[[NSMutableArray alloc]init];
        Date_Downloaded=[[NSMutableArray alloc]init];
        Date_Redeemed=[[NSMutableArray alloc]init];
        VoucherId=[[NSMutableArray alloc]init];
        RedeemedOutlet=[[NSMutableArray alloc]init];
        Platform=[[NSMutableArray alloc]init];
        
        logoShared=[[NSMutableArray alloc]init];
        merchantShared=[[NSMutableArray alloc]init];
        voucherCodeShared=[[NSMutableArray alloc]init];
        titleShared=[[NSMutableArray alloc]init];
        
        offerIDDownloaded = [[NSMutableArray alloc] init];
        offerIDRedem  = [[NSMutableArray alloc] init];
        offerIDshared = [[NSMutableArray alloc] init];
        
        NSDictionary*json;
        if (data)
        {
            NSError* error;
            json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSMutableArray *DataArray = [json objectForKey:@"data"];
            
            for (int i = 0; i < [DataArray count]; i++)
            {
                // NSString *redeom=[[DataArray objectAtIndex:i] valueForKey:@"Date_Redeemed__c"];
                [Date_Redeemed addObject:[[DataArray objectAtIndex:i] valueForKey:@"Date_Redeemed__c"]];
                
                // if(redeom!=(id)[NSNull null])
                if([[[DataArray objectAtIndex:i] valueForKey:@"Date_Redeemed__c"] isEqualToString:@"0"])
                {
                    [offerIDDownloaded addObject:[[DataArray objectAtIndex:i] valueForKey:@"OfferId"]];
                    
                    [logoUnused addObject:[[DataArray objectAtIndex:i] valueForKey:@"Offer_Image_1__c"]];//Logo_URL__c
                    [merchantNameUnused addObject:[[DataArray objectAtIndex:i] valueForKey:@"MearchantName"]];
                    [titleUnused addObject:[[DataArray objectAtIndex:i] valueForKey:@"Title"]];
                    [voucherCodeUnused addObject:[[DataArray objectAtIndex:i] valueForKey:@"Voucher_Code__c"]];
                }
                else if ([[[DataArray objectAtIndex:i] valueForKey:@"is_offer_share"] isEqualToString:@"1"])
                {
                    [offerIDshared addObject:[[DataArray objectAtIndex:i] valueForKey:@"OfferId"]];
                    
                    [logoShared addObject:[[DataArray objectAtIndex:i] valueForKey:@"Offer_Image_1__c"]];//Logo_URL__c
                    [merchantShared addObject:[[DataArray objectAtIndex:i] valueForKey:@"MearchantName"]];
                    [titleShared addObject:[[DataArray objectAtIndex:i] valueForKey:@"Title"]];
                    [voucherCodeShared addObject:[[DataArray objectAtIndex:i] valueForKey:@"Voucher_Code__c"]];
                }
                else
                {
                    [offerIDRedem addObject:[[DataArray objectAtIndex:i] valueForKey:@"OfferId"]];
                    
                    [logo addObject:[[DataArray objectAtIndex:i] valueForKey:@"Offer_Image_1__c"]];//Logo_URL__c
                    [mearchantName addObject:[[DataArray objectAtIndex:i] valueForKey:@"MearchantName"]];
                    [Title addObject:[[DataArray objectAtIndex:i] valueForKey:@"Title"]];
                    [VoucherId addObject:[[DataArray objectAtIndex:i] valueForKey:@"Voucher_Code__c"]];
                }
                
                titleArray = [[NSMutableArray alloc] init];
                subtitleArray  = [[NSMutableArray alloc] init];
                voucherIdArray = [[NSMutableArray alloc] init];
                offerIDArrayiPhone = [[NSMutableArray alloc] init];

                
                flag=1;
                offerIDArrayiPhone=offerIDDownloaded;
                subtitleArray=titleUnused;
                titleArray=merchantNameUnused;
                voucherIdArray=voucherCodeUnused;
            }
        }
        
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            leftOfferID = [[NSMutableArray alloc] init];
            rightOfferID = [[NSMutableArray alloc] init];
            
            LEFTtitleArray = [[NSMutableArray alloc] init];
            LEFTsubtitleArray = [[NSMutableArray alloc] init];
            RIGHTtitleArray = [[NSMutableArray alloc] init];
            RIGHTsubtitleArray = [[NSMutableArray alloc] init];
            LEFTimagesArray = [[NSMutableArray alloc] init];
            RIGHTimagesArray = [[NSMutableArray alloc] init];
            leftLogoArray=[[NSMutableArray alloc]init];
            rightLogoArray=[[NSMutableArray alloc]init];
            LeftLogoUsedArray=[[NSMutableArray alloc]init];
            RightLogoUsedArray=[[NSMutableArray alloc]init];
            LeftDateRedeemedArray=[[NSMutableArray alloc]init];
            RightDateRedeemedArray=[[NSMutableArray alloc]init];
            
            RightLogoSharedArray=[[NSMutableArray alloc]init];
            LeftLogoSharedArray=[[NSMutableArray alloc]init];
            
            for (int i = 0; i < [titleArray count];i++)
            {
                if ((i%2) == 0)
                {
                    [LEFTtitleArray addObject:[merchantNameUnused objectAtIndex:i]];
                    [LEFTsubtitleArray addObject:[titleUnused objectAtIndex:i]];
                    [LEFTimagesArray addObject:[voucherCodeUnused objectAtIndex:i]];
                    [LeftDateRedeemedArray addObject:[Date_Redeemed objectAtIndex:i]];
                    [leftLogoArray addObject:[logoUnused objectAtIndex:i]];
                    [leftOfferID addObject:[offerIDDownloaded objectAtIndex:i]];
                }
                else
                {
                    [RIGHTtitleArray addObject:[merchantNameUnused objectAtIndex:i]];
                    [RIGHTsubtitleArray addObject:[titleUnused objectAtIndex:i]];
                    [RIGHTimagesArray addObject:[voucherCodeUnused objectAtIndex:i]];
                    [RightDateRedeemedArray addObject:[Date_Redeemed objectAtIndex:i]];
                    [rightLogoArray addObject:[logoUnused objectAtIndex:i]];
                    [rightOfferID addObject:[offerIDDownloaded objectAtIndex:i]];
                }
            }
        }
        
        
        [getMyVoucher dismissWithClickedButtonIndex:0 animated:YES];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
                [self displayMyvoucher];
        });
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            [self displayMyvoucheriPad];
        }
        
        

    }
    @catch (NSException *exception) {
      
    }


}

-(void)displayMyvoucher
{
    
    titleArray = [[NSMutableArray alloc] init];
    subtitleArray  = [[NSMutableArray alloc] init];
    voucherIdArray = [[NSMutableArray alloc] init];
    
    flag=1;
    subtitleArray=titleUnused;
    titleArray=merchantNameUnused;
    voucherIdArray=voucherCodeUnused;
    
    mainscrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 150, 320,self.view.frame.size.height-150)];
    mainscrollview.contentSize = CGSizeMake(320, (titleArray.count)*130);
    mainscrollview.delegate = self;
    [self.view addSubview:mainscrollview];
    
    eventtableView = [[UITableView alloc] init];
    eventtableView.tag=2;
    eventtableView.delegate = self;
    eventtableView.dataSource = self;
    eventtableView.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f];
    eventtableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    eventtableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    eventtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  //  eventtableView.separatorColor = [UIColor orangeColor];
    eventtableView.scrollEnabled=NO;
    eventtableView.frame = CGRectMake(0, 0, 320,(titleArray.count)*130);
    [mainscrollview addSubview:eventtableView];
    
    
  //  eventtableView.contentSize=CGSizeMake(320,140*titleArray.count);
    
    if(titleArray.count==0)
    {
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            
            NoResults.numberOfLines=5;
            NoResults.lineBreakMode=NSLineBreakByWordWrapping;
            [NoResults setFont:[UIFont fontWithName:@"Helvetica Neue" size:16]];
            NoResults.text=@"You have not downloaded any Voucher.";
            [self.view addSubview:NoResults];
        }
        else
        {
            
            NoResults.numberOfLines=5;
            NoResults.lineBreakMode=NSLineBreakByWordWrapping;
            [NoResults setFont:[UIFont fontWithName:@"Helvetica Neue" size:20]];
            NoResults.text=@"You have not downloaded any Voucher";
            [self.view addSubview:NoResults];
            
            
        }
        
    }
    
    else
    {
        [NoResults removeFromSuperview];
    }

}


-(void)displayMyvoucheriPad
{
     scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 200, 768, 1024-200)];
    scrollview.contentSize = CGSizeMake(768, (titleArray.count/2)*170);//1024-100
    scrollview.delegate = self;
    [self.view addSubview:scrollview];
    
    leftTableView = [[UITableView alloc] init];
    leftTableView.delegate = self;
    leftTableView.dataSource = self;
    leftTableView.tag = 501;
    leftTableView.scrollEnabled = NO;
    leftTableView.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f];
    leftTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    leftTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    leftTableView.frame = CGRectMake(10, 0, 369, (titleArray.count/2)*170);
    [scrollview addSubview:leftTableView];
    
    rightTableView = [[UITableView alloc] init];
    rightTableView.delegate = self;
    rightTableView.dataSource = self;
    rightTableView.tag = 502;
    rightTableView.scrollEnabled = NO;
    rightTableView.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f];
    rightTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    rightTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    rightTableView.frame = CGRectMake(389, 0, 369, (titleArray.count/2)*170);
    [scrollview addSubview:rightTableView];
    
    if(titleArray.count==0)
    {
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            
            NoResults.numberOfLines=5;
            NoResults.lineBreakMode=NSLineBreakByWordWrapping;
            [NoResults setFont:[UIFont fontWithName:@"Helvetica Neue" size:16]];
            NoResults.text=@"You have not downloaded any Voucher.";
            [self.view addSubview:NoResults];
        }
        else
        {
            
            NoResults.numberOfLines=5;
            NoResults.lineBreakMode=NSLineBreakByWordWrapping;
            [NoResults setFont:[UIFont fontWithName:@"Helvetica Neue" size:20]];
            NoResults.text=@"You have not downloaded any Voucher";
            [self.view addSubview:NoResults];
            
            
        }
        
    }
    
    else
    {
        [NoResults removeFromSuperview];
    }

    
}


- (void) participateMethod : (id) sender
{
    
    OfferDetailsController *offerID=[[OfferDetailsController alloc]init];
    UIButton *btn = (UIButton *) sender;
    if (flag==1) {

        offerID.newestOfferID=[offerIDDownloaded objectAtIndex:btn.tag];
    }
    else if(flag==2)
    {
        offerID.newestOfferID=[offerIDRedem objectAtIndex:btn.tag];
    }
    else if(flag==3)
    {
         offerID.newestOfferID=[offerIDshared objectAtIndex:btn.tag];
    }
    
    [self.navigationController pushViewController:offerID animated:YES];
}

@end
