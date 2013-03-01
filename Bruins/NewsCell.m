//
//  NewsCell.m
//  Bruins
//
//  Created by Nayef Copty on 23/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NewsCell.h"


@implementation NewsCell

@synthesize title, description, pubDate;

- (void)dealloc {
    [title release];
    [description release];
    [pubDate release];
    [super dealloc];
}

@end
