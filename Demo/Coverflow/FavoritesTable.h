//
//  FavoritesTable.h
//  Coverflow
//
//  Created by Udit Kapur on 7/28/13.
//  Copyright (c) 2013 toxicsoftware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleTon.h"

@interface FavoritesTable : UITableViewController

@property (strong, nonatomic) NSMutableArray *songs;
@property (strong, nonatomic) SingleTon *singeton;

@end
