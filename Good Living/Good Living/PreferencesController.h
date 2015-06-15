//
//  PreferencesController.h
//  Good Living
//
//  Created by Minakshi on 9/19/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface PreferencesController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    AppDelegate *delegate;
    
    CGFloat x_ratio;
    CGFloat y_ratio;
    
    NSMutableArray *titleArray;
    NSMutableArray *emiritesArray;
    
    NSMutableArray *cellSelected;
    NSMutableArray *cellSelectedEM;
    
    UITableView *offerstablevie;
    UITableView *emiritaestablevie,*AreaTableView;
    UIAlertView *getPrefalert;
    UIAlertView *Savealert;
    
    UILabel *firstTimeAlert;
    UIScrollView *scrollview;
}

@property(retain,nonatomic) NSString *areaString,*emiratesString;
@end
