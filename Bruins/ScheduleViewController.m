//
//  ScheduleViewController.m
//  Bruins
//
//  Created by Nayef Copty on 23/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ScheduleViewController.h"
#import "ScheduleHeaderCell.h"
#import "ScheduleCell.h"

@implementation ScheduleViewController

static NSString *scheduleHeader = @"ScheduleHeaderType";
static NSString *scheduleCell = @"ScheduleCellType";

@synthesize bannerIsVisible, header, scheduleTableView, segmentedControl, dates, times, channels, awayTeams, awayScores, awayResults, homeTeams, homeScores, homeResults;

- (void)traverseElements {
    
    // Initialize local arrays
    NSMutableArray *datesArray = [[NSMutableArray alloc] init];
    NSMutableArray *timesArray = [[NSMutableArray alloc] init];
    NSMutableArray *channelsArray = [[NSMutableArray alloc] init];
    NSMutableArray *awayTeamsArray = [[NSMutableArray alloc] init];
    NSMutableArray *awayScoresArray = [[NSMutableArray alloc] init];
    NSMutableArray *awayResultsArray = [[NSMutableArray alloc] init];
    NSMutableArray *homeTeamsArray = [[NSMutableArray alloc] init];
    NSMutableArray *homeScoresArray = [[NSMutableArray alloc] init];
    NSMutableArray *homeResultsArray = [[NSMutableArray alloc] init];
    
    // Initialize a TXML with the XML file and get the root
    TBXML *tbxml = [[[TBXML tbxmlWithXMLFile:@"schedule.xml"] retain] autorelease];
    
    TBXMLElement *root = tbxml.rootXMLElement;
    
    if (root) {
        
        // Get the <sports-content> tag
        TBXMLElement *sportsContent = [TBXML childElementNamed:@"sports-content" parentElement:root];
        
        if (sportsContent) {
            
            // Get the <schedule> tag
            TBXMLElement *schedule = [TBXML childElementNamed:@"schedule" parentElement:sportsContent];
            
            if (schedule) {
                
                // Get the <sports-event> tag
                TBXMLElement *sportsEvent = [TBXML childElementNamed:@"sports-event" parentElement:schedule];
                
                while (sportsEvent != nil) {
                    
                    // Get the date / time
                    TBXMLElement *event = [TBXML childElementNamed:@"event-metadata" parentElement:sportsEvent];
                    NSString *dateTime = [TBXML valueOfAttributeNamed:@"start-date-time" forElement:event];
                    NSString *dateStr = [dateTime substringWithRange:NSMakeRange(0, 8)];
                    NSString *timeStr = [dateTime substringWithRange:NSMakeRange(9, 4)];
                    
                    // Convert date string to a date object
                    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                    [dateFormat setDateFormat:@"yyyyMMdd"];
                    NSDate *date = [dateFormat dateFromString:dateStr];
                    
                    // Convert date object to a readable date string
                    [dateFormat setDateFormat:@"EEE, LLL d"];
                    dateStr = [dateFormat stringFromDate:date];
                    [datesArray addObject:dateStr];
                    [dateFormat release];
                    
                    NSString *hour = [timeStr substringWithRange:NSMakeRange(0, 2)];
                    NSString *minute = [timeStr substringWithRange:NSMakeRange(2, 2)];
                    NSString *time = [NSString stringWithFormat:@"%@:%@", hour, minute];
                    [timesArray addObject:time];
                    
                    // Get the channel
                    TBXMLElement *sportsProperty = [TBXML childElementNamed:@"sports-property" parentElement:event];
                    NSString *channel = [TBXML valueOfAttributeNamed:@"value" forElement:sportsProperty];
                    [channelsArray addObject:channel];
                    
                    // Get the away team details
                    TBXMLElement *teamAway = [TBXML childElementNamed:@"team" parentElement:sportsEvent];
                    TBXMLElement *teamMetaDataAway = [TBXML childElementNamed:@"team-metadata" parentElement:teamAway];
                    TBXMLElement *nameAway = [TBXML childElementNamed:@"name" parentElement:teamMetaDataAway];
                    NSString *firstNameAway = [TBXML valueOfAttributeNamed:@"first" forElement:nameAway];
                    NSString *lastNameAway = [TBXML valueOfAttributeNamed:@"last" forElement:nameAway];
                    NSString *nameAwayStr = [NSString stringWithFormat:@"%@ %@", firstNameAway, lastNameAway];
                    [awayTeamsArray addObject:nameAwayStr];
                    TBXMLElement *teamStatsAway = [TBXML childElementNamed:@"team-stats" parentElement:teamAway];
                    NSString *awayScore = [TBXML valueOfAttributeNamed:@"score" forElement:teamStatsAway];
                    [awayScoresArray addObject:awayScore];
                    NSString *awayResult = [TBXML valueOfAttributeNamed:@"event-outcome" forElement:teamStatsAway];
                    [awayResultsArray addObject:awayResult];
                    
                    // Get the home team details
                    TBXMLElement *teamHome = teamAway->nextSibling;
                    TBXMLElement *teamMetaDataHome = [TBXML childElementNamed:@"team-metadata" parentElement:teamHome];
                    TBXMLElement *nameHome = [TBXML childElementNamed:@"name" parentElement:teamMetaDataHome];
                    NSString *firstNameHome = [TBXML valueOfAttributeNamed:@"first" forElement:nameHome];
                    NSString *lastNameHome = [TBXML valueOfAttributeNamed:@"last" forElement:nameHome];
                    NSString *nameHomeStr = [NSString stringWithFormat:@"%@ %@", firstNameHome, lastNameHome];
                    [homeTeamsArray addObject:nameHomeStr];
                    TBXMLElement *teamStatsHome = [TBXML childElementNamed:@"team-stats" parentElement:teamHome];
                    NSString *homeScore = [TBXML valueOfAttributeNamed:@"score" forElement:teamStatsHome];
                    [homeScoresArray addObject:homeScore];
                    NSString *homeResult = [TBXML valueOfAttributeNamed:@"event-outcome" forElement:teamStatsHome];
                    [homeResultsArray addObject:homeResult];
                    
                    // Go to next sports-event
                    //sportsEvent = [TBXML nextSiblingNamed:@"sports-event" searchFromElement:schedule];
                    sportsEvent = sportsEvent->nextSibling;
                }
            }
        }
    }
        
    // Store the local arrays into the class arrays and garbage collection
    self.dates = datesArray;
    [datesArray release];
    
    self.times = timesArray;
    [timesArray release];
    
    self.channels = channelsArray;
    [channelsArray release];
    
    self.awayTeams = awayTeamsArray;
    [awayTeamsArray release];
    
    self.awayScores = awayScoresArray;
    [awayScoresArray release];
    
    self.awayResults = awayResultsArray;
    [awayResultsArray release];
    
    self.homeTeams = homeTeamsArray;
    [homeTeamsArray release];
    
    self.homeScores = homeScoresArray;
    [homeScoresArray release];
    
    self.homeResults = homeResultsArray;
    [homeResultsArray release];
}

