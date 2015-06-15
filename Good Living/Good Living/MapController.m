//
//  MapController.m
//  Good Living
//
//  Created by Minakshi on 9/18/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

#import "MapController.h"


@interface MapController ()

@end

@implementation MapController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

//-(id)initWithLat:(NSString*)latitude andLong:(NSString*)longitude
//{
//    self = [super init];
//    if (self) {
//        
//        self.lat = latitude;
//        self.lon = longitude;
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    mapView = [[MKMapView alloc] init];
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    mapView.frame=CGRectMake(0,64,320,self.view.frame.size.height-64);
    else
    mapView.frame=CGRectMake(0,64,768,960);
                          
    [self.view addSubview:mapView];
    
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:1.0f];
    //------------------------Navigation Bar
    UIImageView *navigationImage = [[UIImageView alloc] init];
    navigationImage.backgroundColor = [UIColor colorWithRed:250/255.0f green:165/255.0f blue:25/255.0f alpha:1.0f];
    [self.view addSubview:navigationImage];
    
    UILabel *topLable = [[UILabel alloc] init];
    topLable.text = @"Map";
    topLable.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
    topLable.textAlignment = NSTextAlignmentCenter;
    topLable.textColor = [UIColor whiteColor];
    topLable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topLable];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    
    //---------------------------MapView
    mapView.delegate = self;

    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        navigationImage.frame = CGRectMake(0, 0, 320, 64);
        topLable.frame = CGRectMake(0, 25, 320, 30);
        backButton.frame = CGRectMake(5,25, 35, 35);
    }
    else
    {
        navigationImage.frame = CGRectMake(0, 0, 768, 64);
        topLable.frame = CGRectMake(0, 25, 768, 30);
        backButton.frame = CGRectMake(5,22, 35, 35);

    }
    
     CLLocationCoordinate2D center;
    center.latitude =[self.lat doubleValue];// (userLocation.coordinate.latitude);
    center.longitude = [self.lon doubleValue];//(userLocation.coordinate.longitude);
    mapView.centerCoordinate=center;
    
    // Add an annotation
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = center;
    //point.title = @"Where am I?";
    //point.subtitle = @"I'm here!!!";
    
    double miles = 0.5;
    double scalingFactor = ABS( (cos(2 * M_PI * [self.lat doubleValue] / 360.0) ));

    MKCoordinateSpan span;
    span.latitudeDelta = miles/69.0;
    span.longitudeDelta = miles/(scalingFactor * 69.0);
    MKCoordinateRegion region;
    region.span = span;
    region.center = center;
    [mapView setRegion:region animated:YES];
    [mapView addAnnotation:point];
}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
//    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
}

-(void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end