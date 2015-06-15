//
//  AppDelegate.h
//  Good Living
//
//  Created by NanoStuffs on 04/09/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

//gulfnews.goodliving

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

#import "Flurry.h"

#import "GAI.h"
#import "ViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    int loginFlag,subUpdateFlag,leftPannelflag;
    NSString *pass3;
}

@property(nonatomic, strong) id<GAITracker> tracker;

@property (strong, nonatomic) UIWindow *window;

@property int loginFlag,subUpdateFlag,leftPannelflag;

@property (nonatomic) NSString* userID,*pass3;
@property (nonatomic) NSString* password;
@property (nonatomic) NSString *emiratesLbl;
@property (nonatomic) NSString *lattitude;
@property (nonatomic) NSString *longitude;
@property (nonatomic)NSString *fname,*laname;
@property (nonatomic) int flag_btnSelected;
@property (nonatomic,retain)NSString *DeviceToken;
@property (nonatomic) int loginSuccessfulFLAG;

@property (strong,nonatomic) ViewController *viewController;
@property (strong,nonatomic) UINavigationController *navigController;
@end