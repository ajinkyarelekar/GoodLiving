//
//  LeftPanelViewController.h
//  Good Living
//
//  Created by Minakshi on 9/20/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@protocol LeftPanelViewControllerDelegate <NSObject>

@optional
- (void)imageSelected:(UIImage *)image withTitle:(NSString *)imageTitle withCreator:(NSString *)imageCreator;

@end
@interface LeftPanelViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

{
    
    AppDelegate *delegate;
    CGFloat x_ratio;
    CGFloat y_ratio;
    
    //Menu
    UIView *menuView;
    UIButton *menuButton;
    
//    UIScrollView *menuScreenScrool;
    
    NSMutableArray *titleArray,*titleArray1;
    NSMutableArray *subTitleArray;
    
    UITableView *mainMenuTable,*mainMenuTable1;
    
    UILabel *accountHolderName;
    NSString *fname1;
    NSString *lname1;

}


@end
