//
//  jsonArtists.h
//  Coverflow
//
//  Created by Udit Kapur on 8/3/13.
//  Copyright (c) 2013 toxicsoftware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingleTon.h"

@interface jsonArtists : NSObject

@property (strong, nonatomic) SingleTon *singleTon;

-(void)executeJson;

@end
