//
//  URLApi.m
//  tuoke
//
//  Created by 3Vjia on 15/9/15.
//  Copyright (c) 2015年 3Vjia. All rights reserved.
//

#import "URLApi.h"

@implementation URLApi

+(NSString *)requestURL
{
    return @"http://passport.admin.3weijia.com/MNMNH.axd";
}

+(NSString *)readAuthCodeString
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString *authCode = [userDefaultes stringForKey:@"AuthCode"];
    return authCode;
}

+(NSString *)imageURL
{
    return @"http://passport.admin.3weijia.com";
}

+(NSString *) storeUrl
{
    return @"http://www.3vjia.com";
}
@end
