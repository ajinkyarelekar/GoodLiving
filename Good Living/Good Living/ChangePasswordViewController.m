//
//  myProfileController.m
//  Good Living
//
//  Created by Minakshi on 9/19/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "Customcell.h"

@interface ChangePasswordViewController ()
{
    UITextField *txtCurrenPass,*txtNewPass,*txtConfirmNewPass;
    UIButton *btnSave;
    int txtindex;
}
@end

@implementation ChangePasswordViewController

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
    
    delegate=[UIApplication sharedApplication].delegate;
    
    txtindex=0;
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:1.0f];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    x_ratio = screenRect.size.width/320;
    y_ratio = screenRect.size.height/568;

    
    //------------------------Navigation Bar
    UIImageView *navigationImage = [[UIImageView alloc] init];
    navigationImage.backgroundColor = [UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f];
    [self.view addSubview:navigationImage];
 
    
    UILabel *topLable = [[UILabel alloc] init];
    topLable.text = @"Change Password!";


    topLable.textAlignment = NSTextAlignmentCenter;
    topLable.textColor = [UIColor whiteColor];
    topLable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topLable];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];

    
    titleArray=[[NSMutableArray alloc]initWithObjects:@"Current Password " ,@"New Password ",@"Confirm Password ", nil];
    
    txtCurrenPass=[[UITextField alloc]init];
    txtCurrenPass.placeholder=@"Current Password";
    txtCurrenPass.secureTextEntry=YES;
    txtCurrenPass.delegate=self;
//    txtCurrenPass.textAlignment = NSTextAlignmentCenter;
    
    txtNewPass=[[UITextField alloc]init];
    txtNewPass.placeholder=@"New Password";
    txtNewPass.secureTextEntry=YES;
    txtNewPass.delegate=self;
    
    txtConfirmNewPass=[[UITextField alloc]init];
    txtConfirmNewPass.placeholder=@"Confirm Password";
    txtConfirmNewPass.secureTextEntry=YES;
    txtConfirmNewPass.delegate=self;
    
    subTitleArray=[[NSMutableArray alloc]initWithObjects:txtCurrenPass ,txtNewPass,txtConfirmNewPass, nil];
 
    //-------------------MyProfileView
    myProfileTableView = [[UITableView alloc] init];
    myProfileTableView.delegate = self;
    myProfileTableView.dataSource = self;
       myProfileTableView.tag = 2;
    myProfileTableView.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
    myProfileTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    myProfileTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    myProfileTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myProfileTableView];
    
    
    btnSave =[UIButton buttonWithType:UIButtonTypeCustom];
    [btnSave addTarget:self action:@selector(SaveMethod) forControlEvents:UIControlEventTouchUpInside];
    [btnSave setTitle:@"SAVE" forState:UIControlStateNormal];
    [btnSave setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnSave.layer.cornerRadius=5.0f;
    [btnSave setBackgroundColor:[UIColor colorWithRed:250.0f/255.0f green:165.0f/255.0f blue:25.0f/255.0f alpha:1.0f]];
//    [btnSave setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
    [self.view addSubview:btnSave];
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        navigationImage.frame = CGRectMake(0, 0, 320    , 64     );
        topLable.frame = CGRectMake(0, 25     , 320    , 30     );
        topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
        backButton.frame = CGRectMake(5    ,25     , 35    , 35     );
        myProfileTableView.frame = CGRectMake(0, 100     , 320    ,120     );
        btnSave.frame=CGRectMake(20, 230, 100, 30);
        btnSave.titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:16];
        txtCurrenPass.font=[UIFont fontWithName:@"Helvetica Neue" size:16];
        txtNewPass.font=[UIFont fontWithName:@"Helvetica Neue" size:16];
        txtConfirmNewPass.font=[UIFont fontWithName:@"Helvetica Neue" size:16];
    }
    else
    {
        topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:25];
        navigationImage.frame = CGRectMake(0, 0, 768, 64);
        backButton.frame = CGRectMake(5,22, 35, 35);
        topLable.frame = CGRectMake(0, 25, 768, 30);
        myProfileTableView.frame = CGRectMake(10, 150     , 748    ,228     );
        
        btnSave.frame=CGRectMake(40, 398, 200, 60);
        btnSave.titleLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:25];
        txtCurrenPass.font=[UIFont fontWithName:@"Helvetica Neue" size:26];
        txtNewPass.font=[UIFont fontWithName:@"Helvetica Neue" size:26];
        txtConfirmNewPass.font=[UIFont fontWithName:@"Helvetica Neue" size:26];
    }
    
	// Do any additional setup after loading the view.
}
-(void)SaveMethod
{
    
    if ([txtCurrenPass.text length]==0 || [txtNewPass.text length]==0 || [txtConfirmNewPass.text length]==0)
    {
        UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Please enter all fields." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        [alt show];
        return;

    }
    if (![txtNewPass.text isEqualToString:txtConfirmNewPass.text])
    {
        UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Passwords do not match." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        [alt show];
        return;
    }
    
    UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"Please Wait..." message:Nil delegate:Nil cancelButtonTitle:Nil otherButtonTitles:Nil, nil];
    [alt show];
    NSString *urlstr=[NSString stringWithFormat:@"https://testws.goodliving.ae/api/index.php/offer/changePassword/%@/%@/%@",delegate.userID,txtNewPass.text,txtCurrenPass.text];

    urlstr=[urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURLRequest *req=[NSURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data)
        {
            [alt dismissWithClickedButtonIndex:0 animated:YES];

            NSError *err;
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
            dict=[[dict objectForKey:@"data"] firstObject];
            
            if ([[dict valueForKey:@"status"] intValue]==1) //isEqualToString:@"1"])
            {
                NSUserDefaults *UserDefault=[NSUserDefaults standardUserDefaults];
                NSData *data;
                
                data= [UserDefault valueForKey:@"fname"];
                
                NSString * name=[NSKeyedUnarchiver unarchiveObjectWithData:[UserDefault valueForKey:@"fname"]];
                
                name=[name stringByAppendingString:[NSString stringWithFormat:@" %@",[NSKeyedUnarchiver unarchiveObjectWithData:[UserDefault valueForKey:@"lname"]]]];
                
                //Change_Password
                
                if (name && delegate.userID)
                {
                    [Flurry logEvent:@"Change Password"];
                    [Flurry logPageView];
                    
                    self.screenName = @"Change Password";
                }

                
                txtCurrenPass.text=Nil;
                txtNewPass.text=Nil;
                txtConfirmNewPass.text=Nil;
                UIAlertView *newalt=[[UIAlertView alloc]initWithTitle:@"Success!" message:@"Hi! Your password has been reset." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                [newalt show];
            }
            else
            {
                UIAlertView *newalt=[[UIAlertView alloc]initWithTitle:@"Error!" message:[dict valueForKey:@"msg"] delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                [newalt show];
            }
        }
    }];
    //    http://testws.goodliving.ae/api/index.php/offer/updateProfile/564761/test4@test.com/ 3333333333/Test4/User4/M/Relative
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
    return 40     ;
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
        cell.str.font=[UIFont fontWithName:@"Helvetica Neue" size:16];
    else
    { cell.str.font=[UIFont fontWithName:@"Helvetica Neue" size:26]; }
    
    cell.str.textColor= [UIColor blackColor];
    
    UITextField *txtfield;
    if (indexPath.row==0)
        txtfield=[subTitleArray objectAtIndex:0];
    else if (indexPath.row==1)
        txtfield=[subTitleArray objectAtIndex:1];
    else if (indexPath.row==2)
        txtfield=[subTitleArray objectAtIndex:2];
    
    txtfield.frame= CGRectMake(cell.str1.frame.origin.x-10, cell.str1.frame.origin.y, cell.str1.frame.size.width, cell.str1.frame.size.height);//cell.str1.frame;
        [cell.str1 removeFromSuperview];
        [cell addSubview:txtfield];
    
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        UIView *line;
        line=[[UIView alloc]initWithFrame:CGRectMake(0, 39, 320, 1)];
        
        [line setBackgroundColor:[UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:0.7f]];
        
        [cell.contentView addSubview:line];
        
    }
    else
    {
        
        cell.textLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:26];
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 75, 768, 1)];
        
        [line setBackgroundColor:[UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:0.7f]];
        
        [cell.contentView addSubview:line];
        
    }
    
    cell.str1.textColor= [UIColor grayColor];
    
    return cell;
}

