//
//  StandingsViewController.m
//  Bruins
//
//  Created by Nayef Copty on 23/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StandingsViewController.h"
#import "StandingsHeaderCell.h"
#import "StandingsCell.h"

@implementation StandingsViewController

static NSString *standingsHeader = @"StandingsHeaderType";
static NSString *standingsCell = @"StandingsCellType";

@synthesize bannerIsVisible, header, standingsTableView;
@synthesize atlTeams, atlGamesPlayed, atlWins, atlLose, atlOvertime, atlPts, atlStrk;
@synthesize neTeams, neGamesPlayed, neWins, neLose, neOvertime, nePts, neStrk;
@synthesize seTeams, seGamesPlayed, seWins, seLose, seOvertime, sePts, seStrk;
@synthesize ctrTeams, ctrGamesPlayed, ctrWins, ctrLose, ctrOvertime, ctrPts, ctrStrk;
@synthesize nwTeams, nwGamesPlayed, nwWins, nwLose, nwOvertime, nwPts, nwStrk;
@synthesize pcTeams, pcGamesPlayed, pcWins, pcLose, pcOvertime, pcPts, pcStrk;

- (void)traverseElements {
    
    NSMutableArray *atlTeamsArr = [[NSMutableArray alloc] init];
    NSMutableArray *atlGamesPlayedArr = [[NSMutableArray alloc] init];
    NSMutableArray *atlWinsArr = [[NSMutableArray alloc] init];
    NSMutableArray *atlLoseArr = [[NSMutableArray alloc] init];
    NSMutableArray *atlOvertimeArr = [[NSMutableArray alloc] init];
    NSMutableArray *atlPtsArr = [[NSMutableArray alloc] init];
    NSMutableArray *atlStrkArr = [[NSMutableArray alloc] init];
    NSMutableArray *neTeamsArr = [[NSMutableArray alloc] init];
    NSMutableArray *neGamesPlayedArr = [[NSMutableArray alloc] init];
    NSMutableArray *neWinsArr = [[NSMutableArray alloc] init];
    NSMutableArray *neLoseArr = [[NSMutableArray alloc] init];
    NSMutableArray *neOvertimeArr = [[NSMutableArray alloc] init];
    NSMutableArray *nePtsArr = [[NSMutableArray alloc] init];
    NSMutableArray *neStrkArr = [[NSMutableArray alloc] init];
    NSMutableArray *seTeamsArr = [[NSMutableArray alloc] init];
    NSMutableArray *seGamesPlayedArr = [[NSMutableArray alloc] init];
    NSMutableArray *seWinsArr = [[NSMutableArray alloc] init];
    NSMutableArray *seLoseArr = [[NSMutableArray alloc] init];
    NSMutableArray *seOvertimeArr = [[NSMutableArray alloc] init];
    NSMutableArray *sePtsArr = [[NSMutableArray alloc] init];
    NSMutableArray *seStrkArr = [[NSMutableArray alloc] init];
    NSMutableArray *ctrTeamsArr = [[NSMutableArray alloc] init];
    NSMutableArray *ctrGamesPlayedArr = [[NSMutableArray alloc] init];
    NSMutableArray *ctrWinsArr = [[NSMutableArray alloc] init];
    NSMutableArray *ctrLoseArr = [[NSMutableArray alloc] init];
    NSMutableArray *ctrOvertimeArr = [[NSMutableArray alloc] init];
    NSMutableArray *ctrPtsArr = [[NSMutableArray alloc] init];
    NSMutableArray *ctrStrkArr = [[NSMutableArray alloc] init];
    NSMutableArray *nwTeamsArr = [[NSMutableArray alloc] init];
    NSMutableArray *nwGamesPlayedArr = [[NSMutableArray alloc] init];
    NSMutableArray *nwWinsArr = [[NSMutableArray alloc] init];
    NSMutableArray *nwLoseArr = [[NSMutableArray alloc] init];
    NSMutableArray *nwOvertimeArr = [[NSMutableArray alloc] init];
    NSMutableArray *nwPtsArr = [[NSMutableArray alloc] init];
    NSMutableArray *nwStrkArr = [[NSMutableArray alloc] init];
    NSMutableArray *pcTeamsArr = [[NSMutableArray alloc] init];
    NSMutableArray *pcGamesPlayedArr = [[NSMutableArray alloc] init];
    NSMutableArray *pcWinsArr = [[NSMutableArray alloc] init];
    NSMutableArray *pcLoseArr = [[NSMutableArray alloc] init];
    NSMutableArray *pcOvertimeArr = [[NSMutableArray alloc] init];
    NSMutableArray *pcPtsArr = [[NSMutableArray alloc] init];
    NSMutableArray *pcStrkArr = [[NSMutableArray alloc] init];
    
    // Initialize a TXML with the XML file and get the root
    TBXML *tbxml = [[[TBXML tbxmlWithXMLFile:@"standings.xml"] retain] autorelease];
    TBXMLElement *root = tbxml.rootXMLElement;
    
    if (root) {
        
        // Get the <sports-content> tag
        TBXMLElement *sportsContent = [TBXML childElementNamed:@"sports-content" parentElement:root];
        
        if (sportsContent) {
            
            // Get the <standing> tag
            TBXMLElement *standing = [TBXML childElementNamed:@"standing" parentElement:sportsContent];
            
            if (standing) {
                
                // Get the <team> tag and extract the required values
                TBXMLElement *team = [TBXML childElementNamed:@"team" parentElement:standing];
                
                while (team != nil) {
                    
                    TBXMLElement *teamMetaData = [TBXML childElementNamed:@"team-metadata" parentElement:team];
                    TBXMLElement *name = [TBXML childElementNamed:@"name" parentElement:teamMetaData];
                    NSString *first = [TBXML valueOfAttributeNamed:@"first" forElement:name];
                    NSString *last = [TBXML valueOfAttributeNamed:@"last" forElement:name];
                    NSMutableString *nameStr = [NSMutableString string];
                    [nameStr appendString:first];
                    [nameStr appendString:@" "];
                    [nameStr appendString:last];
                    [atlTeamsArr addObject:nameStr];
                    
                    TBXMLElement *teamStats = [TBXML childElementNamed:@"team-stats" parentElement:team];
                    NSString *gamesPlayedStr = [TBXML valueOfAttributeNamed:@"events-played" forElement:teamStats];
                    [atlGamesPlayedArr addObject:gamesPlayedStr];
                    
                    NSString *pointsStr = [TBXML valueOfAttributeNamed:@"standing-points" forElement:teamStats];
                    [atlPtsArr addObject:pointsStr];
                    
                    TBXMLElement *outcomeTotals = [TBXML childElementNamed:@"outcome-totals" parentElement:teamStats];
                    outcomeTotals = outcomeTotals->nextSibling;
                    outcomeTotals = outcomeTotals->nextSibling;
                    outcomeTotals = outcomeTotals->nextSibling;
                    outcomeTotals = outcomeTotals->nextSibling;
                    outcomeTotals = outcomeTotals->nextSibling;
                    outcomeTotals = outcomeTotals->nextSibling;
                    outcomeTotals = outcomeTotals->nextSibling;
                    outcomeTotals = outcomeTotals->nextSibling;
                    outcomeTotals = outcomeTotals->nextSibling;
                    outcomeTotals = outcomeTotals->nextSibling;
                    
                    NSString *winsStr = [TBXML valueOfAttributeNamed:@"wins" forElement:outcomeTotals];
                    NSString *loseStr = [TBXML valueOfAttributeNamed:@"losses" forElement:outcomeTotals];
                    NSString *overtimeStr = [TBXML valueOfAttributeNamed:@"losses-overtime" forElement:outcomeTotals];
                    NSString *streakStr = [TBXML valueOfAttributeNamed:@"xts:streak" forElement:outcomeTotals];
                    
                    [atlWinsArr addObject:winsStr];
                    [atlLoseArr addObject:loseStr];
                    [atlOvertimeArr addObject:overtimeStr];
                    [atlStrkArr addObject:streakStr];
                    
                    team = team->nextSibling;
                }
            }
            
            standing = standing->nextSibling;
            TBXMLElement *teamNE = [TBXML childElementNamed:@"team" parentElement:standing];
            
            while (teamNE != nil) {
                
                TBXMLElement *teamMetaData = [TBXML childElementNamed:@"team-metadata" parentElement:teamNE];
                TBXMLElement *name = [TBXML childElementNamed:@"name" parentElement:teamMetaData];
                NSString *first = [TBXML valueOfAttributeNamed:@"first" forElement:name];
                NSString *last = [TBXML valueOfAttributeNamed:@"last" forElement:name];
                NSMutableString *nameStr = [NSMutableString string];
                [nameStr appendString:first];
                [nameStr appendString:@" "];
                [nameStr appendString:last];
                [neTeamsArr addObject:nameStr];
                
                TBXMLElement *teamStats = [TBXML childElementNamed:@"team-stats" parentElement:teamNE];
                NSString *gamesPlayedStr = [TBXML valueOfAttributeNamed:@"events-played" forElement:teamStats];
                [neGamesPlayedArr addObject:gamesPlayedStr];
                
                NSString *pointsStr = [TBXML valueOfAttributeNamed:@"standing-points" forElement:teamStats];
                [nePtsArr addObject:pointsStr];
                
                TBXMLElement *outcomeTotals = [TBXML childElementNamed:@"outcome-totals" parentElement:teamStats];
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                
                NSString *winsStr = [TBXML valueOfAttributeNamed:@"wins" forElement:outcomeTotals];
                NSString *loseStr = [TBXML valueOfAttributeNamed:@"losses" forElement:outcomeTotals];
                NSString *overtimeStr = [TBXML valueOfAttributeNamed:@"losses-overtime" forElement:outcomeTotals];
                NSString *streakStr = [TBXML valueOfAttributeNamed:@"xts:streak" forElement:outcomeTotals];
                
                [neWinsArr addObject:winsStr];
                [neLoseArr addObject:loseStr];
                [neOvertimeArr addObject:overtimeStr];
                [neStrkArr addObject:streakStr];
                
                teamNE = teamNE->nextSibling;
            }
            
            standing = standing->nextSibling;
            TBXMLElement *teamSE = [TBXML childElementNamed:@"team" parentElement:standing];
            
            while (teamSE != nil) {
                
                TBXMLElement *teamMetaData = [TBXML childElementNamed:@"team-metadata" parentElement:teamSE];
                TBXMLElement *name = [TBXML childElementNamed:@"name" parentElement:teamMetaData];
                NSString *first = [TBXML valueOfAttributeNamed:@"first" forElement:name];
                NSString *last = [TBXML valueOfAttributeNamed:@"last" forElement:name];
                NSMutableString *nameStr = [NSMutableString string];
                [nameStr appendString:first];
                [nameStr appendString:@" "];
                [nameStr appendString:last];
                [seTeamsArr addObject:nameStr];
                
                TBXMLElement *teamStats = [TBXML childElementNamed:@"team-stats" parentElement:teamSE];
                NSString *gamesPlayedStr = [TBXML valueOfAttributeNamed:@"events-played" forElement:teamStats];
                [seGamesPlayedArr addObject:gamesPlayedStr];
                
                NSString *pointsStr = [TBXML valueOfAttributeNamed:@"standing-points" forElement:teamStats];
                [sePtsArr addObject:pointsStr];
                
                TBXMLElement *outcomeTotals = [TBXML childElementNamed:@"outcome-totals" parentElement:teamStats];
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                
                NSString *winsStr = [TBXML valueOfAttributeNamed:@"wins" forElement:outcomeTotals];
                NSString *loseStr = [TBXML valueOfAttributeNamed:@"losses" forElement:outcomeTotals];
                NSString *overtimeStr = [TBXML valueOfAttributeNamed:@"losses-overtime" forElement:outcomeTotals];
                NSString *streakStr = [TBXML valueOfAttributeNamed:@"xts:streak" forElement:outcomeTotals];
                
                [seWinsArr addObject:winsStr];
                [seLoseArr addObject:loseStr];
                [seOvertimeArr addObject:overtimeStr];
                [seStrkArr addObject:streakStr];
                
                teamSE = teamSE->nextSibling;
            }
            
            standing = standing->nextSibling;
            TBXMLElement *teamCTR = [TBXML childElementNamed:@"team" parentElement:standing];
            
            while (teamCTR != nil) {
                
                TBXMLElement *teamMetaData = [TBXML childElementNamed:@"team-metadata" parentElement:teamCTR];
                TBXMLElement *name = [TBXML childElementNamed:@"name" parentElement:teamMetaData];
                NSString *first = [TBXML valueOfAttributeNamed:@"first" forElement:name];
                NSString *last = [TBXML valueOfAttributeNamed:@"last" forElement:name];
                NSMutableString *nameStr = [NSMutableString string];
                [nameStr appendString:first];
                [nameStr appendString:@" "];
                [nameStr appendString:last];
                [ctrTeamsArr addObject:nameStr];
                
                TBXMLElement *teamStats = [TBXML childElementNamed:@"team-stats" parentElement:teamCTR];
                NSString *gamesPlayedStr = [TBXML valueOfAttributeNamed:@"events-played" forElement:teamStats];
                [ctrGamesPlayedArr addObject:gamesPlayedStr];
                
                NSString *pointsStr = [TBXML valueOfAttributeNamed:@"standing-points" forElement:teamStats];
                [ctrPtsArr addObject:pointsStr];
                
                TBXMLElement *outcomeTotals = [TBXML childElementNamed:@"outcome-totals" parentElement:teamStats];
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                
                NSString *winsStr = [TBXML valueOfAttributeNamed:@"wins" forElement:outcomeTotals];
                NSString *loseStr = [TBXML valueOfAttributeNamed:@"losses" forElement:outcomeTotals];
                NSString *overtimeStr = [TBXML valueOfAttributeNamed:@"losses-overtime" forElement:outcomeTotals];
                NSString *streakStr = [TBXML valueOfAttributeNamed:@"xts:streak" forElement:outcomeTotals];
                
                [ctrWinsArr addObject:winsStr];
                [ctrLoseArr addObject:loseStr];
                [ctrOvertimeArr addObject:overtimeStr];
                [ctrStrkArr addObject:streakStr];
                
                teamCTR = teamCTR->nextSibling;
            }
            
            standing = standing->nextSibling;
            TBXMLElement *teamNW = [TBXML childElementNamed:@"team" parentElement:standing];
            
            while (teamNW != nil) {
                
                TBXMLElement *teamMetaData = [TBXML childElementNamed:@"team-metadata" parentElement:teamNW];
                TBXMLElement *name = [TBXML childElementNamed:@"name" parentElement:teamMetaData];
                NSString *first = [TBXML valueOfAttributeNamed:@"first" forElement:name];
                NSString *last = [TBXML valueOfAttributeNamed:@"last" forElement:name];
                NSMutableString *nameStr = [NSMutableString string];
                [nameStr appendString:first];
                [nameStr appendString:@" "];
                [nameStr appendString:last];
                [nwTeamsArr addObject:nameStr];
                
                TBXMLElement *teamStats = [TBXML childElementNamed:@"team-stats" parentElement:teamNW];
                NSString *gamesPlayedStr = [TBXML valueOfAttributeNamed:@"events-played" forElement:teamStats];
                [nwGamesPlayedArr addObject:gamesPlayedStr];
                
                NSString *pointsStr = [TBXML valueOfAttributeNamed:@"standing-points" forElement:teamStats];
                [nwPtsArr addObject:pointsStr];
                
                TBXMLElement *outcomeTotals = [TBXML childElementNamed:@"outcome-totals" parentElement:teamStats];
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                
                NSString *winsStr = [TBXML valueOfAttributeNamed:@"wins" forElement:outcomeTotals];
                NSString *loseStr = [TBXML valueOfAttributeNamed:@"losses" forElement:outcomeTotals];
                NSString *overtimeStr = [TBXML valueOfAttributeNamed:@"losses-overtime" forElement:outcomeTotals];
                NSString *streakStr = [TBXML valueOfAttributeNamed:@"xts:streak" forElement:outcomeTotals];
                
                [nwWinsArr addObject:winsStr];
                [nwLoseArr addObject:loseStr];
                [nwOvertimeArr addObject:overtimeStr];
                [nwStrkArr addObject:streakStr];
                
                teamNW = teamNW->nextSibling;
            }
            
            standing = standing->nextSibling;
            TBXMLElement *teamPC = [TBXML childElementNamed:@"team" parentElement:standing];
            
            while (teamPC != nil) {
                
                TBXMLElement *teamMetaData = [TBXML childElementNamed:@"team-metadata" parentElement:teamPC];
                TBXMLElement *name = [TBXML childElementNamed:@"name" parentElement:teamMetaData];
                NSString *first = [TBXML valueOfAttributeNamed:@"first" forElement:name];
                NSString *last = [TBXML valueOfAttributeNamed:@"last" forElement:name];
                NSMutableString *nameStr = [NSMutableString string];
                [nameStr appendString:first];
                [nameStr appendString:@" "];
                [nameStr appendString:last];
                [pcTeamsArr addObject:nameStr];
                
                TBXMLElement *teamStats = [TBXML childElementNamed:@"team-stats" parentElement:teamPC];
                NSString *gamesPlayedStr = [TBXML valueOfAttributeNamed:@"events-played" forElement:teamStats];
                [pcGamesPlayedArr addObject:gamesPlayedStr];
                
                NSString *pointsStr = [TBXML valueOfAttributeNamed:@"standing-points" forElement:teamStats];
                [pcPtsArr addObject:pointsStr];
                
                TBXMLElement *outcomeTotals = [TBXML childElementNamed:@"outcome-totals" parentElement:teamStats];
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                outcomeTotals = outcomeTotals->nextSibling;
                
                NSString *winsStr = [TBXML valueOfAttributeNamed:@"wins" forElement:outcomeTotals];
                NSString *loseStr = [TBXML valueOfAttributeNamed:@"losses" forElement:outcomeTotals];
                NSString *overtimeStr = [TBXML valueOfAttributeNamed:@"losses-overtime" forElement:outcomeTotals];
                NSString *streakStr = [TBXML valueOfAttributeNamed:@"xts:streak" forElement:outcomeTotals];
                
                [pcWinsArr addObject:winsStr];
                [pcLoseArr addObject:loseStr];
                [pcOvertimeArr addObject:overtimeStr];
                [pcStrkArr addObject:streakStr];
                
                teamPC = teamPC->nextSibling;
            }
            
            
        }
    }
    
    // Store the local arrays into the class arrays and garbage collection
    self.atlTeams = atlTeamsArr;
    [atlTeamsArr release];
    
    self.atlGamesPlayed = atlGamesPlayedArr;
    [atlGamesPlayedArr release];
    
    self.atlWins = atlWinsArr;
    [atlWinsArr release];
    
    self.atlLose = atlLoseArr;
    [atlLoseArr release];
    
    self.atlOvertime = atlOvertimeArr;
    [atlOvertimeArr release];
    
    self.atlPts = atlPtsArr;
    [atlPtsArr release];
    
    self.atlStrk = atlStrkArr;
    [atlStrkArr release];
    
    self.neTeams = neTeamsArr;
    [neTeamsArr release];
    
    self.neGamesPlayed = neGamesPlayedArr;
    [neGamesPlayedArr release];
    
    self.neWins = neWinsArr;
    [neWinsArr release];
    
    self.neLose = neLoseArr;
    [neLoseArr release];
    
    self.neOvertime = neOvertimeArr;
    [neOvertimeArr release];
    
    self.nePts = nePtsArr;
    [nePtsArr release];
    
    self.neStrk = neStrkArr;
    [neStrkArr release];
    
    self.seTeams = seTeamsArr;
    [seTeamsArr release];
    
    self.seGamesPlayed = seGamesPlayedArr;
    [seGamesPlayedArr release];
    
    self.seWins = seWinsArr;
    [seWinsArr release];
    
    self.seLose = seLoseArr;
    [seLoseArr release];
    
    self.seOvertime = seOvertimeArr;
    [seOvertimeArr release];
    
    self.sePts = sePtsArr;
    [sePtsArr release];
    
    self.seStrk = seStrkArr;
    [seStrkArr release];
    
    self.ctrTeams = ctrTeamsArr;
    [ctrTeamsArr release];
    
    self.ctrGamesPlayed = ctrGamesPlayedArr;
    [ctrGamesPlayedArr release];
    
    self.ctrWins = ctrWinsArr;
    [ctrWinsArr release];
    
    self.ctrLose = ctrLoseArr;
    [ctrLoseArr release];
    
    self.ctrOvertime = ctrOvertimeArr;
    [ctrOvertimeArr release];
    
    self.ctrPts = ctrPtsArr;
    [ctrPtsArr release];
    
    self.ctrStrk = ctrStrkArr;
    [ctrStrkArr release];
    
    self.nwTeams = nwTeamsArr;
    [nwTeamsArr release];
    
    self.nwGamesPlayed = nwGamesPlayedArr;
    [nwGamesPlayedArr release];
    
    self.nwWins = nwWinsArr;
    [nwWinsArr release];
    
    self.nwLose = nwLoseArr;
    [nwLoseArr release];
    
    self.nwOvertime = nwOvertimeArr;
    [nwOvertimeArr release];
    
    self.nwPts = nwPtsArr;
    [nwPtsArr release];
    
    self.nwStrk = nwStrkArr;
    [nwStrkArr release];
    
    self.pcTeams = pcTeamsArr;
    [pcTeamsArr release];
    
    self.pcGamesPlayed = pcGamesPlayedArr;
    [pcGamesPlayedArr release];
    
    self.pcWins = pcWinsArr;
    [pcWinsArr release];
    
    self.pcLose = pcLoseArr;
    [pcLoseArr release];
    
    self.pcOvertime = pcOvertimeArr;
    [pcOvertimeArr release];
    
    self.pcPts = pcPtsArr;
    [pcPtsArr release];
    
    self.pcStrk = pcStrkArr;
    [pcStrkArr release];
}

