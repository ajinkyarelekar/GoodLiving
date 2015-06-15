//
//  myProfileController.m
//  Good Living
//
//  Created by Minakshi on 9/19/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import "myProfileController.h"
#import "Customcell.h"

@interface myProfileController ()
{
    UITextField *txtNAme,*txtEmail,*txtnum,*txtGender,*txtNAme1;
    NSString *firstname,*email,*number,*gender,*lastname;
    UIButton *btnEditProfile,*btnSaveProfile;
    UIPickerView *myPickerView;
    NSArray *genderArray;
}
@end

@implementation myProfileController

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
    genderArray=[[NSArray alloc]initWithObjects:@"Male",@"Female", nil];
    
    delegate=[UIApplication sharedApplication].delegate;
    
    validationMobile=0;
    ValidationFlag=0;
    NSUserDefaults *UserDefault=[NSUserDefaults standardUserDefaults];
    NSData *data;
    
    data= [UserDefault valueForKey:@"fname"];
    
    firstname=[NSKeyedUnarchiver unarchiveObjectWithData:[UserDefault valueForKey:@"fname"]];
    lastname=[NSKeyedUnarchiver unarchiveObjectWithData:[UserDefault valueForKey:@"lname"]];

//    name=[name stringByAppendingString:[NSString stringWithFormat:@" %@",[NSKeyedUnarchiver unarchiveObjectWithData:[UserDefault valueForKey:@"lname"]]]];

    
    email=[NSKeyedUnarchiver unarchiveObjectWithData:[UserDefault valueForKey:@"email"]];
    number=[NSKeyedUnarchiver unarchiveObjectWithData:[UserDefault valueForKey:@"mobileNum"]];
    gender=[NSKeyedUnarchiver unarchiveObjectWithData:[UserDefault valueForKey:@"gender"]];

    
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:1.0f];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    x_ratio = screenRect.size.width/320;
    y_ratio = screenRect.size.height/568;

    
    //------------------------Navigation Bar
    UIImageView *navigationImage = [[UIImageView alloc] init];
    navigationImage.backgroundColor = [UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f];
    [self.view addSubview:navigationImage];
 
    
    UILabel *topLable = [[UILabel alloc] init];
    topLable.text = @"My Profile";


    topLable.textAlignment = NSTextAlignmentCenter;
    topLable.textColor = [UIColor whiteColor];
    topLable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topLable];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];

    
    titleArray=[[NSMutableArray alloc]initWithObjects:@"First Name",@"Last Name",@"Email",@"Mobile",@"Gender", nil];
    
    txtNAme=[[UITextField alloc]init];
    txtNAme.text=firstname;
    txtNAme.textColor = [UIColor lightGrayColor];
    txtNAme.delegate=self;
    
    txtNAme1=[[UITextField alloc]init];
    txtNAme1.text=lastname;
    txtNAme1.textColor = [UIColor lightGrayColor];
    txtNAme1.delegate=self;

    
    txtEmail=[[UITextField alloc]init];
    txtEmail.text=email;
    txtEmail.textColor = [UIColor lightGrayColor];
    txtEmail.delegate=self;
    
    txtnum=[[UITextField alloc]init];
    txtnum.keyboardType=UIKeyboardTypeNumberPad;
    txtnum.text=number;
    txtnum.textColor = [UIColor lightGrayColor];
    txtnum.delegate=self;
    
    txtGender=[[UITextField alloc]init];
    txtGender.text= [gender isEqualToString:@"Male"] ? @"Male" : @"Female" ;
    txtGender.textColor = [UIColor lightGrayColor];
    txtGender.delegate=self;
    
    subTitleArray=[[NSMutableArray alloc]initWithObjects:txtNAme ,txtNAme1,txtEmail,txtnum,txtGender, nil];
 
    //-------------------MyProfileView
    myProfileTableView = [[UITableView alloc] init];
    myProfileTableView.delegate = self;
    myProfileTableView.dataSource = self;
    myProfileTableView.tag = 2;
    myProfileTableView.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
    myProfileTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    myProfileTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    myProfileTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myProfileTableView.scrollEnabled=NO;
    [self.view addSubview:myProfileTableView];
    
    
    btnSaveProfile =[UIButton buttonWithType:UIButtonTypeCustom];
    [btnSaveProfile addTarget:self action:@selector(SaveMethod) forControlEvents:UIControlEventTouchUpInside];
    [btnSaveProfile setTitle:@"SAVE" forState:UIControlStateNormal];
    [btnSaveProfile setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnSaveProfile.hidden=YES;
    [btnSaveProfile setBackgroundColor:[UIColor colorWithRed:250.0f/255.0f green:165.0f/255.0f blue:25.0f/255.0f alpha:1.0f]];
   btnSaveProfile.layer.cornerRadius = 5.0f;
//    [btnSaveProfile setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
    [self.view addSubview:btnSaveProfile];
    
    btnEditProfile =[UIButton buttonWithType:UIButtonTypeCustom];
    [btnEditProfile addTarget:self action:@selector(EditMethod) forControlEvents:UIControlEventTouchUpInside];
    [btnEditProfile setTitle:@"EDIT" forState:UIControlStateNormal];
    [btnEditProfile setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnEditProfile setBackgroundColor:[UIColor colorWithRed:250.0f/255.0f green:165.0f/255.0f blue:25.0f/255.0f alpha:1.0f]];
    btnEditProfile.layer.cornerRadius = 5.0f;
//    [btnEditProfile setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
    btnEditProfile.hidden=NO;
    [self.view addSubview:btnEditProfile];
    
    myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(35*x_ratio, 266*y_ratio, 250*x_ratio, 100*y_ratio)];
    myPickerView.delegate = self;
    myPickerView.showsSelectionIndicator = YES;
    myPickerView.backgroundColor=[UIColor whiteColor];

    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        navigationImage.frame = CGRectMake(0, 0, 320    , 64     );
        topLable.frame = CGRectMake(0, 25     , 320    , 30     );
        topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
        backButton.frame = CGRectMake(5    ,25     , 35    , 35     );

        
        myProfileTableView.frame = CGRectMake(0, 100     , 320    ,215);
        btnSaveProfile.frame=CGRectMake(20, 325, 100, 30);
        btnEditProfile.frame=CGRectMake(20, 325, 100, 30);
        
        btnEditProfile.titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:16];
        btnSaveProfile.titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:16];
        
        txtNAme.font=[UIFont fontWithName:@"Helvetica Neue" size:16];
        txtNAme1.font=[UIFont fontWithName:@"Helvetica Neue" size:16];

        txtEmail.font=[UIFont fontWithName:@"Helvetica Neue" size:16];
        txtnum.font=[UIFont fontWithName:@"Helvetica Neue" size:16];
        txtGender.font=[UIFont fontWithName:@"Helvetica Neue" size:16];
    }

    else
    {
        topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:25];
          navigationImage.frame = CGRectMake(0, 0, 768, 64);
        backButton.frame = CGRectMake(5,22, 35, 35);
        topLable.frame = CGRectMake(0, 25, 768, 30);
        myProfileTableView.frame = CGRectMake(10, 150     , 748    ,380     );
        
        btnSaveProfile.frame=CGRectMake(40, 550, 200, 60);
        btnEditProfile.frame=CGRectMake(40, 550, 200, 60);
        btnEditProfile.titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:25];
        btnSaveProfile.titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:25];
        txtNAme.font=[UIFont fontWithName:@"Helvetica Neue" size:26];
        txtNAme1.font=[UIFont fontWithName:@"Helvetica Neue" size:26];

        txtEmail.font=[UIFont fontWithName:@"Helvetica Neue" size:26];
        txtnum.font=[UIFont fontWithName:@"Helvetica Neue" size:26];
        txtGender.font=[UIFont fontWithName:@"Helvetica Neue" size:26];
    }
    
	// Do any additional setup after loading the view.
}
-(void)SaveMethod
{
    [self chkValidation];
    
    
    if( validationMobile==1 && ValidationFlag ==1)
    {
    UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"Please Wait..." message:Nil delegate:Nil cancelButtonTitle:Nil otherButtonTitles:Nil, nil];
    [alt show];
    
        NSMutableArray *nameArray=[[NSMutableArray alloc]init];
    
        
//        NSRange rng = [txtNAme.text rangeOfString:@" "];
//        
//        
//        [nameArray addObject:[txtNAme.text componentsSeparatedByString:@" "]];
// 
//        NSString *first = [nameArray objectAtIndex:0];
//      NSString *last = [nameArray objectAtIndex:1];
//
//        if ([last isEqualToString:nil]) {
//           last=@"";
//        }
//        
//        NSLog(@"Name Array== %@",nameArray);
        
//    NSString *urlstr=[NSString stringWithFormat:@"https://testws.goodliving.ae/api/index.php/offer/updateProfile/%@/%@/%@/%@/%@/%@",delegate.userID,txtEmail.text,txtnum.text,[[txtNAme.text componentsSeparatedByString:@" "] firstObject],[[txtNAme.text componentsSeparatedByString:@" "] lastObject],[txtGender.text isEqualToString:@"Male"] ? @"Male" : @"Female"];
        
   NSString *urlstr=[NSString stringWithFormat:@"https://testws.goodliving.ae/api/index.php/offer/updateProfile/%@/%@/%@/%@/%@/%@",delegate.userID,txtEmail.text,txtnum.text,txtNAme.text,txtNAme1.text,[txtGender.text isEqualToString:@"Male"] ? @"Male" : @"Female"];

    urlstr=[urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSURLRequest *req=[NSURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data)
        {
            [alt dismissWithClickedButtonIndex:0 animated:YES];

            NSError *err;
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
            dict=[[dict objectForKey:@"data"] firstObject];
            
            if ([[dict valueForKey:@"Response"] isEqualToString:@"1"])
            {
                btnSaveProfile.hidden=YES;
                btnEditProfile.hidden=NO;
                txtEmail.enabled=NO;
                txtNAme.enabled=NO;
                txtNAme1.enabled=NO;


                txtnum.enabled=NO;
                txtGender.enabled=NO;
                
                
                NSUserDefaults *UserDefault=[NSUserDefaults standardUserDefaults];
                
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:txtNAme.text];//[[txtNAme.text componentsSeparatedByString:@" "] firstObject]];
                [UserDefault setObject:data forKey:@"fname"];
                
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"SignUpSuccess"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                delegate.fname=txtNAme.text;
                delegate.laname=txtNAme1.text;
                
                NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:txtNAme1.text];//[[txtNAme.text componentsSeparatedByString:@" "] lastObject]];
                [UserDefault setObject:data1 forKey:@"lname"];
                
                NSData *data2 = [NSKeyedArchiver archivedDataWithRootObject:txtnum.text];
                [UserDefault setObject:data2 forKey:@"mobileNum"];
                
                NSData *data3 = [NSKeyedArchiver archivedDataWithRootObject:txtEmail.text];
                [UserDefault setObject:data3 forKey:@"email"];
                
                NSData *data4 = [NSKeyedArchiver archivedDataWithRootObject:[txtGender.text isEqualToString:@"Male"] ? @"Male" : @"Female"];
                [UserDefault setObject:data4 forKey:@"gender"];
                
                UIAlertView *newalt=[[UIAlertView alloc]initWithTitle:@"Success!" message:@"Profile updated successfully." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                [newalt show];
            }
            else
            {
                UIAlertView *newalt=[[UIAlertView alloc]initWithTitle:@"Error!" message:[dict valueForKey:@"Message"] delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                [newalt show];
            }
        }
    }];
    //    http://testws.goodliving.ae/api/index.php/offer/updateProfile/564761/test4@test.com/ 3333333333/Test4/User4/M/Relative

    }

}

