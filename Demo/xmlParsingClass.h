//
//  xmlParsingClass.h
//  xmlJsonAssignment
//
//  Created by oodit on 7/17/13.
//  Copyright (c) 2013 oodit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface xmlParsingClass : NSObject <NSXMLParserDelegate>


@property (strong, nonatomic) NSMutableArray *songsForXML;
@property (strong, nonatomic) NSString *currentElement;
@property (strong, nonatomic) NSXMLParser *parser;
@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) NSMutableArray *artistsForXML;
@property (strong, nonatomic) NSString *artistName;

@property (strong, nonatomic) NSMutableArray *pictureLinks;
@property (strong, nonatomic) NSString *picturelink;

@property (strong, nonatomic) NSString  *linkToiTunes;

@property (strong, nonatomic) NSString* height;

-(void)executeXML;

@end
