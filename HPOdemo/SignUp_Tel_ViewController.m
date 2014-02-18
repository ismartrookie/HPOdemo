//
//  SignUp_Tel_ViewController.m
//  HPOdemo
//
//  Created by Gueie on 14-2-8.
//  Copyright (c) 2014年 Gueie. All rights reserved.
//

#import "SignUp_Tel_ViewController.h"
#import "SignUp_Verify_ViewController.h"
#import "FormatCheck.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"

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
    BOOL isMobileNo = [FormatCheck isMobileNumber:telTextField.text];
    
    if (isMobileNo) {
        if ([telTextField isFirstResponder]) {
            [telTextField resignFirstResponder];
        }
        
        [self requestVerifyCode];
    } else {
        [SVProgressHUD showErrorWithStatus:@"请检查手机号码是否正确" duration:1.5f];
    }
}

- (void)requestVerifyCode
{
    [SVProgressHUD show];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://115.28.3.92:8000/verify_code?phone=%@",telTextField.text]]];
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
        
        NSString *hashCode = [responseDic objectForKey:@"hashed_code"];
        
        NSLog(@"hashCode = %@", hashCode);
        
        if (result == 1) {
            SignUp_Verify_ViewController *suvVC = [[SignUp_Verify_ViewController alloc] init];
            [self.navigationController pushViewController:suvVC animated:YES];
            
            [suvVC setPhoneNumber:telTextField.text];
        } else {
            [SVProgressHUD showErrorWithStatus:[responseDic objectForKey:@"message"] duration:1.5f];
        }
    }
                                       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                           [SVProgressHUD dismissWithError:@"网络异常" afterDelay:2];
                                       }];
    
    [httpRequest start];
}

- (NSString *)analysisSessionId:(NSString *)code
{
    int endIndex = [code rangeOfString:@";"].location;
    
    NSString *sessionId = [code substringToIndex:endIndex];
    
    NSLog(@"%@", sessionId);
    
    return sessionId;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if ([telTextField isFirstResponder]) {
        [telTextField resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
