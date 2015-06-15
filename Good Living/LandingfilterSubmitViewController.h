//
//  LandingfilterSubmitViewController.h
//  Good Living
//
//  Created by Ajinkya's on 01/11/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "GAI.h"

@interface LandingfilterSubmitViewController : GAITrackedViewController <UISearchBarDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIGestureRecognizerDelegate>
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
    UIView *emirateImage;
    
    int counter;
    
    UIAlertView *waitingAlt;
    NSString *areaString,*CuisineStrimg;
    
    NSArray *tabsarray;
    UIButton *hidePremium;
    UILabel *NoResults;
    
    UIAlertView *filterdelay;
    UIButton *overlayButton;
    
}
//@property (nonatomic, retain) NSString *titleString;
@property (nonatomic, retain) NSString *titleString,*emirateString;
@property(nonatomic)BOOL IsFromSubmitBtn;@end
