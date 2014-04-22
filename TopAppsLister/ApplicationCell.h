//
//  ApplicationCell.h
//  TopAppsLister
//
//  Created by Daniel Stokowski on 22.04.2014.
//  Copyright (c) 2014 BLTest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplicationCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIImageView *IconImageView;
@property (retain, nonatomic) IBOutlet UILabel *positionLabel;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;

@end
