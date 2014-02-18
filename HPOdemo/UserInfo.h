//
//  UserInfo.h
//  HPOdemo
//
//  Created by Gueie on 14-2-14.
//  Copyright (c) 2014年 Gueie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject<NSCoding>

@property (copy, nonatomic) NSString *mobilephone;          //  手机号
@property (copy, nonatomic) NSString *password;             //  密码
@property (copy, nonatomic) NSString *real_name;            //  姓名
@property (copy, nonatomic) NSString *id_number;            //  身份证号
@property (copy, nonatomic) NSString *gender;               //  性别
@property (copy, nonatomic) NSString *birthday;             //  生日
@property (copy, nonatomic) NSString *address;              //  联系地址
@property (copy, nonatomic) NSString *age;                  //  年龄
@property (copy, nonatomic) NSString *avatar;               //  头像URL
@property (copy, nonatomic) NSString *education;            //  教育程度
@property (copy, nonatomic) NSString *marital_status;       //  婚姻状况
@property (copy, nonatomic) NSString *job;                  //  工作
@property (copy, nonatomic) NSString *nation;               //  国家
@property (copy, nonatomic) NSString *nationality;          //  民族
@property (copy, nonatomic) NSString *province;             //  省份


@end
