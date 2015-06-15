//
//  ForgotPasswordViewController.m
//  Good Living
//
//  Created by Nanostuffs's Macbook on 02/10/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "globalURL.h"

@interface ForgotPasswordViewController ()

@end

@implementation ForgotPasswordViewController

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
	// Do any additional setup after loading the view, typically from a nib.
    
    //Forgot_Password
    if (delegate.fname || delegate.laname)
    {
        [Flurry logEvent:@"Forgot Password"];
        self.screenName = @"Forgot Password";
    }
    else
    {
        [Flurry logEvent:@"Forgot Password "];
        self.screenName =@"Forgot Password ";
    }

    [Flurry logPageView];
    

    
    UITapGestureRecognizer *hideKeyboard=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(HideKeyboard)];
    [self.view addGestureRecognizer:hideKeyboard];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    x_ratio = screenRect.size.width/320;
    y_ratio = screenRect.size.height/568;
    
    delegate = [[UIApplication sharedApplication] delegate];
  
    self.view.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:0.9f];
    
    //----------------------- Navigation
    UIImageView *navigationImage = [[UIImageView alloc] init];
    navigationImage.backgroundColor = [UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f];
    self.navigationController.navigationBarHidden = YES;
    [self.view addSubview:navigationImage];
    
    
    UILabel *topLable = [[UILabel alloc] init];
    topLable.text = @"Forgot Password!";
    topLable.textAlignment = NSTextAlignmentCenter;
    topLable.textColor = [UIColor whiteColor];
    topLable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topLable];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    self.navigationController.navigationBarHidden = YES;
    
    UIScrollView *mainscrollvertical = [[UIScrollView alloc] init];
    mainscrollvertical.delegate = self;
    mainscrollvertical.frame = CGRectMake(0, 64 , 768 , self.view.frame.size.height);
    mainscrollvertical.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f];
        
    
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
        backButton.frame = CGRectMake(20  , 22   , 35  , 35   );
        mainscrollvertical.contentSize = CGSizeMake(768 , 560);
    }
        
        
        UIView *paddingView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        emailTextfield = [[UITextField alloc] init];
        emailTextfield.placeholder = @"Mobile Number";//ABC@XYZ.com
        emailTextfield.delegate = self;
        emailTextfield.backgroundColor = [UIColor whiteColor];
        [emailTextfield setLeftViewMode:UITextFieldViewModeAlways];
        [emailTextfield setLeftView:paddingView1];
        emailTextfield.keyboardType=UIKeyboardTypeNumberPad;
        [mainscrollvertical addSubview:emailTextfield];
        
    
        UIImageView *login=[[UIImageView alloc]init];
//        [mainscrollvertical addSubview:login];
    
        UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [loginButton setTitle:@"Send Password to Email" forState:UIControlStateNormal];
        [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [loginButton addTarget:self action:@selector(SendPasswordMethod) forControlEvents:UIControlEventTouchUpInside];
        [loginButton setBackgroundColor:[UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f]];
        loginButton.layer.cornerRadius=5.0f;
        [mainscrollvertical addSubview:loginButton];
    
        UIImageView *goodlivingLogo=[[UIImageView alloc]init];
        [mainscrollvertical addSubview:goodlivingLogo];
    
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
            
            [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
            login.image=[UIImage imageNamed:@"login_new.png"];
            goodlivingLogo.image=[UIImage imageNamed:@"loginscreenlogo.png"];
            [loginButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:15]];
        }
        else
        {
            topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:26];
            [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
            login.image=[UIImage imageNamed:@"login-ipad.png"];
            goodlivingLogo.image=[UIImage imageNamed:@"logo-ipad.png"];
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
            
            loginButton.frame = CGRectMake(20  , 200   , 280  , 30   );
            login.frame=CGRectMake(15  , 200   , 288  , 38   );
        }
        else
        {
            goodlivingLogo.frame=CGRectMake(258, 50, 252, 252 );
            emailTextfield.frame = CGRectMake(158  , 352 , 452  , 50);
            login.frame=CGRectMake(158, 430, 452  , 50   );
            CGRect screenRect = [[UIScreen mainScreen] bounds];
            x_ratio = screenRect.size.width/320;
            y_ratio = screenRect.size.height/568;
            loginButton.frame = CGRectMake(158, 440, 452, 60);
//            loginButton.frame = CGRectMake(50*x_ratio, 340*y_ratio, 230*x_ratio, 38*y_ratio);
        }
        [self.view addSubview:mainscrollvertical];
}

- (void) backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

//------------------------Webservice

-(void)SendPasswordMethod
{
    [self.view endEditing:YES];
    
    if([emailTextfield.text length]==0)
    {
        
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Please enter mobile number." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alertView.tag=2;
        [alertView show];
    }
    
    else
    {
        
        
        @try {
            UIActivityIndicatorView *activityview1 = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            activityview1.center = CGPointMake(self.view.frame.size.width / 2,self.view.frame.size.height /2);
            [activityview1 startAnimating];
            [self.view addSubview:activityview1];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSString *forgotPassword=emailTextfield.text;
                NSString *url =getForgotPassword;
                
                if(forgotPassword)
                    url=[url stringByAppendingString:forgotPassword];
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
                    delegate.loginFlag=0;

                    NSError* error;
                    json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                    NSMutableArray *DataArray = [json objectForKey:@"data"];
                    NSString *status=[[DataArray objectAtIndex:0]valueForKey:@"status"];
                    NSString *message=[[DataArray objectAtIndex:0]valueForKey:@"msg"];
                    
                    if([[NSString stringWithFormat:@"%@",status] isEqualToString:@"1"])
                    {
                        UIAlertView *myAlert=[[UIAlertView alloc]initWithTitle:@"Success!" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                        [myAlert show];
                        [activityview1 stopAnimating];
                    }
                    else
                    {
                        UIAlertView *myAlert=[[UIAlertView alloc]initWithTitle:@"Error!" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                        [myAlert show];
                        [activityview1 stopAnimating];
                   }
                }
            });
    
            }
        @catch (NSException *exception) {
                   }
        }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Textfield delegates
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
 
    [self.view endEditing:YES];
}

-(void)HideKeyboard
{
    [self.view endEditing:YES];
}

@end
