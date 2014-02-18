//
//  FormatCheck.h
//  HPOdemo
//
//  Created by Gueie on 14-2-13.
//  Copyright (c) 2014年 Gueie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FormatCheck : NSObject

+ (BOOL)isMobileNumber:(NSString *)mobileNum;
+ (BOOL) isIdCardNumber:(NSString *)idCardNumber;

@end
