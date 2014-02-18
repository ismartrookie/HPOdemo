//
//  UserInfo.m
//  HPOdemo
//
//  Created by Gueie on 14-2-14.
//  Copyright (c) 2014年 Gueie. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

- (void)encodeWithCoder:(NSCoder *)encoder
{
	[encoder encodeObject:self.mobilephone      forKey:@"mobilephone"];
    [encoder encodeObject:self.password         forKey:@"password"];
    [encoder encodeObject:self.real_name        forKey:@"real_name"];
    [encoder encodeObject:self.id_number        forKey:@"id_number"];
    [encoder encodeObject:self.gender           forKey:@"gender"];
    [encoder encodeObject:self.birthday         forKey:@"birthday"];
    [encoder encodeObject:self.address          forKey:@"address"];
    [encoder encodeObject:self.age              forKey:@"age"];
    [encoder encodeObject:self.avatar           forKey:@"avatar"];
    [encoder encodeObject:self.education        forKey:@"education"];
    [encoder encodeObject:self.marital_status   forKey:@"marital_status"];
    [encoder encodeObject:self.job              forKey:@"job"];
    [encoder encodeObject:self.nation           forKey:@"nation"];
    [encoder encodeObject:self.nationality      forKey:@"nationality"];
    [encoder encodeObject:self.province         forKey:@"province"];
}

- (id)initWithCoder:(NSCoder *)decoder {
	if ( (self = [super init]) ) {
        self.mobilephone    = [decoder decodeObjectForKey:@"mobilephone"];
        self.password       = [decoder decodeObjectForKey:@"password"];
        self.real_name      = [decoder decodeObjectForKey:@"real_name"];
        self.id_number      = [decoder decodeObjectForKey:@"id_number"];
        self.gender         = [decoder decodeObjectForKey:@"gender"];
        self.birthday       = [decoder decodeObjectForKey:@"birthday"];
        self.address        = [decoder decodeObjectForKey:@"address"];
        self.age            = [decoder decodeObjectForKey:@"age"];
        self.avatar         = [decoder decodeObjectForKey:@"avatar"];
        self.education      = [decoder decodeObjectForKey:@"education"];
        self.marital_status = [decoder decodeObjectForKey:@"marital_status"];
        self.job            = [decoder decodeObjectForKey:@"job"];
        self.nation         = [decoder decodeObjectForKey:@"nation"];
        self.nationality    = [decoder decodeObjectForKey:@"nationality"];
        self.province       = [decoder decodeObjectForKey:@"province"];
    }
    return self;
}

@end
