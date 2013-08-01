//
//  VCForOptions.h
//  Coverflow
//
//  Created by Udit Kapur on 7/27/13.
//  Copyright (c) 2013 toxicsoftware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleTon.h"


@interface VCForOptions : UIViewController <UITableViewDataSource, UITableViewDelegate, UIWebViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *labelForSongName;
@property (strong, nonatomic) SingleTon *theSingleTon;
@property (weak, nonatomic) IBOutlet UITableView *tableForOptions;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UITextField *textForLyrics;
@property NSMutableArray *savedSongNames;

@end
