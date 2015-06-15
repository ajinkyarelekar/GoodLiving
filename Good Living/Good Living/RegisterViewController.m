//
//  RegisterViewController.m
//  Good Living
//
//  Created by NanoStuffs on 06/09/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import "RegisterViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "TermsAndConditionController.h"
#import "LeadingViewController.h"
#import "MyVoucherController.h"
#import "MyAccountController.h"
#import "ViewController.h"
#import "myPurchaseController.h"
#import "ContactusController.h"
#import "aboutGoodLivingController.h"
#import "notificationController.h"
#import "AuthenticatedController.h"
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //Signup
    [Flurry logEvent:@"Signup"];
    [Flurry logPageView];
    
    //Google Analytics
    self.screenName = @"Signup";

    
    delegate = [[UIApplication sharedApplication] delegate];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    x_ratio = screenRect.size.width/320;
    y_ratio = screenRect.size.height/568;
    self.view.backgroundColor = [UIColor whiteColor];
    OTPCount=1;
    
    genderArray=[[NSArray alloc]initWithObjects:@"Male",@"Female", nil];
        ValidationFlag = 0;
       validationPass=0;
    validationMobile=0;
    checkCount=1;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    //------------------------Navigation Bar
    UIImageView *navigationImage = [[UIImageView alloc] init];
    navigationImage.backgroundColor = [UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f];
    navigationImage.frame = CGRectMake(0, 0, 320, 64);
    [self.view addSubview:navigationImage];
    
    UILabel *topLable = [[UILabel alloc] init];
    topLable.text = @"Register";
    topLable.frame = CGRectMake(0, 28, 320, 30);
    topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
    topLable.textAlignment = NSTextAlignmentCenter;
    topLable.textColor = [UIColor whiteColor];
    topLable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topLable];
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
  
        backButton.frame = CGRectMake(5, 25, 35, 35);
   
    
    [backButton setImage:[UIImage imageNamed:@"back1.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    

    //---------------------------------------Register Page
    
    registerScrool = [[UIScrollView alloc] init];
    registerScrool.delegate = self;
   // registerScrool.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f];
    [self.view addSubview:registerScrool];
    registerScrool.frame = CGRectMake(0, 64, 320*x_ratio, self.view.frame.size.height-64*y_ratio);
    registerScrool.contentSize = CGSizeMake(320*x_ratio, 500*y_ratio);
    
    
    firstName=[[UILabel alloc]init];
    firstName.text=@"First Name";
    firstName.frame = CGRectMake(8, 8, 100, 30);
    firstName.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    firstName.textAlignment = NSTextAlignmentLeft;
    firstName.textColor = [UIColor darkGrayColor];
    firstName.backgroundColor = [UIColor clearColor];
    [registerScrool addSubview:firstName];
    
    
    usernameTextfield = [[UITextField alloc] init];
    usernameTextfield.placeholder = @"First Name";
    usernameTextfield.delegate = self;
    usernameTextfield.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    usernameTextfield.frame = CGRectMake(140, 8, 160, 30);
    usernameTextfield.backgroundColor = [UIColor clearColor];
    usernameTextfield.autocapitalizationType = UITextAutocapitalizationTypeWords;
    [registerScrool addSubview:usernameTextfield];
    
    UIImageView *imgf = [[UIImageView alloc] initWithFrame:CGRectMake(5, 40, 320, 2)];
    imgf.image=[UIImage imageNamed:@"line.png"];
    [registerScrool addSubview:imgf];

    lastName=[[UILabel alloc]init];
    lastName.text=@"Last Name";
    lastName.frame = CGRectMake(8, 48, 100, 30);
    lastName.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    lastName.textAlignment = NSTextAlignmentLeft;
    lastName.textColor = [UIColor darkGrayColor];
    lastName.backgroundColor = [UIColor clearColor];
    [registerScrool addSubview:lastName];
    
    lastNameTextfield = [[UITextField alloc] init];
    lastNameTextfield.placeholder = @"Last Name";
    lastNameTextfield.delegate = self;
    lastNameTextfield.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    lastNameTextfield.frame = CGRectMake(140, 48, 160, 30);
    lastNameTextfield.backgroundColor = [UIColor clearColor];
    lastNameTextfield.autocapitalizationType = UITextAutocapitalizationTypeWords;
    [registerScrool addSubview:lastNameTextfield];
    
    UIImageView *imgl = [[UIImageView alloc] initWithFrame:CGRectMake(5, 80, 320, 2)];
    imgl.image=[UIImage imageNamed:@"line.png"];
    [registerScrool addSubview:imgl];

    
    mobNum=[[UILabel alloc]init];
    mobNum.text=@"Mobile Number";
    mobNum.frame = CGRectMake(8, 88, 100, 30);
    mobNum.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    mobNum.textAlignment = NSTextAlignmentLeft;
    mobNum.textColor = [UIColor darkGrayColor];
    mobNum.backgroundColor = [UIColor clearColor];
    [registerScrool addSubview:mobNum];
    
    mobileNum = [[UITextField alloc] init];
    mobileNum.placeholder = @"Mobile Number";
    mobileNum.delegate = self;
    mobileNum.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    mobileNum.frame = CGRectMake(140, 88, 160, 30);
    mobileNum.backgroundColor = [UIColor clearColor];
    mobileNum.keyboardType=UIKeyboardTypeNumberPad;
    [registerScrool addSubview:mobileNum];
    
    UIImageView *imgM = [[UIImageView alloc] initWithFrame:CGRectMake(5, 123, 320, 2)];
    imgM.image=[UIImage imageNamed:@"line.png"];
    [registerScrool addSubview:imgM];

    
    email=[[UILabel alloc]init];
    email.text=@"Email";
    email.frame = CGRectMake(8, 130, 100, 30);
    email.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    email.textAlignment = NSTextAlignmentLeft;
    email.textColor = [UIColor darkGrayColor];
    email.backgroundColor = [UIColor clearColor];
    [registerScrool addSubview:email];

    
    emailTextfield = [[UITextField alloc] init];
    emailTextfield.placeholder = @"Email";
    emailTextfield.delegate = self;
    emailTextfield.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    emailTextfield.frame = CGRectMake(140, 130, 200, 30);
    emailTextfield.backgroundColor = [UIColor clearColor];
    emailTextfield.keyboardType=UIKeyboardTypeEmailAddress;
    [registerScrool addSubview:emailTextfield];
    
    
    UIImageView *imgEmail = [[UIImageView alloc] initWithFrame:CGRectMake(5, 163, 320, 2)];
    imgEmail.image=[UIImage imageNamed:@"line.png"];
    [registerScrool addSubview:imgEmail];
    
    Gender=[[UILabel alloc]init];
    Gender.text=@"Gender";
    Gender.frame = CGRectMake(10, 166, 100, 30);
    Gender.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    Gender.textAlignment = NSTextAlignmentLeft;
    Gender.textColor = [UIColor darkGrayColor];
    Gender.backgroundColor = [UIColor clearColor];
    [registerScrool addSubview:Gender];
    
    
    
    genderTextfield = [[UITextField alloc] init];
    genderTextfield.placeholder = @"Gender";
    genderTextfield.delegate = self;
    genderTextfield.tag=1;
    genderTextfield.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    genderTextfield.frame = CGRectMake(140, 166, 160, 30);
    genderTextfield.backgroundColor = [UIColor clearColor];
   [registerScrool addSubview:genderTextfield];
   
    myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(35, 266, 250, 100)];
    myPickerView.delegate = self;
    myPickerView.showsSelectionIndicator = YES;
    myPickerView.backgroundColor=[UIColor whiteColor];
    
    
    UITapGestureRecognizer* gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerViewTapGestureRecognized:)];
    [myPickerView addGestureRecognizer:gestureRecognizer];
    
    gestureRecognizer.cancelsTouchesInView=NO;
    gestureRecognizer.delegate = self;
    
    UIImageView *imgGender = [[UIImageView alloc] initWithFrame:CGRectMake(5, 201, 320, 2)];
    imgGender.image=[UIImage imageNamed:@"line.png"];
    [registerScrool addSubview:imgGender];
    
    
    password=[[UILabel alloc]init];
    password.text=@"Password";
    password.frame = CGRectMake(10, 204, 100, 30);
    password.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    password.textAlignment = NSTextAlignmentLeft;
    password.textColor = [UIColor darkGrayColor];
    password.backgroundColor = [UIColor clearColor];
    [registerScrool addSubview:password];
    
    passwordTextfield = [[UITextField alloc] init];
    passwordTextfield.placeholder = @"Password";
    passwordTextfield.delegate = self;
    passwordTextfield.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    passwordTextfield.frame = CGRectMake(140, 204, 160, 30);
    passwordTextfield.backgroundColor = [UIColor clearColor];
    passwordTextfield.secureTextEntry=YES;
    [registerScrool addSubview:passwordTextfield];
    
    
    imgPass = [[UIImageView alloc] init];
    imgPass.frame =CGRectMake(5, 239, 320 ,2);
    imgPass.image=[UIImage imageNamed:@"line.png"];
    [registerScrool addSubview:imgPass];
    
    
    confirmPass=[[UILabel alloc]init];
    confirmPass.text=@"Confirm Password";
    confirmPass.frame = CGRectMake(10, 242, 180, 30);
    confirmPass.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    confirmPass.textAlignment = NSTextAlignmentLeft;
    confirmPass.textColor = [UIColor darkGrayColor];
    confirmPass.backgroundColor = [UIColor clearColor];
    [registerScrool addSubview:confirmPass];

    
   confirmpassTextfield = [[UITextField alloc] init];
    confirmpassTextfield.placeholder = @"Confirm Password";
    confirmpassTextfield.delegate = self;
    confirmpassTextfield.tag = 4;
    confirmpassTextfield.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    confirmpassTextfield.frame = CGRectMake(140, 242, 180, 30);
    confirmpassTextfield.backgroundColor = [UIColor clearColor];
    confirmpassTextfield.secureTextEntry=YES;
    [registerScrool addSubview:confirmpassTextfield];
    
    imgCPass = [[UIImageView alloc] init];

    imgCPass.frame=CGRectMake(5, 278, 320, 2);
    imgCPass.image=[UIImage imageNamed:@"line.png"];
    [registerScrool addSubview:imgCPass];
    
    
   btnCheckBox =[UIButton buttonWithType:UIButtonTypeCustom];
    btnCheckBox.frame = CGRectMake(12, 296, 19, 19);
    if(delegate.flag_btnSelected==1)
    {
    btnCheckBox.selected = YES;
    }
    else
    {
        btnCheckBox.selected = NO;
 
    }
    [btnCheckBox addTarget:self action:@selector(btnCheckBoxMethod:) forControlEvents:UIControlEventTouchUpInside];
    [btnCheckBox setImage:[UIImage imageNamed:@"checkbox_n-1.png"] forState:UIControlStateNormal];
    [btnCheckBox setImage:[UIImage imageNamed:@"checkbox_p-1.png"] forState:UIControlStateSelected];
    [registerScrool addSubview:btnCheckBox];
    
   term=[UIButton buttonWithType:UIButtonTypeCustom];
    [term addTarget:self action:@selector(termsMethod) forControlEvents:UIControlEventTouchUpInside];
    [term setTitle:@"I agree to Good Living's terms & conditions." forState:UIControlStateNormal];
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        if(self.view.frame.size.height==480)
     term.frame = CGRectMake(33, 290, 280, 30);
        else
        term.frame = CGRectMake(33, 290, 280, 30);
      
    }
    
    [term setTitleColor:[UIColor colorWithRed:35/255.0f green:144/255.0f blue:176/255.0f alpha:1.0f]forState:UIControlStateNormal];
    [term.titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
    term.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    term.backgroundColor = [UIColor clearColor];
    [registerScrool addSubview:term];
    
    
   registerBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(20, 364, 280, 30);
    [registerBtn addTarget:self action:@selector(registerMethod) forControlEvents:UIControlEventTouchUpInside];
    [registerBtn setTitle:@"REGISTER" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[registerBtn setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
    [registerBtn setBackgroundColor: [UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f]];
    registerBtn.layer.cornerRadius=5.0f;
    [registerScrool addSubview:registerBtn];
    
    if(UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad)
    {
        navigationImage.frame = CGRectMake(0, 0, 768 , 64);
        topLable.frame = CGRectMake(0, 25   , 768  , 30);
        topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:26];
        backButton.frame = CGRectMake(20  , 25   , 35  , 35   );
        registerScrool.contentSize = CGSizeMake(768 , 560);
        
        
        firstName.frame = CGRectMake(150, 20, 200, 30);
        firstName.font = [UIFont fontWithName:@"Helvetica Neue" size:26];
        
        usernameTextfield.font = [UIFont fontWithName:@"Helvetica Neue" size:26];
        usernameTextfield.frame = CGRectMake(380, 22, 160, 30);
        
        lastName.frame = CGRectMake(150, 90, 100*x_ratio, 30);
        lastName.font = [UIFont fontWithName:@"Helvetica Neue" size:26];
        
        lastNameTextfield.font = [UIFont fontWithName:@"Helvetica Neue" size:26];
        lastNameTextfield.frame = CGRectMake(380, 92, 160*x_ratio, 30);
        
        mobNum.frame = CGRectMake(150, 170, 100*x_ratio, 30);
        mobNum.font = [UIFont fontWithName:@"Helvetica Neue" size:26];
        
        mobileNum.font = [UIFont fontWithName:@"Helvetica Neue" size:26];
        mobileNum.frame = CGRectMake(380, 172, 160*x_ratio, 30);
        
        email.frame = CGRectMake(150, 245, 100*y_ratio, 30);
        email.font = [UIFont fontWithName:@"Helvetica Neue" size:26];
        
        emailTextfield.font = [UIFont fontWithName:@"Helvetica Neue" size:26];
        emailTextfield.frame = CGRectMake(380, 247, 200*x_ratio, 30);
        
        Gender.frame = CGRectMake(150, 315, 100*x_ratio, 30);
        Gender.font = [UIFont fontWithName:@"Helvetica Neue" size:26];
        
        genderTextfield.font = [UIFont fontWithName:@"Helvetica Neue" size:26];
        genderTextfield.frame = CGRectMake(380, 317, 160*x_ratio, 30);
        
        password.frame = CGRectMake(150, 385, 100*x_ratio, 30);
        password.font = [UIFont fontWithName:@"Helvetica Neue" size:26];
        
        passwordTextfield.font = [UIFont fontWithName:@"Helvetica Neue" size:26];
        passwordTextfield.frame = CGRectMake(380, 387, 160*x_ratio, 30);
        
        confirmPass.frame = CGRectMake(150, 450, 180*x_ratio, 30);
        confirmPass.font = [UIFont fontWithName:@"Helvetica Neue" size:26];
        
        confirmpassTextfield.font = [UIFont fontWithName:@"Helvetica Neue" size:26];
        confirmpassTextfield.frame = CGRectMake(380, 452, 180*x_ratio, 30);
        
        btnCheckBox.frame = CGRectMake(50*x_ratio, 297*y_ratio, 19*x_ratio, 19*y_ratio);

        term.frame = CGRectMake(188, 292*y_ratio, 500, 30*y_ratio);
        [term setTitleColor:[UIColor colorWithRed:35/255.0f green:144/255.0f blue:176/255.0f alpha:1.0f]forState:UIControlStateNormal];
        [term.titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:25]];
        
        registerBtn.layer.cornerRadius=5.0f;
        registerBtn.frame = CGRectMake(50*x_ratio, 340*y_ratio, 230*x_ratio, 38*y_ratio);
        [registerBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:25]];
        
        imgf.frame=CGRectMake(50*x_ratio, 40*y_ratio, 230*x_ratio, 2*y_ratio);
        imgl.frame=CGRectMake(50*x_ratio, 80*y_ratio, 230*x_ratio, 2*y_ratio);
        imgM.frame=CGRectMake(50*x_ratio, 123*y_ratio, 230*x_ratio, 2*y_ratio);
        imgEmail.frame=CGRectMake(50*x_ratio, 163*y_ratio, 230*x_ratio, 2*y_ratio);
        imgGender.frame=CGRectMake(50*x_ratio, 201*y_ratio, 230*x_ratio, 2*y_ratio);
        imgPass.frame=CGRectMake(50*x_ratio, 239*y_ratio, 230*x_ratio, 2*y_ratio);
        imgCPass.frame=CGRectMake(50*x_ratio, 278*y_ratio, 230*x_ratio, 2*y_ratio);
    }

}


