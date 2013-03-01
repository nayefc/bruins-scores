//
//  StandingsCell.m
//  Bruins
//
//  Created by Nayef Copty on 09/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StandingsCell.h"


@implementation StandingsCell

@synthesize team, gamesPlayed, wins, loses, overtime, points, streak;

- (void)dealloc {
    [team release];
    [gamesPlayed release];
    [wins release];
    [loses release];
    [overtime release];
    [points release];
    [streak release];
    [super dealloc];
}

@end
