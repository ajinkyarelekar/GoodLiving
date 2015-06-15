//
//  GNTravellerController.h
//  Good Living
//
//  Created by NanoStuffs on 11/09/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

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
#import "AppDelegate.h"

@interface GNTravellerController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

{
    AppDelegate *delegate;
    UIPageControl *pageControl;
    NSMutableArray *titleArray,*subtitleArray;
    
    UITableView *eventtableView;
    
  }
@end
