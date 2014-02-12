//
//  SignUp_Info_ViewController.m
//  HPOdemo
//
//  Created by Gueie on 14-2-8.
//  Copyright (c) 2014年 Gueie. All rights reserved.
//

#import "SignUp_Info_ViewController.h"

@interface SignUp_Info_ViewController ()
{
    UITextField *nameTextField;
    UITextField *idTextField;
    
    UIButton *maleButton;
    UIButton *femaleButton;
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
    [submitButton addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:submitButton];
    [self.navigationItem setRightBarButtonItem:rightBarButtonItem];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 82, 300, 20)];
    [tipLabel setText:@"请填写真是信息，一旦绑定，不可修改"];
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
    
    nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(75, 14, 250, 22)];
    [nameTextField setTextColor:[UIColor darkGrayColor]];
    [nameTextField setPlaceholder:@"请输入姓名"];
    [textBGView addSubview:nameTextField];
    
    idTextField = [[UITextField alloc] initWithFrame:CGRectMake(75, 13 + 44, 250, 22)];
    [idTextField setTextColor:[UIColor darkGrayColor]];
    [idTextField setPlaceholder:@"请输入身份证号"];
    [textBGView addSubview:idTextField];
    
    UILabel *sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(105, 100, 200, 22)];
    [sexLabel setText:@"男                  女"];
    [sexLabel setTextColor:[UIColor darkGrayColor]];
    [textBGView addSubview:sexLabel];
    
    maleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [maleButton setFrame:CGRectMake(75, 13 + 88, 20, 20)];
    [maleButton.layer setCornerRadius:10.0f];
    [maleButton.layer setMasksToBounds:YES];
    [maleButton setBackgroundColor:HPO_GREEN];
    [textBGView addSubview:maleButton];
    
    femaleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [femaleButton setFrame:CGRectMake(178, 13 + 88, 20, 20)];
    [femaleButton.layer setCornerRadius:10.0f];
    [femaleButton.layer setMasksToBounds:YES];
    [femaleButton setBackgroundColor:[UIColor lightGrayColor]];
    [textBGView addSubview:femaleButton];
    
    UIButton *passButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [passButton setFrame:CGRectMake(130, 264, 60, 15)];
    [passButton setTitle:@"下次填写" forState:UIControlStateNormal];
    [passButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [passButton.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [passButton setShowsTouchWhenHighlighted:YES];
    [self.view addSubview:passButton];
    
}

- (void)submit:(UIButton *)sender
{
    self.name = nameTextField.text;
    self.idCard = idTextField.text;
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [SMHPO_HTTP_Pool SMHPO_signup_Name:self.name withPassword:self.password withPhone:self.phoneNum withVerify_code:self.hashed_code withSuccess:^(id resp) {
        NSLog(@"resp = %@",resp);
        int result = [[resp objectForKey:@"result"] intValue];
        NSString *message = [resp objectForKey:@"message"];
        /**
         *  注册成功
         */
        if (result == 1) {
            [SVProgressHUD dismissWithSuccess:message];
        } else {
            [SVProgressHUD dismissWithError:message];
        }
    } withFailure:^(id error) {
        NSLog(@"error = %@",error);
        [SVProgressHUD dismissWithError:[error description]];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
