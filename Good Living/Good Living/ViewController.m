//
//  ViewController.m
//  Good Living
//
//  Created by NanoStuffs on 04/09/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import "stdlib.h"
#import "ViewController.h"
#import "LeadingViewController.h"
#import "RegisterViewController.h"

#import "SelectedThemesController.h"
#import "OfferDetailsController.h"
#import "MyAccountController.h"
#import "MyVoucherController.h"
#import "LeadingViewController.h"

#import "myPurchaseController.h"
#import "ContactusController.h"
#import "aboutGoodLivingController.h"
#import "notificationController.h"
#import "MainLeadingController.h"
#import "globalURL.h"
#import "ForgotPasswordViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    x_ratio = screenRect.size.width/320;
    y_ratio = screenRect.size.height/568;
    
    delegate = [[UIApplication sharedApplication] delegate];
    int randomNumber = arc4random_uniform(900000) + 100000;

  
    UIImageView *backImg=[[UIImageView alloc]init];
    //backImg.image=[UIImage imageNamed:@"11-Login_Ipad1.jpg"];
    backImg.frame=CGRectMake(0,0,768,1024);
   // [self.view addSubview:backImg];

    
    self.view.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:0.9f];

    //----------------------- Navigation
    UIImageView *navigationImage = [[UIImageView alloc] init];
    navigationImage.backgroundColor = [UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f];
    self.navigationController.navigationBarHidden = YES;
    [self.view addSubview:navigationImage];
        
       
    UILabel *topLable = [[UILabel alloc] init];
    topLable.text = @"Login";
    topLable.textAlignment = NSTextAlignmentCenter;
    topLable.textColor = [UIColor whiteColor];
    topLable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topLable];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    if (delegate.loginFlag == 0)
    {
        UIImageView *flashImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [self.view addSubview:flashImage];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if (self.view.frame.size.height == 480)
            {
                flashImage.image = [UIImage imageNamed:@"default42x.png"];
            }
            else
            {
                flashImage.image = [UIImage imageNamed:@"default5_2x.png"];
            }
        }
        else
        {
            flashImage.image = [UIImage imageNamed:@"Default-PortraitUpsideDown.png"];

        }
        
        [self performSelector:@selector(GotoLandingScreen) withObject:nil afterDelay:2.0];
    }
    else
    {
        self.navigationController.navigationBarHidden = YES;
        
       
        UIScrollView *mainscrollvertical = [[UIScrollView alloc] init];
        mainscrollvertical.delegate = self;
        mainscrollvertical.frame = CGRectMake(0, 64 , 768 , self.view.frame.size.height);
               mainscrollvertical.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f];
       
        UITapGestureRecognizer *hideKeyboard=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(HideKeyboard)];
        
        [mainscrollvertical addGestureRecognizer:hideKeyboard];
        
        if(UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPhone)
        //------------------  Login Form
        {
            navigationImage.frame = CGRectMake(0, 0, 320  , 64);
            topLable.frame = CGRectMake(0, 25   , 320  , 30);
            backButton.frame = CGRectMake(5  , 25   , 35  , 35   );
            mainscrollvertical.contentSize = CGSizeMake(320 , 560);
        }
        else
        {
            navigationImage.frame = CGRectMake(0, 0, 768 , 64*y_ratio);
            topLable.frame = CGRectMake(0, 25   , 768  , 30);
            backButton.frame = CGRectMake(20  , 25   , 35  , 35   );
            mainscrollvertical.contentSize = CGSizeMake(768 , 560);
        }
        
        
        UIView *paddingView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        emailTextfield = [[UITextField alloc] init];
        emailTextfield.placeholder = @"Mobile";
        emailTextfield.delegate = self;
        emailTextfield.backgroundColor = [UIColor whiteColor];
        [emailTextfield setLeftViewMode:UITextFieldViewModeAlways];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            emailTextfield.keyboardType=UIKeyboardTypeDecimalPad;
        else
            emailTextfield.keyboardType=UIKeyboardTypeNumberPad;
        
        [emailTextfield setLeftView:paddingView1];
        [mainscrollvertical addSubview:emailTextfield];
        
        UIView *paddingView2=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        passwordTextfield = [[UITextField alloc] init];
        passwordTextfield.placeholder = @"Password";
        passwordTextfield.delegate = self;
        passwordTextfield.backgroundColor = [UIColor whiteColor];
        [passwordTextfield setLeftViewMode:UITextFieldViewModeAlways];
        passwordTextfield.secureTextEntry=YES;
        [passwordTextfield setLeftView:paddingView2];

        [mainscrollvertical addSubview:passwordTextfield];
        
        UIImageView *login=[[UIImageView alloc]init];
  
        [mainscrollvertical addSubview:login];
        
        UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [loginButton setTitle:@"LOGIN" forState:UIControlStateNormal];
         [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [loginButton addTarget:self action:@selector(loginMethod) forControlEvents:UIControlEventTouchUpInside];
        loginButton.layer.cornerRadius=5.0f;
        loginButton.backgroundColor = [UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f];
        [mainscrollvertical addSubview:loginButton];
       
        UIImageView *signup=[[UIImageView alloc]init];

        [mainscrollvertical addSubview:signup];
        
        UIButton *signupbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [signupbtn setTitle:@"SIGN UP" forState:UIControlStateNormal];
      
        [signupbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [signupbtn addTarget:self action:@selector(signupMethod) forControlEvents:UIControlEventTouchUpInside];
        signupbtn.backgroundColor = [UIColor clearColor];
        [mainscrollvertical addSubview:signupbtn];
        
        UIButton *forgetPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
          [forgetPasswordButton setTitle:@"Forgot Password?" forState:UIControlStateNormal];
         [forgetPasswordButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [forgetPasswordButton addTarget:self action:@selector(forgetPasswordMethod) forControlEvents:UIControlEventTouchUpInside];
        forgetPasswordButton.backgroundColor = [UIColor clearColor];
        [mainscrollvertical addSubview:forgetPasswordButton];
    
        UIImageView *goodlivingLogo=[[UIImageView alloc]init];
     [mainscrollvertical addSubview:goodlivingLogo];
        
        UILabel *lbl = [[UILabel alloc] init];
        lbl.text = @"Please register or login to enjoy our offers program. If you are a Gulf News Subscriber you can also access our PREMIUM offer program.";

        lbl.numberOfLines=3;
        lbl.textAlignment = NSTextAlignmentLeft;
        lbl.textColor = [UIColor grayColor];
        lbl.backgroundColor = [UIColor clearColor];
        [mainscrollvertical addSubview:lbl];

        UILabel *lbl1 = [[UILabel alloc] init];
        lbl1.text = @"If you are a Gulf News Subscriber you can also access our PREMIUM offer program.";
        lbl1.numberOfLines=2;
        lbl1.textAlignment = NSTextAlignmentLeft;
        lbl1.textColor = [UIColor grayColor];
        lbl1.backgroundColor = [UIColor clearColor];
        //[mainscrollvertical addSubview:lbl1];
        
        
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
     
            [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
            login.image=[UIImage imageNamed:@"login_new.png"];
            signup.image=[UIImage imageNamed:@"signup_new.png"];
            goodlivingLogo.image=[UIImage imageNamed:@"loginscreenlogo.png"];
                lbl.numberOfLines=5;
            lbl.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
            lbl1.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
           [forgetPasswordButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:15]];
            [signupbtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:15]];
             [loginButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:15]];
        }
        else
        {
           topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:26];
            [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
            login.image=[UIImage imageNamed:@"login-ipad.png"];
            signup.image=[UIImage imageNamed:@"reg-ipad.png"];
            goodlivingLogo.image=[UIImage imageNamed:@"logo-ipad.png"];
              lbl.numberOfLines=5;
           lbl.font = [UIFont fontWithName:@"Helvetica Neue" size:25];
            lbl1.font = [UIFont fontWithName:@"Helvetica Neue" size:25];
            [forgetPasswordButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:25]];
            [signupbtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:30]];
            [loginButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:30]];
        }
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if (self.view.frame.size.height == 568)
            {
                goodlivingLogo.frame=CGRectMake(103, 15, 113, 113 );
            }
            else
            {
                goodlivingLogo.frame=CGRectMake(103, 15, 113, 113);
            }
            
            emailTextfield.frame = CGRectMake(15 , 142, 288  , 38   );
            
            passwordTextfield.frame = CGRectMake(15 , 199 , 288  , 38   );
            
            loginButton.frame = CGRectMake(15  , 257   , 288  , 38   );
            login.frame=CGRectMake(15  , 257   , 288  , 38   );
            
            signup.frame = CGRectMake(15  , 304   , 288  , 38   );
            signupbtn.frame=CGRectMake(15  , 304   , 288  , 38   );
            
            lbl.frame = CGRectMake(15  , 392   , 306  , 100   );
            lbl1.frame = CGRectMake(15  , 442   , 320  , 50   );
            forgetPasswordButton.frame = CGRectMake(0  , 355   , 160  , 30   );

        }
        
       
        
        else
        {
            goodlivingLogo.frame=CGRectMake(258, 50, 252, 252 );
            emailTextfield.frame = CGRectMake(158  , 352 , 452  , 50);
            
            passwordTextfield.frame = CGRectMake(158, 430, 452  , 50   );
            
            loginButton.frame = CGRectMake(158, 528, 452  , 50   );
            login.frame=CGRectMake(158, 528, 452  , 50   );
            
            signup.frame = CGRectMake(158, 598, 452  , 50   );
            signupbtn.frame=CGRectMake(158, 598  , 452  , 50   );
            
            
            lbl.frame = CGRectMake(160, 728, 480  , 200  );
            lbl1.frame = CGRectMake(160, 818, 500  , 100   );
            forgetPasswordButton.frame = CGRectMake(145  , 668 , 240  , 30   );

            
        }
          [self.view addSubview:mainscrollvertical];
        
    }
}


