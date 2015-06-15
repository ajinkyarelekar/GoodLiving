//
//  MyCompetationController.h
//  Good Living
//
//  Created by Nanostuffs's Macbook on 28/09/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "GAI.h"

@interface MyCompetationController : GAITrackedViewController<UITableViewDelegate,UITableViewDataSource>

{
    AppDelegate *delegate;
    UIButton *menuButton;
    
    UISearchBar *searchBar;
    
    UITableView *eventtableView;
    
    NSMutableArray *idArray,*typeArray,*titleArray,*subtitleArray;
    
    NSMutableArray *LEFTtitleArray,*LEFTsubtitleArray;
    NSMutableArray *RIGHTtitleArray,*RIGHTsubtitleArray;
    NSMutableArray *LEFTimagesArray,*RIGHTimagesArray;
    
    
    NSMutableArray *smsCodeArray,*smsToArray,*winnerArray,*termsCondArray;
    NSMutableArray *Participation_Last_DateArray,*Winner_AnnouncedArray;
    
    
    
    UILabel *topLable;
    
    //----- Webservice
    
    UIAlertView *getOfferAlert;
    
    NSString *giftName,*giftDesc;
    NSString *giftImg1,*giftImg2,*giftImg3,*giftImg4;
    NSMutableArray *giftImages;
    NSString *smsCode,*smsTo,*termsCond,*winner,*participateCode,*winnerAnnounced;
    
     NSMutableArray *DataArray;
    
    UIButton *deletebtn;
    
    UILabel *NoResults;
}

-(void)getTheGiftOfWeek;
-(void)giftOfWeek;


@end
