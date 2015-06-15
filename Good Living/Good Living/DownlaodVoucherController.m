//
//  DownlaodVoucherController.m
//  Good Living
//
//  Created by NanoStuffs on 06/09/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import "DownlaodVoucherController.h"
#import "LeadingViewController.h"
#import "MyAccountController.h"
#import "ViewController.h"
#import "MyVoucherController.h"
#import "myPurchaseController.h"
#import "ContactusController.h"
#import "aboutGoodLivingController.h"
#import "notificationController.h"

#import "UIImage+MDQRCode.h"

@interface DownlaodVoucherController ()

@end

@implementation DownlaodVoucherController
@synthesize titleName,merchantName,voucherCode,logoImg;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    delegate = [[UIApplication sharedApplication] delegate];
    
    self.view.backgroundColor = [UIColor colorWithRed:88/255.0f green:88/255.0f blue:88/255.0f alpha:1.0f];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    //------------------------Navigation Bar
    UIImageView *navigationImage = [[UIImageView alloc] init];
    navigationImage.backgroundColor = [UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f];
    [self.view addSubview:navigationImage];
    
    UILabel *topLable = [[UILabel alloc] init];
    topLable.text = @"Download Voucher";
    topLable.textAlignment = NSTextAlignmentCenter;
    topLable.textColor = [UIColor whiteColor];
    topLable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topLable];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    //MainScroll
    mainscrollvertical = [[UIScrollView alloc] init];
    mainscrollvertical.delegate = self;
    mainscrollvertical.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f];
    [self.view addSubview:mainscrollvertical];

    UILabel *showTheVoucText = [[UILabel alloc] init];
    showTheVoucText.text =@"Show this voucher to the merchant to redeem the \n offer.";
    showTheVoucText.textAlignment = NSTextAlignmentLeft;
    showTheVoucText.numberOfLines = 2;
    showTheVoucText.lineBreakMode = NSLineBreakByCharWrapping;
    showTheVoucText.textColor = [UIColor whiteColor];
    showTheVoucText.backgroundColor = [UIColor clearColor];
    [mainscrollvertical addSubview:showTheVoucText];

    UILabel *offerAvailableText = [[UILabel alloc] init];
    offerAvailableText.text =@"Offer available with m-voucher, printed voucher or goodliving card.";
    offerAvailableText.numberOfLines=2;
    offerAvailableText.lineBreakMode = NSLineBreakByWordWrapping;
    offerAvailableText.textAlignment = NSTextAlignmentLeft;
    offerAvailableText.textColor = [UIColor whiteColor];
    offerAvailableText.backgroundColor = [UIColor clearColor];
    [mainscrollvertical addSubview:offerAvailableText];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        showTheVoucText.frame = CGRectMake(15, 7, 300, 32);
        offerAvailableText.frame = CGRectMake(15, 37, 300, 32);
        
        showTheVoucText.font = [UIFont fontWithName:@"Helvetica Neue" size:11];
        showTheVoucText.font = [UIFont boldSystemFontOfSize:12];

        offerAvailableText.font = [UIFont fontWithName:@"Helvetica Neue" size:11];
        offerAvailableText.font = [UIFont boldSystemFontOfSize:12];
    }
    else
    {
        showTheVoucText.frame = CGRectMake(30, 40, 708, 30);
        offerAvailableText.frame = CGRectMake(30, 100, 708, 60);
        
        showTheVoucText.font = [UIFont fontWithName:@"Helvetica Neue" size:25];
        showTheVoucText.font = [UIFont boldSystemFontOfSize:25];

        offerAvailableText.font = [UIFont fontWithName:@"Helvetica Neue" size:25];
        offerAvailableText.font = [UIFont boldSystemFontOfSize:25];
    }

    
    UIImageView *background = [[UIImageView alloc] init];
    [mainscrollvertical addSubview:background];
    background.image = [UIImage imageNamed:@"bg.png"];
    
    UIImageView *ffflogo = [[UIImageView alloc] init];
    [mainscrollvertical addSubview:ffflogo];
    
    //UIImage *img1 = logoImg;
    
    if(UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPhone)
        ffflogo.frame = CGRectMake(124, 80, 72, 36);
    else
        ffflogo.frame = CGRectMake(40, 41, 72, 70);
    
    UIActivityIndicatorView *activityview1 = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityview1.center = CGPointMake(ffflogo.bounds.size.width / 2,ffflogo.bounds.size.height /2);
    [activityview1 startAnimating];
    [ffflogo addSubview:activityview1];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        NSData *imageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",logoImg  ]]];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (imageData)
            {
                NSArray *subviewArray = [ffflogo subviews];
                
                for (UIView *view in subviewArray)
                {
                    if([view isKindOfClass:[UIActivityIndicatorView class]])
                    {
                        UIActivityIndicatorView *activity = (UIActivityIndicatorView *)view;
                        [activity stopAnimating];
                        [activity removeFromSuperview];
                    }
                }
                //                [gnOffersBtn setImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
                UIImage *imageGNoff = [UIImage imageWithData:imageData];
                
                if (imageGNoff.size.width*2 <  ffflogo.frame.size.width || imageGNoff.size.height*2 < ffflogo.frame.size.height)
                {
                    [ffflogo setContentMode:UIViewContentModeScaleAspectFit];
                }
                ffflogo.image =imageGNoff;
            }
            else
                ffflogo.image =[UIImage imageNamed:@"11.png"];
        });
    });
    
    UILabel *discountLbl = [[UILabel alloc] init];
    discountLbl.text = titleName;
    discountLbl.textAlignment = NSTextAlignmentCenter;
    discountLbl.textColor = [UIColor colorWithRed:91/255.0f green:91/255.0f blue:91/255.0f alpha:1.0f];
    discountLbl.backgroundColor = [UIColor clearColor];
    discountLbl.numberOfLines = 2;
    discountLbl.lineBreakMode = NSLineBreakByWordWrapping;
    [mainscrollvertical addSubview:discountLbl];
    
    UILabel *Contact = [[UILabel alloc] init];
    Contact.text = @"Use voucher code below on merchant app/portal";
    Contact.textAlignment = NSTextAlignmentLeft;
    Contact.textColor = [UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f];
    Contact.backgroundColor = [UIColor clearColor];
    [mainscrollvertical addSubview:Contact];
    
    UIImageView *imageViewVouCode = [[UIImageView alloc] init];
    imageViewVouCode.image = [UIImage imageNamed:@"codebg.png"];
    [mainscrollvertical addSubview:imageViewVouCode];
    
    UILabel *contactDes = [[UILabel alloc] init];
    contactDes.text = voucherCode;
    contactDes.textAlignment = NSTextAlignmentCenter;
    contactDes.textColor = [UIColor colorWithRed:136/255.0f green:136/255.0f blue:136/255.0f alpha:1.0f];
    contactDes.backgroundColor = [UIColor clearColor];
    [mainscrollvertical addSubview:contactDes];

    //88 88 88
    UILabel *forMerchant = [[UILabel alloc] init];
    forMerchant.text =@"Or scan the QR code below";
    forMerchant.textAlignment = NSTextAlignmentLeft;
    forMerchant.textColor = [UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f];
    forMerchant.backgroundColor = [UIColor clearColor];
    [mainscrollvertical addSubview:forMerchant];
    
    UIImageView *imageViewqrCodebg = [[UIImageView alloc] init];
    imageViewqrCodebg.image = [UIImage imageNamed:@"qrbg.png"];
    [mainscrollvertical addSubview:imageViewqrCodebg];
    
    UILabel *enterPinLable = [[UILabel alloc] init];
    enterPinLable.text =@"Or click to enter 4 - digit PIN";
    enterPinLable.textAlignment = NSTextAlignmentLeft;
    enterPinLable.textColor = [UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f];
    enterPinLable.backgroundColor = [UIColor clearColor];
    [mainscrollvertical addSubview:enterPinLable];
    
    UIImageView *redeembg = [[UIImageView alloc] init];
    redeembg.image = [UIImage imageNamed:@"redeembg.png"];
    [mainscrollvertical addSubview:redeembg];

    UIButton *redeemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [redeemButton addTarget:self action:@selector(redeemMethod) forControlEvents:UIControlEventTouchUpInside];
    [redeemButton setTitle:@"REDEEM" forState:UIControlStateNormal];
    [redeemButton setBackgroundImage:[UIImage imageNamed:@"redeembtn.png"] forState:UIControlStateNormal];
    [mainscrollvertical addSubview:redeemButton];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        navigationImage.frame = CGRectMake(0, 0, 320, 64);
        backButton.frame = CGRectMake(5,25, 35, 35);
        background.frame = CGRectMake(9, 70, 302, 430);

        topLable.frame = CGRectMake(0, 25, 320, 30);
        topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:18];

        discountLbl.frame = CGRectMake(20, 122, 280, 25);
        discountLbl.font = [UIFont fontWithName:@"Helvetica Neue" size:11];
        
        forMerchant.frame=CGRectMake(30, 218, 260, 15);
        forMerchant.font = [UIFont fontWithName:@"Helvetica Neue" size:11];
        forMerchant.font = [UIFont boldSystemFontOfSize:11];
        
        enterPinLable.frame=CGRectMake(30, 370, 260, 15);
        enterPinLable.font = [UIFont fontWithName:@"Helvetica Neue" size:11];
        enterPinLable.font = [UIFont boldSystemFontOfSize:11];
        
        Contact.frame = CGRectMake(30, 150, 260, 15);
        Contact.font = [UIFont fontWithName:@"Helvetica Neue" size:11];
        Contact.font = [UIFont boldSystemFontOfSize:11];
        
        imageViewVouCode.frame = CGRectMake(30, 170, 260, 38);

        imageViewqrCodebg.frame = CGRectMake(30, 243, 260, 116);
        
        redeembg.frame = CGRectMake(30, 395, 260, 53);
        
        redeemButton.frame = CGRectMake(100, 402, 100, 40);
        
        contactDes.frame = CGRectMake(30, 174, 260, 30);
        contactDes.font = [UIFont fontWithName:@"Helvetica Neue" size:25];
        
        mainscrollvertical.frame = CGRectMake(0, 64, 320, self.view.frame.size.height-64);
        mainscrollvertical.contentSize = CGSizeMake(320, 568);
    }
    else
    {
        navigationImage.frame = CGRectMake(0, 0, 768, 64);
        backButton.frame = CGRectMake(5,22, 35, 35);
        background.frame = CGRectMake(40, 180, 688, 750);

        topLable.frame = CGRectMake(0, 25, 768, 30);
        topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:18];

        mainscrollvertical.frame = CGRectMake(0, 64, 768, self.view.frame.size.height-64);
        mainscrollvertical.contentSize = CGSizeMake(768, 1400);
        
        ffflogo.frame = CGRectMake(309, 210, 150, 50);
        
        discountLbl.frame = CGRectMake(70, 260, 628, 70);
        discountLbl.font = [UIFont fontWithName:@"Helvetica Neue" size:28];
        
        Contact.frame = CGRectMake(70, 340, 628, 32);
        Contact.font = [UIFont fontWithName:@"Helvetica Neue" size:28];
        
        imageViewVouCode.frame = CGRectMake(70, 380, 628, 60);

        contactDes.frame = CGRectMake(100, 390, 568, 40);
        contactDes.font = [UIFont fontWithName:@"Helvetica Neue" size:35];

        forMerchant.frame=CGRectMake(70, 460, 628, 32);
        forMerchant.font = [UIFont fontWithName:@"Helvetica Neue" size:28];
        
        imageViewqrCodebg.frame = CGRectMake(70, 500, 628, 250);

        enterPinLable.frame=CGRectMake(70, 762, 628, 32);
        enterPinLable.font = [UIFont fontWithName:@"Helvetica Neue" size:28];
        
        redeembg.frame = CGRectMake(70, 804, 628, 90);
        redeemButton.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:30];
        redeemButton.frame = CGRectMake(234, 814, 300, 70);
    }
    
    [self generateQRImage];
}

