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


+ (void)SMHPO_verify_code_PhoneNum:(NSString *)phone withSuccess:(success)success withFailure:(failure)failure;


@end