#pragma mark - View lifecycle / Memory Management

- (void)viewDidLoad {
    
    // Set the title page for the navigation controller
    self.title = @"Standings";
    
    // Set up and display iAd
    CGRect iAdRect = CGRectMake(0, 43, 0, 0);
    adView = [[ADBannerView alloc] initWithFrame:iAdRect];
    adView.frame = CGRectOffset(adView.frame, 0, 0);
    adView.requiredContentSizeIdentifiers = [NSSet setWithObject:ADBannerContentSizeIdentifierPortrait];
    adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    [self.view addSubview:adView];
    adView.delegate = self;
    self.bannerIsVisible = YES;
    
    if ([[[UIDevice currentDevice] systemVersion] compare:@"4.2" options:NSNumericSearch] == NSOrderedAscending) {
        adView.requiredContentSizeIdentifiers = [NSSet setWithObject:ADBannerContentSizeIdentifierPortrait];
        adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    }
    
    else {
        adView.requiredContentSizeIdentifiers = [NSSet setWithObject:ADBannerContentSizeIdentifierPortrait];
        adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    }
    
    // Title Bar Image
    header.image = [UIImage imageNamed:@"header_standings.png"];
    
    // Add a view on top of the Table View to display a yellow background when a user scrolls upwards and bounces
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0,-480,320,480)];
    topView.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:181.0/255.0 blue:41.0/255.0 alpha:1];
    [self.standingsTableView addSubview:topView];
    [topView release];
    
    // Set the table view background to display a gray background when a user scrolls downwards and bounces
    standingsTableView.backgroundColor = [UIColor colorWithRed:71.0/255.0 green:71.0/255.0 blue:71.0/255.0 alpha:1];
    
    // Parse the news XML file
    [self traverseElements];
    
    [super viewDidLoad];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.header = nil;
    self.standingsTableView = nil;
    self.atlTeams = nil;
    self.atlGamesPlayed = nil;
    self.atlWins = nil;
    self.atlLose = nil;
    self.atlOvertime = nil;
    self.atlPts = nil;
    self.atlStrk = nil;
    self.neTeams = nil;
    self.neGamesPlayed = nil;
    self.neWins = nil;
    self.neLose = nil;
    self.neOvertime = nil;
    self.nePts = nil;
    self.neStrk = nil;
    self.seTeams = nil;
    self.seGamesPlayed = nil;
    self.seWins = nil;
    self.seLose = nil;
    self.seOvertime = nil;
    self.sePts = nil;
    self.seStrk = nil;
    self.ctrTeams = nil;
    self.ctrGamesPlayed = nil;
    self.ctrWins = nil;
    self.ctrLose = nil;
    self.ctrOvertime = nil;
    self.ctrPts = nil;
    self.ctrStrk = nil;
    self.nwTeams = nil;
    self.nwGamesPlayed = nil;
    self.nwWins = nil;
    self.nwLose = nil;
    self.nwOvertime = nil;
    self.nwPts = nil;
    self.nwStrk = nil;
    self.pcTeams = nil;
    self.pcGamesPlayed = nil;
    self.pcWins = nil;
    self.pcLose = nil;
    self.pcOvertime = nil;
    self.pcPts = nil;
    self.pcStrk = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [super dealloc];
    [header release];
    [standingsTableView release];
    [atlTeams release];
    [atlGamesPlayed release];
    [atlWins release];
    [atlLose release];
    [atlOvertime release];
    [atlPts release];
    [atlStrk release];
    [neTeams release];
    [neGamesPlayed release];
    [neWins release];
    [neLose release];
    [neOvertime release];
    [nePts release];
    [neStrk release];
    [seTeams release];
    [seGamesPlayed release];
    [seWins release];
    [seLose release];
    [seOvertime release];
    [sePts release];
    [seStrk release];
    [ctrTeams release];
    [ctrGamesPlayed release];
    [ctrWins release];
    [ctrLose release];
    [ctrOvertime release];
    [ctrPts release];
    [ctrStrk release];
    [nwTeams release];
    [nwGamesPlayed release];
    [nwWins release];
    [nwLose release];
    [nwOvertime release];
    [nwPts release];
    [nwStrk release];
    [pcTeams release];
    [pcGamesPlayed release];
    [pcWins release];
    [pcLose release];
    [pcOvertime release];
    [pcPts release];
    [pcStrk release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table View Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 35;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger rowNumber = [indexPath row];
    
    if (rowNumber == 0 || rowNumber == 6 || rowNumber == 12 || rowNumber == 18 || rowNumber == 24 || rowNumber == 30) {
        
        StandingsHeaderCell *cell = (StandingsHeaderCell *)[tableView dequeueReusableCellWithIdentifier:standingsHeader];
        if (cell == nil) { 
            NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"StandingsHeaderCell" owner:self options:nil];          
            for (id anObject in nibObjects) {
                if ([anObject isKindOfClass:[StandingsHeaderCell class]]) {
                    cell = (StandingsHeaderCell *)anObject;
                }
            }
        }
        
        // Set the division header cell title
        if (rowNumber == 0)
            cell.division.text = @"Atlantic";
        else if (rowNumber == 6)
            cell.division.text = @"Northeast";
        else if (rowNumber == 12)
            cell.division.text = @"Southeast";
        else if (rowNumber == 18)
            cell.division.text = @"Central";
        else if (rowNumber == 24)
            cell.division.text = @"Northwest";
        else if (rowNumber == 30)
            cell.division.text = @"Pacific";
        
        return cell;
    }
    
    /*
     * Populate each division separetely
     */
    
    if (rowNumber >= 1 && rowNumber <= 5) {
        
        StandingsCell *cell = (StandingsCell *)[tableView dequeueReusableCellWithIdentifier:standingsCell];
        if (cell == nil) { 
            NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"StandingsCell" owner:self options:nil];          
            for (id anObject in nibObjects) {
                if ([anObject isKindOfClass:[StandingsCell class]]) {
                    cell = (StandingsCell *)anObject;
                }
            }
        }
        
        cell.team.text = [atlTeams objectAtIndex:rowNumber - 1];
        cell.gamesPlayed.text = [atlGamesPlayed objectAtIndex:rowNumber - 1];
        cell.wins.text = [atlWins objectAtIndex:rowNumber - 1];
        cell.loses.text = [atlLose objectAtIndex:rowNumber - 1];
        cell.overtime.text = [atlOvertime objectAtIndex:rowNumber - 1];
        cell.points.text = [atlPts objectAtIndex:rowNumber - 1];
        cell.streak.text = [atlStrk objectAtIndex:rowNumber - 1];
        
        return cell;
    }
    
    if (rowNumber >= 6 && rowNumber <= 11) {
        
        StandingsCell *cell = (StandingsCell *)[tableView dequeueReusableCellWithIdentifier:standingsCell];
        if (cell == nil) { 
            NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"StandingsCell" owner:self options:nil];          
            for (id anObject in nibObjects) {
                if ([anObject isKindOfClass:[StandingsCell class]]) {
                    cell = (StandingsCell *)anObject;
                }
            }
        }
        
        cell.team.text = [neTeams objectAtIndex:rowNumber - 7];
        cell.gamesPlayed.text = [neGamesPlayed objectAtIndex:rowNumber - 7];
        cell.wins.text = [neWins objectAtIndex:rowNumber - 7];
        cell.loses.text = [neLose objectAtIndex:rowNumber - 7];
        cell.overtime.text = [neOvertime objectAtIndex:rowNumber - 7];
        cell.points.text = [nePts objectAtIndex:rowNumber - 7];
        cell.streak.text = [neStrk objectAtIndex:rowNumber - 7];
        
        return cell;
    }
    
    if (rowNumber >= 12 && rowNumber <= 17) {
        
        StandingsCell *cell = (StandingsCell *)[tableView dequeueReusableCellWithIdentifier:standingsCell];
        if (cell == nil) { 
            NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"StandingsCell" owner:self options:nil];          
            for (id anObject in nibObjects) {
                if ([anObject isKindOfClass:[StandingsCell class]]) {
                    cell = (StandingsCell *)anObject;
                }
            }
        }
        
        cell.team.text = [seTeams objectAtIndex:rowNumber - 13];
        cell.gamesPlayed.text = [seGamesPlayed objectAtIndex:rowNumber - 13];
        cell.wins.text = [seWins objectAtIndex:rowNumber - 13];
        cell.loses.text = [seLose objectAtIndex:rowNumber - 13];
        cell.overtime.text = [seOvertime objectAtIndex:rowNumber - 13];
        cell.points.text = [sePts objectAtIndex:rowNumber - 13];
        cell.streak.text = [seStrk objectAtIndex:rowNumber - 13];
        
        return cell;
    }
    
    if (rowNumber >= 18 && rowNumber <= 23) {
        
        StandingsCell *cell = (StandingsCell *)[tableView dequeueReusableCellWithIdentifier:standingsCell];
        if (cell == nil) { 
            NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"StandingsCell" owner:self options:nil];          
            for (id anObject in nibObjects) {
                if ([anObject isKindOfClass:[StandingsCell class]]) {
                    cell = (StandingsCell *)anObject;
                }
            }
        }
        
        cell.team.text = [ctrTeams objectAtIndex:rowNumber - 19];
        cell.gamesPlayed.text = [ctrGamesPlayed objectAtIndex:rowNumber - 19];
        cell.wins.text = [ctrWins objectAtIndex:rowNumber - 19];
        cell.loses.text = [ctrLose objectAtIndex:rowNumber - 19];
        cell.overtime.text = [ctrOvertime objectAtIndex:rowNumber - 19];
        cell.points.text = [ctrPts objectAtIndex:rowNumber - 19];
        cell.streak.text = [ctrStrk objectAtIndex:rowNumber - 19];
        
        return cell;
    }
    
    if (rowNumber >= 24 && rowNumber <= 29) {
        
        StandingsCell *cell = (StandingsCell *)[tableView dequeueReusableCellWithIdentifier:standingsCell];
        if (cell == nil) { 
            NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"StandingsCell" owner:self options:nil];          
            for (id anObject in nibObjects) {
                if ([anObject isKindOfClass:[StandingsCell class]]) {
                    cell = (StandingsCell *)anObject;
                }
            }
        }
        
        cell.team.text = [nwTeams objectAtIndex:rowNumber - 25];
        cell.gamesPlayed.text = [nwGamesPlayed objectAtIndex:rowNumber - 25];
        cell.wins.text = [nwWins objectAtIndex:rowNumber - 25];
        cell.loses.text = [nwLose objectAtIndex:rowNumber - 25];
        cell.overtime.text = [nwOvertime objectAtIndex:rowNumber - 25];
        cell.points.text = [nwPts objectAtIndex:rowNumber - 25];
        cell.streak.text = [nwStrk objectAtIndex:rowNumber - 25];
        
        return cell;
    }
    
    if (rowNumber >= 30 && rowNumber <= 35) {
        
        StandingsCell *cell = (StandingsCell *)[tableView dequeueReusableCellWithIdentifier:standingsCell];
        if (cell == nil) { 
            NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"StandingsCell" owner:self options:nil];          
            for (id anObject in nibObjects) {
                if ([anObject isKindOfClass:[StandingsCell class]]) {
                    cell = (StandingsCell *)anObject;
                }
            }
        }
        
        cell.team.text = [pcTeams objectAtIndex:rowNumber - 31];
        cell.gamesPlayed.text = [pcGamesPlayed objectAtIndex:rowNumber - 31];
        cell.wins.text = [pcWins objectAtIndex:rowNumber - 31];
        cell.loses.text = [pcLose objectAtIndex:rowNumber - 31];
        cell.overtime.text = [pcOvertime objectAtIndex:rowNumber - 31];
        cell.points.text = [pcPts objectAtIndex:rowNumber - 31];
        cell.streak.text = [pcStrk objectAtIndex:rowNumber - 31];
        
        return cell;
    }
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = @"Error";
    
    return cell;
}

