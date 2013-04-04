//
//  comViewController.h
//  Potravinovy inspektor TV NOVA
//
//  Created by Jan Damek on 03.04.13.
//  Copyright (c) 2013 Asseco Solutions, a.s. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "comMistaViewController.h"

@interface comViewController : UIViewController<CLLocationManagerDelegate, MKMapViewDelegate>{
    CLLocationManager *locationManager;
    
    NSDate *last_places;
    
    NSMutableDictionary *obrazky;
}

@property (strong, nonatomic) IBOutlet MKMapView *map;
@property (strong, nonatomic) IBOutlet UIView *container;

-(IBAction)nactiNovaMista:(id)sender;

@end
