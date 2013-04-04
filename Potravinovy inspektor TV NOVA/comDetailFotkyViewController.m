//
//  comDetailFotkyViewController.m
//  Potravinovy inspektor TV NOVA
//
//  Created by Jan Damek on 04.04.13.
//  Copyright (c) 2013 Asseco Solutions, a.s. All rights reserved.
//

#import "comDetailFotkyViewController.h"
#import "comAppDelegate.h"

@implementation comDetailFotkyViewController

@synthesize image;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    comAppDelegate *d = (comAppDelegate*)[[UIApplication sharedApplication]delegate];
    image.image = [d.fotky objectAtIndex:d.aktFotka];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)moveToTrash:(id)sender{
    comAppDelegate *d = (comAppDelegate*)[[UIApplication sharedApplication]delegate];
    [d.fotky removeObjectAtIndex:d.aktFotka];
    [d.seznamFotek.collectionView reloadData];

    [self.navigationController popViewControllerAnimated:YES];
}

@end
