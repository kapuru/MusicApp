//
//  lyricsView.h
//  Coverflow
//
//  Created by Udit Kapur on 7/28/13.
//  Copyright (c) 2013 toxicsoftware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleTon.h"

@interface lyricsView : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *labelForLyrics;
@property SingleTon *singleton;
@property (weak, nonatomic) IBOutlet UILabel *labelForSongName;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end
