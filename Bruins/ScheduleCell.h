//
//  ScheduleCell.h
//  Bruins
//
//  Created by Nayef Copty on 04/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ScheduleCell : UITableViewCell {
    UILabel *date;
    UILabel *matchup;
    UILabel *time;
    UILabel *result;
}

@property (nonatomic, retain) IBOutlet UILabel *date;
@property (nonatomic, retain) IBOutlet UILabel *matchup;
@property (nonatomic, retain) IBOutlet UILabel *time;
@property (nonatomic, retain) IBOutlet UILabel *result;

@end