-(void)EditMethod
{
    btnEditProfile.hidden=YES;
    btnSaveProfile.hidden=NO;
    txtNAme.enabled=YES;
      txtNAme1.enabled=YES;
    txtEmail.enabled=YES;
    txtnum.enabled=YES;
    txtGender.enabled=YES;
  
    
}

-(void)chkValidation
{
    if(([txtNAme.text length] > 0) && ([txtNAme.text length] > 0) && ([txtEmail.text length] > 0) && ([txtnum.text length] > 0))
    {
        
        if ([self checkemail])
            [self checkMobileNume];
                    
    }
    else
    {
        UIAlertView *tempAlert = [[UIAlertView alloc] initWithTitle:@"Please enter all fields." message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [tempAlert show];
      //  checkCount=1;
    }
}
-(BOOL)checkMobileNume
{
    if(txtnum.text.length<10 )
    {
        UIAlertView *tempAlert = [[UIAlertView alloc] initWithTitle:@"Please enter 10 digit number." message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [tempAlert show];
        [txtnum becomeFirstResponder];
        validationMobile=0;
      
    }
    else
    {
       
        validationMobile=1;
        return YES;
        
    }
    return NO;
}
-(BOOL) checkemail
{
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    if ([emailTest evaluateWithObject:txtEmail.text] == YES)
    {
        
        ValidationFlag = 1;
        return YES;
    }
    else
    {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Email not in proper format" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [txtEmail becomeFirstResponder];
        ValidationFlag=0;
      //  checkCount=1;
    }
    
    return NO;
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  
    [self.view endEditing:YES];
}

#pragma mark - TableView delegate and datasource methods
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return titleArray.count;
    
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    // Cell isn't selected so return single height
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
    return 44;
    }
    else
        return 76;
    
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    Customcell *cell =(Customcell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[Customcell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    
    
    cell.str.text=[titleArray objectAtIndex:indexPath.row];
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
       cell.str.font=[UIFont fontWithName:@"Helvetica Neue" size:16];
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 43, 320, 1)];
        
        [line setBackgroundColor:[UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:0.7f]];
        
        [cell.contentView addSubview:line];
        
        cell.str1.frame=CGRectMake(100, 5, 180, 30);
        
    }
    else
    {
        cell.str.font=[UIFont fontWithName:@"Helvetica Neue" size:26];
        cell.textLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:26];
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 75, 768, 1)];
        
        [line setBackgroundColor:[UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:0.7f]];
        
        [cell.contentView addSubview:line];
        
    }
    
       cell.str.textColor= [UIColor blackColor];
    
