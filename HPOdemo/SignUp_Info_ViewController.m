//
//  SignUp_Info_ViewController.m
//  HPOdemo
//
//  Created by Gueie on 14-2-8.
//  Copyright (c) 2014年 Gueie. All rights reserved.
//

#import "SignUp_Info_ViewController.h"
#import "FormatCheck.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "UserInfo.h"

@interface SignUp_Info_ViewController ()
{
    UITextField *realNameTextField;
    UITextField *idCardTextField;
    
    UIButton *maleButton;
    UIButton *femaleButton;
    
    NSString *gender;
    NSString *birthday;
}

@end

@implementation SignUp_Info_ViewController

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
    
    [self.titleLabel setText:@"完善个人信息"];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setFrame:CGRectMake(253, 29, 47, 28)];
    [submitButton setBackgroundColor:[UIColor clearColor]];
    [submitButton setTitle:@"完成" forState:UIControlStateNormal];
    [submitButton.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [submitButton.layer setCornerRadius:3.0f];
    [submitButton.layer setMasksToBounds:YES];
    [submitButton.layer setBorderWidth:1.0f];
    [submitButton.layer setBorderColor:[[UIColor colorWithRed:0 / 255.0f green:188 / 255.0f blue:118 / 255.0f alpha:1.0f] CGColor]];
    [submitButton addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:submitButton];
    [self.navigationItem setRightBarButtonItem:rightBarButtonItem];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 82, 300, 20)];
    [tipLabel setText:@"请填写真实信息，一旦绑定，不可修改"];
    [tipLabel setTextColor:[UIColor darkGrayColor]];
    [tipLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [self.view addSubview:tipLabel];
    
    UIView *textBGView = [[UIView alloc] initWithFrame:CGRectMake(-5, 118, 330, 44 * 3)];
    [textBGView setBackgroundColor:[UIColor whiteColor]];
    [textBGView.layer setBorderWidth:1.0f];
    [textBGView.layer setBorderColor:[[UIColor colorWithRed:235 / 255.0f green:232 / 255.0f blue:221 / 255.0f alpha:1.0f] CGColor]];
    [self.view addSubview:textBGView];
    
    for (int i = 1; i < 3; i++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(76, 44 * i, 255, 1)];
        [lineView setBackgroundColor:[UIColor colorWithRed:235 / 255.0f green:232 / 255.0f blue:221 / 255.0f alpha:1.0f]];
        [textBGView addSubview:lineView];
    }
    
    for (int i = 0; i < 3; i++) {
        UILabel *noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 14 + 43 * i, 60, 22)];
        [noteLabel setTextColor:[UIColor darkGrayColor]];
        [noteLabel setTextAlignment:NSTextAlignmentRight];
        [noteLabel setFont:[UIFont systemFontOfSize:16.0f]];
        
        switch (i) {
            case 0:
                [noteLabel setText:@"姓名"];
                break;
            case 1:
                [noteLabel setText:@"身份证"];
                break;
            case 2:
                [noteLabel setText:@"性别"];
                break;
                
            default:
                break;
        }
        
        [textBGView addSubview:noteLabel];
    }
    
    realNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(75, 14, 250, 22)];
    [realNameTextField setTextColor:[UIColor darkGrayColor]];
    [realNameTextField setPlaceholder:@"请输入姓名"];
    [textBGView addSubview:realNameTextField];
    
    idCardTextField = [[UITextField alloc] initWithFrame:CGRectMake(75, 13 + 44, 250, 22)];
    [idCardTextField setTextColor:[UIColor darkGrayColor]];
    [idCardTextField setPlaceholder:@"请输入身份证号"];
    [textBGView addSubview:idCardTextField];
    
    UILabel *sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(105, 100, 200, 22)];
    [sexLabel setText:@"男                  女"];
    [sexLabel setTextColor:[UIColor darkGrayColor]];
    [textBGView addSubview:sexLabel];
    
    maleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [maleButton setFrame:CGRectMake(75, 13 + 88, 20, 20)];
    [maleButton setBackgroundImage:[UIImage imageNamed:@"circle_highlight"] forState:UIControlStateNormal];
    [maleButton addTarget:self action:@selector(selectGender:) forControlEvents:UIControlEventTouchUpInside];
    [maleButton.layer setCornerRadius:10.0f];
    [maleButton.layer setMasksToBounds:YES];
    [textBGView addSubview:maleButton];
    
    femaleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [femaleButton setFrame:CGRectMake(178, 13 + 88, 20, 20)];
    [femaleButton setBackgroundImage:[UIImage imageNamed:@"circle_normal"] forState:UIControlStateNormal];
    [femaleButton addTarget:self action:@selector(selectGender:) forControlEvents:UIControlEventTouchUpInside];
    [femaleButton.layer setCornerRadius:10.0f];
    [femaleButton.layer setMasksToBounds:YES];
    [textBGView addSubview:femaleButton];
    
    gender = @"男";
    
    UIButton *passButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [passButton setFrame:CGRectMake(130, 264, 60, 15)];
    [passButton setTitle:@"下次填写" forState:UIControlStateNormal];
    [passButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [passButton.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [passButton setShowsTouchWhenHighlighted:YES];
    [passButton addTarget:self action:@selector(passInputUserInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:passButton];
}

- (void)passInputUserInfo
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)submit
{
    NSString *idCardNumber = idCardTextField.text;
    birthday = [self analysisBirthday:idCardNumber];
    
    NSString *realName = realNameTextField.text;
    
    BOOL isIdCardNumber = [FormatCheck isIdCardNumber:idCardNumber];
    
    if (isIdCardNumber && realName.length > 2) {
        [self requestUploadUserInfo];
    } else if (!isIdCardNumber) {
        [SVProgressHUD showErrorWithStatus:@"请检查身份证号输入是否正确" duration:1.5f];
    } else if (realName.length < 2) {
        [SVProgressHUD showErrorWithStatus:@"请检查姓名输入是否正确" duration:1.5f];
    }
}

- (void)requestUploadUserInfo
{
    [SVProgressHUD show];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *sessionId = [userDefaults objectForKey:@"cookie"];
    
//    NSString *realName = realNameTextField.text;
//    NSString *idCardNumber = idCardTextField.text;
    
//    NSString *urlStr = [NSString stringWithFormat:@"http://115.28.3.92:8000/account_setting?real_name=%@&id_number=%@&gender=%@&birthday=%@", realName, idCardNumber, gender, birthday];
//    
//    NSLog(@"%@", urlStr);
//    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    
//    NSLog(@"%@", url);
//    
//    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"http://115.28.3.92:8000/account_setting?real_name=%@&id_number=%@&gender=%@&birthday=%@", realNameTextField.text, idCardTextField.text, gender, birthday] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    NSLog(@"%@", urlRequest);
    
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
            [self saveUserInfo];
            
            [self requestSignIn];
            
            [self dismissViewControllerAnimated:YES completion:NULL];
        } else {
            [SVProgressHUD showErrorWithStatus:[responseDic objectForKey:@"message"] duration:1.5f];
        }
    }
                                       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                           [SVProgressHUD dismissWithError:@"网络异常" afterDelay:2];
                                           
                                           NSLog(@"error = %@", error.description);
                                       }];
    
    [httpRequest start];
}

