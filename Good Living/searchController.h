//
//  SelectedThemesController.h
//  Good Living
//
//  Created by NanoStuffs on 05/09/14.
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

@interface searchController : GAITrackedViewController <UISearchBarDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    AppDelegate *delegate;
    UIButton *menuButton;
    // NSString *titleString;
    UIScrollView *restorantImagesScrool;
    UIScrollView *mainScrollview;
    UIScrollView *tableView;
    
    UIButton *tabbutton;
    
    CGFloat x_ratio;
    CGFloat y_ratio;
    
    UIPickerView *myPickerView;
    
    UIImageView *lineImg;
    
    UISearchBar *searchBar;
    
    UISwipeGestureRecognizer *swipeGestureLeft;
    
    UITableView *tableviewemitare;
    NSMutableArray *emiritsArray;
    UILabel *emirateLable;
    UIView *emiritsBackView;
    UIImageView *arraowImage;
    
    UIPageControl *pageControl;
    
    UIScrollView *tabsScrool;
    
    UITableView *offerstablevie, *offerstablevie1;
    UIView *filterView;
    
    UIButton *emiratesbtn,*categorybtn,*Subcategorybtn,*storeNmbtn,*areabtn;
    
    UITableView *tableviewFilters;
    NSMutableArray *filtersArray;
    int filterSeleted;
    UIButton *emirateButton ;
    
    int counter;
    
    UIAlertView *waitingAlt;
    NSString *areaString;
    
    NSArray *tabsarray;
    UIButton *hidePremium;
    UILabel *NoResults;
    
    UIAlertView *filterdelay;
    
}
//@property (nonatomic, retain) NSString *titleString;
@property (nonatomic, retain) NSString *titleString,*emirateString;

@property(nonatomic , retain) NSMutableArray *filtersArray;

@end
