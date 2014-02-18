//
//  AddPatientViewController.m
//  HPOdemo
//
//  Created by Gueie on 14-2-12.
//  Copyright (c) 2014年 Gueie. All rights reserved.
//

#import "AddPatientViewController.h"

@interface AddPatientViewController ()
{
    UITextField *nameTextField;
    UITextField *idCardTextField;
    UITextField *telNoTextField;
}

@end

@implementation AddPatientViewController

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
    
    [self.titleLabel setText:@"新增就诊人"];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 82, 320, 15)];
    [tipLabel setText:@"提交前请核对输入的信息，提交之后不可更改"];
    [tipLabel setTextColor:[UIColor grayColor]];
    [tipLabel setTextAlignment:NSTextAlignmentCenter];
    [tipLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [self.view addSubview:tipLabel];
    
    UIView *personInfoBGView = [[UIView alloc] initWithFrame:CGRectMake(16, 113, 288, 132)];
    [personInfoBGView setBackgroundColor:[UIColor whiteColor]];
    [personInfoBGView.layer setCornerRadius:3.0f];
    [personInfoBGView.layer setMasksToBounds:YES];
    [personInfoBGView.layer setBorderWidth:1.0f];
    [personInfoBGView.layer setBorderColor:HPO_BROWN.CGColor];
    [self.view addSubview:personInfoBGView];
    
    UIView *uselessView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 288, 44)];
    [uselessView.layer setBorderWidth:1.0f];
    [uselessView.layer setBorderColor:HPO_LINEN.CGColor];
    [personInfoBGView addSubview:uselessView];
    
    for (int i = 0; i < 3; i++) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 44 * i, 85, 44)];
        [titleLabel setTextAlignment:NSTextAlignmentRight];
        [titleLabel setFont:[UIFont systemFontOfSize:15.5f]];
        [personInfoBGView addSubview:titleLabel];
        
        switch (i) {
            case 0:
                [titleLabel setText:@"姓名:"];
                break;
            case 1:
                [titleLabel setText:@"身份证号:"];
                break;
            case 2:
                [titleLabel setText:@"手机号:"];
                break;
                
            default:
                break;
        }
    }
    
    nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(98, 1, 180, 44)];
    [nameTextField setPlaceholder:@"请输入就诊人姓名"];
    [nameTextField setTextColor:[UIColor darkGrayColor]];
    [personInfoBGView addSubview:nameTextField];
    
    idCardTextField = [[UITextField alloc] initWithFrame:CGRectMake(98, 45, 180, 44)];
    [idCardTextField setPlaceholder:@"请输入身份证号"];
    [idCardTextField setTextColor:[UIColor darkGrayColor]];
    [personInfoBGView addSubview:idCardTextField];
    
    telNoTextField = [[UITextField alloc] initWithFrame:CGRectMake(98, 90, 180, 44)];
    [telNoTextField setPlaceholder:@"请输入手机号"];
    [telNoTextField setTextColor:[UIColor darkGrayColor]];
    [telNoTextField setKeyboardType:UIKeyboardTypePhonePad];
    [personInfoBGView addSubview:telNoTextField];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setFrame:CGRectMake(16, 259, 288, 44)];
    [submitButton setBackgroundColor:HPO_GREEN];
    [submitButton setTitle:@"添加完成" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitButton.titleLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
    [submitButton.layer setCornerRadius:3.0f];
    [submitButton.layer setMasksToBounds:YES];
    [self.view addSubview:submitButton];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if ([nameTextField isFirstResponder] || [idCardTextField isFirstResponder] || [telNoTextField isFirstResponder]) {
        [nameTextField resignFirstResponder];
        [idCardTextField resignFirstResponder];
        [telNoTextField resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
