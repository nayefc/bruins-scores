//
//  NewsViewController.m
//  Bruins
//
//  Created by Nayef Copty on 23/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsCell.h"
#import "BruinsAppDelegate.h"
#import "NewsWebViewController.h"

@implementation NewsViewController

static NSString *newsCellType = @"NewsCellType";

@synthesize bannerIsVisible, header, newsTableView, titles, descriptions, pubDates, guids;

#pragma mark - View lifecycle / Memory Management

- (void)traverseElements {
    
    // Initialize local arrays
    NSMutableArray *titlesArray = [[NSMutableArray alloc] init];
    NSMutableArray *descriptionsArray = [[NSMutableArray alloc] init];
    NSMutableArray *pubDatesArray = [[NSMutableArray alloc] init];
    NSMutableArray *guidsArray = [[NSMutableArray alloc] init];
    
    // Get the XML file
    NSData *xmlData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:@"http://bruins.nhl.com/rss/news.xml"]];
    
    // Check for internet connection
    if (xmlData == nil) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Error!" 
                              message:@"Please check that you are connected to the internet" 
                              delegate:nil 
                              cancelButtonTitle:@"OK" 
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }
    
    // Initialize a TXML with the XML file and get the root
    TBXML *tbxml = [[TBXML alloc]initWithXMLData:xmlData];
    TBXMLElement *root = tbxml.rootXMLElement;
    
    if (root) {
        
        // Get the <channel> tag
        TBXMLElement *channel = [TBXML childElementNamed:@"channel" parentElement:root];
        
        if (channel) {
            
            // Get the <item> tag and read the title, descriptions, pubdates, and links and store them into the arrays
            TBXMLElement *item = [TBXML childElementNamed:@"item" parentElement:channel];
            
            while (item !=nil) {
                
                // Get Title
                TBXMLElement *title = [TBXML childElementNamed:@"title" parentElement:item];
                NSString *titleString = [TBXML textForElement:title];
                [titlesArray addObject:titleString];
            
                // Get Description
                TBXMLElement *description = [TBXML childElementNamed:@"description" parentElement:item];
                NSString *descriptionString = [TBXML textForElement:description];
                [descriptionsArray addObject:descriptionString];
            
                // Get pubDate
                TBXMLElement *pubDate = [TBXML childElementNamed:@"pubDate" parentElement:item];
                NSString *pubDateString = [TBXML textForElement:pubDate];
                [pubDatesArray addObject:pubDateString];
                
                // Get the URL
                TBXMLElement *guid = [TBXML childElementNamed:@"guid" parentElement:item];
                NSString *guidString = [TBXML textForElement:guid];
                [guidsArray addObject:guidString];
                
                // Go to next item
                item = [TBXML nextSiblingNamed:@"item" searchFromElement:item];
            }
        }
        
    }
    
    // Store the local arrays into the class arrays and garbage collection
    self.titles = titlesArray;
    [titlesArray release];
    
    self.descriptions = descriptionsArray;
    [descriptionsArray release];
    
    self.pubDates = pubDatesArray;
    [pubDatesArray release];
    
    self.guids = guidsArray;
    [guidsArray release];
}

- (void)viewDidLoad {
    
    // Set the title page for the navigation controller
    self.title = @"News";
    
    // Set up and display iAd
    CGRect iAdRect = CGRectMake(0, 43, 0, 0);
    adView = [[ADBannerView alloc] initWithFrame:iAdRect];
    adView.frame = CGRectOffset(adView.frame, 0, 0);
    adView.requiredContentSizeIdentifiers = [NSSet setWithObject:ADBannerContentSizeIdentifierPortrait];
    adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    [self.view addSubview:adView];
    //[self.view bringSubviewToFront:adView];
    //adView.frame = CGRectMake(0.0, 0.0, adView.frame.size.width, adView.frame.size.height);
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
    header.image = [UIImage imageNamed:@"header_news.png"];
    
    // Add a view on top of the Table View to display a yellow background when a user scrolls upwards and bounces
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0,-480,320,480)];
    topView.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:181.0/255.0 blue:41.0/255.0 alpha:1];
    [self.newsTableView addSubview:topView];
    [topView release];
    
    // Set the table view background to display a gray background when a user scrolls downwards and bounces
    newsTableView.backgroundColor = [UIColor colorWithRed:71.0/255.0 green:71.0/255.0 blue:71.0/255.0 alpha:1];
    
    // Parse the news XML file
    [self traverseElements];
    
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Hide the navigation bar from the News table view page
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.header = nil;
    self.newsTableView = nil;
    self.titles = nil;
    self.descriptions = nil;
    self.pubDates = nil;
    self.guids = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [header release];
    [newsTableView release];
    [titles release];
    [descriptions release];
    [pubDates release];
    [guids release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table View Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [titles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger rowNumber = [indexPath row];
        
    NewsCell *cell = (NewsCell *)[tableView dequeueReusableCellWithIdentifier:newsCellType];
    if (cell == nil) { 
        NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:self options:nil];          
        for (id anObject in nibObjects) {
            if ([anObject isKindOfClass:[NewsCell class]]) {
                cell = (NewsCell *)anObject;
            }
        }
    }
    
    cell.title.text = [titles objectAtIndex:rowNumber];
    
    NSString *description = [descriptions objectAtIndex:rowNumber];
    description = [description stringByReplacingOccurrencesOfString:@"&ndash;" withString:@"-"];
    description = [description stringByReplacingOccurrencesOfString:@"&rsquo;" withString:@"'"];
    description = [description stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    description = [description stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    cell.description.text = description;

    cell.pubDate.text = [pubDates objectAtIndex:rowNumber];
    
    return cell;
}

#pragma mark - Table View Delegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}

// Alternate Cell Background Color
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row % 2 == 0)
        cell.backgroundView.backgroundColor = DARK_CELL;
    else
        cell.backgroundView.backgroundColor = LIGHT_CELL;
}


// Informs the table view delegate that the specified row is now selected.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger rowNumber = [indexPath row];
    
    // Instantiate a Web View Controller object
    NewsWebViewController *webView = [[[NewsWebViewController alloc]
                                       initWithNibName:@"NewsWebViewController"
                                       bundle:nil] autorelease];
    
    // Copy the link into webURL
    NSString *webURL = [[NSString alloc] initWithFormat:@"%@", [guids objectAtIndex:rowNumber]];
    
    // Set the properties of NewsWebViewController
    webView.urlStr = webURL;
    
    // Garbage Collection
    [webURL release];
    
    // Push the NewsWebViewController onto the stack to display it
    [self.navigationController pushViewController:webView animated:YES];
    self.navigationController.navigationBarHidden = NO;
    
    // Deselect selected row in table view
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
