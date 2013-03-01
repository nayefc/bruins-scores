//
//  NewsViewController.h
//  Bruins
//
//  Created by Nayef Copty on 23/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAD.h>
#import "TBXML.h"

#define DARK_CELL  [UIColor colorWithRed:151.0/255.0 green:152.0/255.0 blue:155.0/255.0 alpha:1.0]
#define LIGHT_CELL [UIColor colorWithRed:172.0/255.0 green:173.0/255.0 blue:175.0/255.0 alpha:1.0]

@class BlogRssParser;
@class BlogRss;

@interface NewsViewController : UIViewController <ADBannerViewDelegate, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate> {
    ADBannerView *adView;
    BOOL bannerIsVisible;
    UIImageView *header;
    UITableView *newsTableView;
    
    // XML Arrays
    NSMutableArray *titles;
    NSMutableArray *descriptions;
    NSMutableArray *pubDates;
    NSMutableArray *guids;
}

@property (nonatomic, assign) BOOL bannerIsVisible;
@property (nonatomic, retain) IBOutlet UIImageView *header;
@property (nonatomic, retain) IBOutlet UITableView *newsTableView;

@property (nonatomic, retain) NSMutableArray *titles;
@property (nonatomic, retain) NSMutableArray *descriptions;
@property (nonatomic, retain) NSMutableArray *pubDates;
@property (nonatomic, retain) NSMutableArray *guids;

- (void)traverseElements;

@end