// Returns a team's abbreviation
- (NSString *)teamAbbreviation:(NSString *)team {
    
    NSString *string;
    
    if ([team isEqualToString:@"Minnesota Wild"])
        string = [NSString stringWithString:@"MIN"];
    
    else if ([team isEqualToString:@"Pittsburgh Penguins"])
        string = [NSString stringWithString:@"PIT"];
    
    else if ([team isEqualToString:@"Chicago Blackhawks"])
        string = [NSString stringWithString:@"CHI"];
    
    else if ([team isEqualToString:@"Philadelphia Flyers"])
        string = [NSString stringWithString:@"PHI"];
    
    else if ([team isEqualToString:@"Buffalo Sabres"])
        string = [NSString stringWithString:@"BUF"];
    
    else if ([team isEqualToString:@"Washington Capitals"])
        string = [NSString stringWithString:@"WAS"];
    
    else if ([team isEqualToString:@"St. Louis Blues"])
        string = [NSString stringWithString:@"STL"];
    
    else if ([team isEqualToString:@"Colorado Avalanche"])
        string = [NSString stringWithString:@"COL"];
    
    else if ([team isEqualToString:@"Toronto Maple Leafs"])
        string = [NSString stringWithString:@"TOR"];
    
    else if ([team isEqualToString:@"Montreal Canadiens"])
        string = [NSString stringWithString:@"MTL"];
    
    else if ([team isEqualToString:@"Vancouver Canucks"])
        string = [NSString stringWithString:@"VAN"];
    
    else if ([team isEqualToString:@"Los Angeles Kings"])
        string = [NSString stringWithString:@"LAK"];
    
    else if ([team isEqualToString:@"Atlanta Thrashers"])
        string = [NSString stringWithString:@"ATL"];
    
    else if ([team isEqualToString:@"Detroit Red Wings"])
        string = [NSString stringWithString:@"DET"];
    
    else if ([team isEqualToString:@"Florida Panthers"])
        string = [NSString stringWithString:@"FLO"];
    
    else if ([team isEqualToString:@"Nashville Predators"])
        string = [NSString stringWithString:@"NSH"];
    
    else if ([team isEqualToString:@"Tampa Bay Lightning"])
        string = [NSString stringWithString:@"TBL"];
    
    else if ([team isEqualToString:@"Ottawa Senators"])
        string = [NSString stringWithString:@"OTT"];
    
    else if ([team isEqualToString:@"Phoenix Coyotes"])
        string = [NSString stringWithString:@"PHX"];
    
    else if ([team isEqualToString:@"San Jose Sharks"])
        string = [NSString stringWithString:@"SJS"];
    
    else if ([team isEqualToString:@"Edmonton Oilers"])
        string = [NSString stringWithString:@"EDM"];
    
    else if ([team isEqualToString:@"Columbus Blue Jackets"])
        string = [NSString stringWithString:@"CBJ"];
    
    else if ([team isEqualToString:@"Carolina Hurricanes"])
        string = [NSString stringWithString:@"CAR"];
    
    else if ([team isEqualToString:@"Calgary Flames"])
        string = [NSString stringWithString:@"CGY"];
    
    else if ([team isEqualToString:@"Boston Bruins"])
        string = [NSString stringWithString:@"BOS"];
    
    else if ([team isEqualToString:@"New York Rangers"])
        string = [NSString stringWithString:@"NYR"];
    
    else if ([team isEqualToString:@"New York Islanders"])
        string = [NSString stringWithString:@"NYI"];
    
    else if ([team isEqualToString:@"Anaheim Ducks"])
        string = [NSString stringWithString:@"ANA"];
    
    else if ([team isEqualToString:@"Dallas Stars"])
        string = [NSString stringWithString:@"DAL"];
    
    else if ([team isEqualToString:@"New Jersey Devils"])
        string = [NSString stringWithString:@"NJD"];
    
    else
        string = [NSString stringWithString:@" "];
    
    return string;
    
}

