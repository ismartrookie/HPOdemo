//
//  HomeViewController.m
//  HPOdemo
//
//  Created by Gueie on 14-1-24.
//  Copyright (c) 2014年 Gueie. All rights reserved.
//

#import "HomeViewController.h"
#import "SignUp_Tel_ViewController.h"
#import "SignIn_Tel_ViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

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
    [self.view setBackgroundColor:HPO_LINEN];
    
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((320 - 217) / 2.0f, 125, 217, 69)];
    [logoImageView setImage:[UIImage imageNamed:@"logo"]];
    [self.view addSubview:logoImageView];
    
    UIButton *signInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [signInButton setFrame:CGRectMake(16, self.view.bounds.size.height - 120, 288, 44)];
    [signInButton setBackgroundColor:HPO_GREEN];
    [signInButton setTitle:@"登录" forState:UIControlStateNormal];
    [signInButton addTarget:self action:@selector(signIn) forControlEvents:UIControlEventTouchUpInside];
    [signInButton setShowsTouchWhenHighlighted:YES];
    [signInButton.layer setCornerRadius:4.0f];
    [signInButton.layer setShadowColor:[[UIColor darkGrayColor] CGColor]];
    [signInButton.layer setShadowOffset:CGSizeMake(0, 1.0f)];
    [signInButton.layer setShadowRadius:1.0f];
    [signInButton.layer setShadowOpacity:1.0f];
    [self.view addSubview:signInButton];
    
    UIButton *signUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [signUpButton setFrame:CGRectMake(16, self.view.bounds.size.height - 120 + 44 + 14, 288, 44)];
    [signUpButton setBackgroundColor:[UIColor whiteColor]];
    [signUpButton setTitle:@"注册" forState:UIControlStateNormal];
    [signUpButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [signUpButton addTarget:self action:@selector(signUp) forControlEvents:UIControlEventTouchUpInside];
    [signUpButton setShowsTouchWhenHighlighted:YES];
    [signUpButton.layer setCornerRadius:4.0f];
    [signUpButton.layer setShadowColor:[[UIColor grayColor] CGColor]];
    [signUpButton.layer setShadowOffset:CGSizeMake(0, 1.0f)];
    [signUpButton.layer setShadowRadius:1.0f];
    [signUpButton.layer setShadowOpacity:1.0f];
    [self.view addSubview:signUpButton];
}

- (void)signIn
{
    NSLog(@"login");
    
    SignIn_Tel_ViewController *sitVC = [[SignIn_Tel_ViewController alloc] init];
    [self.navigationController pushViewController:sitVC animated:YES];
}

- (void)signUp
{
    SignUp_Tel_ViewController *sutVC = [[SignUp_Tel_ViewController alloc] init];
    [self.navigationController pushViewController:sutVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
