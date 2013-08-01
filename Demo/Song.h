//
//  Song.h
//  Coverflow
//
//  Created by Udit Kapur on 7/28/13.
//  Copyright (c) 2013 toxicsoftware. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Song : NSObject <NSCoding>

@property (strong, nonatomic) NSString *songName;
@property (strong, nonatomic) NSString *songLyrics;
@property (strong, nonatomic) NSData *pictureData;
@property (strong, nonatomic) NSString *pictureURL;

@end
