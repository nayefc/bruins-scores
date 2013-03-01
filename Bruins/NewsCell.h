//
//  NewsCell.h
//  Bruins
//
//  Created by Nayef Copty on 23/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NewsCell : UITableViewCell {
    UILabel *title;
    UILabel *description;
    UILabel *pubDate;
}

@property (nonatomic, retain) IBOutlet UILabel *title;
@property (nonatomic, retain) IBOutlet UILabel *description;
@property (nonatomic, retain) IBOutlet UILabel *pubDate;

@end
