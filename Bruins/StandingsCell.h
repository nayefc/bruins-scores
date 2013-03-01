//
//  StandingsCell.h
//  Bruins
//
//  Created by Nayef Copty on 09/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StandingsCell : UITableViewCell {
    UILabel *team;
    UILabel *gamesPlayed;
    UILabel *wins;
    UILabel *loses;
    UILabel *overtime;
    UILabel *points;
    UILabel *streak;
}

@property (nonatomic, retain) IBOutlet UILabel *team;
@property (nonatomic, retain) IBOutlet UILabel *gamesPlayed;
@property (nonatomic, retain) IBOutlet UILabel *wins;
@property (nonatomic, retain) IBOutlet UILabel *loses;
@property (nonatomic, retain) IBOutlet UILabel *overtime;
@property (nonatomic, retain) IBOutlet UILabel *points;
@property (nonatomic, retain) IBOutlet UILabel *streak;

@end
