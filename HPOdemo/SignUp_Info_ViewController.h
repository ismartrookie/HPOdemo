//
//  SignUp_Info_ViewController.h
//  HPOdemo
//
//  Created by Gueie on 14-2-8.
//  Copyright (c) 2014年 Gueie. All rights reserved.
//

#import "HPONavigationViewController.h"

@interface SignUp_Info_ViewController : HPONavigationViewController

@property (copy, nonatomic) NSString *phoneNum;
@property (copy, nonatomic) NSString *hashed_code;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *idCard;
@property (copy, nonatomic) NSString *password;
@property (assign, nonatomic) int     sex;

@end
