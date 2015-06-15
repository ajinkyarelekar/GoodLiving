//
//  myProfileController.h
//  Good Living
//
//  Created by Minakshi on 9/19/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface myProfileController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

{
    CGFloat x_ratio;
    CGFloat y_ratio;
    
    NSMutableArray *titleArray;
    NSMutableArray *subTitleArray;
     UITableView *myProfileTableView;
    AppDelegate *delegate;
    int validationMobile,ValidationFlag;

}
@end
