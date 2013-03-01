//
//  NewsWebViewController.h
//  Bruins
//
//  Created by Nayef Copty on 01/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NewsWebViewController : UIViewController <UIWebViewDelegate> {
    UIWebView *newsWebView;
    NSString *urlStr;
}

@property (nonatomic, retain) IBOutlet UIWebView *newsWebView;
@property (nonatomic, retain) NSString *urlStr;

@end
