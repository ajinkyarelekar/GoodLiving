//
//  GNViewController.h
//  Good Living
//
//  Created by Minakshi on 9/26/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "GAI.h"

@interface GNViewController : GAITrackedViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    AppDelegate *delegate;
    UIButton *menuButton;
    
    UISearchBar *searchBar;
    
    UITableView *eventtableView;
    
    NSMutableArray *titleArray,*subtitleArray;
    
    NSMutableArray *LEFTtitleArray,*LEFTsubtitleArray;
    NSMutableArray *RIGHTtitleArray,*RIGHTsubtitleArray;
    NSMutableArray *LEFTimagesArray,*RIGHTimagesArray;

    
    NSMutableArray *smsCodeArray,*smsToArray,*winnerArray,*termsCondArray;
    NSMutableArray *Participation_Last_DateArray,*Winner_AnnouncedArray;
    
    NSMutableArray *selectIDArray;
    NSString *selectID;
    NSString *type;

    
    UILabel *topLable;
    
    //----- Webservice
    
    UIAlertView *getOfferAlert;
    
    NSString *giftName,*giftDesc;
    NSString *giftImg1,*giftImg2,*giftImg3,*giftImg4;
    NSMutableArray *giftImages;
    NSString *smsCode,*smsTo,*termsCond,*winner;
    
    //-------------- Swipe
    UISwipeGestureRecognizer *swipeGestureLeft;
}

-(void)getTheGiftOfWeek;
-(void)giftOfWeek;

@end