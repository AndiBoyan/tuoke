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
///http://passport.admin.3weijia.com/UpFile/C00000098/Platform/ShopInfo/201509//f6be8dcf-f963-4b63-bbf0-7269b3ca3b48.png
+(NSString *)readAuthCodeString
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString *authCode = [userDefaultes stringForKey:@"AuthCode"];
    return authCode;
}
@end
