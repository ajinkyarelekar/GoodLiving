//
//  AuthenticatedController.h
//  Good Living
//
//  Created by NanoStuffs on 17/09/14.
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

@interface AuthenticatedController : UIViewController<UIScrollViewDelegate,UITextFieldDelegate,MFMessageComposeViewControllerDelegate>

{
    AppDelegate *delegate;
    CGFloat x_ratio;
    CGFloat y_ratio;
    
    UIScrollView *authScrollScrool;
    UIScrollView *registerScrool;
    NSString *sub_bp,*sub_email,*sub_mobile,*email2,*Registergender2;
    
    UITextField *emailTextfield;
    UITextField *emailLableTextfield;
    UITextField *mobileNoLableLableTextfield;
    UIAlertView *otpAlert;
    NSString *mobileNumber;
    NSString *NameString;
}

@property (nonatomic) NSString *firstName,*lastName,*registerEmail,*Registergender,*mobileNumer,*password,*fname,*lname,*loginUsername;
@end
