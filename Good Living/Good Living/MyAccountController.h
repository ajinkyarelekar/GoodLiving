//
//  MyAccountController.h
//  Good Living
//
//  Created by NanoStuffs on 08/09/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

/**********************************************
 * Developer: Ankush Ladhane
 * Created on:
 * *************Changes on 19/09/2014**************
 * Design Screen
 * ************************************************
 * *************Changes on
 */


#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "mySubscription.h"

#import "GAI.h"

@interface MyAccountController : GAITrackedViewController <UITableViewDelegate,UITableViewDataSource>
{
    AppDelegate *delegate;
    CGFloat x_ratio;
    CGFloat y_ratio;
    
 
    NSMutableArray *titleArray;
    NSMutableArray *offersTbleviewArray;
    
    UITableView *offerstablevie;
    UITableView *profiletableview;
    
}

@end
