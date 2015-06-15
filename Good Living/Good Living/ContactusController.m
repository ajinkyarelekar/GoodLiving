//
//  ContactusController.m
//  Good Living
//
//  Created by NanoStuffs on 08/10/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import "ContactusController.h"
#import "Flurry.h"

@interface ContactusController ()

@end

@implementation ContactusController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //Contact_Us
    [Flurry logEvent:@"Contact_Us"];
    [Flurry logPageView];
    
    self.screenName = @"Contact_Us";
}

- (IBAction)backMethod:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)emailMethod:(id)sender
{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
        mail.mailComposeDelegate = self;
        [mail setSubject:@""];
        [mail setMessageBody:@"" isHTML:NO];
        [mail setToRecipients:@[@"goodliving@gulfnews.com"]];
        
        [self presentViewController:mail animated:YES completion:NULL];
    }
    else
    {
        NSLog(@"This device cannot send email");
    }
    
}

- (IBAction)faq:(id)sender
{
    FAQViewController *contact;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        contact = [[FAQViewController alloc]initWithNibName:@"FAQViewController" bundle:nil];
    else
        contact = [[FAQViewController alloc]initWithNibName:@"FAQViewControlleriPad" bundle:nil];
    
    [self.navigationController pushViewController:contact animated:YES];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultSent:
            NSLog(@"You sent the email.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"You saved a draft of this email");
            break;
        case MFMailComposeResultCancelled:
            NSLog(@"You cancelled sending this email.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed:  An error occurred when trying to compose this email");
            break;
        default:
            NSLog(@"An error occurred when trying to compose this email");
            break;
    }
  [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)callMethod:(id)sender{
    
    NSString *callid=@"80045";
    NSString *phoneNumber = [NSString stringWithFormat: @"telprompt://%@",callid];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
