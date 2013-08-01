//
//  VCForYoutube.m
//  Coverflow
//
//  Created by Udit Kapur on 7/27/13.
//  Copyright (c) 2013 toxicsoftware. All rights reserved.
//

#import "VCForYoutube.h"

@interface VCForYoutube ()

@end



@implementation VCForYoutube

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.singleForYt = [SingleTon manager];
    self.webView.delegate = self;
    [self.webView scalesPageToFit];
}


-(void)viewDidAppear:(BOOL)animated{
    NSString *searchString= self.singleForYt.songString;
    
    NSString *formattedString = [searchString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    formattedString = [formattedString stringByReplacingOccurrencesOfString:@"&" withString:@"+"];
    formattedString = [formattedString stringByReplacingOccurrencesOfString:@"“" withString:@"+"];
    formattedString = [formattedString stringByReplacingOccurrencesOfString:@"”" withString:@"+"];
    formattedString = [formattedString stringByReplacingOccurrencesOfString:@"'" withString:@"+"];
    formattedString = [formattedString stringByReplacingOccurrencesOfString:@"’" withString:@"+"];
    formattedString = [formattedString stringByReplacingOccurrencesOfString:@"é" withString:@"+"];
    
    self.singleForYt.formattedSongName = formattedString;
    
    if (self.singleForYt.indexRow == 0){
        NSString *urlAddress = [NSString stringWithFormat:@"http://www.google.com/search?q=%@",formattedString];
        NSURL *url = [NSURL URLWithString:urlAddress];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:requestObj];
        
        //NSLog(@"%@",formattedString);
        
    }
    if(self.singleForYt.indexRow == 1){
        NSString *urlAddress =[self.singleForYt.linksToItunes objectAtIndex:self.singleForYt.selectedSongIndex];
        NSURL *url = [NSURL URLWithString:urlAddress];  
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:requestObj];
    }
    if(self.singleForYt.indexRow == 2){
        NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://m.youtube.com/results?q=%@",formattedString]];
        NSURLRequest *request=[NSURLRequest requestWithURL:url];
        
        [self.webView loadRequest:request];
    }
    if(self.singleForYt.indexRow == 3){
            NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://www.google.com/search?q=%@+lyrics",formattedString]];
            NSURLRequest *request=[NSURLRequest requestWithURL:url];
            [self.webView loadRequest:request];
    }
    if (self.singleForYt.indexRow == 4){
        /*
        NSRange rangeOfSubstring = [formattedString rangeOfString:@"-"];
        
        if(rangeOfSubstring.location == NSNotFound)
        {
            rangeOfSubstring = [formattedString rangeOfString:@"("];
            NSLog(@"- NOt Found");
        }
        
        // return only that portion of 'string' up to where '<a href' was found
        
        formattedString = [formattedString substringToIndex:rangeOfSubstring.location];
        NSLog(@"Formatted String %@",formattedString);
        */
        formattedString = [formattedString stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
        formattedString = [formattedString stringByReplacingOccurrencesOfString:@"!" withString:@""];

        NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://www.mp3olimp.net/%@-mp3",formattedString]];
        NSURLRequest *request=[NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
     NSLog(@"%@",self.webView.request.mainDocumentURL);
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)aWebView
{
    /*
    NSString *mp3String = [self.webView.request.mainDocumentURL absoluteString];
    
    if ([mp3String rangeOfString:@".mp3olimp"].location == NSNotFound) {
        NSLog(@"string does not contain mp3olimp");
        if ([mp3String rangeOfString:@".mp3"].location == NSNotFound) {
            NSLog(@"string does not contain mp3");
        } else {
            NSLog(@"%@",self.webView.request.mainDocumentURL);
        }
    } 
     */
    
     NSLog(@"%@",self.webView.request.mainDocumentURL);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
