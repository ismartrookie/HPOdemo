//
//  SMHPO_HTTP_Pool.m
//  HPOdemo
//
//  Created by administrator on 14-2-10.
//  Copyright (c) 2014年 Gueie. All rights reserved.
//

#import "SMHPO_HTTP_Pool.h"
#import "AFNetworking.h"

@implementation SMHPO_HTTP_Pool


+ (void)SMHPO_verify_code_PhoneNum:(NSString *)phone withSuccess:(success)success withFailure:(failure)failure
{
    NSString *urlStr = [NSString stringWithFormat:@"http://115.28.3.92:8000/verify_code?phone=%@&session_id=123",phone];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *httpRequest = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    [httpRequest setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *respDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:Nil];
        if (success) {
            success(respDic);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    [httpRequest start];
}

@end
