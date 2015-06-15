//
//  RegisterViewController.h
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

 * ************************************************
 * *************Changes on
 */


#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "GAI.h"

@interface RegisterViewController : GAITrackedViewController <UIScrollViewDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate,UIGestureRecognizerDelegate>
{
     AppDelegate *delegate;
    
    UIView *oneTimePassView;
    UIScrollView *authScrollScrool;
    UIScrollView *registerScrool;
    
    UITextField *genderTextfield;
    UIPickerView *myPickerView;
    
    UILabel *firstName, *lastName, *mobNum,*email, *Gender ,*password ,* confirmPass;

    UITableView *offerstablevie;
    NSArray *genderArray;
    
    UITextField *usernameTextfield;
    UITextField *lastNameTextfield;
    UITextField *mobileNum;
    UITextField *emailTextfield;
    UITextField *passwordTextfield;
    UIImageView *imgPass;
    UITextField *confirmpassTextfield;
    UIImageView *imgCPass;
    UIButton *btnCheckBox;
    UIButton *term;
    UIButton *registerBtn;
    
    UIButton *resendBtn;
    UITextField *emailTextfield12;
    int OTPCount;
    NSString *OTPRandom;
    
    CGFloat x_ratio;
    CGFloat y_ratio;
     int  checkCount;
    //---- Validation
    
    int ValidationFlag,validationPass,validationMobile;
    BOOL chekBoxFlag;
    
    NSString *GeneratedTime;
}


@property (nonatomic) int flag_btnSelected;

@end
