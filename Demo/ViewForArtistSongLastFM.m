//
//  ViewForArtistSongLastFM.m
//  Coverflow
//
//  Created by Udit Kapur on 8/3/13.
//  Copyright (c) 2013 toxicsoftware. All rights reserved.
//

#import "ViewForArtistSongLastFM.h"

@interface ViewForArtistSongLastFM ()

@end

@implementation ViewForArtistSongLastFM

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
    
    self.singleton = [SingleTon manager];
    self.webV.scalesPageToFit = YES;
    self.webV.delegate = self;
    NSURL *url = [NSURL URLWithString:self.singleton.selectedArtistSongURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webV loadRequest:requestObj];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
