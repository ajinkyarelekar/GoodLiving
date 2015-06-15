//
//  SelectGiftsOfTheWeekController.h
//  Good Living
//
//  Created by NanoStuffs on 11/09/14.
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

#import <MessageUI/MessageUI.h>

#import "GAI.h"

@interface SelectGiftsOfTheWeekController : GAITrackedViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,MFMessageComposeViewControllerDelegate>

{
    AppDelegate *delegate;

    UIScrollView *mainscrollvertical;
    
    UIPageControl *pageControl;
    NSMutableArray *titleArray,*subtitleArray;
    
    int descHeight,TandCHeight,previousWinnerHeight;
    
    UIAlertView *showAlert,*showAlert1;
    UITableView *eventtableView;
    
    NSString *wiinerDate;
     
}
@property(nonatomic) NSString *title,*smsCode,*smsTo,*termsCond,*winner,*name,*desc,*participentsDateby,*winnerAnaouncedBy;
@property(nonatomic) UIImage *img;
@property (nonatomic) NSString *type;
@property(nonatomic) NSString *selectID;
- (void)setTextColor:(UIColor *)textColor range:(NSRange)range;

@end
