//
//  Song.m
//  Coverflow
//
//  Created by Udit Kapur on 7/28/13.
//  Copyright (c) 2013 toxicsoftware. All rights reserved.
//

#import "Song.h"

@implementation Song

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_songName forKey:@"songName"];
    [encoder encodeObject:_songLyrics forKey:@"songLyrics"];
    [encoder encodeObject:_pictureData forKey:@"pictureData"];
    [encoder encodeObject:_pictureURL forKey:@"pictureURL"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.songName = [decoder decodeObjectForKey:@"songName"];
        self.songLyrics= [decoder decodeObjectForKey:@"songLyrics"];
        self.pictureData = [decoder decodeObjectForKey:@"pictureData"];
        self.pictureURL = [decoder decodeObjectForKey:@"pictureURL"];
    }
    return self;
}

@end
