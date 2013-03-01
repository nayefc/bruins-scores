//
//  StatsViewController.h
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
#define HEADER_CELL [UIColor colorWithRed:236.0/255.0 green:171.0/255.0 blue:67.0/255.0 alpha:1.0]

@interface StatsViewController : UIViewController <ADBannerViewDelegate, UITableViewDelegate, UITableViewDataSource> {
    ADBannerView *adView;
    BOOL bannerIsVisible;
    UIImageView *header;
    UITableView *statsTableView;
    
    NSMutableArray *names;
    NSMutableArray *gamesPlayed;
    NSMutableArray *goals;
    NSMutableArray *points;
    NSMutableArray *assists;
    NSMutableArray *plusMinuses;
    NSMutableArray *penalties;
}

@property (nonatomic, assign) BOOL bannerIsVisible;
@property (nonatomic, retain) IBOutlet UIImageView *header;
@property (nonatomic, retain) IBOutlet UITableView *statsTableView;

@property (nonatomic, retain) NSMutableArray *names;
@property (nonatomic, retain) NSMutableArray *gamesPlayed;
@property (nonatomic, retain) NSMutableArray *goals;
@property (nonatomic, retain) NSMutableArray *points;
@property (nonatomic, retain) NSMutableArray *assists;
@property (nonatomic, retain) NSMutableArray *plusMinuses;
@property (nonatomic, retain) NSMutableArray *penalties;

- (void)traverseElements;

@end
