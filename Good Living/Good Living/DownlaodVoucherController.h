//
//  DownlaodVoucherController.h
//  Good Living
//
//  Created by NanoStuffs on 06/09/14.
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

@interface DownlaodVoucherController : GAITrackedViewController <UIScrollViewDelegate,UITextFieldDelegate,UITextFieldDelegate>
{
    int Pass3Times;
    AppDelegate *delegate;
    UIButton *menuButton;
    
    UIButton *enterBtn;
    UITextField *textFiled1;
    UIButton *redeemBtn;
    
    UIScrollView *mainscrollvertical;
    UISwipeGestureRecognizer *swipeGestureLeft;

    UITextField *textField1,*textField2,*textField3,*textField4;
    int redeemFlag;
    
    UIView *RedeemSuccessView;
    UIView *passwordView;
}

@property(nonatomic) NSString *titleName;
@property (nonatomic) NSString *merchantName;
@property (nonatomic) NSString *voucherCode;
@property(nonatomic) NSURL *logoImg;

@end
