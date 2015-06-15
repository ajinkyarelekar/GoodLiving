//
//  TermsAndConditionController.h
//  Good Living
//
//  Created by NanoStuffs on 08/10/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface TermsAndConditionController : UIViewController <UIScrollViewDelegate>
{
    IBOutlet UIScrollView *scrollView;
        AppDelegate *delegate;
}
- (IBAction)backMethod:(id)sender;

- (IBAction)AgreeMethod:(id)sender;
- (IBAction)DisAgreeMethod:(id)sender;
@end
