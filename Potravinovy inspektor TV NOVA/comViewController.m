//
//  comViewController.m
//  Potravinovy inspektor TV NOVA
//
//  Created by Jan Damek on 03.04.13.
//  Copyright (c) 2013 Asseco Solutions, a.s. All rights reserved.
//

#import "comViewController.h"
#import "comAppDelegate.h"

@implementation comViewController

@synthesize container, map;

static NSString *GoogleApiKey = @"AIzaSyBezdSzgQfKNnhiJuQq5SCxn7KYveUzEBk";

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyBest; // 100 m
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    
    [map setShowsUserLocation:YES];
    [map setZoomEnabled:YES];
    [map setUserInteractionEnabled:YES];
    [map setScrollEnabled:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)stahniXMLMist{
    //stazeni a nacteni XML z googlu
    NSString *url_string = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=500&types=store&sensor=true&key=%@",locationManager.location.coordinate.latitude,locationManager.location.coordinate.longitude,GoogleApiKey];

    NSData *responseData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url_string]];   
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          
                          options:kNilOptions
                          error:nil];
    
    NSMutableArray* places = [json objectForKey:@"results"];
    NSLog(@"Google Data: %@", places);
    
    last_places = [NSDate date];
    
    comAppDelegate *d = (comAppDelegate*)[[UIApplication sharedApplication]delegate];
    d.mista = places;
    
    [[container.subviews objectAtIndex:0] reloadData];
    
}

-(void)nactiNovaMista:(id)sender{
    NSDate *kdy;
    if ([sender isKindOfClass:[UIButton class]]){
        kdy =  [NSDate dateWithTimeIntervalSinceNow:-60];
    }else{
        kdy =  [NSDate dateWithTimeIntervalSinceNow:-60*5];
    }
    
    if (!last_places || [last_places compare:kdy]==NSOrderedAscending){
        //proved nacteni mist, ubeh casovy inteval
        [self performSelectorInBackground:@selector(stahniXMLMist) withObject:nil];
        last_places = [NSDate date];
    }
    if (!last_places){
        last_places = [NSDate date];
    }    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    double latitude_map  = round(map.centerCoordinate.latitude *10000)/10000;
    double longitude_map = round(map.centerCoordinate.longitude*10000)/10000;

    double latitude_gps  = round(manager.location.coordinate.latitude *10000)/10000;
    double longitude_gps = round(manager.location.coordinate.longitude*10000)/10000;
    
    if (
        (latitude_map  != latitude_gps) ||
        (longitude_map != longitude_gps) ) {
        
        [map setCenterCoordinate:manager.location.coordinate animated:YES];
        
        int presnost = round(manager.location.horizontalAccuracy);
        if (presnost<20){
            //provede nasteni seznamu mist
            [self nactiNovaMista:nil];
        }
        comAppDelegate *d = (comAppDelegate*)[[UIApplication sharedApplication]delegate];
        d.coordinates = manager.location.coordinate;
        [[container.subviews objectAtIndex:0] reloadData];
    }
}

@end