- (void) HideKeyboard
{
    [self.view endEditing:YES];
}

- (void) GotoLandingScreen
{
   
    MainLeadingController *LeadingView = [[MainLeadingController alloc] init];
    [self.navigationController pushViewController:LeadingView animated:YES];
    
//    LeadingViewController *LeadingView = [[LeadingViewController alloc] init];
//    [self.navigationController pushViewController:LeadingView animated:YES];
}

- (void) loginMethod
{
    loginalert = [[UIAlertView alloc] initWithTitle:@"Please wait..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [loginalert show];
    
    [self performSelector:@selector(chkValidation) withObject:nil afterDelay:0.1];
    //[self chkValidation];
    
}

-(void)chkValidation
{
    if(([emailTextfield.text length] > 0) && ([passwordTextfield.text length] > 0))
    {
        [self checkPassword];
    }
    else
    {
        [loginalert dismissWithClickedButtonIndex:0 animated:YES];
        
        UIAlertView *tempAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter both Mobile & Password." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [tempAlert show];
    }
    
}

-(void)checkPassword
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getLoginDetails];
    });
  
    
}


- (void) forgetPasswordMethod
{
    ForgotPasswordViewController *objForgotPasswordViewController=[[ForgotPasswordViewController alloc]init];
    
    [self.navigationController pushViewController:objForgotPasswordViewController animated:YES];
}

