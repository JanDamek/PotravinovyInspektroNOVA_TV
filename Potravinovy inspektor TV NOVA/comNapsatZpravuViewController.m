//
//  comNapsatZpravuViewController.m
//  Potravinovy inspektor TV NOVA
//
//  Created by Jan Damek on 04.04.13.
//  Copyright (c) 2013 Asseco Solutions, a.s. All rights reserved.
//

#import "comNapsatZpravuViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface comNapsatZpravuViewController ()

@end

@implementation comNapsatZpravuViewController

@synthesize datum, container, misto, zprava;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(comAppDelegate *)getDelegate{
    return (comAppDelegate*)[[UIApplication sharedApplication]delegate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    zprava.layer.cornerRadius = 5;
    container.layer.cornerRadius = 10;
}

-(void)viewDidAppear:(BOOL)animated{
    if (self.d.vybrano.section>0){
        NSDictionary *data = [self.d.mista objectAtIndex:self.d.vybrano.row];
        // Do any additional setup after loading the view.
        zprava.text = [NSString stringWithFormat:@"Dobrý den.\nTakové zboží prodávají tady v obchodě:\n%@\n %@.\n\nNafoceno to bylo %@.\n\nS pozdravem a přáním kvalitních potravin.",[data valueForKey:@"name"],[data valueForKey:@"vicinity"],[NSDate date]];
        misto.text = [data valueForKey:@"name"];
    }else{
        zprava.text = [NSString stringWithFormat:@"Dobrý den.\nTakové zboží prodávají tady na souradnicich %f , %f.\nNafoceno to bylo %@.\n\nS pozdravem a přáním kvalitních potravin.",self.d.coordinates.latitude,self.d.coordinates.longitude,[NSDate date]];
        misto.text = [NSString stringWithFormat:@"%f , %f",self.d.coordinates.latitude,self.d.coordinates.longitude];
    }
    datum.text = [NSString stringWithFormat:@"%@",[NSDate date]];
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //nafoceno nebo vybrano
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSString *mediaType = [info
                           objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        //preulozeni pres PNG
        NSData *d = UIImagePNGRepresentation(image);
        UIImage *img = [UIImage imageWithData:d];
        [self.d.fotky addObject:img];
    }
    [self.d.seznamFotek.collectionView reloadData];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)novaFoto:(id)sender{
    if ( [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]){
        UIImagePickerController* picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        
        picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        
        [self.navigationController presentViewController:picker animated:YES completion:nil];
    }else{
        
    }
}
-(void)odeslat:(id)sender{
    
}

@end
