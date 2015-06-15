//
//  ContactusController.h
//  Good Living
//
//  Created by NanoStuffs on 08/10/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "FAQViewController.h"
#import "GAI.h"

@interface ContactusController : GAITrackedViewController<MFMailComposeViewControllerDelegate>

- (IBAction)backMethod:(id)sender;
- (IBAction)emailMethod:(id)sender;
- (IBAction)callMethod:(id)sender;
- (IBAction)faq:(id)sender;
@end
