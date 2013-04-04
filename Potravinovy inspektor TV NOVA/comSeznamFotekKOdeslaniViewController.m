//
//  comSeznamFotekKOdeslaniViewController.m
//  Potravinovy inspektor TV NOVA
//
//  Created by Jan Damek on 04.04.13.
//  Copyright (c) 2013 Asseco Solutions, a.s. All rights reserved.
//

#import "comSeznamFotekKOdeslaniViewController.h"

@interface comSeznamFotekKOdeslaniViewController ()

@end

@implementation comSeznamFotekKOdeslaniViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(comAppDelegate *)getDelegate{
    return (comAppDelegate*)[[UIApplication sharedApplication]delegate];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.d.fotky count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"fotkaCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
}

@end
