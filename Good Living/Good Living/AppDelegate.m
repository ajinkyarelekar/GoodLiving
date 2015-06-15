//
//  AppDelegate.m
//  Good Living
//
//  Created by NanoStuffs on 04/09/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import "AppDelegate.h"

/******* Set your tracking ID here *******/
static NSString *const kTrackingId = @"UA-7996438-53";
static NSString *const kAllowTracking = @"allowTracking";

@implementation AppDelegate

@synthesize loginFlag,userID,password,lattitude,longitude,fname,laname,subUpdateFlag,pass3,leftPannelflag,loginSuccessfulFLAG;

void uncaughtExceptionHandler(NSException *exception)
{
    [Flurry logError:@"Error" message:[exception name] exception:exception];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
//    if([defaults valueForKey:@"userID"])
//    {
//        NSData *data5 = [defaults valueForKey:@"userID"];
//        
//        self.userID=[NSKeyedUnarchiver unarchiveObjectWithData:data5];
//        self.loginFlag=1;
//    }
    
    // Override point for customization after application launch.
 [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];

    //note: iOS only allows one crash reporting tool per app; if using another, set to: NO
    [Flurry setCrashReportingEnabled:YES];
    
    // Replace YOUR_API_KEY with the api key in the downloaded package
    [Flurry startSession:@"7NN2PTP7K88NGYDVQWYQ"];
    [Flurry logEvent:@"Application StartSession"];
    
    NSDictionary *appDefaults = @{kAllowTracking: @(YES)};
    [[NSUserDefaults standardUserDefaults] registerDefaults:appDefaults];
    // User must be able to opt out of tracking
    [GAI sharedInstance].optOut =
    ![[NSUserDefaults standardUserDefaults] boolForKey:kAllowTracking];
    // Initialize Google Analytics with a 120-second dispatch interval. There is a
    // tradeoff between battery usage and timely dispatch.
    [GAI sharedInstance].dispatchInterval = 120;
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    self.tracker = [[GAI sharedInstance] trackerWithName:@"GoodLiving"
                                              trackingId:kTrackingId];
    
    self.tracker = [[GAI sharedInstance] defaultTracker];
    [self.tracker set:kAllowTracking value:@"YES"];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[ViewController alloc] init];
    
    //set navigation controller as root controller
    self.navigController=[[UINavigationController alloc] initWithRootViewController:self.viewController];
    
    self.window.rootViewController = self.navigController;
    [self.window makeKeyAndVisible];
    
    return YES;
}



#pragma mark- push notification

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
	
    _DeviceToken=[NSString stringWithFormat:@"%@",deviceToken];
    _DeviceToken=[_DeviceToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    _DeviceToken=[_DeviceToken stringByReplacingOccurrencesOfString:@"<" withString:@""];
    _DeviceToken=[_DeviceToken stringByReplacingOccurrencesOfString:@">" withString:@""];
    
   
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	NSLog(@"Failed to get token, error: %@", error);
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    NSUserDefaults *UserDefault=[NSUserDefaults standardUserDefaults];
    [UserDefault setObject:userID forKey:@"Loginuserid"];
    [UserDefault setInteger:loginFlag forKey:@"lofinflag"];
    [UserDefault setInteger:loginSuccessfulFLAG forKey:@"loginSuccess"];
    [UserDefault setObject:fname forKey:@"firstName"];
    [UserDefault setObject:laname forKey:@"lastName"];
    
    [UserDefault synchronize];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSUserDefaults *UserDefault=[NSUserDefaults standardUserDefaults];
    [UserDefault setObject:userID forKey:@"Loginuserid"];
    [UserDefault setInteger:loginFlag forKey:@"lofinflag"];
    [UserDefault setInteger:loginSuccessfulFLAG forKey:@"loginSuccess"];
    [UserDefault setObject:fname forKey:@"firstName"];
    [UserDefault setObject:laname forKey:@"lastName"];

    [UserDefault synchronize];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *loginStr= [defaults objectForKey:@"loginUsername"];
    NSString *passStr = [defaults objectForKey:@"loginPassword"];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    userID = [prefs objectForKey:@"Loginuserid"];
    loginFlag = [[prefs objectForKey:@"lofinflag"] intValue];
    loginSuccessfulFLAG = [[prefs objectForKey:@"loginSuccess"] intValue];
    fname =   [prefs objectForKey:@"firstName"];
    laname =  [prefs objectForKey:@"lastName"];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    userID = [prefs objectForKey:@"Loginuserid"];
    loginFlag = [[prefs objectForKey:@"lofinflag"] intValue];
    loginSuccessfulFLAG = [[prefs objectForKey:@"loginSuccess"] intValue];
    fname =   [prefs objectForKey:@"firstName"];
    laname =  [prefs objectForKey:@"lastName"];

    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    NSUserDefaults *UD=[NSUserDefaults standardUserDefaults];
    [UD removeObjectForKey:@"FilterSubTitleArray"];
    [UD removeObjectForKey:@"SelectedCatogories"];
    [UD removeObjectForKey:@"SelectedAreas"];
    
    [UD removeObjectForKey:@"LandingFilterSubTitleArray"];
    [UD removeObjectForKey:@"LandingSelectedCatogories"];
    [UD removeObjectForKey:@"LandingSelectedAreas"];
    
    [UD synchronize];
    
    NSUserDefaults *UserDefault=[NSUserDefaults standardUserDefaults];
    [UserDefault setObject:userID forKey:@"Loginuserid"];
    [UserDefault setInteger:loginFlag forKey:@"lofinflag"];
    [UserDefault setInteger:loginSuccessfulFLAG forKey:@"loginSuccess"];
    [UserDefault setObject:fname forKey:@"firstName"];
    [UserDefault setObject:laname forKey:@"lastName"];

    [UserDefault synchronize];
    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
