//
//  StatsViewController.m
//  Bruins
//
//  Created by Nayef Copty on 23/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StatsViewController.h"
#import "StatsHeaderCell.h"
#import "StatsCell.h"

@implementation StatsViewController

static NSString *statsHeader = @"StatsHeaderType";
static NSString *statsCell = @"StatsCellType";

@synthesize bannerIsVisible, header, statsTableView, names, gamesPlayed, goals, points, assists, plusMinuses, penalties;

- (void)traverseElements {
    
    // Initialize local arrays
    NSMutableArray *namesArr = [[NSMutableArray alloc] init];
    NSMutableArray *gamesPlayedArr = [[NSMutableArray alloc] init];
    NSMutableArray *goalsArr = [[NSMutableArray alloc] init];
    NSMutableArray *pointsArr = [[NSMutableArray alloc] init];
    NSMutableArray *assistsArr = [[NSMutableArray alloc] init];
    NSMutableArray *plusMinusesArr = [[NSMutableArray alloc] init];
    NSMutableArray *penaltiesArr = [[NSMutableArray alloc] init];
    
    // Initialize a TXML with the XML file and get the root
    TBXML *tbxml = [[[TBXML tbxmlWithXMLFile:@"stats.xml"] retain] autorelease];
    TBXMLElement *root = tbxml.rootXMLElement;
    
    if (root) {
        
        // Get the <sports-content> tag
        TBXMLElement *sportsContent = [TBXML childElementNamed:@"sports-content" parentElement:root];
        
        if (sportsContent) {
            
            // Get the <statistic> tag
            TBXMLElement *statistic = [TBXML childElementNamed:@"statistic" parentElement:sportsContent];
            
            if (statistic) {
                
                // Get the <team> tag
                TBXMLElement *team = [TBXML childElementNamed:@"team" parentElement:statistic];
                
                if (team) {
                    
                    TBXMLElement *player = [TBXML childElementNamed:@"player" parentElement:team];
                    
                    while (player != nil) {
                        
                        // Get player name
                        TBXMLElement *playerMetaData = [TBXML childElementNamed:@"player-metadata" parentElement:player];
                        TBXMLElement *playerName = [TBXML childElementNamed:@"name" parentElement:playerMetaData];
                        NSString *name = [TBXML valueOfAttributeNamed:@"full" forElement:playerName];
                        [namesArr addObject:name];
                        
                        // Get rest of stats
                        TBXMLElement *playerStats = [TBXML childElementNamed:@"player-stats" parentElement:player];
                        NSString *gp = [TBXML valueOfAttributeNamed:@"events-played" forElement:playerStats];
                        [gamesPlayedArr addObject:gp];
                        NSString *goal = [TBXML valueOfAttributeNamed:@"score" forElement:playerStats];
                        [goalsArr addObject:goal];
                        
                        TBXMLElement *penaltyStats = [TBXML childElementNamed:@"penalty-stats" parentElement:playerStats];
                        NSString *penaltyMin = [TBXML valueOfAttributeNamed:@"count" forElement:penaltyStats];
                        [penaltiesArr addObject:penaltyMin];
                        
                        
                        TBXMLElement *playerStatsIceHockey = [TBXML childElementNamed:@"player-stats-ice-hockey" parentElement:playerStats];
                        NSString *plusMinus = [TBXML valueOfAttributeNamed:@"plus-minus" forElement:playerStatsIceHockey];
                        [plusMinusesArr addObject:plusMinus];
                        
                        TBXMLElement *offensiveStats = [TBXML childElementNamed:@"stats-ice-hockey-offensive" parentElement:playerStatsIceHockey];
                        NSString *assist = [TBXML valueOfAttributeNamed:@"assists" forElement:offensiveStats];
                        [assistsArr addObject:assist];
                        
                        NSString *point = [TBXML valueOfAttributeNamed:@"points" forElement:offensiveStats];
                        [pointsArr addObject:point];
                        
                        // Set into next <player>
                        player = player->nextSibling;
                    }   
                }
            }
        }
    }
    
    // Store the local arrays into the class arrays and garbage collection
    self.names = namesArr;
    [namesArr release];
    
    self.gamesPlayed = gamesPlayedArr;
    [gamesPlayedArr release];
    
    self.goals = goalsArr;
    [goalsArr release];
    
    self.points = pointsArr;
    [pointsArr release];
    
    self.assists = assistsArr;
    [assistsArr release];
    
    self.plusMinuses = plusMinusesArr;
    [plusMinusesArr release];
    
    self.penalties = penaltiesArr;
    [penaltiesArr release];
}

#pragma mark - View lifecycle / Memory Management

- (void)viewDidLoad {
    
    // Set the title page for the navigation controller
    self.title = @"Stats";
    
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
    header.image = [UIImage imageNamed:@"header_stats.png"];
    
    // Add a view on top of the Table View to display a yellow background when a user scrolls upwards and bounces
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0,-480,320,480)];
    topView.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:181.0/255.0 blue:41.0/255.0 alpha:1];
    [self.statsTableView addSubview:topView];
    [topView release];
    
    // Set the table view background to display a gray background when a user scrolls downwards and bounces
    statsTableView.backgroundColor = [UIColor colorWithRed:71.0/255.0 green:71.0/255.0 blue:71.0/255.0 alpha:1];
    
    // Parse the news XML file
    [self traverseElements];
    
    [super viewDidLoad];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.header = nil;
    self.statsTableView = nil;
    self.names = nil;
    self.gamesPlayed = nil;
    self.goals = nil;
    self.points = nil;
    self.assists = nil;
    self.plusMinuses = nil;
    self.penalties = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [super dealloc];
    [header release];
    [statsTableView release];
    [names release];
    [gamesPlayed release];
    [goals release];
    [points release];
    [assists release];
    [plusMinuses release];
    [penalties release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table View Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [names count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger rowNumber = [indexPath row];
    
    if (rowNumber == 0) {
        
        StatsHeaderCell *cell = (StatsHeaderCell *)[tableView dequeueReusableCellWithIdentifier:statsHeader];
        if (cell == nil) { 
            NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"StatsHeaderCell" owner:self options:nil];          
            for (id anObject in nibObjects) {
                if ([anObject isKindOfClass:[StatsHeaderCell class]]) {
                    cell = (StatsHeaderCell *)anObject;
                }
            }
        }
        
        return cell;
    }
    
    StatsCell *cell = (StatsCell *)[tableView dequeueReusableCellWithIdentifier:statsCell];
    if (cell == nil) { 
        NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"StatsCell" owner:self options:nil];          
        for (id anObject in nibObjects) {
            if ([anObject isKindOfClass:[StatsCell class]]) {
                cell = (StatsCell *)anObject;
            }
        }
    }
    
    cell.name.text = [names objectAtIndex:rowNumber];
    cell.gamesPlayed.text = [gamesPlayed objectAtIndex:rowNumber];
    cell.goals.text = [goals objectAtIndex:rowNumber];
    cell.assists.text = [assists objectAtIndex:rowNumber];
    cell.points.text = [points objectAtIndex:rowNumber];
    cell.plusMinus.text = [plusMinuses objectAtIndex:rowNumber];
    cell.penalty.text = [penalties objectAtIndex:rowNumber];
    
    cell.name.font = [UIFont fontWithName:@"Helvetica" size:10];
    
    return cell;
}

#pragma mark - Table View Delegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row] == 0)
        return 27;
    return 20;
}

// Alternate Cell Background Color
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0)
        cell.backgroundView.backgroundColor = HEADER_CELL;
    else if (indexPath.row % 2 == 0)
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
