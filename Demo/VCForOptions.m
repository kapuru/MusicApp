//
//  VCForOptions.m
//  Coverflow
//
//  Created by Udit Kapur on 7/27/13.
//  Copyright (c) 2013 toxicsoftware. All rights reserved.
//

#import "VCForOptions.h"
#import "CDemoCollectionViewController.h"
#import "Song.h"
#import "jsonArtists.h"

@interface VCForOptions ()

@end

@implementation VCForOptions

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
    self.theSingleTon = [SingleTon manager];
    self.tableForOptions.backgroundColor = [UIColor blackColor];
    [self.tableForOptions setDataSource:self];
    [self.tableForOptions setDelegate:self];
    [self.tableForOptions reloadData];
    
    //unarchive
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *fullFileName = [NSString stringWithFormat:@"%@/ourArray", docDir];
    NSMutableArray *arrayFromDisk = [NSKeyedUnarchiver unarchiveObjectWithFile:fullFileName];
    
    self.savedSongNames = [[NSMutableArray alloc]init];
    if (arrayFromDisk.count==0){
        self.theSingleTon.songs = [[NSMutableArray alloc]init];
    }
    else{
        self.theSingleTon.songs = arrayFromDisk;
        for(int i =0;i<self.theSingleTon.songs.count;i++){
            [self.savedSongNames addObject:[[self.theSingleTon.songs objectAtIndex:i] songName]];
        }
    }

    UIBarButtonItem *addFav = [[UIBarButtonItem alloc] initWithTitle:@"Add To Favorites" style:UIBarButtonItemStylePlain target:self action:@selector(toolbarItemTapped:)];
    self.navigationItem.rightBarButtonItem = addFav;
    [self.textForLyrics setDelegate:self];
}

-(IBAction)toolbarItemTapped:(id)sender{
    //Do Data Base Stuff
    // check errors and present alert view
    
    [self.textForLyrics resignFirstResponder];
    
    
    Song *newSong = [[Song alloc]init];
    newSong.songName = self.theSingleTon.songString;
    newSong.songLyrics = self.textForLyrics.text;
    NSURL *theURL = [NSURL URLWithString:self.theSingleTon.pictureURL];
    NSData *imageData = [[NSData alloc]initWithContentsOfURL: theURL];
    newSong.pictureData = imageData;
    newSong.pictureURL = self.theSingleTon.pictureURL;
    
    // find current song name in the saved array ??
    
    if([self.savedSongNames containsObject:self.theSingleTon.songString]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"This Song Already is a Favorite!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else{
        [self.theSingleTon.songs addObject:newSong];

        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docDir = [paths objectAtIndex:0];
        NSString *fullFileName = [NSString stringWithFormat:@"%@/ourArray", docDir];
        [NSKeyedArchiver archiveRootObject:self.theSingleTon.songs toFile:fullFileName];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Song Saved!" message:@"Added to Favorites!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        [self.savedSongNames addObject:self.theSingleTon.songString];
    }
    self.textForLyrics.text = @"";
}

-(void)viewWillAppear:(BOOL)animated{
    self.labelForSongName.text = self.theSingleTon.songString;
    NSURL *theURL = [NSURL URLWithString:self.theSingleTon.pictureURL];
    NSData *imageData = [[NSData alloc]initWithContentsOfURL: theURL];
    UIImage *theImage = [UIImage imageWithData:imageData];
    self.imageV.image = theImage;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    cell.textLabel.textColor = [UIColor whiteColor];
    if (indexPath.row == 0){
        cell.textLabel.text = @"Google it!";
        cell.imageView.image = [UIImage imageNamed:@"google.png"];
    }
    if(indexPath.row ==1){
        cell.textLabel.text = @"Show in app Store";
        cell.imageView.image = [UIImage imageNamed:@"itunes.png"];
    }
    if (indexPath.row ==2) {
        cell.textLabel.text = @"Search Youtube";
        cell.imageView.image = [UIImage imageNamed:@"yt2.png"];
    }
    if(indexPath.row == 3){
        cell.textLabel.text = @"Find Lyrics";
        cell.imageView.image = [UIImage imageNamed:@"lyrics2.png"];
    }
    if(indexPath.row == 4){
        cell.textLabel.text = @"Find mp3";
        cell.imageView.image = [UIImage imageNamed:@"mp3.png"];
    }
    if(indexPath.row == 5){
        cell.textLabel.text = @"Post";
        cell.imageView.image = [UIImage imageNamed:@"post.png"];
    }
    if(indexPath.row == 6){
        cell.textLabel.text = @"Top songs by this Artist";
        cell.imageView.image = [UIImage imageNamed:@"artist.png"];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 6){
        NSString *searchString= self.theSingleTon.songString;
        
        NSString *formattedString = [searchString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        formattedString = [formattedString stringByReplacingOccurrencesOfString:@"&" withString:@"+"];
        formattedString = [formattedString stringByReplacingOccurrencesOfString:@"“" withString:@"+"];
        formattedString = [formattedString stringByReplacingOccurrencesOfString:@"”" withString:@"+"];
        formattedString = [formattedString stringByReplacingOccurrencesOfString:@"'" withString:@"+"];
        formattedString = [formattedString stringByReplacingOccurrencesOfString:@"’" withString:@"+"];
        formattedString = [formattedString stringByReplacingOccurrencesOfString:@"é" withString:@"+"];
        
        NSRange rangeOfSubstring = [formattedString rangeOfString:@"-"];
        self.theSingleTon.artistName = [formattedString substringFromIndex:rangeOfSubstring.location];
        self.theSingleTon.artistName = [self.theSingleTon.artistName stringByReplacingOccurrencesOfString:@"-" withString:@""];
        
        jsonArtists *json = [[jsonArtists alloc]init];
        [json executeJson];
        
        self.theSingleTon.indexRow = indexPath.row;
        [self.navigationController.viewControllers[1] performSegueWithIdentifier:@"segwayForLastFmArtists" sender:self];
    }
    if (indexPath.row == 5){
        
        NSData *postImageData = [NSData dataWithContentsOfURL: [NSURL URLWithString: self.theSingleTon.pictureURL]];
        UIImage *postImage = [UIImage imageWithData:postImageData];
        NSString *postText = [NSString stringWithFormat:@"I am listening to %@ \n on Udit's Music App",self.theSingleTon.songString ];
        NSArray *activityItems = @[postText, postImage];
        
        UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
        
        activityController.excludedActivityTypes = @[UIActivityTypePostToWeibo, UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeMessage, UIActivityTypeSaveToCameraRoll];
        
        [self presentViewController:activityController animated:YES completion:nil];
    }
    if(indexPath.row ==0 || indexPath.row ==1 || indexPath.row ==2 || indexPath.row == 3 || indexPath.row == 4)
    {
    self.theSingleTon.indexRow = indexPath.row;
    [self.navigationController.viewControllers[1] performSegueWithIdentifier:@"segwayGoToOption" sender:self];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    [self.textForLyrics resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
