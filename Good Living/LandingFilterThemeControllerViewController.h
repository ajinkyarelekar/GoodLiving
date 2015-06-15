//
//  LandingFilterThemeControllerViewController.h
//  Good Living
//
//  Created by Ajinkya's on 01/11/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "GAI.h"

@interface LandingFilterThemeControllerViewController : GAITrackedViewController<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
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
