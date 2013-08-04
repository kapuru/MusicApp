//
//  VCForYoutube.h
//  Coverflow
//
//  Created by Udit Kapur on 7/27/13.
//  Copyright (c) 2013 toxicsoftware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleTon.h"


@interface VCForYoutube : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) SingleTon *singleForYt;

@end
