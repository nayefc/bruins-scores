//
//  StatsCell.m
//  Bruins
//
//  Created by Nayef Copty on 08/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StatsCell.h"


@implementation StatsCell

@synthesize name, gamesPlayed, goals, points, assists, plusMinus, penalty;

- (void)dealloc {
    [super dealloc];
    [name release];
    [gamesPlayed release];
    [goals release];
    [points release];
    [assists release];
    [plusMinus release];
    [penalty release];
}

@end