-(void)viewWillAppear:(BOOL)animated
{
    if(delegate.flag_btnSelected==1)
    {
        btnCheckBox.selected = YES;
         chekBoxFlag=YES;
        
    }
    else
    {
        btnCheckBox.selected = NO;
        chekBoxFlag=NO;
        
    }
}
-(void)termsMethod
{
    TermsAndConditionController *terms;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        terms=[[TermsAndConditionController alloc]initWithNibName:@"TermsAndConditionController" bundle:nil];
    else
        terms=[[TermsAndConditionController alloc]initWithNibName:@"TermsAndConditionControlleriPad" bundle:nil];
    
    [self.navigationController pushViewController:terms animated:YES];
}
- (void) registerMethod
{
    
    //-------- Validation Field
    
    [self chkValidation];
    
    
}

-(void) OTPGeneration
{
   if(OTPCount<=3)
   {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSString *userId1=@"gnhttpotp";//httpdemo2";
        NSString *pass=@"htpgn236";//abc1234";
        NSString *senderID=@"GulfNews";//SMS4YOU";
        NSString *mobileNum1=mobileNum.text;
         //int randomNumber = arc4random_uniform(1000000);
        
        NSString *newStr = [mobileNum1 substringToIndex:1];

        if ([newStr isEqualToString:@"0"] == TRUE)
        {
            mobileNum1 = [mobileNum1 substringFromIndex:1];
        }
        
        NSString *mobilePrefix=@"971";
        
        mobilePrefix=[mobilePrefix stringByAppendingString:mobileNum1];
        
        int randomNumber = arc4random_uniform(900000) + 100000;
        
         OTPRandom=[NSString stringWithFormat:@"%d",randomNumber];
        
          NSString *url = [NSString stringWithFormat:@"https://global.myvaluefirst.com/smpp/sendsms?username=%@&password=%@&to=%@&from=%@&text=%@",userId1,pass,mobilePrefix,senderID,OTPRandom];
          url=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
        [request setURL:[NSURL URLWithString:url]];
        [request setHTTPMethod:@"POST"];
        NSHTTPURLResponse *response = nil;
        NSError *error = [[NSError alloc] init];
        NSData *data= [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        NSString *returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

        
        NSCalendar * calendar = [NSCalendar currentCalendar];
        NSDateComponents * components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSSecondCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:[NSDate date]];
        
        GeneratedTime = [NSString stringWithFormat:@"%d:%d:%d",components.hour, components.minute, components.second];
        
        if([returnString isEqualToString:@"Sent."])
        {
            oneTimePassView = [[UIView alloc] initWithFrame:CGRectMake(0, -40, self.view.frame.size.width, self.view.frame.size.height+40)];
            oneTimePassView.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.5f];
            [self.view addSubview:oneTimePassView];
            
            UIView *emiritsviewLocal = [[UIView alloc] init];
            emiritsviewLocal.frame = CGRectMake(35*x_ratio, 200*y_ratio, 250*x_ratio, 200*y_ratio);//200*y_ratio y position
            emiritsviewLocal.center = oneTimePassView.center;
            emiritsviewLocal.backgroundColor  = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f];
            emiritsviewLocal.layer.cornerRadius = 5.0f;
            [oneTimePassView addSubview:emiritsviewLocal];
            
            UILabel *emiritsLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, emiritsviewLocal.frame.size.width,20)];
            emiritsLable.text = @"Welcome";
            emiritsLable.textColor = [UIColor blackColor];
            emiritsLable.backgroundColor = [UIColor clearColor];
            emiritsLable.textAlignment = NSTextAlignmentCenter;
            emiritsLable.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
            emiritsLable.font = [UIFont boldSystemFontOfSize:18];
            [emiritsviewLocal addSubview:emiritsLable];
            
            UILabel *detailLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 45*x_ratio, emiritsviewLocal.frame.size.width,40*y_ratio)];
            detailLable.text = @"Please enter the OTP sent to your Mobile and Email";
            
            detailLable.textColor = [UIColor blackColor];
            detailLable.backgroundColor = [UIColor clearColor];
            detailLable.textAlignment = NSTextAlignmentCenter;
            detailLable.numberOfLines = 2;
            detailLable.lineBreakMode = NSLineBreakByWordWrapping;
            detailLable.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
            [emiritsviewLocal addSubview:detailLable];
                   
            emailTextfield12 = [[UITextField alloc] init];
            emailTextfield12.placeholder =@"";//OTPRandom;// @"OTP";
            emailTextfield12.delegate = self;
            emailTextfield12.frame = CGRectMake(15*x_ratio, 110*y_ratio, 220*x_ratio, 30*y_ratio);
            emailTextfield12.backgroundColor = [UIColor clearColor];
            [emailTextfield12 setBackground:[UIImage imageNamed:@"textf.png"]];
            emailTextfield12.keyboardType=UIKeyboardTypeNumberPad;
            [emiritsviewLocal addSubview:emailTextfield12];
            
            
            UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            nextBtn.frame = CGRectMake(10*x_ratio, 160*y_ratio, 100*x_ratio, 30*y_ratio);
            [nextBtn setTitle:@"Next" forState:UIControlStateNormal];
            [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [nextBtn setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
            [nextBtn addTarget:self action:@selector(nextMethod) forControlEvents:UIControlEventTouchUpInside];
            [emiritsviewLocal addSubview:nextBtn];
            
            resendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            resendBtn.frame = CGRectMake(120*x_ratio, 160*y_ratio, 120*x_ratio, 30*y_ratio);
            [resendBtn setTitle:@"Resend OTP" forState:UIControlStateNormal];
            [resendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [resendBtn setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
            [resendBtn addTarget:self action:@selector(resendMethod) forControlEvents:UIControlEventTouchUpInside];
            [emiritsviewLocal addSubview:resendBtn];
        }
        else
        {
           
                UIAlertView* alertView1 = [[UIAlertView alloc] initWithTitle:nil message:returnString delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil];
               alertView1.delegate=self;
            [alertView1 show];

        }
    });
       
}
    
    else
    {
       
        OTPCount=1;
         UIAlertView* alertView1 = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"You have exceeds the OTP limit." delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil];
           [alertView1 show];
    }

}


