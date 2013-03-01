//
//  ScheduleCell.m
//  Bruins
//
//  Created by Nayef Copty on 04/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ScheduleCell.h"


@implementation ScheduleCell

@synthesize date, matchup, time, result;

- (void)dealloc {
    [super dealloc];
    [date release];
    [matchup release];
    [time release];
    [result release];
}

@end
