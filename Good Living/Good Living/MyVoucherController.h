//
//  MyVoucherController.h
//  Good Living
//
//  Created by NanoStuffs on 10/09/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

/**********************************************
 * Developer: Ankush Ladhane
 * Created on:
 * *************Changes on 17/09/2014**************
 * list 1
 * list 2
 * list 3
 * ************************************************
 * *************Changes on
 */


#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "GAI.h"

@interface MyVoucherController : GAITrackedViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
{
    AppDelegate *delegate;
    UIButton *menuButton;
    
    UISearchBar *searchBar;
    UIAlertView *getMyVoucher;
    
    UITableView *eventtableView;
    UISegmentedControl *mySegmentedControl;

    NSMutableArray *titleArray,*subtitleArray,*voucherIdArray,*offerIDArrayiPhone;;
    
    NSMutableArray *logo,*mearchantName,*voucherCode,*offerImages,*Title,*redemptionMethod,*redemptionLocation,*Date_Downloaded,*Date_Redeemed,*VoucherId,*RedeemedOutlet,*Platform;
    
    NSMutableArray *logoUnused,*merchantNameUnused,*voucherCodeUnused,*titleUnused;
    
    NSMutableArray *logoShared,*merchantShared,*voucherCodeShared,*titleShared,*LeftLogoSharedArray,*RightLogoSharedArray;
    
    NSMutableArray *LEFTtitleArray,*LEFTsubtitleArray,*leftLogoArray,*LeftLogoUsedArray,*LeftDateRedeemedArray;
    NSMutableArray *RIGHTtitleArray,*RIGHTsubtitleArray,*rightLogoArray,*RightLogoUsedArray,*RightDateRedeemedArray;
    NSMutableArray *LEFTimagesArray,*RIGHTimagesArray;
    
    
    UITableView *leftTableView;
    UITableView *rightTableView;
    
    int flag;
    UILabel *NoResults;
    UIButton *overlayButton;
    UIScrollView *mainscrollview;
    UIScrollView *scrollview;
    
    NSMutableArray *offerIDDownloaded,*offerIDRedem,*offerIDshared;
    NSMutableArray *leftOfferID,*rightOfferID;
    
}
@end
