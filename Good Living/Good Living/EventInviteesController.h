//
//  EventInviteesController.h
//  Good Living
//
//  Created by NanoStuffs on 09/09/14.
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

@interface EventInviteesController : GAITrackedViewController <UISearchBarDelegate, UITableViewDataSource,UITableViewDelegate>
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
    
     //-------- Swipe
     UISwipeGestureRecognizer *swipeGestureLeft;
}

-(void)getTheGiftOfWeek;
-(void)giftOfWeek;

@end