//    cell.str1.text=[subTitleArray objectAtIndex:indexPath.row];
    

    UITextField *txtfield=[subTitleArray objectAtIndex:indexPath.row];
    txtfield.enabled=NO;
    txtfield.frame=cell.str1.frame;
    
    [cell.str1 removeFromSuperview];
    
    [cell addSubview:txtfield];
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        cell.str1.font=[UIFont fontWithName:@"Helvetica Neue" size:16];
    }
    else
    { cell.str1.font=[UIFont fontWithName:@"Helvetica Neue" size:26];
    }
   
    cell.str1.textColor= [UIColor grayColor];

    return cell;
    
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


-(void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark- textfield Delegates

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range

replacementString:(NSString *)string
{
    if (textField==txtnum)
    {
        if ([txtnum.text length]>9)
        {
            if ([string length]==0)
            {
                return YES;
            }
            return NO;
        }
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==txtGender)
    {
        [self.view endEditing:YES];
        [self.view addSubview:myPickerView];
        return false;
    }
    return true;
}

#pragma mark - Pickerview Delegate

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSUInteger numRows = genderArray.count;
    return numRows;
}
// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    [txtGender setText:[NSString stringWithFormat:@"%@",[genderArray objectAtIndex:[pickerView selectedRowInComponent:0]]]];
    
    [myPickerView removeFromSuperview];
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [genderArray objectAtIndex:row];
    
    
}
// tell the picker the width of each row for a given component

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        return 60.0;
    }
    return 30.0;
}
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



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
