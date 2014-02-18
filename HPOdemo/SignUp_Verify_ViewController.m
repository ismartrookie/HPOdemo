//
//  SignUp_Verify_ViewController.m
//  HPOdemo
//
//  Created by Gueie on 14-2-8.
//  Copyright (c) 2014年 Gueie. All rights reserved.
//

#import "SignUp_Verify_ViewController.h"
#import "SignUp_Info_ViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "UserInfo.h"

@interface SignUp_Verify_ViewController ()
{
    UILabel *telLabel;
    UITextField *verifyTextField;
    UITextField *passwordTextField;
    
    UIButton *resendButton;
}

@end

@implementation SignUp_Verify_ViewController

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
    
    telLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 103, 150, 20)];
    [telLabel setText:self.phoneNumber];
    [telLabel setTextColor:[UIColor darkGrayColor]];
    [telLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [self.view addSubview:telLabel];
    
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
    [passwordTextField setSecureTextEntry:YES];
    [textBGView addSubview:passwordTextField];
    
    resendButton = [UIButton buttonWithType:UIButtonTypeCustom];
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
    
    [self countDown];
}

- (void)setPhoneNumber:(NSString *)phoneNumber
{
    _phoneNumber = phoneNumber;
    
    [telLabel setText:phoneNumber];
}

- (void)resend
{
    [self requestVerifyCode];
    [self countDown];
}

- (void)countDown
{
    __block int timeout = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0f * NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        if (timeout <= 0) { //倒计时结束，关闭
            dispatch_source_cancel(_timer);
        } else {
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:@"%2d秒后重发", seconds];
            
            [resendButton.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
            [resendButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [resendButton setEnabled:NO];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [resendButton setTitle:strTime forState:UIControlStateNormal];
            });
            
            timeout--;
        }
    });
    
    dispatch_source_set_cancel_handler(_timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            //设置界面的按钮显示 根据自己需求设置
            [resendButton setTitle:@"重新发送" forState:UIControlStateNormal];
            [resendButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
            [resendButton setTitleColor:HPO_GREEN forState:UIControlStateNormal];
            [resendButton setEnabled:YES];
        });
    });
    
    dispatch_resume(_timer);
}

- (void)next
{
    if (verifyTextField.text.length != 6) {
        [SVProgressHUD showErrorWithStatus:@"请检查验证码输入是否正确" duration:1.5f];
    } else if (passwordTextField.text.length < 6) {
        [SVProgressHUD showErrorWithStatus:@"密码长度不得小于6位" duration:1.5f];
    } else {
        if ([passwordTextField isFirstResponder]) {
            [passwordTextField resignFirstResponder];
        }
        
        [self requestSignUp];
    }
}

- (void)requestVerifyCode
{
    [SVProgressHUD show];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://115.28.3.92:8000/verify_code?phone=%@",self.phoneNumber]]];
    [urlRequest addValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [urlRequest setTimeoutInterval:10.0f];
    
    AFHTTPRequestOperation *httpRequest = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    
    [httpRequest setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                    options:NSJSONReadingAllowFragments
                                                                      error:nil];
        
        int result = [[responseDic objectForKey:@"result"] intValue];
        
        if (result == 1) {
            NSString *hashCode = [responseDic objectForKey:@"hashed_code"];
            NSLog(@"hashCode = %@", hashCode);
        } else {
            [SVProgressHUD showErrorWithStatus:[responseDic objectForKey:@"message"] duration:1.5f];
        }
    }
                                       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                           [SVProgressHUD dismissWithError:@"网络异常" afterDelay:2];
                                       }];
    
    [httpRequest start];
}

- (void)requestSignUp
{
    [SVProgressHUD show];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *sessionId = [userDefaults objectForKey:@"cookie"];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://115.28.3.92:8000/signup?password=%@&verify_code=%@", passwordTextField.text, verifyTextField.text]]];
    
    [urlRequest addValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [urlRequest addValue:sessionId forHTTPHeaderField:@"Cookie"];
    [urlRequest setTimeoutInterval:10.0f];
    
    AFHTTPRequestOperation *httpRequest = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    
    [httpRequest setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                    options:NSJSONReadingAllowFragments
                                                                      error:nil];
        
        int result = [[responseDic objectForKey:@"result"] intValue];
        
        if (result == 1) {
            [SVProgressHUD showSuccessWithStatus:[responseDic objectForKey:@"message"] duration:1.5f];
            
            [self saveUserInfo];
            
            SignUp_Info_ViewController *suiVC = [[SignUp_Info_ViewController alloc] init];
            [self.navigationController pushViewController:suiVC animated:YES];
            
            [suiVC setPhoneNumber:self.phoneNumber];
            [suiVC setPassword:passwordTextField.text];
        } else {
            [SVProgressHUD showErrorWithStatus:[responseDic objectForKey:@"message"] duration:1.5f];
        }
        
    }
                                       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                           [SVProgressHUD dismissWithError:@"网络异常" afterDelay:2];
                                       }];
    
    [httpRequest start];
}

- (void)saveUserInfo
{
    UserInfo *userInfo = [[UserInfo alloc] init];
    [userInfo setMobilephone:self.phoneNumber];
    [userInfo setPassword:passwordTextField.text];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:userInfo] forKey:@"userInfo"];
    [userDefaults synchronize];
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
