//
//  AuthenticatedController.m
//  Good Living
//
//  Created by NanoStuffs on 17/09/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import "AuthenticatedController.h"

#import "myPurchaseController.h"
#import "ContactusController.h"
#import "aboutGoodLivingController.h"
#import "notificationController.h"
#import "ViewController.h"
#import "LeadingViewController.h"

#import "MyVoucherController.h"
#import "MyAccountController.h"
#import "MainLeadingController.h"

@interface AuthenticatedController ()

@end

@implementation AuthenticatedController
@synthesize firstName,lastName,registerEmail,Registergender,mobileNumer,password,fname,lname,loginUsername;

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
    
    self.view.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f];
    
    delegate = [[UIApplication sharedApplication] delegate];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    x_ratio = screenRect.size.width/320;
    y_ratio = screenRect.size.height/568;
    self.view.backgroundColor = [UIColor whiteColor];
  
    
    //------------------------Navigation Bar
    UIImageView *navigationImage = [[UIImageView alloc] init];
    navigationImage.backgroundColor = [UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        navigationImage.frame = CGRectMake(0, 0, 320, 64);
    else
        navigationImage.frame = CGRectMake(0, 0, 768, 64);
    
    UILabel *topLable = [[UILabel alloc] init];
    
    if (delegate.subUpdateFlag == 1)
        topLable.text = @"Update";
    else
        topLable.text = @"Register";
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
       topLable.frame = CGRectMake(0, 25, 320, 30);
    else
        topLable.frame = CGRectMake(0, 25, 768, 30);
  
    topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
    topLable.textAlignment = NSTextAlignmentCenter;
    topLable.textColor = [UIColor whiteColor];
    topLable.backgroundColor = [UIColor clearColor];
    
   
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(5, 25, 35, 35);
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];

    
    registerScrool = [[UIScrollView alloc] init];
    registerScrool.delegate = self;
    // registerScrool.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f];
    [self.view addSubview:registerScrool];
    registerScrool.frame = CGRectMake(0, 64, 320, self.view.frame.size.height-64*y_ratio);
    registerScrool.contentSize = CGSizeMake(320*x_ratio, 500*y_ratio);
    
    //------------------------------- Authentication
    
        UIView *autherenticationView = [[UIView alloc] init];
    
    if (delegate.subUpdateFlag == 1)
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            autherenticationView.frame = CGRectMake(0, 65-60, self.view.frame.size.width, self.view.frame.size.height+125);
        else
            autherenticationView.frame = CGRectMake(0, 65-100, self.view.frame.size.width, self.view.frame.size.height+165);
    }
    else
        autherenticationView.frame = CGRectMake(0, 65, self.view.frame.size.width, self.view.frame.size.height+65);

        autherenticationView.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f];
        autherenticationView.userInteractionEnabled = YES;
        [self.view addSubview:autherenticationView];
        
        authScrollScrool = [[UIScrollView alloc] init];
        authScrollScrool.delegate = self;
        authScrollScrool.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1.0f];
    UITapGestureRecognizer *hideKeyboard=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(HideKeyboard)];
    
    [self.view addGestureRecognizer:hideKeyboard];
    
    [autherenticationView addSubview:authScrollScrool];

    authScrollScrool.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    authScrollScrool.contentSize = CGSizeMake(self.view.frame.size.width, 568*y_ratio);
    
        
        UILabel *emiritsLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 20*y_ratio, autherenticationView.frame.size.width,30*y_ratio)];
        emiritsLable.text = @"Authenticated!";
        emiritsLable.textColor = [UIColor blackColor];
        emiritsLable.backgroundColor = [UIColor clearColor];
        emiritsLable.textAlignment = NSTextAlignmentCenter;
 
    if (delegate.subUpdateFlag == 0)
        [authScrollScrool addSubview:emiritsLable];

        UILabel *infoLable1 = [[UILabel alloc] initWithFrame:CGRectMake(15*x_ratio, 60*y_ratio, 290*x_ratio,100*y_ratio)];
        infoLable1.text = @"If you are a relative or partner or subscriber, please enter any of the following subscriber details.";
        infoLable1.textColor = [UIColor grayColor];
        infoLable1.numberOfLines = 4;
        infoLable1.lineBreakMode = NSLineBreakByWordWrapping;
        infoLable1.backgroundColor = [UIColor clearColor];
   infoLable1.textAlignment = NSTextAlignmentLeft;
       
        [authScrollScrool addSubview:infoLable1];
        
    
        //BPcode
        UILabel *bpcodeLable = [[UILabel alloc] initWithFrame:CGRectMake(15*x_ratio, 160*y_ratio, 290*x_ratio,25*y_ratio)];
        bpcodeLable.text = @"SUBSCRIPTION NO.";
        bpcodeLable.textColor = [UIColor grayColor];
        bpcodeLable.backgroundColor = [UIColor clearColor];
        bpcodeLable.textAlignment = NSTextAlignmentLeft;

        [authScrollScrool addSubview:bpcodeLable];
        
      emailTextfield = [[UITextField alloc] init];
        //emailTextfield.placeholder = @"";
        emailTextfield.delegate = self;
        emailTextfield.tag = 1;
         emailTextfield.frame = CGRectMake(15*x_ratio, 190*y_ratio, 290*x_ratio, 40*y_ratio);
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        emailTextfield.keyboardType=UIKeyboardTypeNumberPad;
    else
        emailTextfield.keyboardType=UIKeyboardTypeDecimalPad;

        emailTextfield.backgroundColor = [UIColor clearColor];
        [emailTextfield setBackground:[UIImage imageNamed:@"textf.png"]];
        [authScrollScrool addSubview:emailTextfield];
        //orlable1
      UILabel *orLable1 = [[UILabel alloc] initWithFrame:CGRectMake(15*x_ratio, 240*y_ratio, 290*x_ratio,25*x_ratio)];
        orLable1.text = @"OR";
        orLable1.textColor = [UIColor grayColor];
        orLable1.backgroundColor = [UIColor clearColor];
        orLable1.textAlignment = NSTextAlignmentCenter;

        [authScrollScrool addSubview:orLable1];
        
        //Email
        UILabel *emailLable = [[UILabel alloc] initWithFrame:CGRectMake(15*x_ratio, 270*y_ratio, 290*x_ratio,25*y_ratio)];
        emailLable.text = @"EMAIL";
        emailLable.textColor = [UIColor grayColor];
        emailLable.backgroundColor = [UIColor clearColor];
        emailLable.textAlignment = NSTextAlignmentLeft;

        [authScrollScrool addSubview:emailLable];
        
      emailLableTextfield = [[UITextField alloc] init];
        emailLableTextfield.placeholder = @"";
        emailLableTextfield.tag = 2;
        emailLableTextfield.delegate = self;
        emailLableTextfield.frame = CGRectMake(15*x_ratio, 300*y_ratio, 290*x_ratio, 40*y_ratio);
        emailLableTextfield.backgroundColor = [UIColor clearColor];
        [emailLableTextfield setBackground:[UIImage imageNamed:@"textf.png"]];
        [authScrollScrool addSubview:emailLableTextfield];
        
        
        //orlable2
        UILabel *orLable2 = [[UILabel alloc] initWithFrame:CGRectMake(15*x_ratio, 350*y_ratio, 290*x_ratio,25*y_ratio)];
        orLable2.text = @"OR";
        orLable2.textColor = [UIColor grayColor];
        orLable2.backgroundColor = [UIColor clearColor];
        orLable2.textAlignment = NSTextAlignmentCenter;
   
        [authScrollScrool addSubview:orLable2];
        
        //mobileNo
        UILabel *mobileNoLable = [[UILabel alloc] initWithFrame:CGRectMake(15*x_ratio, 370*y_ratio, 290*x_ratio,25*y_ratio)];
        mobileNoLable.text = @"MOBILE NO.";
        mobileNoLable.textColor = [UIColor grayColor];
        mobileNoLable.backgroundColor = [UIColor clearColor];
        mobileNoLable.textAlignment = NSTextAlignmentLeft;
 
        [authScrollScrool addSubview:mobileNoLable];
    
      mobileNoLableLableTextfield = [[UITextField alloc] init];
        mobileNoLableLableTextfield.placeholder = @"";
        mobileNoLableLableTextfield.tag = 3;
        mobileNoLableLableTextfield.delegate = self;
        mobileNoLableLableTextfield.frame = CGRectMake(15*x_ratio, 400*y_ratio, 290*x_ratio, 40*y_ratio);
        mobileNoLableLableTextfield.backgroundColor = [UIColor clearColor];
        [mobileNoLableLableTextfield setBackground:[UIImage imageNamed:@"textf.png"]];
   if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    mobileNoLableLableTextfield.keyboardType=UIKeyboardTypeNumberPad;
    else
        mobileNoLableLableTextfield.keyboardType=UIKeyboardTypeDecimalPad;

    
        [authScrollScrool addSubview:mobileNoLableLableTextfield];
        
        UIButton *SkipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        SkipBtn.frame = CGRectMake(70*x_ratio, 455*y_ratio, 80*x_ratio, 30*y_ratio);
        [SkipBtn setTitle:@"SKIP" forState:UIControlStateNormal];
        [SkipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [SkipBtn setBackgroundColor: [UIColor colorWithRed:241/255.0f green:89/255.0f blue:35/255.0f alpha:1.0f]];
    SkipBtn.layer.cornerRadius=5.0f;
        //[SkipBtn setBackgroundImage:[UIImage imageNamed:@"btn1.png"] forState:UIControlStateNormal];
        [SkipBtn addTarget:self action:@selector(skitMethod) forControlEvents:UIControlEventTouchUpInside];
        [authScrollScrool addSubview:SkipBtn];
        
        UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        submitBtn.frame = CGRectMake(170*x_ratio, 455*y_ratio, 80*x_ratio, 30*y_ratio);
        [submitBtn setTitle:@"SUBMIT" forState:UIControlStateNormal];
        [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       // [submitBtn setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
         [submitBtn setBackgroundColor:[UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f]];
          submitBtn.layer.cornerRadius=5.0f;
    
        [submitBtn addTarget:self action:@selector(submitMethod) forControlEvents:UIControlEventTouchUpInside];
        [authScrollScrool addSubview:submitBtn];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
            emiritsLable.font = [UIFont fontWithName:@"Helvetica Neue" size:22];
            emiritsLable.font = [UIFont boldSystemFontOfSize:22];
            
            infoLable1.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
            infoLable1.font = [UIFont boldSystemFontOfSize:15];
            bpcodeLable.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
            bpcodeLable.font = [UIFont boldSystemFontOfSize:18];
            orLable1.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
            orLable1.font = [UIFont boldSystemFontOfSize:18];
            emailLable.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
            emailLable.font = [UIFont boldSystemFontOfSize:18];
            orLable2.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
            orLable2.font = [UIFont boldSystemFontOfSize:18];
            mobileNoLable.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
            mobileNoLable.font = [UIFont boldSystemFontOfSize:18];
    }
    else
    {
        navigationImage.frame = CGRectMake(0, 0, 768, 64);
        topLable.frame = CGRectMake(0, 25, 768, 30);
        backButton.frame = CGRectMake(5,25, 35, 35);
        
        topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:22];
        
        
        emiritsLable.font = [UIFont fontWithName:@"Helvetica Neue" size:26];
        emiritsLable.font = [UIFont boldSystemFontOfSize:26];
        
        infoLable1.font = [UIFont fontWithName:@"Helvetica Neue" size:16];
        infoLable1.font = [UIFont boldSystemFontOfSize:16];
        bpcodeLable.font = [UIFont fontWithName:@"Helvetica Neue" size:19];
        bpcodeLable.font = [UIFont boldSystemFontOfSize:19];
        orLable1.font = [UIFont fontWithName:@"Helvetica Neue" size:19];
        orLable1.font = [UIFont boldSystemFontOfSize:19];
        emailLable.font = [UIFont fontWithName:@"Helvetica Neue" size:19];
        emailLable.font = [UIFont boldSystemFontOfSize:19];
        orLable2.font = [UIFont fontWithName:@"Helvetica Neue" size:19];
        orLable2.font = [UIFont boldSystemFontOfSize:19];
        mobileNoLable.font = [UIFont fontWithName:@"Helvetica Neue" size:19];
        mobileNoLable.font = [UIFont boldSystemFontOfSize:19];
    }
    
    
    [self.view addSubview:navigationImage];
    [self.view addSubview:topLable];
    [self.view addSubview:backButton];

 	// Do any additional setup after loading the view.
}

