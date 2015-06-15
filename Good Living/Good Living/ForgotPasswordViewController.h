//
//  ForgotPasswordViewController.h
//  Good Living
//
//  Created by Nanostuffs's Macbook on 02/10/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "GAI.h"

@interface ForgotPasswordViewController : GAITrackedViewController<UITextFieldDelegate,UIScrollViewDelegate>
{
    AppDelegate *delegate;
    
    CGFloat x_ratio;
    CGFloat y_ratio;
    UITextField *emailTextfield;
}

@end