- (void) redeemMethod
{
    redeemFlag = 1;
    passwordView = [[UIView alloc] init];
    passwordView.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255 blue:0.0f/255.0f alpha:0.7f];
    [self.view addSubview:passwordView];
    

    UILabel *lable = [[UILabel alloc] init];
    lable.text = @"Please ask the merchant to enter their PIN";
    lable.textColor = [UIColor whiteColor];
    lable.backgroundColor = [UIColor clearColor];
    [passwordView addSubview:lable];
    
    
    
    textField1 = [[UITextField alloc] init];
    textField1.keyboardType=UIKeyboardTypeNumberPad;
    textField1.delegate = self;
    textField1.textAlignment = NSTextAlignmentCenter;
    textField1.backgroundColor = [UIColor whiteColor];
    textField1.textColor = [UIColor blackColor];
    [passwordView addSubview:textField1];
    [textField1 becomeFirstResponder];
    
    textField2 = [[UITextField alloc] init];
    textField2.keyboardType=UIKeyboardTypeNumberPad;

    textField2.delegate = self;
    textField2.textAlignment = NSTextAlignmentCenter;
    textField2.backgroundColor = [UIColor whiteColor];
    textField2.textColor = [UIColor blackColor];
    [passwordView addSubview:textField2];
    
    textField3 = [[UITextField alloc] init];
    textField3.keyboardType=UIKeyboardTypeNumberPad;
    textField3.delegate = self;
    textField3.textAlignment = NSTextAlignmentCenter;
    textField3.backgroundColor = [UIColor whiteColor];
    textField3.textColor = [UIColor blackColor];
    [passwordView addSubview:textField3];
    
    textField4 = [[UITextField alloc] init];
    textField4.keyboardType=UIKeyboardTypeNumberPad;
    textField4.delegate = self;
    textField4.textAlignment = NSTextAlignmentCenter;
    textField4.backgroundColor = [UIColor whiteColor];
    textField4.textColor = [UIColor blackColor];
    [passwordView addSubview:textField4];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        passwordView.frame = CGRectMake(0, 64, 320, self.view.frame.size.height-64);
        
        lable.frame = CGRectMake(30, 100, 260, 15);
        lable.font = [UIFont fontWithName:@"Helvetica Neue" size:11];
        lable.font = [UIFont boldSystemFontOfSize:11];
        
        textField1.frame = CGRectMake(30, 125, 50, 50);
        textField2.frame = CGRectMake(100, 125, 50, 50);
        textField3.frame = CGRectMake(170, 125, 50, 50);
        textField4.frame = CGRectMake(240, 125, 50, 50);
    }
    else
    {
        passwordView.frame = CGRectMake(0, 64, 768, self.view.frame.size.height-64);
        
        lable.frame = CGRectMake(50, 200, 668, 32);
        lable.font = [UIFont fontWithName:@"Helvetica Neue" size:28];
        lable.font = [UIFont boldSystemFontOfSize:28];
        
        textField1.frame = CGRectMake(109,  250, 100, 100);
        textField2.frame = CGRectMake(259, 250, 100, 100);
        textField3.frame = CGRectMake(409, 250, 100, 100);
        textField4.frame = CGRectMake(559, 250, 100, 100);
    }
}