- (void) signupMethod
{
    [KeyboarddoneButton removeFromSuperview];
   // delegate.loginFlag=1;
    RegisterViewController *LeadingView = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:LeadingView animated:YES];
}

- (void) backMethod
{
    [KeyboarddoneButton removeFromSuperview];
    delegate = [[UIApplication sharedApplication] delegate];
    delegate.loginFlag=0;
    [self.navigationController popViewControllerAnimated:YES];
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



#pragma mark- Textfield Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField==emailTextfield)
    {
//        [self performSelector:@selector(delayButton) withObject:nil afterDelay:0.1];
    }
    else
    {
//        [KeyboarddoneButton removeFromS uperview];
    }
}

- (void) delayButton
{
    // create custom button
    [KeyboarddoneButton removeFromSuperview];
    KeyboarddoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    KeyboarddoneButton.frame = CGRectMake(0, self.view.frame.size.height-45, 100, 30);
    KeyboarddoneButton.adjustsImageWhenHighlighted = NO;
    [KeyboarddoneButton setTitle:@"Next" forState:UIControlStateNormal];
    KeyboarddoneButton.backgroundColor = [UIColor clearColor];
    [KeyboarddoneButton.titleLabel setTextColor:[UIColor blackColor]];
    [KeyboarddoneButton addTarget:self action:@selector(doneButton:) forControlEvents:UIControlEventTouchUpInside];
    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    [tempWindow addSubview:KeyboarddoneButton];
}

