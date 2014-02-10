//
//  PersonalCenterCell.m
//  HPOdemo
//
//  Created by Gueie on 14-2-10.
//  Copyright (c) 2014年 Gueie. All rights reserved.
//

#import "PersonalCenterCell.h"

@implementation PersonalCenterCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, 62, 62)];
        [self.contentView addSubview:self.imageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, 86, 15)];
        [self.titleLabel setTextColor:[UIColor darkGrayColor]];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [self.contentView addSubview:self.titleLabel];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
