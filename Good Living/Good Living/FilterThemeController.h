//
//  FilterThemeController.h
//  Good Living
//
//  Created by Minakshi on 9/19/14.
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

@interface FilterThemeController : UIViewController<UITableViewDelegate,UITableViewDataSource>

{
    CGFloat x_ratio;
    CGFloat y_ratio;
    NSMutableArray *subTitleArray;
    NSMutableArray *cellSelected;
    UITableView *filterThemeTable;
    
    NSIndexPath *ZeroIndexPath;
}
@property(strong,nonatomic)NSString *tableFor,*DataString,*TopText,*themeString;
@property(strong,nonatomic)NSArray *titleArray;
@end
