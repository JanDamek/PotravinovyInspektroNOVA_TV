//
//  comAppDelegate.m
//  Potravinovy inspektor TV NOVA
//
//  Created by Jan Damek on 03.04.13.
//  Copyright (c) 2013 Asseco Solutions, a.s. All rights reserved.
//

#import "comAppDelegate.h"

#import "comViewController.h"

@implementation comAppDelegate

@synthesize mista, odeslano, fotky;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    mista = [[NSMutableArray alloc]init];
    odeslano = [[NSMutableArray alloc]init];
    [self loadFotky];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

+(UIImage *)scaleImage:(UIImage *)image{
    
    float width = image.size.width / 2;
    float height = image.size.height / 2;
    CGSize newSize = CGSizeMake(width, height);
    
    UIGraphicsBeginImageContext(newSize);
    CGRect rect = CGRectMake(0, 0, width, height);
    
    float widthRatio = image.size.width / width;
    float heightRatio = image.size.height / height;
    float divisor = widthRatio > heightRatio ? widthRatio : heightRatio;
    
    width = image.size.width / divisor;
    height = image.size.height / divisor;
    
    rect.size.width  = width;
    rect.size.height = height;
    
    if(height < width)
        rect.origin.y = height / 3;
    [image drawInRect: rect];
    
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return smallImage;
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask, YES);
    NSString * documentsDirectoryPath = [paths objectAtIndex:0];
    
    int i=0;
    for (UIImage *img in fotky) {
        double compressionRatio=1;
        NSData *imgData=UIImageJPEGRepresentation(img,compressionRatio);
        UIImage *image;
        if ([imgData length]>50000) {
            image = [comAppDelegate scaleImage:img];
            imgData=UIImageJPEGRepresentation(image,compressionRatio);
        } else
            image = img;
        while ([imgData length]>50000 && compressionRatio>0.01) {
            compressionRatio=compressionRatio*0.5;
            imgData=UIImageJPEGRepresentation(image,compressionRatio);
        }
        NSString *dataPath = [documentsDirectoryPath  stringByAppendingPathComponent:[NSString stringWithFormat:@"img_%d.jpg",i]];
        [imgData writeToFile:dataPath atomically:YES];
        i++;
    }
}

-(void)loadFotky{
    fotky = [[NSMutableArray alloc]init];
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask, YES);
    NSString * documentsDirectoryPath = [paths objectAtIndex:0];
    
    int i=0;
    while ([[NSFileManager defaultManager] fileExistsAtPath:[documentsDirectoryPath  stringByAppendingPathComponent:[NSString stringWithFormat:@"img_%d.jpg",i]]]) {
        NSString *dataPath = [documentsDirectoryPath  stringByAppendingPathComponent:[NSString stringWithFormat:@"img_%d.jpg",i]];
        NSData *imgData = [NSData dataWithContentsOfFile:dataPath];
        UIImage *img;
        if ([imgData length]>50000) {
            img = [comAppDelegate scaleImage:[UIImage imageWithData:imgData]];
            imgData=UIImageJPEGRepresentation(img,1);
        } else
            img = [UIImage imageWithData:imgData];
        
        double compressionRatio=1;
        while ([imgData length]>50000 && compressionRatio>0.01) {
            compressionRatio=compressionRatio*0.5;
            imgData=UIImageJPEGRepresentation(img,compressionRatio);
        }
        
        [fotky addObject:[UIImage imageWithData:imgData]];
        i++;
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [self loadFotky];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
