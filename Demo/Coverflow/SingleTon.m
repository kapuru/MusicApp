//
//  SingleTon.m
//  Coverflow
//
//  Created by Udit Kapur on 7/27/13.
//  Copyright (c) 2013 toxicsoftware. All rights reserved.
//

#import "SingleTon.h"

@implementation SingleTon

+(id)manager{
    static SingleTon *shared;
    if (shared == nil){
        shared = [[super allocWithZone:NULL]init];
    }
    return shared;
}

+(id)allocWithZone:(NSZone *)zone{
    return [self manager];
}

@end
    
