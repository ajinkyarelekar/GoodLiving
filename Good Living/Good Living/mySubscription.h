//
//  mySubscription.h
//  Good Living
//
//  Created by NanoStuffs on 07/10/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Customcell.h"
#import "AppDelegate.h"
@interface mySubscription : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    CGFloat x_ratio;
    CGFloat y_ratio;

    NSMutableArray *titleArray;
    NSMutableArray *subTitleArray;
    UITableView *myProfileTableView;
    
    NSDictionary *mydictionary;
    NSString *bpcode;
    NSString *email;
    NSString *mobile;
    
        AppDelegate *delegate;
    UIButton *updatebutton,*removebutton;
}
@end
