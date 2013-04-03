//
//  comAppDelegate.h
//  Potravinovy inspektor TV NOVA
//
//  Created by Jan Damek on 03.04.13.
//  Copyright (c) 2013 Asseco Solutions, a.s. All rights reserved.
//

#import <UIKit/UIKit.h>

@class comViewController;

@interface comAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) comViewController *viewController;

@end
