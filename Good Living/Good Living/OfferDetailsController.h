//
//  OfferDetailsController.h
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
#import <MessageUI/MessageUI.h>

#import "GAI.h"

@interface OfferDetailsController : GAITrackedViewController <UIScrollViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate,MFMailComposeViewControllerDelegate>
{
    AppDelegate *delegate;
    UIButton *menuButton;
    
    UIButton *featureButton2;
    
    UIPageControl *pageControl;
    UIPickerView *myPickerView;
    
    UILabel *contactpersonlabel1;
    UILabel *addresslabel1;
    UILabel *locationlabel1;
    UILabel *phonelabel1;
    UILabel *emaillabel1;
    
    UIAlertView *showAlert;

    UIButton *featureButton1;
    NSArray *FeaturesArra ;
    NSInteger selectedArrIndex;
    //swipe
    UISwipeGestureRecognizer *swipeGestureLeft;
    UIScrollView *mainScrool;
    UIView *ContactInfoView;
    
    // Webservice
    
    UIAlertView *getNewestAlert;
    UIAlertView *myAlert,*showAlert1;
    
    NSString *offerID,*title,*offerDesc,*termsAndCondition,*offersName,*logoUrl,*maincategory;
    NSString  * merchantDesc;
    NSString *offerImg1,*offerImg2,*offerImg3,*offerImg4,*offerImg5,*is_favorite,*is_downloaded,*is_non_subscriber,*is_subscriber;
    NSArray *logoArr;
    NSMutableArray *offerArr,*locationArr;
    
    UILabel *contactemaillable;
    
    NSMutableArray *location,*emirates,*locationId ,*addressArr,*emailArr,*phoneArr,*contactPersonNameArr,*geoCordinates;
    NSMutableArray *mainLocationArr;
    
    NSMutableArray *lattitude, *longitude;
    
    int descHeight,tANDcHeight;
    UIView *dealsnearView;
    UIView *descriptionView;
    UIButton *featureButton3 ;
    
    UIScrollView *dealsNearScrool;
    
    
    UIButton *hideMenuButton,*hideMenuButtoniPad;
    
    //--- NewesOffer add object
    
    NSMutableArray *newestOfferIDArray,*newestOfferImg,*newestOfferTitle;
    //------ Nearest Offeer
    NSMutableArray *nearestOfferID,*nearestOfferImg,*nearestOfferTitle;
    //------------- Similar Offer
    NSMutableArray *similarOfferID,*similarOfferImg,*similarOfferTitle;

    
    BOOL check;
    CGFloat x_ratio;
    CGFloat y_ratio;
    
    UIButton *featureButtonmap;
    UIActivityIndicatorView *activityview1,*activityview2;
    UIActivityIndicatorView *activityIndicatorNew ;
    
    //-------------- Sharing
    UIImage *shareImage;
    UIAlertView *voucherAlert,*showAlert2;
    
    NSString *phoneNumber;
    
    UILabel *contactaddresslable;
    
    NSString *Preaddress;
    UILabel *contactlocationlable;
    UILabel *contactphonelable;
    UIButton *featureButton2iPad;
    
    BOOL isMenu_availabel;
    NSString *menuGlobalUrl;
    
    NSString *is_premium,*is_new;
  }
@property (nonatomic, retain) NSString *menuGlobalUrl;
@property (nonatomic, retain) NSString *Preaddress;

-(void)offerNameAndDesc;

@property(nonatomic) NSString *newestOfferID;

- (void) downloadVoucherMethod;
-(void)removeFavorite;
-(void)addFavorite;
@end
