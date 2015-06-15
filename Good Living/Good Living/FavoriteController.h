//
//  FavoriteController.h
//  Good Living
//
//  Created by Nanostuffs's Macbook on 28/09/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "GAI.h"

@interface FavoriteController : GAITrackedViewController<UITableViewDataSource,UITableViewDelegate>
{
    AppDelegate *delegate;
    UITableView *offerstablevie,*offerstablevie1,*offerstablevie2;
    UIAlertView *getOffer;
    UIScrollView *mainScrollview;
    
    NSMutableArray *favID,*favImages,*favTitles,*favMerchantName,*dateAdded,*favIDLeft,*favIDRight;
    
    NSMutableArray *DataArray;
  
    NSMutableArray *LEFTtitleArray,*LEFTsubtitleArray;
    NSMutableArray *RIGHTtitleArray,*RIGHTsubtitleArray;
    NSMutableArray *LEFTimagesArray,*RIGHTimagesArray;
    
    UIButton *deletebtn;
//    UIAlertView *getOfferAlert;
}

@end
