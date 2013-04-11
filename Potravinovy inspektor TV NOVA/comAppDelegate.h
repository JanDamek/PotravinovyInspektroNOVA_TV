//
//  comAppDelegate.h
//  Potravinovy inspektor TV NOVA
//
//  Created by Jan Damek on 03.04.13.
//  Copyright (c) 2013 Asseco Solutions, a.s. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "comSeznamFoteController.h"

@class comViewController;

@interface comAppDelegate : UIResponder <UIApplicationDelegate>{
    int _countOfAnimationIndicator;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSMutableArray *mista;
@property (strong, nonatomic) NSMutableArray *odeslano;

@property (strong, nonatomic) NSMutableArray *fotky;
@property (strong, nonatomic) NSString * id_mista;

@property CLLocationCoordinate2D coordinates;
@property (strong, nonatomic) NSIndexPath *vybrano;

@property (strong, nonatomic) comSeznamFoteController *seznamFotek;
@property int aktFotka;

@property (strong, nonatomic) UIActivityIndicatorView *activity;

-(void)addAnimationIndicator;
-(void)removeAnimationIndicator;

@end
