//
//  User_Account_ViewController.m
//  HPOdemo
//
//  Created by Gueie on 14-2-13.
//  Copyright (c) 2014年 Gueie. All rights reserved.
//

#import "User_Account_ViewController.h"

@interface User_Account_ViewController ()
{
    UIImageView *faceImageView;
    UILabel *nameLabel;
    UILabel *telNoLabel;
}

@end

@implementation User_Account_ViewController

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
    
    [self.titleLabel setText:@"我的账户"];
    
    UIButton *userInfoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [userInfoButton setFrame:CGRectMake(-1, 64 + 16, 322, 88)];
    [userInfoButton setBackgroundColor:[UIColor whiteColor]];
    [userInfoButton.layer setBorderWidth:1.0f];
    [userInfoButton.layer setBorderColor:HPO_BROWN.CGColor];
    [self.view addSubview:userInfoButton];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