#pragma mark AlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==1)
    {
        //------- OTP Generation
      
    }
}
- (void) resendMethod
{
     OTPCount++;
    [oneTimePassView removeFromSuperview];
    [self registerMethod];

}

- (void) nextMethod
{
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDateComponents * components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSSecondCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit
                                                fromDate:[NSDate date]];
    NSString *currentTime = [NSString stringWithFormat:@"%d:%d:%d",components.hour, components.minute, components.second];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    
    NSDate *date1= [formatter dateFromString:GeneratedTime];
    NSDate *date2 = [formatter dateFromString:currentTime];
    
    NSTimeInterval timeDifference = [date2 timeIntervalSinceDate:date1];
    
    NSLog(@"%.2f",timeDifference/60);
    
    if (timeDifference/60 < 15.0)
    {
        if([emailTextfield12.text isEqualToString:OTPRandom])
        {
            AuthenticatedController *authenView = [[AuthenticatedController alloc] init];
            
            authenView.firstName=usernameTextfield.text;
            authenView.lastName=lastNameTextfield.text;
            authenView.mobileNumer=mobileNum.text;
            authenView.registerEmail=emailTextfield.text;
            authenView.Registergender=genderTextfield.text;
            authenView.password=passwordTextfield.text;
            
            [self.navigationController pushViewController:authenView animated:YES];
        }
        else
        {
            UIAlertView* alertView1 = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Sorry incorrect OTP." delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil];
            [alertView1 show];
        }
    }
    else
    {
        [oneTimePassView removeFromSuperview];
        UIAlertView *otpExpireAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"Sorry this OTP has expired, please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [otpExpireAlert show];
    }
}