- (void)HideKeyboard
{
    [self.view endEditing:YES];
}

- (void) backMethod
{
    delegate.subUpdateFlag = 0;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void) skitMethod
{
    NSString *name3,*email3,*number3,*gender3,*lname3;
    NSString *url;
    sub_bp=@"0";
    sub_email=@"0";
    sub_mobile=@"0";

    
    if (delegate.subUpdateFlag==1)
    {
//        delegate.subUpdateFlag = 0;
        [self.navigationController popViewControllerAnimated:YES];
//                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
//        NSUserDefaults *UserDefault=[NSUserDefaults standardUserDefaults];
//        NSData *data;
//        
//        data= [UserDefault valueForKey:@"fname"];
//        
//        name3=[NSKeyedUnarchiver unarchiveObjectWithData:[UserDefault valueForKey:@"fname"]];
//        
//        lname3=[NSKeyedUnarchiver unarchiveObjectWithData:[UserDefault valueForKey:@"lname"]];
//        
//        email3=[NSKeyedUnarchiver unarchiveObjectWithData:[UserDefault valueForKey:@"email"]];
//        number3=[NSKeyedUnarchiver unarchiveObjectWithData:[UserDefault valueForKey:@"mobileNum"]];
//        gender3=[NSKeyedUnarchiver unarchiveObjectWithData:[UserDefault valueForKey:@"gender"]];
        
        
//     url = [NSString stringWithFormat:@"http://testws.goodliving.ae/api/index.php/offer/registerUser/%@/%@/%@/%@/%@/%@/%@/%@/%@",name3,lname3,gender3,number3,email3, delegate.pass3,sub_bp,sub_email,sub_mobile];
        
        //url = [NSString stringWithFormat:@"https://testws.goodliving.ae/api/index.php/offer/editSubscriptionDetail/%@/%@/%@/%@",delegate.userID,sub_bp,sub_email,sub_mobile];
    }
   else
   {
      
       
     url = [NSString stringWithFormat:@"https://testws.goodliving.ae/api/index.php/offer/registerUser/%@/%@/%@/%@/%@/%@/%@/%@/%@/iphone/%@",firstName,lastName,Registergender,mobileNumer,registerEmail,password,sub_bp,sub_email,sub_mobile,delegate.DeviceToken==NULL ? @"abcd" : delegate.DeviceToken];

    
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
        
        NSString *message=[[DataArray objectAtIndex:0] valueForKey:@"msg"];
        NSString *userID=[[DataArray objectAtIndex:0] valueForKey:@"Id"];
       
        
        if(delegate.subUpdateFlag==1)
        {
        }
        else{
            delegate.fname=firstName;
            delegate.laname=lastName;
             delegate.userID=userID;
  
     
            
            loginUsername= [[DataArray objectAtIndex:0] valueForKey:@"Mobile__c"];
            mobileNumber = [[DataArray objectAtIndex:0] valueForKey:@"Mobile__c"];
            
            if ([[[DataArray objectAtIndex:0]valueForKey:@"First_Name__c"] length] > 0 || [[[DataArray objectAtIndex:0]valueForKey:@"Last_Name__c"] length] > 0)
            {
                NameString = [NSString stringWithFormat:@"%@ %@",[[DataArray objectAtIndex:0]valueForKey:@"First_Name__c"],[[DataArray objectAtIndex:0]valueForKey:@"Last_Name__c"]];
            }

            
        fname=[[DataArray objectAtIndex:0] valueForKey:@"First_Name__c"];
        lname=[[DataArray objectAtIndex:0] valueForKey:@"Last_Name__c"];
        email2=[[DataArray objectAtIndex:0] valueForKey:@"Email__c"];
        Registergender2=[[DataArray objectAtIndex:0]valueForKey:@"Gender__c"];
        
        NSUserDefaults *UserDefault1=[NSUserDefaults standardUserDefaults];
        
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:fname];
        [UserDefault1 setObject:data forKey:@"fname"];
        
        NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:lname];
        [UserDefault1 setObject:data1 forKey:@"lname"];
        NSData *data3 = [NSKeyedArchiver archivedDataWithRootObject:email2];
        [UserDefault1 setObject:data3 forKey:@"email"];
        
        NSData *data4 = [NSKeyedArchiver archivedDataWithRootObject:Registergender2];
        [UserDefault1 setObject:data4 forKey:@"gender"];
        
        NSData *data2 = [NSKeyedArchiver archivedDataWithRootObject:loginUsername];
        [UserDefault1 setObject:data2 forKey:@"mobileNum"];
        

        
       // NSString *bpcode=[[DataArray objectAtIndex:0]valueForKey:@"Subscription_BPId__c"];
        NSString *email1=@"0";//[[DataArray objectAtIndex:0]valueForKey:@"Email__c"];
        NSString *mobile=@"0";//[[DataArray objectAtIndex:0]valueForKey:@"Mobile__c"];
        NSString *status=@"0";//[[DataArray objectAtIndex:0]valueForKey:@"status"];
        NSString *startDate=@"0";//[[DataArray objectAtIndex:0]valueForKey:@"DateCreated"];
       NSString *endDate=@"0";//=[[DataArray objectAtIndex:0]valueForKey:@"Subscription_EndDate"];
        NSString *productionCode=@"0";//=[[DataArray objectAtIndex:0]valueForKey:@"Subscription_ProductCode"];
       NSString *subscrptionType=@"0";//=[[DataArray objectAtIndex:0]valueForKey:@"Subscription_Type"];
        
        //bpcode,startDate,status,endDate,productionCode,subscrptionType,mobile,email,
        
        NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc]init];
        if(sub_bp)
            [mutableDict setObject:sub_bp forKey:@"bpcode"];
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
        }
        
        if ([[[DataArray objectAtIndex:0] valueForKey:@"status"] isEqual:@"1"])
        {
            
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Success" message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            alertView.tag=2;
            [alertView show];
            
            delegate.loginSuccessfulFLAG=1;
            
        }
        else
        {
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            [alertView show];
            
        }
      
    }
    
    }
    @catch (NSException *exception)
    {
        return;
    }
   }
    
}

