//
//  SMHPO_HTTP_Pool.h
//  HPOdemo
//
//  Created by administrator on 14-2-10.
//  Copyright (c) 2014年 Gueie. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^success)(id resp);
typedef void (^failure)(id error);


@interface SMHPO_HTTP_Pool : NSObject

/**
 *  获取验证码
 *
 *  @param phone   电话
 *  @param success 成功返回值
 *  @param failure 失败返回值
 */
+ (void)SMHPO_verify_code_PhoneNum:(NSString *)phone withSuccess:(success)success withFailure:(failure)failure;

/**
 *  客户端通过手机注册帐号
 *
 *  @param name        姓名
 *  @param pwd         密码
 *  @param phone       电话
 *  @param verify_code 验证码
 *  @param success     成功返回值
 *  @param failure     失败返回值
 */
+ (void)SMHPO_signup_Name:(NSString *)name withPassword:(NSString *)pwd withPhone:(NSString *)phone withVerify_code:(NSString *)verify_code withSuccess:(success)success withFailure:(failure)failure;

@end
