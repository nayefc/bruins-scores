//
//  ScheduleViewController.h
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

@interface ScheduleViewController : UIViewController <ADBannerViewDelegate, UITableViewDelegate, UITableViewDataSource> {
    ADBannerView *adView;
    BOOL bannerIsVisible;
    UIImageView *header;
    UITableView *scheduleTableView;
    UISegmentedControl *segmentedControl;
    
    NSMutableArray *dates;
    NSMutableArray *times;
    NSMutableArray *channels;
    NSMutableArray *awayTeams;
    NSMutableArray *awayScores;
    NSMutableArray *awayResults;
    NSMutableArray *homeTeams;
    NSMutableArray *homeScores;
    NSMutableArray *homeResults;
}

@property (nonatomic, assign) BOOL bannerIsVisible;
@property (nonatomic, retain) IBOutlet UIImageView *header;
@property (nonatomic, retain) IBOutlet UITableView *scheduleTableView;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentedControl;

@property (nonatomic, retain) NSMutableArray *dates;
@property (nonatomic, retain) NSMutableArray *times;
@property (nonatomic, retain) NSMutableArray *channels;
@property (nonatomic, retain) NSMutableArray *awayTeams;
@property (nonatomic, retain) NSMutableArray *awayScores;
@property (nonatomic, retain) NSMutableArray *awayResults;
@property (nonatomic, retain) NSMutableArray *homeTeams;
@property (nonatomic, retain) NSMutableArray *homeScores;
@property (nonatomic, retain) NSMutableArray *homeResults;

- (void)traverseElements;
- (NSString *)teamAbbreviation:(NSString *)team;
- (IBAction)scheduleControl:(id)sender;

@end