-(void)clearAllFields
{
    usernameTextfield.text = @"";
    passwordTextfield.text = @"";
    lastNameTextfield.text = @"";
    emailTextfield.text = @"";
     confirmpassTextfield.text = @"";
     mobileNum.text = @"";
}

-(void)chkValidation
{
     if(([usernameTextfield.text length] > 0) && ([lastNameTextfield.text length] > 0) && ([emailTextfield.text length] > 0) && ([passwordTextfield.text length] > 0) && ([confirmpassTextfield.text length] > 0) && ([genderTextfield.text length] > 0) && ([mobileNum.text length] > 0))
    {
        
        if ([self checkemail])
           if([self checkPassword])
            if([self checkMobileNume])
                [self getMobileNUmber];
        
    }
    else
    {
        UIAlertView *tempAlert = [[UIAlertView alloc] initWithTitle:@"Please enter all fields." message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [tempAlert show];
        checkCount=1;
    }
}

-(BOOL)checkMobileNume
{
    if(mobileNum.text.length<10 )
    {
        UIAlertView *tempAlert = [[UIAlertView alloc] initWithTitle:@"Please enter 10 digit number." message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [tempAlert show];
        [mobileNum becomeFirstResponder];
         checkCount=1;
    }
    else
    {
        checkCount=0;
        validationMobile=1;
        return YES;

    }
    return NO;
}

-(BOOL)checkPassword
{
    if([passwordTextfield.text isEqualToString:confirmpassTextfield.text])
    {
        validationPass=1;
        return YES;
    }
    else
    {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Password does not match" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [confirmpassTextfield becomeFirstResponder];
            checkCount=1;
    }
    return NO;
}

-(BOOL) checkemail
{
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
      if ([emailTest evaluateWithObject:emailTextfield.text] == YES)
    {
    
        ValidationFlag = 1;
        return YES;
    }
    else
    {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Email not in proper format" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [emailTextfield becomeFirstResponder];
        checkCount=1;
    }
    
    return NO;
}



- (void) btnCheckBoxMethod : (id) sender
{
    
    UIButton *btn = (UIButton *) sender;
    if (btn.selected == YES)
    {
        btn.selected = NO;
        chekBoxFlag=NO;
    }
    else
    {
        btn.selected = YES;
        chekBoxFlag=YES;
        
    }
}

- (void) backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [oneTimePassView removeFromSuperview];
    [myPickerView removeFromSuperview];
    [self.view endEditing:YES];
}

#pragma mark - TextField Delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag==1)
    {
        // [self.view addSubview:offerstablevie];
        // offerstablevie.frame = CGRectMake(150, 266, 150, 80);
        [self.view endEditing:YES];
//        textField.text=@"Male";
        [self.view addSubview:myPickerView];
        return false;
    }
    return true;
}
- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag==1)
    {
       // [self.view addSubview:offerstablevie];
       // offerstablevie.frame = CGRectMake(150, 266, 150, 80);
        [self.view endEditing:YES];
        [self.view addSubview:myPickerView];
    }
    
    else
    {
        [myPickerView removeFromSuperview];
    }
    
 
    
    if (textField.tag == 2 || textField.tag == 3)
    {
        authScrollScrool.contentOffset = CGPointMake(authScrollScrool.contentOffset.x,authScrollScrool.contentOffset.y+140*y_ratio);
    }
    if (textField.tag == 4)
    {
        registerScrool.contentOffset = CGPointMake(registerScrool.contentOffset.x,registerScrool.contentOffset.y+50*y_ratio);
    }
}

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    
    
    if (textField.tag == 2 || textField.tag == 3)
    {
        authScrollScrool.contentOffset = CGPointMake(authScrollScrool.contentOffset.x,authScrollScrool.contentOffset.y-140*y_ratio);
    }
    if (textField.tag == 4)
    {
        registerScrool.contentOffset = CGPointMake(registerScrool.contentOffset.x,registerScrool.contentOffset.y-50*y_ratio);
    }
}