-(void)doneButton:(id)sender
{
    [KeyboarddoneButton removeFromSuperview];
    [emailTextfield resignFirstResponder];
    [passwordTextfield becomeFirstResponder];
}

- (BOOL) textFieldShouldReturn:(UITextField*)textField
{
    [KeyboarddoneButton removeFromSuperview];
    if (textField == emailTextfield)
    {
        [emailTextfield resignFirstResponder];
        [passwordTextfield becomeFirstResponder];
    }
    else if (textField == passwordTextfield)
    {
        [passwordTextfield resignFirstResponder];
    }
    
    [textField resignFirstResponder];
    return TRUE;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range

replacementString:(NSString *)string
{
    if (textField ==emailTextfield)
    {
        if ([emailTextfield.text length ]>9 && [string length] !=0)
        {
            return NO;
        }
    }
    if([emailTextfield.text length]==0 && [passwordTextfield.text length]==0 )
    {
        if([string isEqualToString:@" "]){
            return NO;
        }
    }
    
    return YES;
}

//------------------ WebService
-(void)getLoginDetails

{
    @try {
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSString *userId1=emailTextfield.text;
            NSString *pass=passwordTextfield.text;//offerID;
            
            delegate.pass3=pass;
            //        NSString *url = [NSString stringWithFormat:@"http://testws.goodliving.ae/api/index.php/offer/returnLogin/%@/%@",userId1,pass];
            NSString *url = [NSString stringWithFormat:@"https://testws.goodliving.ae/api/index.php/offer/returnNewLogin/%@/%@/iphone/%@",userId1,pass,delegate.DeviceToken==NULL ? @"abcd" : delegate.DeviceToken];
            
            url=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
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
                
                loginUsername= [[DataArray objectAtIndex:0] valueForKey:@"Mobile__c"];
                loginID=[[DataArray objectAtIndex:0] valueForKey:@"Id"];
                
                fname=[[DataArray objectAtIndex:0] valueForKey:@"First_Name__c"];
                lname=[[DataArray objectAtIndex:0] valueForKey:@"Last_Name__c"];
                email=[[DataArray objectAtIndex:0] valueForKey:@"Email__c"];
                gender=[[DataArray objectAtIndex:0]valueForKey:@"Gender__c"];
                
                
                NSString *bpcode=[[DataArray objectAtIndex:0]valueForKey:@"Subscription_BPId__c"];
                NSString *email1=[[DataArray objectAtIndex:0]valueForKey:@"Subscription_Email"];
                NSString *mobile=[[DataArray objectAtIndex:0]valueForKey:@"Subscription_Mobile"];
                NSString *status=[[DataArray objectAtIndex:0]valueForKey:@"Response"];
                NSString *startDate=[[DataArray objectAtIndex:0]valueForKey:@"Subscription_StartDate"];
                NSString *endDate=[[DataArray objectAtIndex:0]valueForKey:@"Subscription_EndDate"];
                NSString *productionCode=[[DataArray objectAtIndex:0]valueForKey:@"Subscription_ProductCode"];
                NSString *subscrptionType=[[DataArray objectAtIndex:0]valueForKey:@"Subscription_Type"];
                
                NSString *subscrptionStatus=[[DataArray objectAtIndex:0]valueForKey:@"Subscription_Status__c"];
                
                if((NSNull *)subscrptionStatus == [NSNull null])
                {
                    subscrptionStatus=@"0";
                }
                
                if((NSNull *)bpcode == [NSNull null])
                {
                    bpcode=@"0";
                }
                
                if((NSNull *)email1 == [NSNull null])
                {
                    email1=@"0";
                }
                if((NSNull *)mobile == [NSNull null])
                {
                    mobile=@"0";
                }
                if((NSNull *)status == [NSNull null])
                {
                    status=@"0";
                }
                
                if((NSNull *)startDate == [NSNull null])
                {
                    startDate=@"0";
                }
                if((NSNull *)endDate == [NSNull null])
                {
                    endDate=@"0";
                }
                
                if((NSNull *)productionCode == [NSNull null])
                {
                    productionCode=@"0";
                }
                if((NSNull *)subscrptionType == [NSNull null])
                {
                    subscrptionType=@"0";
                }
                
                //bpcode,startDate,status,endDate,productionCode,subscrptionType,mobile,email,
                
                NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc]init];
                
                if(subscrptionStatus)
                    [mutableDict setObject:subscrptionStatus forKey:@"subscrptionStatus"];
                else
                    [mutableDict setObject: @"0" forKey:@"subscrptionStatus"];
                
                
                if(bpcode)
                    [mutableDict setObject:bpcode forKey:@"bpcode"];
                else
                    [mutableDict setObject: @"0" forKey:@"bpcode"];
                
                if(email1)
                    [mutableDict setObject:email1 forKey:@"email"];
                else
                    [mutableDict setObject: @"0" forKey:@"email"];
                
                if(mobile)
                    [mutableDict setObject:mobile forKey:@"mobile"];
                else
                    [mutableDict setObject: @"0" forKey:@"mobile"];
                
                if(status)
                    [mutableDict setObject:status forKey:@"status"];
                else
                    [mutableDict setObject: @"0" forKey:@"status"];
                
                if(startDate)
                    [mutableDict setObject:startDate forKey:@"startdate"];
                else
                    [mutableDict setObject: @"0" forKey:@"startdate"];
                
                if(endDate)
                    [mutableDict setObject:endDate forKey:@"enddate"];
                else
                    [mutableDict setObject: @"0" forKey:@"enddate"];
                
                if(productionCode)
                    [mutableDict setObject:productionCode forKey:@"prodcode"];
                else
                    [mutableDict setObject: @"0" forKey:@"prodcode"];
                
                if(subscrptionType)
                    [mutableDict setObject:subscrptionType forKey:@"subType"];
                else
                    [mutableDict setObject: @"0" forKey:@"subType"];
                
                NSUserDefaults *UserDefault=[NSUserDefaults standardUserDefaults];
                [UserDefault setObject:mutableDict forKey:@"Registration"];
                [UserDefault synchronize];
                
                NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                // getting an dictionary
                NSDictionary *mydictionary=(NSDictionary *) [prefs objectForKey:@"Registration"];
                
              
                
                NSUserDefaults *UserDefault1=[NSUserDefaults standardUserDefaults];
                
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:fname];
                [UserDefault1 setObject:data forKey:@"fname"];
                
                NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:lname];
                [UserDefault1 setObject:data1 forKey:@"lname"];
                
                NSData *data2 = [NSKeyedArchiver archivedDataWithRootObject:loginUsername];
                [UserDefault1 setObject:data2 forKey:@"mobileNum"];
                
                NSData *data3 = [NSKeyedArchiver archivedDataWithRootObject:email];
                [UserDefault1 setObject:data3 forKey:@"email"];
                
                NSData *data4 = [NSKeyedArchiver archivedDataWithRootObject:gender];
                [UserDefault1 setObject:data4 forKey:@"gender"];
                
                 NSData *data5 = [NSKeyedArchiver archivedDataWithRootObject:loginID];
                 [UserDefault1 setObject:data5 forKey:@"userID"];
                
                
                if ([[[DataArray objectAtIndex:0] valueForKey:@"Message"] isEqual:@"success"])
                {
                    //Login
                    [Flurry logEvent:@"Login"];
                    [Flurry logPageView];
                    
                    //Google Analytics
                    self.screenName = @"Login";

                    
                    delegate.loginFlag=1;
                    delegate.loginSuccessfulFLAG=1;

                    MainLeadingController *LeadingView = [[MainLeadingController alloc] init];
                    [self.navigationController pushViewController:LeadingView animated:YES];
                    //adingView.userID=loginID;
                    delegate.userID=loginID;
                    delegate.fname=fname;
                    delegate.laname=lname;
                    delegate.password=passwordTextfield.text;
                    
                            [loginalert dismissWithClickedButtonIndex:0 animated:YES];
                }
                else
                {
                            [loginalert dismissWithClickedButtonIndex:0 animated:YES];
                    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Sorry, incorrect login details." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alertView show];
                }
                
            
            }
                    [loginalert dismissWithClickedButtonIndex:0 animated:YES];
        });
        
        // [self ChkResponse];
        

    }
    @catch (NSException *exception) {
              [loginalert dismissWithClickedButtonIndex:0 animated:YES];
    }
   

}

-(void)ChkResponse
{
    
}


@end
