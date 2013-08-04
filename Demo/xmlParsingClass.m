//
//  xmlParsingClass.m
//  xmlJsonAssignment
//
//  Created by oodit on 7/17/13.
//  Copyright (c) 2013 oodit. All rights reserved.
//

#import "xmlParsingClass.h"

@implementation xmlParsingClass

#define songsURL [NSURL URLWithString: @"http://itunes.apple.com/rss/topsongs/limit=50/xml"]

-(void)executeXML{
    self.songsForXML = [[NSMutableArray alloc]init];
    self.artistsForXML = [[NSMutableArray alloc]init];
    self.pictureLinks = [[NSMutableArray alloc]init];
   
    self.parser = [[NSXMLParser alloc]initWithContentsOfURL:songsURL];
    self.parser.delegate = self;
    [self.parser parse];
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    self.currentElement = elementName;  
    self.height = [attributeDict objectForKey:@"height"];
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    if([self.currentElement isEqualToString:@"title"]){
        NSString *noSpace = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        self.name = [self.name stringByAppendingString:noSpace];
    }
    if([self.currentElement isEqualToString: @"im:artist"]){
        NSString *noSpaceArtist = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        self.artistName = [self.artistName stringByAppendingString:noSpaceArtist];
    }
    
    if ([self.currentElement isEqualToString:@"im:image"] && [self.height isEqualToString:@"170"]) {
        self.picturelink = string;
    }
    if ([self.currentElement isEqualToString:@"id"]){
        NSString *parsedLink = [string stringByResolvingSymlinksInPath];
        self.linkToiTunes = parsedLink;
        if ([self.linkToiTunes length]>5 && ![self.linkToiTunes isEqualToString:@"http:/itunes.apple.com/rss/topsongs/limit=20/xml"])
        {
        }
    }
}


-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    if ([self.name length] > 0 &&
        ![self.name isEqualToString:@"iTunes Store: Top Songs"])
    {
        [self.songsForXML addObject:self.name];
    }
    if ([self.artistName length]>0){
        [self.artistsForXML addObject:self.artistName];
    }
    if ([self.picturelink length]>0){
        [self.pictureLinks addObject:self.picturelink];
    }
    self.currentElement = NULL;
    self.name = @"";
    self.artistName = @"";
    self.picturelink=@"";
    self.linkToiTunes=@"";
}

@end
