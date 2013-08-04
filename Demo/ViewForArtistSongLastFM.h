//
//  ViewForArtistSongLastFM.h
//  Coverflow
//
//  Created by Udit Kapur on 8/3/13.
//  Copyright (c) 2013 toxicsoftware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleTon.h"

@interface ViewForArtistSongLastFM : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webV;
@property (strong, nonatomic) SingleTon *singleton;

@end
