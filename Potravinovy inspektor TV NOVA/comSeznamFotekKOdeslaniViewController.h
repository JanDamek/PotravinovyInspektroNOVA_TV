//
//  comSeznamFotekKOdeslaniViewController.h
//  Potravinovy inspektor TV NOVA
//
//  Created by Jan Damek on 04.04.13.
//  Copyright (c) 2013 Asseco Solutions, a.s. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "comAppDelegate.h"

@interface comSeznamFotekKOdeslaniViewController : UICollectionViewController

@property (readonly, getter = getDelegate) comAppDelegate *d;

@end
