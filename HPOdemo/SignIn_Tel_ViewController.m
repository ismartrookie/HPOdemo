//
//  SignIn_Tel_ViewController.m
//  HPOdemo
//
//  Created by Gueie on 14-2-9.
//  Copyright (c) 2014年 Gueie. All rights reserved.
//

#import "SignIn_Tel_ViewController.h"

@interface SignIn_Tel_ViewController ()
{
    UITextField *telTextField;
    UITextField *passwordTextField;
}

@end

@implementation SignIn_Tel_ViewController

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
    
    [self.titleLabel setText:@"登录"];
    
    UIButton *signInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [signInButton setFrame:CGRectMake(253, 29, 47, 28)];
    [signInButton setBackgroundColor:[UIColor clearColor]];
    [signInButton setTitle:@"登录" forState:UIControlStateNormal];
    [signInButton.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [signInButton.layer setCornerRadius:3.0f];
    [signInButton.layer setMasksToBounds:YES];
    [signInButton.layer setBorderWidth:1.0f];
    [signInButton.layer setBorderColor:[[UIColor colorWithRed:0 / 255.0f green:188 / 255.0f blue:118 / 255.0f alpha:1.0f] CGColor]];
    [signInButton addTarget:self action:@selector(signIn) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:signInButton];
    [self.navigationItem setRightBarButtonItem:rightBarButtonItem];
    
    UIView *textBGView = [[UIView alloc] initWithFrame:CGRectMake(-5, 86, 330, 88)];
    [textBGView setBackgroundColor:[UIColor whiteColor]];
    [textBGView.layer setBorderWidth:1.0f];
    [textBGView.layer setBorderColor:[[UIColor colorWithRed:235 / 255.0f green:232 / 255.0f blue:221 / 255.0f alpha:1.0f] CGColor]];
    [self.view addSubview:textBGView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(320 - 265, 44, 270, 1)];
    [lineView setBackgroundColor:[UIColor colorWithRed:235 / 255.0f green:232 / 255.0f blue:221 / 255.0f alpha:1.0f]];
    [textBGView addSubview:lineView];
    
    UIImageView *phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(22, 11, 15, 22)];
    [phoneImageView setImage:[UIImage imageNamed:@"phone"]];
    [textBGView addSubview:phoneImageView];
    
    UIImageView *passwordImageView = [[UIImageView alloc] initWithFrame:CGRectMake(21, 55, 17, 21)];
    [passwordImageView setImage:[UIImage imageNamed:@"password"]];
    [textBGView addSubview:passwordImageView];
    
    telTextField = [[UITextField alloc] initWithFrame:CGRectMake(55, 13, 175, 22)];
    [telTextField setTextColor:[UIColor darkGrayColor]];
    [telTextField setPlaceholder:@"手机号"];
    [telTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [textBGView addSubview:telTextField];
    
    passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(55, 56, 250, 22)];
    [passwordTextField setTextColor:[UIColor darkGrayColor]];
    [passwordTextField setPlaceholder:@"登录密码"];
    [textBGView addSubview:passwordTextField];
    
    UIButton *lostButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [lostButton setFrame:CGRectMake(120, 190, 80, 15)];
    [lostButton setTitle:@"忘记密码了？" forState:UIControlStateNormal];
    [lostButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [lostButton.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [lostButton setShowsTouchWhenHighlighted:YES];
    [self.view addSubview:lostButton];
}

- (void)signIn
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if ([telTextField isFirstResponder] || [passwordTextField isFirstResponder]) {
        [telTextField resignFirstResponder];
        [passwordTextField resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
