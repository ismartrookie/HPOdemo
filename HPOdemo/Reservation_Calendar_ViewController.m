//
//  Reservation_Calendar_ViewController.m
//  HPOdemo
//
//  Created by Gueie on 14-2-11.
//  Copyright (c) 2014年 Gueie. All rights reserved.
//

#import "Reservation_Calendar_ViewController.h"

@interface Reservation_Calendar_ViewController ()
{
    UIButton *dateButton;
    UIButton *amButton;
    UIButton *pmButton;
    UIButton *submitButton;
    
    DDCalendarView *calendarView;
    
    NSString *time;
}

@end

@implementation Reservation_Calendar_ViewController

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
    
    [self.titleLabel setText:@"选择预约时间"];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIView *monthBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 320, 44)];
    [monthBGView setBackgroundColor:HPO_LINEN];
    [self.view addSubview:monthBGView];
    
    calendarView = [[DDCalendarView alloc] initWithFrame:CGRectMake(7, 64, 306, 334) fontName:@"" delegate:self];
    [self.view addSubview:calendarView];
    
    dateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [dateButton setFrame:CGRectMake(12, 415, 43, 43)];
    [dateButton setBackgroundColor:HPO_LINEN];
    [dateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [dateButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
    [dateButton.layer setBorderWidth:1.0f];
    [dateButton.layer setBorderColor:HPO_BROWN.CGColor];
    [self.view addSubview:dateButton];
    
    pmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [pmButton setFrame:CGRectMake(189, 415, 121, 44)];
    [pmButton setBackgroundColor:[UIColor lightGrayColor]];
    [pmButton setTitle:@"下午" forState:UIControlStateNormal];
    [pmButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [pmButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
    [pmButton.layer setCornerRadius:3.0f];
    [pmButton.layer setMasksToBounds:YES];
    [pmButton addTarget:self action:@selector(selectNoon:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pmButton];
    
    amButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [amButton setFrame:CGRectMake(69, 415, 121, 44)];
    [amButton setBackgroundColor:[UIColor whiteColor]];
    [amButton setTitle:@"上午" forState:UIControlStateNormal];
    [amButton setTitleColor:HPO_GREEN forState:UIControlStateNormal];
    [amButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
    [amButton.layer setCornerRadius:3.0f];
    [amButton.layer setMasksToBounds:YES];
    [amButton.layer setBorderWidth:1.0f];
    [amButton.layer setBorderColor:HPO_GREEN.CGColor];
    [amButton addTarget:self action:@selector(selectNoon:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:amButton];
    
    time = @"上午";
    
    submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setFrame:CGRectMake(12, 473, 296, 44)];
    [submitButton setBackgroundColor:HPO_GREEN];
    [submitButton setTitle:@"选好了 2014-02-11 上午" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
    [submitButton.layer setCornerRadius:3.0f];
    [submitButton.layer setMasksToBounds:YES];
    
    [self.view addSubview:submitButton];
}

- (void)selectNoon:(UIButton *)button
{
    if ([button isEqual:amButton]) {
        [amButton setBackgroundColor:[UIColor whiteColor]];
        [amButton setTitleColor:HPO_GREEN forState:UIControlStateNormal];
        [amButton.layer setBorderWidth:1.0f];
        [amButton.layer setBorderColor:HPO_GREEN.CGColor];
        
        [pmButton setBackgroundColor:[UIColor lightGrayColor]];
        [pmButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [pmButton.layer setBorderWidth:0];
    } else {
        [pmButton setBackgroundColor:[UIColor whiteColor]];
        [pmButton setTitleColor:HPO_GREEN forState:UIControlStateNormal];
        [pmButton.layer setBorderWidth:1.0f];
        [pmButton.layer setBorderColor:HPO_GREEN.CGColor];
        
        [amButton setBackgroundColor:[UIColor lightGrayColor]];
        [amButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [amButton.layer setBorderWidth:0];
    }
    
    time = button.titleLabel.text;
    [self.view bringSubviewToFront:button];
}

- (void)dayButtonPressed:(DayButton *)button
{
    [dateButton setTitle:button.titleLabel.text forState:UIControlStateNormal];
    
    NSLog(@"%@", button.buttonDate);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