-(void)redeomMethod
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self checkRedeom];
    });
}

-(void)checkRedeom
{
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSString *userId1=delegate.userID;
        NSString *lat=delegate.lattitude;
        NSString *longt=delegate.longitude;
        
        
        NSString *textField1Str=[textField1.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *textField2Str=[textField2.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *textField3Str=[textField3.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *textField4Str=[textField4.text stringByReplacingOccurrencesOfString:@" " withString:@""];

//        NSString *merchantPin=[NSString stringWithFormat:@"%@%@%@%@",textField1.text,textField2.text,textField3.text,textField4Str];
        NSString *merchantPin=[NSString stringWithFormat:@"%@%@%@%@",textField1Str,textField2Str,textField3Str,textField4Str];
        
        NSUserDefaults *UserDefault=[NSUserDefaults standardUserDefaults];
        NSData *data1;
        
        data1= [UserDefault valueForKey:@"fname"];
        
        NSString * name=[NSKeyedUnarchiver unarchiveObjectWithData:[UserDefault valueForKey:@"fname"]];
        
        name=[name stringByAppendingString:[NSString stringWithFormat:@" %@",[NSKeyedUnarchiver unarchiveObjectWithData:[UserDefault valueForKey:@"lname"]]]];
        
        //Redeem_User_App
        [Flurry logEvent:[NSString stringWithFormat:@"Download Voucher - %@",voucherCode]];
        [Flurry logPageView];
        
        //[NSString stringWithFormat:@"Download Voucher - %@",voucherCode]
        
        self.screenName = [NSString stringWithFormat:@"Download Voucher %@",voucherCode];
        
        NSString *url = [NSString stringWithFormat:@"https://testws.goodliving.ae/api/index.php/offer/redeemVoucherByUserApp/%@/%@/%@/%@/%@",merchantPin,lat,longt,voucherCode,userId1];
        url=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        //request.URL=[NSURL URLWithString:url];
        [request setURL:[NSURL URLWithString:url]];
        [request setHTTPMethod:@"POST"];
        NSHTTPURLResponse *response = nil;
        NSError *error = [[NSError alloc] init];
        NSData *data= [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        NSString *returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSDictionary*json;
        if (data)
        {
            NSError* error;
            json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSMutableArray *DataArray = [json objectForKey:@"data"];
            
            NSString *status=[[DataArray objectAtIndex:0] valueForKey:@"status"];
            NSString *message=[[DataArray objectAtIndex:0] valueForKey:@"msg"];
            
            if ([[NSString stringWithFormat:@"%@",status] isEqual:@"1"])
            {
                [self redeemSuccessMethod:message];
                

//                
//                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                if (Pass3Times < 2)
                {
                    Pass3Times = Pass3Times+1;
                  
                    textField1.text=@"";
                    textField2.text=@"";
                    textField3.text=@"";
                    [textField1 becomeFirstResponder];
                    textField4.text=@"";

                    
                    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error!" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    
                    [alertView show];
                }
                else
                {
//                    Pass3Times = 0;
                    [self.view endEditing:YES];
            
                    
                    UIAlertView* alertView1 = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Sorry 3 attempts exceeded. Use Merchant App or Merchant Portal to redeem this voucher."  delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                    alertView1.tag=100;
                    [alertView1 show];

                
                }
            }
        }
    });
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==100)
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)needMethod
{
    
}
- (void) backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark- UIAlertView Delegate

-(void)willPresentAlertView:(UIAlertView *)alertView{
   
}


#pragma mark- Textfield Delegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range  replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    newString=[newString stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if ([string length]==0)
    {
        UIResponder* nextResponder;
        
        if (textField == textField4)
            nextResponder = textField3;
        else if(textField == textField3)
            nextResponder = textField2;
        else if(textField == textField2)
            nextResponder = textField1;
        
        if (nextResponder)
            [nextResponder performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.1];
        return YES;
    }
    
    
    if(newString.length == 1)
    {
        UIResponder* nextResponder;
        
        if (textField == textField1)
            nextResponder = textField2;
        else if(textField == textField2)
            nextResponder = textField3;
        else if(textField == textField3)
            nextResponder = textField4;
        
        if (nextResponder)
            [nextResponder performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.1];
        else
        {
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                [self checkRedeom];
//            });
            //textField4.text=newString;
            
            [self performSelector:@selector(checkRedeom) withObject:nil afterDelay:0.2f];
            
            return newString.length <= 1;
        }
    }
    
    
    return newString.length <= 1;
}


- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    
      //  [textField resignFirstResponder];
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        self.view.frame=CGRectMake(0, 0, 320, 568);
    }
    else
    {
        self.view.frame=CGRectMake(0, 0, 768, 1024);
    }
    textField.text=@" ";
//    if(textField==textField3)
//    {
//        //commented by gafar here is empty space
//        textField3.text=@" ";
//    }
//
//    //commented by gafar here is empty space
//    if(textField==textField4)
//    {
//        //commented by gafar here is empty space
//        textField4.text=@" ";
//    }
}

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    //    if ([textField1.text length] > 0)
    //    {
    //        [textField1 resignFirstResponder];
    //        [textField2 resignFirstResponder];
    //    }
}

- (BOOL) textFieldShouldReturn:(UITextField*)textField
{
    if (redeemFlag == 1)
    {
        if ([textField1.text length] > 0 && [textField2.text length] && [textField3.text length] > 0 && [textField4.text length] > 0)
        {
            [textField resignFirstResponder];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self checkRedeom];
            });
            
            return YES;
        }
        else
            return YES;
    }
    else
    {
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            self.view.frame=CGRectMake(0, 0, 320, 568);
        }
        else
        {
            self.view.frame=CGRectMake(0, 0, 768, 1024);
            
        }
        // mainscrollvertical.frame = CGRectMake(0, 64, 320, self.view.frame.size.height-64);
        
        [textField resignFirstResponder];
        return TRUE;
    }
}