- (BOOL) textFieldShouldReturn:(UITextField*)textField
{
    if (textField == usernameTextfield)
    {
        [usernameTextfield resignFirstResponder];
        [lastNameTextfield becomeFirstResponder];
    }
    else if (textField == lastNameTextfield)
    {
        [lastNameTextfield resignFirstResponder];
        [mobileNum becomeFirstResponder];
    }
    else if (textField == emailTextfield)
    {
        [emailTextfield resignFirstResponder];
    }
    else if (textField == passwordTextfield)
    {
        [passwordTextfield resignFirstResponder];
        [confirmpassTextfield becomeFirstResponder];
    }
    else
        [textField resignFirstResponder];
    
    return TRUE;
}
-(void)dismissKeyboard
{
    //[myPickerView removeFromSuperview];
    [emailTextfield12 resignFirstResponder];
   
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range

replacementString:(NSString *)string
{
    if (textField==mobileNum)
    {
        if ([mobileNum.text length]>9)
        {
            if ([string length]==0)
            {
                return YES;
            }
            return NO;
        }
    }
    
    if([usernameTextfield.text length]==0 && [lastNameTextfield.text length]==0 && [passwordTextfield.text length]==0 && [confirmpassTextfield.text length]==0 && [mobileNum.text length]==0)
    {
        if([string isEqualToString:@" "]){
            return NO;
        }
    }
    
   return YES;
}


#pragma mark - Pickerview Delegate
-(void)pickerViewTapGestureRecognized:(id)sender
{
    UIGestureRecognizer *gestureRecognizer=(UIGestureRecognizer *)sender;
    CGPoint touchPoint = [gestureRecognizer locationInView:gestureRecognizer.view.superview];
    
    CGRect frame = myPickerView.frame;
    CGRect selectorFrame = CGRectInset( frame, 0.0, myPickerView.bounds.size.height * 0.85 / 2.0 );
    
    if( CGRectContainsPoint( selectorFrame, touchPoint) )
    {
        genderTextfield.text=[genderArray objectAtIndex:[myPickerView selectedRowInComponent:0]];
             [myPickerView removeFromSuperview];
    }
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return true;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger numRows = genderArray.count;
    return numRows;
}
// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
  
    [genderTextfield setText:[NSString stringWithFormat:@"%@",[genderArray objectAtIndex:[pickerView selectedRowInComponent:0]]]];
    
    [myPickerView removeFromSuperview];
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [genderArray objectAtIndex:row];
    
    
}
// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    CGFloat componentWidth = 0.0;
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        
        componentWidth = 200.0;
    }
    else
    {
        
        componentWidth = 400.0;
    }
    return componentWidth;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        return 50;
    
    return 30;

}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* tView = (UILabel*)view;
    if (!tView)
    {
        tView = [[UILabel alloc] init];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if (self.view.frame.size.height == 568)
            {
                [tView setFont:[UIFont fontWithName:@"Helvetica" size:18]];
            }
            else
            {
                [tView setFont:[UIFont fontWithName:@"Helvetica" size:14]];
                
            }
        }
        else
        {
            [tView setFont:[UIFont fontWithName:@"Helvetica" size:36]];
        }
    }
    // Fill the label text here
    tView.text=[genderArray objectAtIndex:row];
    tView.textAlignment = NSTextAlignmentCenter;
    return tView;
}

