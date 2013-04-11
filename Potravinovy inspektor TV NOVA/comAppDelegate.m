//
//  comAppDelegate.m
//  Potravinovy inspektor TV NOVA
//
//  Created by Jan Damek on 03.04.13.
//  Copyright (c) 2013 Asseco Solutions, a.s. All rights reserved.
//

#import "comAppDelegate.h"
#import "comViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation comAppDelegate

@synthesize mista, odeslano, fotky;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    mista = [[NSMutableArray alloc]init];
    odeslano = [NSKeyedUnarchiver unarchiveObjectWithFile:[self storeFileName:@"odeslano"]];
    fotky = [NSKeyedUnarchiver unarchiveObjectWithFile:[self storeFileName:@"fotky"]];
    if (!odeslano)
       odeslano = [[NSMutableArray alloc]init];
    if (!fotky)
        fotky = [[NSMutableArray alloc]init];
    
    [self.window makeKeyAndVisible];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        _activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(110, 185, 57, 57)];
        _activity.center = CGPointMake(160, 260);
    }else{
        _activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(200, 300, 57, 57)];
        _activity.center = CGPointMake(384, 512);
        
    }
    [_activity setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleWhiteLarge];
    _activity.layer.cornerRadius = 10;
    [_activity setBackgroundColor:[UIColor grayColor]];
    
    //[self.window.rootViewController.view addSubview:_activity];
    [self.window addSubview:_activity];
    _activity.hidesWhenStopped=YES;
    [_activity setHidden:NO];
    [_activity startAnimating];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
-(NSString*)storeFileName:(NSString*)name{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    
    return [basePath stringByAppendingPathComponent:[NSString stringWithFormat:@"s_1_%@.dat",name]];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [NSKeyedArchiver archiveRootObject:self.odeslano toFile:[self storeFileName:@"odeslano"]];
    [NSKeyedArchiver archiveRootObject:self.fotky toFile:[self storeFileName:@"fotky"]];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    odeslano = [NSKeyedUnarchiver unarchiveObjectWithFile:[self storeFileName:@"odeslano"]];
    fotky = [NSKeyedUnarchiver unarchiveObjectWithFile:[self storeFileName:@"fotky"]];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)addAnimationIndicator{
    _countOfAnimationIndicator++;
    //[self.window.rootViewController.view addSubview:_activity];
    [_activity startAnimating];
}

-(void)removeAnimationIndicator{
    _countOfAnimationIndicator--;
    if (_countOfAnimationIndicator<=0){
        _countOfAnimationIndicator = 0;
        [_activity stopAnimating];
        
    }
}

@end
