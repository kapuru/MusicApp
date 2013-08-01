//
//  DirectToYoutubeView.h
//  Coverflow
//
//  Created by Udit Kapur on 7/29/13.
//  Copyright (c) 2013 toxicsoftware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleTon.h"

@interface DirectToYoutubeView : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webViewForYt;
@property SingleTon *singleton;
           
@end
