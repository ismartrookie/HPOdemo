//
//  SignUp_Verify_ViewController.h
//  HPOdemo
//
//  Created by Gueie on 14-2-8.
//  Copyright (c) 2014年 Gueie. All rights reserved.
//

#import "HPONavigationViewController.h"

@interface SignUp_Verify_ViewController : HPONavigationViewController

@property (copy, nonatomic) NSString *phoneNum;
@property (copy, nonatomic) NSString *hashed_code;
@property (copy, nonatomic) NSString *password;

@end
