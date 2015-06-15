//
//  ViewController.h
//  Good Living
//
//  Created by NanoStuffs on 04/09/14.
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
//#import "AppDelegate.h"

#import "GAI.h"

@class  AppDelegate;
//UIViewController


@interface ViewController : GAITrackedViewController  <UITextFieldDelegate,UIScrollViewDelegate>
{
    AppDelegate *delegate;
    
    CGFloat x_ratio;
    CGFloat y_ratio;
    UITextField *emailTextfield;
    UITextField *passwordTextfield;
 
    NSString *loginID,*loginUsername,*loginpassword,*message,*fname,*lname,*email,*gender;
    UIButton *KeyboarddoneButton;
    UIAlertView *loginalert;
}
@end