- (void)requestSignIn
{
    [SVProgressHUD show];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://115.28.3.92:8000/login?mobilephone=%@&password=%@", self.phoneNumber, self.password]]];
    
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

- (void)saveUserInfo
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    UserInfo *userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"userInfo"]];
    [userInfo setReal_name:realNameTextField.text];
    [userInfo setId_number:idCardTextField.text];
    [userInfo setGender:gender];
    [userInfo setBirthday:birthday];
    
    [userDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:userInfo] forKey:@"userInfo"];
    [userDefaults synchronize];
}

- (void)selectGender:(UIButton *)button
{
    if ([button isEqual:maleButton]) {
        [maleButton setBackgroundImage:[UIImage imageNamed:@"circle_highlight"] forState:UIControlStateNormal];
        [femaleButton setBackgroundImage:[UIImage imageNamed:@"circle_normal"] forState:UIControlStateNormal];
        
        gender = @"男";
    } else if ([button isEqual:femaleButton]) {
        [femaleButton setBackgroundImage:[UIImage imageNamed:@"circle_highlight"] forState:UIControlStateNormal];
        [maleButton setBackgroundImage:[UIImage imageNamed:@"circle_normal"] forState:UIControlStateNormal];
        
        gender = @"女";
    }
    
    NSLog(@"%@", [self analysisBirthday:idCardTextField.text]);
    NSLog(@"%d", [FormatCheck isIdCardNumber:idCardTextField.text]);
}

- (NSString *)analysisBirthday:(NSString *)idCardNumber
{
    NSRange birthdayRange = {6, 8};
    
    NSString *birthDay = [idCardNumber substringWithRange:birthdayRange];
    
    NSString *year = [birthDay substringToIndex:4];
    
    NSRange monthRange = {4, 2};
    NSString *month = [birthDay substringWithRange:monthRange];
    
    NSString *day = [birthDay substringFromIndex:6];
    
    birthDay = [NSString stringWithFormat:@"%@-%@-%@", year, month, day];
    
    return birthDay;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if ([realNameTextField isFirstResponder] || [idCardTextField isFirstResponder]) {
        [realNameTextField resignFirstResponder];
        [idCardTextField resignFirstResponder];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