//{
//    static NSString *CellIdentifier = @"Cell";
//
//
//
//
//    Customcell *cell =(Customcell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[Customcell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
//    }
//    
//    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
//    {
//        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 39, 320, 1)];
//        
//        [line setBackgroundColor:[UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:0.7f]];
//        
//        [cell.contentView addSubview:line];
//        
//    }
//    else
//    {
//        cell.textLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:26];
//        
//        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 75, 768, 1)];
//        
//        [line setBackgroundColor:[UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:0.7f]];
//        
//        [cell.contentView addSubview:line];
//        
//    }
//
//    
//    
//    cell.str.text=[titleArray objectAtIndex:indexPath.row];
//    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
//        cell.str.font=[UIFont fontWithName:@"Helvetica Neue" size:16];
//    else
//    { cell.str.font=[UIFont fontWithName:@"Helvetica Neue" size:26]; }
//
//      cell.str.textColor= [UIColor blackColor];
//    UITextField *txtfield;
//    if (indexPath.row==1)
//        txtfield=[subTitleArray objectAtIndex:0];
//    else if (indexPath.row==3)
//        txtfield=[subTitleArray objectAtIndex:1];
//    else if (indexPath.row==5)
//        txtfield=[subTitleArray objectAtIndex:2];
//
//    txtfield.frame= CGRectMake(10, cell.str1.frame.origin.y, 300, cell.str1.frame.size.height);//cell.str1.frame;
//    [cell.str1 removeFromSuperview];
//    [cell addSubview:txtfield];
//
//    
//    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
//    {
//        cell.str1.font=[UIFont fontWithName:@"Helvetica Neue" size:16];
//    }
//    else
//    { cell.str1.font=[UIFont fontWithName:@"Helvetica Neue" size:26];
//    }
//   
//    cell.str1.textColor= [UIColor grayColor];
//
//    return cell;
//}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark- textfield Delegates
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