#pragma mark - Table View Delegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger rowNumber = [indexPath row];
    
    if (rowNumber == 0 || rowNumber == 6 || rowNumber == 12 || rowNumber == 18 || rowNumber == 24 || rowNumber == 30)
        return 27;
    return 20;
}

// Alternate Cell Background Color
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger rowNumber = [indexPath row];
    
    if (rowNumber == 0 || rowNumber == 6 || rowNumber == 12 || rowNumber == 18 || rowNumber == 24 || rowNumber == 30)
        cell.backgroundView.backgroundColor = HEADER_CELL;
    else if (rowNumber% 2 == 0)
        cell.backgroundView.backgroundColor = DARK_CELL;
    else
        cell.backgroundView.backgroundColor = LIGHT_CELL;
}


// Informs the table view delegate that the specified row is now selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];    
}


#pragma mark - iAd Delegate

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    if (!self.bannerIsVisible) {
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        // banner is invisible now and moved out of the screen on 50 px
        banner.frame = CGRectOffset(banner.frame, 0, 50);
        [UIView commitAnimations];
        self.bannerIsVisible = YES;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    if (self.bannerIsVisible) {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        // banner is visible and we move it out of the screen, due to connection issue
        banner.frame = CGRectOffset(banner.frame, 0, -50);
        [UIView commitAnimations];
        self.bannerIsVisible = NO;
    }
}

@end
