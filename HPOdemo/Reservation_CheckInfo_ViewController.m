//
//  Reservation_CheckInfo_ViewController.m
//  HPOdemo
//
//  Created by Gueie on 14-2-12.
//  Copyright (c) 2014年 Gueie. All rights reserved.
//

#import "Reservation_CheckInfo_ViewController.h"

@interface Reservation_CheckInfo_ViewController ()
{
    UILabel *nameLabel;
    UILabel *hospitalLabel;
    UILabel *dateLabel;
    UILabel *diagnosisLabel;
    UILabel *reasonLabel;
    UILabel *cardLabel;
    UILabel *serviceLabel;
}

@end

@implementation Reservation_CheckInfo_ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.titleLabel setText:@"核对信息"];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(17, 78, 286, 303)];
    [bgImageView setImage:[UIImage imageNamed:@"info_list"]];
    [self.view addSubview:bgImageView];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(68, 15, 200, 20)];
//    [nameLabel setBackgroundColor:[UIColor yellowColor]];
    [nameLabel setText:@"王宝强"];
    [nameLabel setTextColor:[UIColor darkGrayColor]];
    [nameLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [bgImageView addSubview:nameLabel];
    
    hospitalLabel = [[UILabel alloc] initWithFrame:CGRectMake(68, 59, 200, 20)];
    [hospitalLabel setText:@"北京协和医院 · 神经内科"];
    [hospitalLabel setTextColor:[UIColor darkGrayColor]];
    [hospitalLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [bgImageView addSubview:hospitalLabel];
    
    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(68, 103, 200, 20)];
    [dateLabel setText:@"2014 年 2 月 14 日  上午"];
    [dateLabel setTextColor:[UIColor darkGrayColor]];
    [dateLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [bgImageView addSubview:dateLabel];
    
    diagnosisLabel = [[UILabel alloc] initWithFrame:CGRectMake(68, 146, 200, 20)];
    [diagnosisLabel setText:@"神经病"];
    [diagnosisLabel setTextColor:[UIColor darkGrayColor]];
    [diagnosisLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [bgImageView addSubview:diagnosisLabel];
    
    reasonLabel = [[UILabel alloc] initWithFrame:CGRectMake(68, 191, 200, 20)];
    [reasonLabel setText:@"原因1 · 补充说明"];
    [reasonLabel setTextColor:[UIColor darkGrayColor]];
    [reasonLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [bgImageView addSubview:reasonLabel];
    
    cardLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 233, 260, 20)];
    [cardLabel setText:@"原因1 · 补充说明"];
    [cardLabel setTextColor:[UIColor darkGrayColor]];
    [cardLabel setTextAlignment:NSTextAlignmentCenter];
    [cardLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [bgImageView addSubview:cardLabel];
    
    serviceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 253, 260, 20)];
    [serviceLabel setText:@"原因1 · 补充说明"];
    [serviceLabel setTextColor:[UIColor darkGrayColor]];
    [serviceLabel setTextAlignment:NSTextAlignmentCenter];
    [serviceLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [bgImageView addSubview:serviceLabel];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setFrame:CGRectMake(16, 383, 288, 44)];
    [submitButton setBackgroundColor:HPO_GREEN];
    [submitButton setTitle:@"确认无误, 提交" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitButton.titleLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
    [submitButton.layer setCornerRadius:3.0f];
    [submitButton.layer setMasksToBounds:YES];
    [self.view addSubview:submitButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
