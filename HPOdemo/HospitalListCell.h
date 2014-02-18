//
//  HospitalListCell.h
//  HPOdemo
//
//  Created by Gueie on 14-2-10.
//  Copyright (c) 2014年 Gueie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TQStarRatingView.h"

@protocol HospitalListCellDelegate;

@interface HospitalListCell : UITableViewCell

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *score;
@property (copy, nonatomic) NSString *id_No;
@property (assign, nonatomic) id<HospitalListCellDelegate> delegate;

@end

@protocol HospitalListCellDelegate <NSObject>

- (void)reservation:(HospitalListCell *)cell;

@end