- (void) submitMethod
{
    //1168268
    
    if([emailTextfield.text isEqualToString:@""])
    {
        sub_bp=@"0";
    }
    else
    {
        sub_bp = emailTextfield.text;
        
    }
    
    if([emailLableTextfield.text isEqualToString:@""])
    {
        sub_email=@"0";
        
    }
    else
    {
        sub_email =emailLableTextfield.text;
    }
    
    if([mobileNoLableLableTextfield.text isEqualToString:@""])
    {
        sub_mobile=@"0";
    }
    else
    {
        sub_mobile =mobileNoLableLableTextfield.text;
        
    }
    
    if([emailTextfield.text isEqualToString:@""] && [emailLableTextfield.text isEqualToString:@""] && [mobileNoLableLableTextfield.text isEqualToString:@""])
    {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please Enter at least one value." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];

    }
    else
    {
        NSString *url;
        if (delegate.subUpdateFlag==1)
        {
            url = [NSString stringWithFormat:@"https://testws.goodliving.ae/api/index.php/offer/editSubscriptionDetail/%@/%@/%@/%@",delegate.userID,sub_bp,sub_email,sub_mobile];
        }
        
        else
        {
              url = [NSString stringWithFormat:@"https://testws.goodliving.ae/api/index.php/offer/registerUser/%@/%@/%@/%@/%@/%@/%@/%@/%@/iphone/%@",firstName,lastName,Registergender,mobileNumer,registerEmail,password,sub_bp,sub_email,sub_mobile,delegate.DeviceToken==NULL ? @"abcd" : delegate.DeviceToken];
        }

        
  
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
        
        if ([[[DataArray objectAtIndex:0]valueForKey:@"Mobile__c"] length] > 0)
        {
            mobileNumber = [[DataArray objectAtIndex:0]valueForKey:@"Mobile__c"];
        }
        
        if ([[[DataArray objectAtIndex:0]valueForKey:@"First_Name__c"] length] > 0 || [[[DataArray objectAtIndex:0]valueForKey:@"Last_Name__c"] length] > 0)
        {
            NameString = [NSString stringWithFormat:@"%@ %@",[[DataArray objectAtIndex:0]valueForKey:@"First_Name__c"],[[DataArray objectAtIndex:0]valueForKey:@"Last_Name__c"]];
        }
        
        NSString *message=[[DataArray objectAtIndex:0] valueForKey:@"msg"];
        NSString *userID=[[DataArray objectAtIndex:0] valueForKey:@"Id"];
        
        NSString *bpcode=[[DataArray objectAtIndex:0]valueForKey:@"Subscription_BPId__c"];
        NSString *email1=[[DataArray objectAtIndex:0]valueForKey:@"Subscription_Email"];
        NSString *mobile=[[DataArray objectAtIndex:0]valueForKey:@"Subscription_Mobile"];
        NSString *status=[[DataArray objectAtIndex:0]valueForKey:@"status"];
        NSString *startDate=[[DataArray objectAtIndex:0]valueForKey:@"Subscription_StartDate"];
        NSString *endDate=[[DataArray objectAtIndex:0]valueForKey:@"Subscription_EndDate"];
        NSString *productionCode=[[DataArray objectAtIndex:0]valueForKey:@"Subscription_ProductCode"];
        NSString *subscrptionType=[[DataArray objectAtIndex:0]valueForKey:@"Subscription_Type"];
        
        //bpcode,startDate,status,endDate,productionCode,subscrptionType,mobile,email,
        
        if(delegate.subUpdateFlag==1)
        {
        }
        else{
            delegate.fname=firstName;
            delegate.laname=lastName;
            delegate.userID=userID;
         }
        loginUsername= [[DataArray objectAtIndex:0] valueForKey:@"Mobile__c"];
        fname=[[DataArray objectAtIndex:0] valueForKey:@"First_Name__c"];
        lname=[[DataArray objectAtIndex:0] valueForKey:@"Last_Name__c"];
        email2=[[DataArray objectAtIndex:0] valueForKey:@"Email__c"];
        Registergender2=[[DataArray objectAtIndex:0]valueForKey:@"Gender__c"];
        
        if ([[[DataArray objectAtIndex:0] valueForKey:@"status"] isEqual:@"1"])
        {
            UIAlertView* alertView2 = [[UIAlertView alloc] initWithTitle:@"Success!" message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            alertView2.tag=1;
            [alertView2 show];
            delegate.loginSuccessfulFLAG=1;
        }
        else
        {
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            [alertView show];
            
        }
        
        
        NSUserDefaults *UserDefault1=[NSUserDefaults standardUserDefaults];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:fname];
        [UserDefault1 setObject:data forKey:@"fname"];
        
        NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:lname];
        [UserDefault1 setObject:data1 forKey:@"lname"];
        NSData *data3 = [NSKeyedArchiver archivedDataWithRootObject:email2];
        [UserDefault1 setObject:data3 forKey:@"email"];
        
        NSData *data4 = [NSKeyedArchiver archivedDataWithRootObject:Registergender2];
        [UserDefault1 setObject:data4 forKey:@"gender"];
        
        NSData *data2 = [NSKeyedArchiver archivedDataWithRootObject:loginUsername];
        [UserDefault1 setObject:data2 forKey:@"mobileNum"];

        
        
        NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc]init];
        if(bpcode)
            [mutableDict setObject:bpcode forKey:@"bpcode"];
        else
            [mutableDict setObject:@"0" forKey:@"bpcode"];
        
        if(email1)
            [mutableDict setObject:email1 forKey:@"email"];
        else
            [mutableDict setObject: @"0" forKey:@"email"];
        
        if(mobile)
            [mutableDict setObject:mobile forKey:@"mobile"];
        else
            [mutableDict setObject:@"0" forKey:@"mobile"];
        
        if(status)
            [mutableDict setObject:status forKey:@"status"];
        else
            [mutableDict setObject:@"0" forKey:@"status"];
        
        if(startDate)
            [mutableDict setObject:startDate forKey:@"startdate"];
        else
            [mutableDict setObject: @"0" forKey:@"startdate"];
        
        if(endDate)
            [mutableDict setObject:endDate forKey:@"enddate"];
        else
            [mutableDict setObject:@"0" forKey:@"enddate"];
        
        if(productionCode)
            [mutableDict setObject:productionCode forKey:@"prodcode"];
        else
           [mutableDict setObject:@"0" forKey:@"prodcode"];
        
        if(subscrptionType)
            [mutableDict setObject:subscrptionType forKey:@"subType"];
        else
          [mutableDict setObject:@"0" forKey:@"subType"];
        
        NSUserDefaults *UserDefault=[NSUserDefaults standardUserDefaults];
        [UserDefault setObject:mutableDict forKey:@"Registration"];
        [UserDefault synchronize];
        
     
    }
        
        
    }
        
    @catch (NSException *exception)
    {
        return;
    }


    }
}

