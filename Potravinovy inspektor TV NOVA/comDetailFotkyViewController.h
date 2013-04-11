//
//  comDetailFotkyViewController.h
//  Potravinovy inspektor TV NOVA
//
//  Created by Jan Damek on 04.04.13.
//  Copyright (c) 2013 Asseco Solutions, a.s. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "comStoredImage.h"

@interface comDetailFotkyViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *image;

-(IBAction)moveToTrash:(id)sender;

@end
