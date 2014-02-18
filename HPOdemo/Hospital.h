//
//  Hospital.h
//  HPOdemo
//
//  Created by Gueie on 14-2-16.
//  Copyright (c) 2014年 Gueie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hospital : NSObject

@property (strong, nonatomic) NSString *abbr;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *district;
@property (strong, nonatomic) NSString *id_No;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *phoneArray;
@property (strong, nonatomic) NSString *province;
@property (strong, nonatomic) NSString *website;

@end
