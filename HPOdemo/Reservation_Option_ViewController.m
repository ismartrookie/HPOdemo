//
//  Reservation_Option_ViewController.m
//  HPOdemo
//
//  Created by Gueie on 14-2-11.
//  Copyright (c) 2014年 Gueie. All rights reserved.
//

#import "Reservation_Option_ViewController.h"

@interface Reservation_Option_ViewController ()
{
    UILabel *hospitalLabel;
    UILabel *departmentLabel;
    UILabel *dateLabel;
}

@end

@implementation Reservation_Option_ViewController

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
    
    [self.titleLabel setText:@"就医预约"];
    
    for (int i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(18, 82 + 14 * i + 44 * i, 320 - 36, 44)];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button setTag:(100 + i)];
        [button addTarget:self action:@selector(changeOption:) forControlEvents:UIControlEventTouchUpInside];
        [button.layer setCornerRadius:3.0f];
        [button.layer setMasksToBounds:YES];
        [button.layer setBorderWidth:1.0f];
        [button.layer setBorderColor:HPO_BROWN.CGColor];
        [self.view addSubview:button];
    }

    UIButton *hospitalButton = (UIButton *)[self.view viewWithTag:100];
    UIButton *departmentButton = (UIButton *)[self.view viewWithTag:101];
    UIButton *dateButton = (UIButton *)[self.view viewWithTag:102];
    
    hospitalLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 11, 240, 22)];
    [hospitalLabel setText:@"北京协和医院（东院）"];
    [hospitalLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [hospitalButton addSubview:hospitalLabel];
    
    departmentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 11, 240, 22)];
    [departmentLabel setText:@"脑神经科"];
    [departmentLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [departmentButton addSubview:departmentLabel];
    
    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 11, 240, 22)];
    [dateLabel setText:@"2014 年 8 月 17 日  上午"];
    [dateLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [dateButton addSubview:dateLabel];
    
    for (int i = 0; i < 3; i++) {
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 86 - 24, 86, 24)];
        [bottomView setBackgroundColor:[HPO_BROWN colorWithAlphaComponent:0.75f]];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(17 + 86 * i + 14 * i, 256, 86, 86)];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button setTag:(200 + i)];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button.layer setCornerRadius:4.0f];
        [button.layer setMasksToBounds:YES];
        [button.layer setBorderWidth:1.0f];
        [button.layer setBorderColor:HPO_BROWN.CGColor];
        [button addSubview:bottomView];
        [self.view addSubview:button];
    }
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setFrame:CGRectMake(18, 357, 320 - 36, 44)];
    [nextButton setBackgroundColor:HPO_GREEN];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextButton.titleLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
    [nextButton.layer setCornerRadius:3.0f];
    [nextButton.layer setMasksToBounds:YES];
    [self.view addSubview:nextButton];
//
//    UIButton *bothButton = (UIButton *)[self.view viewWithTag:200];
//    [bothButton setTitle:@"特需普通皆可" forState:UIControlStateNormal];
//    
//    UIButton *specialButton = (UIButton *)[self.view viewWithTag:201];
//    UIButton *normalButton = (UIButton *)[self.view viewWithTag:202];
}

- (void)changeOption:(UIButton *)button
{
    int tag = button.tag;
    
    if (tag == 100) {
        NSLog(@"%@", hospitalLabel.text);
    } else if (tag == 101) {
        NSLog(@"%@", departmentLabel.text);
    } else if (tag == 102) {
        NSLog( @"%@", dateLabel.text);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
