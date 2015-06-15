//
//  LeadingViewController.h
//  Good Living
//
//  Created by NanoStuffs on 04/09/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//


/**********************************************
 * Developer: Ankush Ladhane
 * Created on:
 * *************Changes on 17/09/2014**************
 * Design these screen on iPad

 * ************************************************
 * *************Changes on
 */

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import <MobileCoreServices/MobileCoreServices.h>
#import <CoreLocation/CoreLocation.h>

#import "GAI.h"

@protocol LeadingViewController <NSObject>
@optional
- (void)movePanelLeft;
- (void)movePanelRight;

@required
- (void)movePanelToOriginalPosition;

@end

@interface LeadingViewController : GAITrackedViewController < UIScrollViewDelegate, UIPickerViewDelegate,CLLocationManagerDelegate,UISearchBarDelegate>
{
    AppDelegate *delegate;
    
    UIScrollView *mainscrollvertical;
    UIPageControl *pageControl;
    
    UIAlertView *refreshAlert,*filterdelay;
    
    UISearchBar *searchBar;
    NSString *type;
    
    UITableView *tableviewemitare;
    NSMutableArray *emiritsArray;
    UILabel *emirateLable;
    UIView *emiritsBackView;
    UIButton *emirateButton ;
    
    CGFloat x_ratio;
    CGFloat y_ratio;
    
    UIPickerView *myPickerView;
    UIButton *menuButton;
    
    UIActivityIndicatorView *activity1;
    
    UIImageView *arraowImage;
    
    //------- Lattitude & Longitude
    
    CLLocationManager *locationManager;
    NSString *latitude,*longitude;
    
    //--- NewesOffer add object
    
    UIAlertView *getNewestAlert;
    NSMutableArray *newestOfferID,*newestOfferImg,*newestOfferTitle,*nearestLoc,*nearestLoc1;
    
    //---- Promotion Images
    
    NSMutableArray *promotionImgArr ,*promotionImgId ,*promotionType;
    
    //------ Nearest Offeer
     NSMutableArray *nearestOfferID,*nearestOfferImg,*nearestOfferTitle;
    
    UIAlertView *waitingAlt;
    BOOL isPanelVisible;
    UIButton *overlayButton;
    NSString *btnType;
    NSString *btnID;
 }

- (void)getnewestOffer;
-(void)newestOfferContent;

-(void)getPromotionImg;
-(void)promotionImgaes;
-(void)promotionMethod;

-(void)getNearestOffer;
-(void)nearestOffers;


@property (nonatomic, assign) id<LeadingViewController> delegate;

@property (nonatomic, weak)  UIButton *menuButton;



@end
