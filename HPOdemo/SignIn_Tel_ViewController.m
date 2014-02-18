//
//  SignIn_Tel_ViewController.m
//  HPOdemo
//
//  Created by Gueie on 14-2-9.
//  Copyright (c) 2014年 Gueie. All rights reserved.
//

#import "SignIn_Tel_ViewController.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "FormatCheck.h"
#import "UserInfo.h"

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
    [signInButton addTarget:self action:@selector(signIn) forControlEvents:UIControlEventTouchUpInside];
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
    [passwordTextField setSecureTextEntry:YES];
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
    BOOL isMobileNumber = [FormatCheck isMobileNumber:telTextField.text];
    BOOL isPasswordEmpty = [passwordTextField.text isEqualToString:@""];
    
    if (isMobileNumber && !isPasswordEmpty) {
        if ([telTextField isFirstResponder] || [passwordTextField isFirstResponder]) {
            [telTextField resignFirstResponder];
            [passwordTextField resignFirstResponder];
        }
        
        [self requestSignIn];
    } else if (!isMobileNumber) {
        [SVProgressHUD showErrorWithStatus:@"请检查手机号码是否正确" duration:1.5f];
    } else if (isPasswordEmpty) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码" duration:1.5f];
    }
}

- (void)requestSignIn
{
    [SVProgressHUD show];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://115.28.3.92:8000/login?mobilephone=%@&password=%@", telTextField.text, passwordTextField.text]]];
    
    [urlRequest addValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [urlRequest setTimeoutInterval:10.0f];
    
    AFHTTPRequestOperation *httpRequest = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    
    [httpRequest setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                    options:NSJSONReadingAllowFragments
                                                                      error:nil];
        
        int result = [[responseDic objectForKey:@"result"] intValue];
        
        NSString *sessionId = [self analysisSessionId:[[operation.response allHeaderFields] objectForKey:@"Set-Cookie"]];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:sessionId forKey:@"cookie"];
        [userDefaults synchronize];
        
        if (result == 1) {
            [self requestUserInfo];
        } else {
           [SVProgressHUD showErrorWithStatus:[responseDic objectForKey:@"message"] duration:1.5f];
        }
    }
                                       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                           [SVProgressHUD dismissWithError:@"网络异常" afterDelay:2];
                                       }];
    
    [httpRequest start];
}

- (void)requestUserInfo
{
    [SVProgressHUD show];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *sessionId = [userDefaults objectForKey:@"cookie"];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://115.28.3.92:8000/userinfo"]];
    
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
            [self saveUserInfo:[responseDic objectForKey:@"user_info"]];
            
            [self dismissViewControllerAnimated:YES completion:NULL];
        } else {
            [SVProgressHUD showErrorWithStatus:[responseDic objectForKey:@"message"] duration:1.5f];
        }
    }
                                       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                           [SVProgressHUD dismissWithError:@"网络异常" afterDelay:2];
                                       }];
    
    [httpRequest start];
}

- (void)saveUserInfo:(NSDictionary *)userInfoDic
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    UserInfo *userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"userInfo"]];
    
    if (userInfo == nil) {
        userInfo = [[UserInfo alloc] init];
    }
    
    [userInfo setMobilephone:telTextField.text];
    [userInfo setPassword:passwordTextField.text];
    [userInfo setReal_name:     [userInfoDic objectForKey:@"real_name"]];
    [userInfo setId_number:     [userInfoDic objectForKey:@"id_number"]];
    [userInfo setGender:        [userInfoDic objectForKey:@"gender"]];
    [userInfo setBirthday:      [userInfoDic objectForKey:@"birthday"]];
    [userInfo setAddress:       [userInfoDic objectForKey:@"address"]];
    [userInfo setAge:           [userInfoDic objectForKey:@"age"]];
    [userInfo setAvatar:        [userInfoDic objectForKey:@"avatar"]];
    [userInfo setEducation:     [userInfoDic objectForKey:@"education"]];
    [userInfo setMarital_status:[userInfoDic objectForKey:@"marital_status"]];
    [userInfo setJob:           [userInfoDic objectForKey:@"job"]];
    [userInfo setNation:        [userInfoDic objectForKey:@"nation"]];
    [userInfo setNationality:   [userInfoDic objectForKey:@"nationality"]];
    [userInfo setProvince:      [userInfoDic objectForKey:@"province"]];
    
    [userDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:userInfo] forKey:@"userInfo"];
    [userDefaults synchronize];
}

- (NSString *)analysisSessionId:(NSString *)code
{
    int endIndex = [code rangeOfString:@";"].location;
    
    NSString *sessionId = [code substringToIndex:endIndex];
    
    return sessionId;
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
