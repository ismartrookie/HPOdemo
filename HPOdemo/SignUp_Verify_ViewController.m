//
//  SignUp_Verify_ViewController.m
//  HPOdemo
//
//  Created by Gueie on 14-2-8.
//  Copyright (c) 2014年 Gueie. All rights reserved.
//

#import "SignUp_Verify_ViewController.h"
#import "SignUp_Info_ViewController.h"

@interface SignUp_Verify_ViewController ()
{
    UITextField *verifyTextField;
    UITextField *passwordTextField;
}

@property (strong, nonatomic) UILabel *telLabel;

@end

@implementation SignUp_Verify_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.titleLabel setText:@"注册"];
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setFrame:CGRectMake(253, 29, 58, 28)];
    [nextButton setBackgroundColor:[UIColor clearColor]];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [nextButton.layer setCornerRadius:3.0f];
    [nextButton.layer setMasksToBounds:YES];
    [nextButton.layer setBorderWidth:1.0f];
    [nextButton.layer setBorderColor:[[UIColor colorWithRed:0 / 255.0f green:188 / 255.0f blue:118 / 255.0f alpha:1.0f] CGColor]];
    [nextButton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:nextButton];
    [self.navigationItem setRightBarButtonItem:rightBarButtonItem];
    
    UILabel *tipLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(16, 78, 100, 20)];
    [tipLabel1 setText:@"我们已经发送"];
    [tipLabel1 setTextColor:[UIColor darkGrayColor]];
    [tipLabel1 setFont:[UIFont systemFontOfSize:16.0f]];
    [self.view addSubview:tipLabel1];
    
    UILabel *tipLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(16 + 96, 77, 85, 20)];
    [tipLabel2 setText:@"验证码短信"];
    [tipLabel2 setTextColor:HPO_GREEN];
    [tipLabel2 setFont:[UIFont boldSystemFontOfSize:17.0f]];
    [self.view addSubview:tipLabel2];
    
    UILabel *tipLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(16 + 96 + 85, 78, 100, 20)];
    [tipLabel3 setText:@"到这个号码"];
    [tipLabel3 setTextColor:[UIColor darkGrayColor]];
    [tipLabel3 setFont:[UIFont systemFontOfSize:16.0f]];
    [self.view addSubview:tipLabel3];
    
    self.telLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 103, 150, 20)];
    [self.telLabel setText:@"+86 138 888 88888"];
    [self.telLabel setTextColor:[UIColor darkGrayColor]];
    [self.telLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [self.view addSubview:self.telLabel];
    
    UIView *textBGView = [[UIView alloc] initWithFrame:CGRectMake(-5, 132, 330, 88)];
    [textBGView setBackgroundColor:[UIColor whiteColor]];
    [textBGView.layer setBorderWidth:1.0f];
    [textBGView.layer setBorderColor:[[UIColor colorWithRed:235 / 255.0f green:232 / 255.0f blue:221 / 255.0f alpha:1.0f] CGColor]];
    [self.view addSubview:textBGView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(320 - 265, 44, 270, 1)];
    [lineView setBackgroundColor:[UIColor colorWithRed:235 / 255.0f green:232 / 255.0f blue:221 / 255.0f alpha:1.0f]];
    [textBGView addSubview:lineView];
    
    UIImageView *verifyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 14, 28, 15)];
    [verifyImageView setImage:[UIImage imageNamed:@"verify"]];
    [textBGView addSubview:verifyImageView];
    
    UIImageView *passwordImageView = [[UIImageView alloc] initWithFrame:CGRectMake(18, 55, 17, 21)];
    [passwordImageView setImage:[UIImage imageNamed:@"password"]];
    [textBGView addSubview:passwordImageView];
    
    verifyTextField = [[UITextField alloc] initWithFrame:CGRectMake(55, 13, 175, 22)];
    [verifyTextField setTextColor:[UIColor darkGrayColor]];
    [verifyTextField setPlaceholder:@"输入验证码"];
    [verifyTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [textBGView addSubview:verifyTextField];
    
    passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(55, 56, 250, 22)];
    [passwordTextField setTextColor:[UIColor darkGrayColor]];
    [passwordTextField setPlaceholder:@"设置登录用密码"];
    [textBGView addSubview:passwordTextField];
    
    UIButton *resendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [resendButton setFrame:CGRectMake(237, 8, 74, 28)];
    [resendButton setBackgroundColor:[UIColor whiteColor]];
    [resendButton setTitle:@"重新发送" forState:UIControlStateNormal];
    [resendButton setTitleColor:HPO_GREEN forState:UIControlStateNormal];
    [resendButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [resendButton.layer setCornerRadius:3.0f];
    [resendButton.layer setMasksToBounds:YES];
    [resendButton.layer setBorderWidth:1.0f];
    [resendButton.layer setBorderColor:[[UIColor colorWithRed:235 / 255.0f green:232 / 255.0f blue:221 / 255.0f alpha:1.0f] CGColor]];
    [resendButton addTarget:self action:@selector(resend) forControlEvents:UIControlEventTouchUpInside];
    [textBGView addSubview:resendButton];
}

- (void)resend
{
    
}

- (void)next
{
    SignUp_Info_ViewController *suiVC = [[SignUp_Info_ViewController alloc] init];
    [self.navigationController pushViewController:suiVC animated:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if ([verifyTextField isFirstResponder] || [passwordTextField isFirstResponder]) {
        [verifyTextField resignFirstResponder];
        [passwordTextField resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
