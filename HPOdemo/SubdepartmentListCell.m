//
//  SubdepartmentListCell.m
//  HPOdemo
//
//  Created by Gueie on 14-2-11.
//  Copyright (c) 2014年 Gueie. All rights reserved.
//

#import "SubdepartmentListCell.h"

@implementation SubdepartmentListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        UILabel *dashLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.contentView.bounds.size.height - 4, self.contentView.bounds.size.width, 4)];
        [dashLineLabel setText:@"  - - - - - - - - - -  "];
        [dashLineLabel setTextColor:HPO_BROWN];
        [dashLineLabel setFont:[UIFont boldSystemFontOfSize:25.0f]];
        [self.contentView addSubview:dashLineLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