- (void) otpSentToMobile : (NSString *)mobNo : (NSString *)nameString
{
    NSString *userId1=@"gnhttpotp";//httpdemo2";
    NSString *pass=@"htpgn236";//abc1234";
    NSString *senderID=@"GulfNews";//SMS4YOU";
    NSString *mobileNum1=mobNo;
    
    NSString *newStr = [mobileNum1 substringToIndex:1];
    
    if ([newStr isEqualToString:@"0"] == TRUE)
    {
        mobileNum1 = [mobileNum1 substringFromIndex:1];
    }
    
    NSString *mobilePrefix=@"971";
    
    mobilePrefix=[mobilePrefix stringByAppendingString:mobileNum1];
    
    NSString *url = [NSString stringWithFormat:@"http://global.myvaluefirst.com/smpp/sendsms?username=%@&password=%@&to=%@&from=%@&text=This is to inform you that, %@ has registered on GoodLiving app using your subscription details. If this is not valid, call 80045.",userId1,pass,mobilePrefix,senderID,nameString];
                     
    url=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    NSHTTPURLResponse *response = nil;
    NSError *error = [[NSError alloc] init];
    NSData *data= [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==2 || alertView.tag==1)
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"SignUpSuccess"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        delegate.loginFlag=1;
        
        [self otpSentToMobile:mobileNumber:NameString];
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
            
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark- Textfield Delegate

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag==1)
    {
      
     //   [textField resignFirstResponder];
        
    }
    
    if (textField.tag == 2 || textField.tag == 3)
    {
        authScrollScrool.contentOffset = CGPointMake(authScrollScrool.contentOffset.x,authScrollScrool.contentOffset.y+140);
        
    }
    if (textField.tag == 4)
    {
        registerScrool.contentOffset = CGPointMake(registerScrool.contentOffset.x,registerScrool.contentOffset.y+50);
    }
}

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    
    
    if (textField.tag == 2 || textField.tag == 3)
    {
        authScrollScrool.contentOffset = CGPointMake(authScrollScrool.contentOffset.x,authScrollScrool.contentOffset.y-140);
    }
    if (textField.tag == 4)
    {
        registerScrool.contentOffset = CGPointMake(registerScrool.contentOffset.x,registerScrool.contentOffset.y-50);
    }
}


- (BOOL) textFieldShouldReturn:(UITextField*)textField
{
    [textField resignFirstResponder];
    return TRUE;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
