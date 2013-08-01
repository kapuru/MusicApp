//
//  DirectToYoutubeView.m
//  Coverflow
//
//  Created by Udit Kapur on 7/29/13.
//  Copyright (c) 2013 toxicsoftware. All rights reserved.
//

#import "DirectToYoutubeView.h"

@interface DirectToYoutubeView ()

@end

@implementation DirectToYoutubeView

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
    self.singleton.youtubeSearchQuery = [self.singleton.youtubeSearchQuery stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    self.singleton.youtubeSearchQuery = [self.singleton.youtubeSearchQuery stringByReplacingOccurrencesOfString:@"&" withString:@"+"];
    self.singleton.youtubeSearchQuery = [self.singleton.youtubeSearchQuery stringByReplacingOccurrencesOfString:@"“" withString:@"+"];
    self.singleton.youtubeSearchQuery = [self.singleton.youtubeSearchQuery stringByReplacingOccurrencesOfString:@"”" withString:@"+"];
     self.singleton.youtubeSearchQuery = [self.singleton.youtubeSearchQuery stringByReplacingOccurrencesOfString:@"'" withString:@"+"];
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://m.youtube.com/results?q=%@",self.singleton.youtubeSearchQuery]];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    [self.webViewForYt loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
