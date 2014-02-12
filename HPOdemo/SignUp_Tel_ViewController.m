//
//  SignUp_Tel_ViewController.m
//  HPOdemo
//
//  Created by Gueie on 14-2-8.
//  Copyright (c) 2014年 Gueie. All rights reserved.
//

#import "SignUp_Tel_ViewController.h"
#import "SignUp_Verify_ViewController.h"

@interface SignUp_Tel_ViewController ()
{
    UITextField *telTextField;
}

@end

@implementation SignUp_Tel_ViewController

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
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 78, 150, 20)];
    [tipLabel setText:@"请输入您的手机号"];
    [tipLabel setTextColor:[UIColor darkGrayColor]];
    [tipLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [self.view addSubview:tipLabel];
    
    UIView *textBGView = [[UIView alloc] initWithFrame:CGRectMake(-5, 110, 330, 44)];
    [textBGView setBackgroundColor:[UIColor whiteColor]];
    [textBGView.layer setBorderWidth:1.0f];
    [textBGView.layer setBorderColor:[[UIColor colorWithRed:235 / 255.0f green:232 / 255.0f blue:221 / 255.0f alpha:1.0f] CGColor]];
    [self.view addSubview:textBGView];
    
    UIImageView *phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(22, 11, 15, 22)];
    [phoneImageView setImage:[UIImage imageNamed:@"phone"]];
    [textBGView addSubview:phoneImageView];
    
    telTextField = [[UITextField alloc] initWithFrame:CGRectMake(55, 11, 260, 22)];
    [telTextField setTextColor:[UIColor darkGrayColor]];
    [telTextField setPlaceholder:@"输入手机号"];
    [telTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [textBGView addSubview:telTextField];
}

- (void)next
{
    [SVProgressHUD show];
    [SMHPO_HTTP_Pool SMHPO_verify_code_PhoneNum:@"18612259290" withSuccess:^(id resp) {
        int result = [[resp objectForKey:@"result"] intValue];
        //请求成功
        if (result == 1) {
            NSLog(@"resp = %@",resp);
            SignUp_Verify_ViewController *suvVC = [[SignUp_Verify_ViewController alloc] init];
            [self.navigationController pushViewController:suvVC animated:YES];
            [suvVC setPhoneNum:@"18612259290"];
            [suvVC setHashed_code:[NSString stringWithFormat:@"%@",[resp objectForKey:@"hashed_code"]]];
            [SVProgressHUD dismiss];
        //异常标记
        } else {
            [SVProgressHUD dismissWithError:[resp objectForKey:@"message"] afterDelay:1];
        }
    } withFailure:^(id error) {
        [SVProgressHUD dismissWithError:error afterDelay:2];
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if ([telTextField isFirstResponder]) {
        [telTextField resignFirstResponder];
    }
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
