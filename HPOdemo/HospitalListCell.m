//
//  HospitalListCell.m
//  HPOdemo
//
//  Created by Gueie on 14-2-10.
//  Copyright (c) 2014年 Gueie. All rights reserved.
//

#import "HospitalListCell.h"

@interface HospitalListCell ()
{
    UILabel *nameLabel;
    UILabel *scoreLabel;
    TQStarRatingView *starRatingView;
}

@end

@implementation HospitalListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 195, 17)];
        [nameLabel setFont:[UIFont boldSystemFontOfSize:16.5f]];
        [self.contentView addSubview:nameLabel];
        
        starRatingView = [[TQStarRatingView alloc] initWithFrame:CGRectMake(16, 51, 73, 14) numberOfStar:5];
        [starRatingView setUserInteractionEnabled:NO];
        [starRatingView setScore:0.7f withAnimation:YES];
        [self.contentView addSubview:starRatingView];
        
        scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(93, 52, 30, 12)];
        [scoreLabel setTextColor:HPO_GREEN];
        [scoreLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [self.contentView addSubview:scoreLabel];
        
        UIButton *reservationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [reservationButton setFrame:CGRectMake(222, 29, 53, 28)];
        [reservationButton setBackgroundColor:HPO_GREEN];
        [reservationButton setTitle:@"预约" forState:UIControlStateNormal];
        [reservationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [reservationButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
        [reservationButton.layer setCornerRadius:3.0f];
        [reservationButton.layer setMasksToBounds:YES];
        [reservationButton addTarget:self action:@selector(clickReservationButton) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:reservationButton];
    }
    return self;
}

- (void)setName:(NSString *)name
{
    _name = name;
    
    [nameLabel setText:name];
}

- (void)setScore:(NSString *)score
{
    _score = score;
    
    [scoreLabel setText:score];
    [starRatingView setScore:([score floatValue] / 5.0f) withAnimation:NO];
}

- (void)clickReservationButton
{
    if ([self.delegate respondsToSelector:@selector(reservation:)]) {
        [self.delegate reservation:self];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
