//
//  comNapsatZpravuViewController.h
//  Potravinovy inspektor TV NOVA
//
//  Created by Jan Damek on 04.04.13.
//  Copyright (c) 2013 Asseco Solutions, a.s. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "comAppDelegate.h"
#import "comStoredImage.h"

@interface comNapsatZpravuViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *datum;
@property (strong, nonatomic) IBOutlet UILabel *misto;
@property (strong, nonatomic) IBOutlet UITextView *zprava;
@property (strong, nonatomic) IBOutlet UIView *container;

@property (strong, readonly, getter = getDelegate) comAppDelegate *d;

-(IBAction)novaFoto:(id)sender;
-(IBAction)odeslat:(id)sender;

@end
