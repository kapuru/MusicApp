//
//  jsonArtists.m
//  Coverflow
//
//  Created by Udit Kapur on 8/3/13.
//  Copyright (c) 2013 toxicsoftware. All rights reserved.
//

#import "jsonArtists.h"

@implementation jsonArtists


-(void) dataRetreived: (NSData *) dataResponse{
    NSError *error;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:dataResponse options:kNilOptions error:&error];
    
    NSDictionary *topTracks = [jsonDict objectForKey:@"toptracks"];
    NSArray *tracksArray = [topTracks objectForKey:@"track"];
    
    for (int i = 0; i<20; i++){
        NSDictionary *songDictionary = [tracksArray objectAtIndex:i];
        NSString *nameOfSongFofArtist = [songDictionary objectForKey:@"name"];
        NSString *urlOfSongOnLastFm = [songDictionary objectForKey:@"url"];
        [self.singleTon.artistSongNames addObject:nameOfSongFofArtist];
        [self.singleTon.artistSongURLs addObject:urlOfSongOnLastFm];
        }
}


-(void)executeJson{
    self.singleTon = [SingleTon manager];
    self.singleTon.artistSongNames = [[NSMutableArray alloc] init];
    self.singleTon.artistSongURLs = [[NSMutableArray alloc]init];
    
    NSURL *lastFmURL = [NSURL URLWithString:[NSString stringWithFormat: @"http://ws.audioscrobbler.com/2.0/?method=artist.gettoptracks&artist=%@&api_key=cd465c0a02292cc6c0b08b1ab748992c&format=json",self.singleTon.artistName]];
    NSData *data = [NSData dataWithContentsOfURL:lastFmURL];
    [self dataRetreived:data];
}


@end
