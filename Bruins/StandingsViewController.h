//
//  StandingsViewController.h
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


@interface StandingsViewController : UIViewController <ADBannerViewDelegate, UITableViewDelegate, UITableViewDataSource> {
    ADBannerView *adView;
    BOOL bannerIsVisible;
    UIImageView *header;
    UITableView *standingsTableView;
    
    NSMutableArray *atlTeams;
    NSMutableArray *atlGamesPlayed;
    NSMutableArray *atlWins;
    NSMutableArray *atlLose;
    NSMutableArray *atlOvertime;
    NSMutableArray *atlPts;
    NSMutableArray *atlStrk;
    
    NSMutableArray *neTeams;
    NSMutableArray *neGamesPlayed;
    NSMutableArray *neWins;
    NSMutableArray *neLose;
    NSMutableArray *neOvertime;
    NSMutableArray *nePts;
    NSMutableArray *neStrk;
    
    NSMutableArray *seTeams;
    NSMutableArray *seGamesPlayed;
    NSMutableArray *seWins;
    NSMutableArray *seLose;
    NSMutableArray *seOvertime;
    NSMutableArray *sePts;
    NSMutableArray *seStrk;
    
    NSMutableArray *ctrTeams;
    NSMutableArray *ctrGamesPlayed;
    NSMutableArray *ctrWins;
    NSMutableArray *ctrLose;
    NSMutableArray *ctrOvertime;
    NSMutableArray *ctrPts;
    NSMutableArray *ctrStrk;
    
    NSMutableArray *nwTeams;
    NSMutableArray *nwGamesPlayed;
    NSMutableArray *nwWins;
    NSMutableArray *nwLose;
    NSMutableArray *nwOvertime;
    NSMutableArray *nwPts;
    NSMutableArray *nwStrk;
    
    NSMutableArray *pcTeams;
    NSMutableArray *pcGamesPlayed;
    NSMutableArray *pcWins;
    NSMutableArray *pcLose;
    NSMutableArray *pcOvertime;
    NSMutableArray *pcPts;
    NSMutableArray *pcStrk;
}

@property (nonatomic, assign) BOOL bannerIsVisible;
@property (nonatomic, retain) IBOutlet UIImageView *header;
@property (nonatomic, retain) IBOutlet UITableView *standingsTableView;

@property (nonatomic, retain) NSMutableArray *atlTeams;
@property (nonatomic, retain) NSMutableArray *atlGamesPlayed;
@property (nonatomic, retain) NSMutableArray *atlWins;
@property (nonatomic, retain) NSMutableArray *atlLose;
@property (nonatomic, retain) NSMutableArray *atlOvertime;
@property (nonatomic, retain) NSMutableArray *atlPts;
@property (nonatomic, retain) NSMutableArray *atlStrk;

@property (nonatomic, retain) NSMutableArray *neTeams;
@property (nonatomic, retain) NSMutableArray *neGamesPlayed;
@property (nonatomic, retain) NSMutableArray *neWins;
@property (nonatomic, retain) NSMutableArray *neLose;
@property (nonatomic, retain) NSMutableArray *neOvertime;
@property (nonatomic, retain) NSMutableArray *nePts;
@property (nonatomic, retain) NSMutableArray *neStrk;

@property (nonatomic, retain) NSMutableArray *seTeams;
@property (nonatomic, retain) NSMutableArray *seGamesPlayed;
@property (nonatomic, retain) NSMutableArray *seWins;
@property (nonatomic, retain) NSMutableArray *seLose;
@property (nonatomic, retain) NSMutableArray *seOvertime;
@property (nonatomic, retain) NSMutableArray *sePts;
@property (nonatomic, retain) NSMutableArray *seStrk;

@property (nonatomic, retain) NSMutableArray *ctrTeams;
@property (nonatomic, retain) NSMutableArray *ctrGamesPlayed;
@property (nonatomic, retain) NSMutableArray *ctrWins;
@property (nonatomic, retain) NSMutableArray *ctrLose;
@property (nonatomic, retain) NSMutableArray *ctrOvertime;
@property (nonatomic, retain) NSMutableArray *ctrPts;
@property (nonatomic, retain) NSMutableArray *ctrStrk;

@property (nonatomic, retain) NSMutableArray *nwTeams;
@property (nonatomic, retain) NSMutableArray *nwGamesPlayed;
@property (nonatomic, retain) NSMutableArray *nwWins;
@property (nonatomic, retain) NSMutableArray *nwLose;
@property (nonatomic, retain) NSMutableArray *nwOvertime;
@property (nonatomic, retain) NSMutableArray *nwPts;
@property (nonatomic, retain) NSMutableArray *nwStrk;

@property (nonatomic, retain) NSMutableArray *pcTeams;
@property (nonatomic, retain) NSMutableArray *pcGamesPlayed;
@property (nonatomic, retain) NSMutableArray *pcWins;
@property (nonatomic, retain) NSMutableArray *pcLose;
@property (nonatomic, retain) NSMutableArray *pcOvertime;
@property (nonatomic, retain) NSMutableArray *pcPts;
@property (nonatomic, retain) NSMutableArray *pcStrk;

- (void)traverseElements;

@end
