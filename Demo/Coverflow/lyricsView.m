//
//  lyricsView.m
//  Coverflow
//
//  Created by Udit Kapur on 7/28/13.
//  Copyright (c) 2013 toxicsoftware. All rights reserved.
//

#import "lyricsView.h"

@interface lyricsView ()

@end

@implementation lyricsView

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
    self.singleton = [SingleTon manager];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    self.imageV.image = self.singleton.thisSongImage;
    self.labelForSongName.text = self.singleton.songString;
    self.labelForLyrics.text = self.singleton.thisSongsLyrics;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