// Reload the table view when toggling the segmented control
- (IBAction)scheduleControl:(id)sender {
    [self.scheduleTableView reloadData];
}

#pragma mark - View lifecycle / Memory Management

- (void)viewDidLoad {
    
    // Set the title page for the navigation controller
    self.title = @"Schedule";
    
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
    header.image = [UIImage imageNamed:@"header_schedule.png"];
    
    // Add a view on top of the Table View to display a yellow background when a user scrolls upwards and bounces
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0,-480,320,480)];
    topView.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:181.0/255.0 blue:41.0/255.0 alpha:1];
    [self.scheduleTableView addSubview:topView];
    [topView release];
    
    // Set the table view background to display a gray background when a user scrolls downwards and bounces
    scheduleTableView.backgroundColor = [UIColor colorWithRed:71.0/255.0 green:71.0/255.0 blue:71.0/255.0 alpha:1];
    
    // Change the UISegmentedControl height
    segmentedControl.tintColor = [UIColor colorWithRed:71.0/255.0 green:71.0/255.0 blue:71.0/255.0 alpha:1];
    
    // Parse the news XML file
    [self traverseElements];
    
    [super viewDidLoad];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.header = nil;
    self.scheduleTableView = nil;
    self.segmentedControl = nil;
    self.dates = nil;
    self.times = nil;
    self.channels = nil;
    self.awayTeams = nil;
    self.awayScores = nil;
    self.awayResults = nil;
    self.homeTeams = nil;
    self.homeScores = nil;
    self.homeResults = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [super dealloc];
    [header release];
    [scheduleTableView release];
    [segmentedControl release];
    [dates release];
    [times release];
    [channels release];
    [awayTeams release];
    [awayScores release];
    [awayResults release];
    [homeTeams release];
    [homeScores release];
    [homeResults release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table View Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dates count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger rowNumber = [indexPath row];
    
    if (rowNumber == 0) {
        
        ScheduleHeaderCell *cell = (ScheduleHeaderCell *)[tableView dequeueReusableCellWithIdentifier:scheduleHeader];
        if (cell == nil) { 
            NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"ScheduleHeaderCell" owner:self options:nil];          
            for (id anObject in nibObjects) {
                if ([anObject isKindOfClass:[ScheduleHeaderCell class]]) {
                    cell = (ScheduleHeaderCell *)anObject;
                }
            }
        }
        
        return cell;
    }
    
    if (segmentedControl.selectedSegmentIndex == 0) {
        ScheduleCell *cell = (ScheduleCell *)[tableView dequeueReusableCellWithIdentifier:scheduleCell];
        if (cell == nil) { 
            NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"ScheduleCell" owner:self options:nil];          
            for (id anObject in nibObjects) {
                if ([anObject isKindOfClass:[ScheduleCell class]]) {
                    cell = (ScheduleCell *)anObject;
                }
            }
        }
        
        cell.date.text = [dates objectAtIndex:rowNumber];
        cell.time.text = [times objectAtIndex:rowNumber];
        
        NSString *awayName = [awayTeams objectAtIndex:rowNumber];
        NSString *homeName = [homeTeams objectAtIndex:rowNumber];
        NSString *awayScore = [awayScores objectAtIndex:rowNumber];
        NSString *homeScore = [homeScores objectAtIndex:rowNumber];
        NSString *awayResult = [awayResults objectAtIndex:rowNumber];
        NSString *homeResult = [homeResults objectAtIndex:rowNumber];
        
        NSString *homeAbv = [self teamAbbreviation:homeName];
        NSString *awayAbv = [self teamAbbreviation:awayName];
        NSMutableString *matchup = [NSMutableString string];
        [matchup appendString:awayAbv];
        [matchup appendString:@" at "];
        [matchup appendString:homeAbv];
        
        cell.matchup.text = matchup;
        
        NSMutableString *result = [NSMutableString string];
        
        [result appendString:awayScore];
        [result appendString:@"-"];
        [result appendString:homeScore];
        
        if ([awayName isEqualToString:@"Boston Bruins"]) {
            if ([awayResult isEqualToString:@"win"])
                [result appendString:@" W"];
            else if ([awayResult isEqualToString:@"loss"])
                [result appendString:@" L"];
            else if ([awayResult isEqualToString:@"undecided"])
                [result appendString:@" D"];
        }
        
        if ([homeName isEqualToString:@"Boston Bruins"]) {
            if ([homeResult isEqualToString:@"win"])
                [result appendString:@" W"];
            else if ([homeResult isEqualToString:@"loss"])
                [result appendString:@" L"];
            else if ([homeResult isEqualToString:@"undecided"])
                [result appendString:@" D"];
        }
        
        cell.result.text = result;
        
        return cell;
    }
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if (rowNumber == 2) {
        cell.textLabel.text = @"Please check back later for 2011 - 2012 season schedule";
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.textColor = [UIColor colorWithRed:236.0/255.0 green:171.0/255.0 blue:67.0/255.0 alpha:1.0];
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size: 10.0];
    }
    
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


// Informs the table view delegate that the specified row is now selected.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Deselect selected row in table view
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSUInteger rowNumber = [indexPath row];
    
    NSString *channel = [[NSString alloc] initWithFormat:@"This game will be on %@", [channels objectAtIndex:rowNumber]];
                         
    UIAlertView *alert = [[UIAlertView alloc] 
                          initWithTitle:@"Channel" 
                          message:channel delegate:nil 
                          cancelButtonTitle:@"OK" 
                          otherButtonTitles:nil, nil];
    [alert show];
    [channel release];
    [alert release];
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
