//
//  StatsCell.h
//  Bruins
//
//  Created by Nayef Copty on 08/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StatsCell : UITableViewCell {
    UILabel *name;
    UILabel *gamesPlayed;
    UILabel *goals;
    UILabel *points;
    UILabel *assists;
    UILabel *plusMinus;
    UILabel *penalty;
}

@property (nonatomic, retain) IBOutlet UILabel *name;
@property (nonatomic, retain) IBOutlet UILabel *gamesPlayed;
@property (nonatomic, retain) IBOutlet UILabel *goals;
@property (nonatomic, retain) IBOutlet UILabel *points;
@property (nonatomic, retain) IBOutlet UILabel *assists;
@property (nonatomic, retain) IBOutlet UILabel *plusMinus;
@property (nonatomic, retain) IBOutlet UILabel *penalty;

@end