- (void) skitMethod
{
    LeadingViewController *LeadingView = [[LeadingViewController alloc] init];
    [self.navigationController pushViewController:LeadingView animated:YES];
    
}

- (void) submitMethod
{
    LeadingViewController *LeadingView = [[LeadingViewController alloc] init];
    [self.navigationController pushViewController:LeadingView animated:YES];
    
}


-(void)getMobileNUmber
{
    NSString *mobileNumber=mobileNum.text;
    NSString *emailID=emailTextfield.text;
    NSString *url = [NSString stringWithFormat:@"https://testws.goodliving.ae/api/index.php/offer/checkUserAlreadyReg/%@/%@",mobileNumber,emailID];//http://testws.goodliving.ae/api/index.php/offer/checkUserAlreadyExists
      url=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    NSHTTPURLResponse *response = nil;
    NSError *error = [[NSError alloc] init];
    NSData *data= [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSDictionary*json;
    @try
    {
    if (data)
    {
        NSError* error;
        json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSMutableArray *DataArray = [json objectForKey:@"data"];
        NSString *status=[[DataArray objectAtIndex:0] valueForKey:@"status"];
        NSString *message=[[DataArray objectAtIndex:0] valueForKey:@"msg"];
        
        if([[NSString stringWithFormat:@"%@",status] isEqualToString:@"0"])
        {
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error!" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
              [alertView show];
        }
        else
        {
            if(chekBoxFlag==YES)
            {
                
                if(ValidationFlag == 1 && validationPass==1 && validationMobile==1)
                {
                    
                    [self OTPGeneration];
                    
                }
            }
            else
            {
                if(checkCount==1)
                {
                    
                }
                
                else{
                    UIAlertView* alertView1 = [[UIAlertView alloc] initWithTitle:nil message:@"To proceed, you need to agree to the Good Living Terms & Conditions." delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil];
                    alertView1.delegate=self;
                    [alertView1 show];
                }
                
            }
            

        }
        
    }
    }
    
    @catch (NSException *exception)
    {
        return;
    }
}



@end
