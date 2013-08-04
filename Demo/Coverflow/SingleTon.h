//
//  SingleTon.h
//  Coverflow
//
//  Created by Udit Kapur on 7/27/13.
//  Copyright (c) 2013 toxicsoftware. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleTon : NSObject

@property (strong, nonatomic) NSString *songString;
@property (strong, nonatomic) NSString *pictureURL;
@property (strong, nonatomic) NSMutableArray *linksToItunes;

@property (strong, nonatomic) NSString *formattedSongName;

@property int indexRow;
@property int selectedSongIndex;

@property (strong, nonatomic) NSMutableArray *songs;
@property (strong, nonatomic) NSString *thisSongsLyrics;

@property (strong, nonatomic) NSString *youtubeSearchQuery;
@property (strong, nonatomic) UIImage *thisSongImage;

@property (strong, nonatomic) NSString *artistName;
@property (strong, nonatomic) NSMutableArray *artistSongNames;
@property (strong, nonatomic) NSMutableArray *artistSongURLs;

@property (strong, nonatomic) NSString *selectedArtistSongURL;

+(id)manager;

@end