- (void) redeemSuccessMethod:(NSString *)msg
{
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Enjoy!" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];

               [alertView show];
    
    [passwordView removeFromSuperview];
    redeemFlag = 1;
    RedeemSuccessView = [[UIView alloc] init];
    RedeemSuccessView.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255 blue:0.0f/255.0f alpha:0.7f];
    [self.view addSubview:RedeemSuccessView];
    
    
    UILabel *lable = [[UILabel alloc] init];
    lable.text = @"Offer available with m-voucher,printed voucher or Good Living card.";
    lable.textColor = [UIColor whiteColor];
    lable.backgroundColor = [UIColor clearColor];
    lable.numberOfLines = 2;
    lable.lineBreakMode = NSLineBreakByWordWrapping;
    lable.font = [UIFont boldSystemFontOfSize:11];
    [RedeemSuccessView addSubview:lable];
    
    UIImageView *whitwbackImage = [[UIImageView alloc] init];
    whitwbackImage.image = [UIImage imageNamed:@"bg.png"];
    [RedeemSuccessView addSubview:whitwbackImage];
    
    UIImageView *ffflogo = [[UIImageView alloc] init];
    [RedeemSuccessView addSubview:ffflogo];
    
//    UIImage *img1 =logoImg;
//    if (img1.size.width*2 <  ffflogo.frame.size.width || img1.size.height*2 < ffflogo.frame.size.height)
//    {
//        [ffflogo setContentMode:UIViewContentModeScaleAspectFit];
//    }
//    ffflogo.image =img1;
    
    
    UIActivityIndicatorView *activityview1 = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityview1.center = CGPointMake(ffflogo.bounds.size.width / 2,ffflogo.bounds.size.height /2);
    [activityview1 startAnimating];
    [ffflogo addSubview:activityview1];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        NSData *imageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",logoImg  ]]];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (imageData)
            {
                NSArray *subviewArray = [ffflogo subviews];
                
                for (UIView *view in subviewArray)
                {
                    if([view isKindOfClass:[UIActivityIndicatorView class]])
                    {
                        UIActivityIndicatorView *activity = (UIActivityIndicatorView *)view;
                        [activity stopAnimating];
                        [activity removeFromSuperview];
                    }
                }
                //                [gnOffersBtn setImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
                UIImage *imageGNoff = [UIImage imageWithData:imageData];
                
                if (imageGNoff.size.width*2 <  ffflogo.frame.size.width || imageGNoff.size.height*2 < ffflogo.frame.size.height)
                {
                    [ffflogo setContentMode:UIViewContentModeScaleAspectFit];
                }
                ffflogo.image =imageGNoff;
            }
            else
                ffflogo.image =[UIImage imageNamed:@"11.png"];
        });
    });
    
    
    UILabel *discountLbl = [[UILabel alloc] init];
    discountLbl.text = titleName;
    discountLbl.textAlignment = NSTextAlignmentCenter;
    discountLbl.textColor = [UIColor colorWithRed:91/255.0f green:91/255.0f blue:91/255.0f alpha:1.0f];
    discountLbl.backgroundColor = [UIColor clearColor];
    discountLbl.numberOfLines = 2;
    discountLbl.lineBreakMode = NSLineBreakByWordWrapping;
    [RedeemSuccessView addSubview:discountLbl];

    UIImageView *BackimageView = [[UIImageView alloc] init];
    BackimageView.image = [UIImage imageNamed:@"bg1.png"];
    [RedeemSuccessView addSubview:BackimageView];

    UIImageView *successimageView = [[UIImageView alloc] init];
    successimageView.image = [UIImage imageNamed:@"done.png"];
    [RedeemSuccessView addSubview:successimageView];
    
    UILabel *redumptionLbl = [[UILabel alloc] init];
    redumptionLbl.text = @"Success! Redemption complete";
    redumptionLbl.textAlignment = NSTextAlignmentCenter;
    redumptionLbl.textColor = [UIColor colorWithRed:91/255.0f green:91/255.0f blue:91/255.0f alpha:1.0f];
    redumptionLbl.backgroundColor = [UIColor clearColor];
    [RedeemSuccessView addSubview:redumptionLbl];

    UILabel *codeLbl = [[UILabel alloc] init];
    codeLbl.text = @"#12345 0 AA";
    codeLbl.textAlignment = NSTextAlignmentCenter;
    codeLbl.textColor = [UIColor colorWithRed:91/255.0f green:91/255.0f blue:91/255.0f alpha:1.0f];
    codeLbl.backgroundColor = [UIColor clearColor];
    //[RedeemSuccessView addSubview:codeLbl];
    
    
    UIButton *DoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [DoneBtn setTitle:@"DONE" forState:UIControlStateNormal];
    [DoneBtn setTitleColor:[UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [DoneBtn addTarget:self action:@selector(doneMethod) forControlEvents:UIControlEventTouchUpInside];
    [DoneBtn setBackgroundImage:[UIImage imageNamed:@"donebtn.png"] forState:UIControlStateNormal];
    [RedeemSuccessView addSubview:DoneBtn];
    
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        RedeemSuccessView.frame = CGRectMake(0, 64, 320, self.view.frame.size.height-64);

        lable.frame = CGRectMake(30, 10, 260, 30);
        lable.font = [UIFont fontWithName:@"Helvetica Neue" size:11];
        lable.font = [UIFont boldSystemFontOfSize:12];
        
        whitwbackImage.frame = CGRectMake(9, 45, 302, 365);
        ffflogo.frame = CGRectMake(124, 60, 72, 36);
        
        discountLbl.frame = CGRectMake(20, 100, 280, 25);
        discountLbl.font = [UIFont fontWithName:@"Helvetica Neue" size:11];
        BackimageView.frame = CGRectMake(30, 130, 260, 265);
        successimageView.frame = CGRectMake(115, 170, 90, 90);
        redumptionLbl.frame = CGRectMake(20, 260, 280, 15);
        redumptionLbl.font = [UIFont fontWithName:@"Helvetica Neue" size:11];
        codeLbl.frame = CGRectMake(20, 320, 280, 22);
        codeLbl.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
        codeLbl.font = [UIFont boldSystemFontOfSize:18];
        DoneBtn.frame = CGRectMake(60, 350, 200, 40);
    }
    else
    {
        RedeemSuccessView.frame = CGRectMake(0, 64, 768, self.view.frame.size.height-64);
        
        lable.frame = CGRectMake(50, 40, 668, 80);
        lable.font = [UIFont fontWithName:@"Helvetica Neue" size:28];
        lable.font = [UIFont boldSystemFontOfSize:28];

        whitwbackImage.frame = CGRectMake(50, 130, 668, 800);

        ffflogo.frame = CGRectMake(309, 145, 150, 90);
        
        discountLbl.frame = CGRectMake(70, 245, 628, 32);
        discountLbl.font = [UIFont fontWithName:@"Helvetica Neue" size:28];
        
        BackimageView.frame = CGRectMake(80, 285, 608, 550);
        
        successimageView.frame = CGRectMake(294, 340, 180, 180);
        
        redumptionLbl.frame = CGRectMake(70, 540, 628, 28);
        redumptionLbl.font = [UIFont fontWithName:@"Helvetica Neue" size:22];

        codeLbl.frame = CGRectMake(70, 660, 628, 45);
        codeLbl.font = [UIFont fontWithName:@"Helvetica Neue" size:35];
        codeLbl.font = [UIFont boldSystemFontOfSize:35];
        
        DoneBtn.frame = CGRectMake(184, 720, 400, 80);
        DoneBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:35];
    }
}

- (void) doneMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dismissKeyboard {
    [textFiled1 resignFirstResponder];
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
    self.view.frame=CGRectMake(0, 0, 320, 568);
    }
    else
    {
        self.view.frame=CGRectMake(0, 0, 768, 1024);

    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void) generateQRImage
{
    UIImageView *QRCODEimage = [[UIImageView alloc] init];
    [mainscrollvertical addSubview:QRCODEimage];
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        QRCODEimage.frame=CGRectMake(107, 248, 106, 106);
    }
    else
    {
        QRCODEimage.frame=CGRectMake(284, 525, 200, 200);
    }
    QRCODEimage.image = [UIImage mdQRCodeForString:[NSString stringWithFormat:@"%@",voucherCode] size:QRCODEimage.bounds.size.width fillColor:[UIColor blackColor]];
}


@end