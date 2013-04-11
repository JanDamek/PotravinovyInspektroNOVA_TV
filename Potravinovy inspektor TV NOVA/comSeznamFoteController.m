//
//  comSeznamFotekKOdeslaniViewController.m
//  Potravinovy inspektor TV NOVA
//
//  Created by Jan Damek on 04.04.13.
//  Copyright (c) 2013 Asseco Solutions, a.s. All rights reserved.
//

#import "comSeznamFoteController.h"
#import "comAppDelegate.h"
#import "comFotkaCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation comSeznamFoteController

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
    [self getDelegate].seznamFotek = self;
    self.view.layer.cornerRadius = 10;
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
    return [[self getDelegate].fotky count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"fotkaCell";
    comFotkaCell *cell = (comFotkaCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.layer.cornerRadius = 5;
    
    cell.image.image = [(comStoredImage*)[[self getDelegate].fotky objectAtIndex:indexPath.row]thumbnails];
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self getDelegate].aktFotka = indexPath.row;
}

@end
