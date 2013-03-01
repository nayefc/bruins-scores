//
//  NewsWebViewController.m
//  Bruins
//
//  Created by Nayef Copty on 01/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NewsWebViewController.h"


@implementation NewsWebViewController

@synthesize newsWebView, urlStr;

#pragma mark - View lifecycle / Memory Management

- (void)viewDidLoad {
    [newsWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
    [super viewDidLoad];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.newsWebView = nil;
    self.urlStr = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [super dealloc];
    [newsWebView release];
    [urlStr release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark UIWebView Delegate Methods

// Start the activity indicator when it starts loading
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

// Stops the activity indicator when it stops loading
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

// Display error if error found
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    NSString *errorString = [NSString stringWithFormat:
                             @"<html><center><font size=+5 color='red'>An error occurred:<br>%@</font></center></html>",
                             error.localizedDescription];
    [newsWebView loadHTMLString:errorString baseURL:nil];
}



@end
