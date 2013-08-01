//
//  FavoritesTable.m
//  Coverflow
//
//  Created by Udit Kapur on 7/28/13.
//  Copyright (c) 2013 toxicsoftware. All rights reserved.
//

#import "FavoritesTable.h"
#import "Song.h"
#import "lyricsView.h"

@interface FavoritesTable ()

@end

@implementation FavoritesTable

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
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.tableView.backgroundColor = [UIColor blackColor];
    
    //UIBarButtonItem *goOnline = [[UIBarButtonItem alloc] initWithTitle:@"Go Online" style:UIBarButtonItemStylePlain target:self action:@selector(toolbarItemTapped:)];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.singeton = [SingleTon manager];
    self.songs = [[NSMutableArray alloc]init];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(IBAction)toolbarItemTapped:(id)sender{
    
}


-(void)viewWillAppear:(BOOL)animated{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *fullFileName = [NSString stringWithFormat:@"%@/ourArray", docDir];
    NSMutableArray *arrayFromDisk = [NSKeyedUnarchiver unarchiveObjectWithFile:fullFileName];
    self.songs = arrayFromDisk;
    [self.tableView reloadData];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.songs.count;
    NSLog(@"%i",self.songs.count);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = [[self.songs objectAtIndex:indexPath.row] songName];
    UIImage *thisSongImage = [UIImage imageWithData:[[self.songs objectAtIndex:indexPath.row] pictureData]];
    cell.imageView.image = thisSongImage;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    UIImage *thisSongImage = [UIImage imageWithData:[[self.songs objectAtIndex:indexPath.row] pictureData]];
    self.singeton.thisSongImage = thisSongImage;
    self.singeton.thisSongsLyrics = [[self.songs objectAtIndex:indexPath.row] songLyrics];
    self.singeton.songString = [[self.songs objectAtIndex:indexPath.row] songName];
    [self.navigationController.viewControllers[0] performSegueWithIdentifier:@"segwayForLyrics" sender:self];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.songs removeObjectAtIndex:indexPath.row];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docDir = [paths objectAtIndex:0];
        NSString *fullFileName = [NSString stringWithFormat:@"%@/ourArray", docDir];
        [NSKeyedArchiver archiveRootObject:self.songs toFile:fullFileName];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

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
    self.singeton.selectedSongIndex = indexPath.row;
    self.singeton.songString = [[self.songs objectAtIndex:indexPath.row] songName];
    self.singeton.pictureURL = [[self.songs objectAtIndex:indexPath.row] pictureURL];
    [self.navigationController.viewControllers[0] performSegueWithIdentifier:@"segwayForOnline" sender:self];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

@end
