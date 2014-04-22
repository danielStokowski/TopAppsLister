//
//  ApplicationCell.m
//  TopAppsLister
//
//  Created by Daniel Stokowski on 22.04.2014.
//  Copyright (c) 2014 BLTest. All rights reserved.
//

#import "ApplicationCell.h"

@implementation ApplicationCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // Initialization code
    }
    return self;
}

- (void)dealloc {
    [_IconImageView release];
    [_positionLabel release];
    [_titleLabel release];
    [super dealloc];
}
@end
