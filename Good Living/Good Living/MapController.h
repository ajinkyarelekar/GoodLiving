//
//  MapController.h
//  Good Living
//
//  Created by Minakshi on 9/18/14.
//  Copyright (c) 2014 NanoStuffs. All rights reserved.
//

/**********************************************
 * Developer: Ankush Ladhane
 * Created on:
 * *************Changes on 17/09/2014**************
 * list 1
 * list 2
 * list 3
 * ************************************************
 * *************Changes on
 */

#
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapController : UIViewController<MKMapViewDelegate>
{
    MKMapView *mapView;
}

//@property (nonatomic, strong) IBOutlet MKMapView *mapView;

@property(nonatomic) NSString *lat;
@property (nonatomic) NSString *lon;

//-(id)initWithLat:(NSString*)latitude andLong:(NSString*)longitude;

@end
