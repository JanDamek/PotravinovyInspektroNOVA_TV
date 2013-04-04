//
//  comMistaViewController.m
//  Potravinovy inspektor TV NOVA
//
//  Created by Jan Damek on 04.04.13.
//  Copyright (c) 2013 Asseco Solutions, a.s. All rights reserved.
//

#import "comMistaViewController.h"
#import "comNovaMistaTableViewCell.h"

@implementation comMistaViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    obrazky = [[NSMutableDictionary alloc]init];
    self.d.vybrano = nil;
}

-(comAppDelegate *)getDelegate{
    return (comAppDelegate*)[[UIApplication sharedApplication]delegate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
      return 1;
    } else{
        return [self.d.mista count];
    }
}

-(void)nactiObrazek:(NSDictionary*)imageAndUrlString{
    NSString *url = [imageAndUrlString valueForKey:@"url"];
    UIImage *image = [obrazky objectForKey:url];
    UIImageView *img = [imageAndUrlString valueForKey:@"imageView"];
    if (!image){
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        image = [UIImage imageWithData:imageData];
        [obrazky setValue:image forKey:url];
    }
    img.image = image;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"novaCell";
    comNovaMistaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (indexPath.section==0){
        cell.image.image = [UIImage imageNamed:@"Map_Pin.png"];
        cell.nazev.text = @"Aktualni pozice";
        cell.misto.text = [NSString stringWithFormat:@"Lat:%f  Long:%f",self.d.coordinates.latitude, self.d.coordinates.longitude];
    }else{
        NSDictionary *row = [self.d.mista objectAtIndex:indexPath.row];
        NSString *url = [row objectForKey:@"icon"];
        if (![url isEqualToString:@""]){
            NSMutableDictionary *data = [[NSMutableDictionary alloc]init];
            [data setValue:url forKey:@"url"];
            [data setValue:cell.image forKey:@"imageView"];
            [self performSelectorInBackground:@selector(nactiObrazek:) withObject:data];
        }
        cell.nazev.text = [row objectForKey:@"name"];
        cell.misto.text = [row objectForKey:@"vicinity"];
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.d.vybrano = [indexPath copy];
}

@end
