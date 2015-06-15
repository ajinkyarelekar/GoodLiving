//
//  FilterController.h
//  Good Living
//
//  Created by NanoStuffs on 15/09/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

/**********************************************
 * Developer: Ankush Ladhane
 * Created on:
 * *************Changes on 19/09/2014**************
 * Design New Screen
 * ************************************************
 * *************Changes on
 */


#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "GAI.h"

@interface FilterController : GAITrackedViewController<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{

    AppDelegate *delegate;
    CGFloat x_ratio;
    CGFloat y_ratio;

    UISwipeGestureRecognizer * swipeGestureLeft;
    
    NSMutableArray *titleArray;
    NSMutableArray *subTitleArray;

    UITableView *offerstablevie;
    
    UIPickerView *myPickerView;

}
@property(strong,nonatomic)NSString *emiratesString,*themeString,*catagoryString,*areaString,*CuisineStrimg;

@end
