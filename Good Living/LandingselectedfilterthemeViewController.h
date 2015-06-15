//
//  LandingselectedfilterthemeViewController.h
//  Good Living
//
//  Created by Ajinkya's on 01/11/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LandingselectedfilterthemeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
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
