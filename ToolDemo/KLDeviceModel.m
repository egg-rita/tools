//
//  KLDeviceModel.m
//  ToolDemo
//
//  Created by zhaokaile on 2018/6/13.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import "KLDeviceModel.h"
#import <sys/utsname.h>
@implementation KLDeviceModel
//苹果手机检测
+(NSString*)iphoneType{
    struct utsname systemInfo;
    uname(&systemInfo);
   NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:(NSUTF8StringEncoding)];
    if ([deviceModel isEqualToString:@"x86_64"]||[deviceModel isEqualToString:@"i386"]) {return @"Device_Simulator";}
    //iPhone 系列
//    if ([deviceModel isEqualToString:@"iPhone1,1"]) { return @"iPhone 1G";}
//    else if ([deviceModel isEqualToString:@"iPhone1,2"]) {return @"iPhone 3G";}
//    else if ([deviceModel isEqualToString:@"iPhone2,1"])    {return @"iPhone 3GS";}
//    else if ([deviceModel isEqualToString:@"iPhone3,1"])    {return @"iPhone 4";}
//    else if ([deviceModel isEqualToString:@"iPhone3,2"])    {return @"Verizon iPhone 4";}
//    else if ([deviceModel isEqualToString:@"iPhone4,1"])    {return @"iPhone 4S";}
//    else if ([deviceModel isEqualToString:@"iPhone5,1"])    {return @"iPhone 5";}
    else if ([deviceModel isEqualToString:@"iPhone5,2"])    {return @"iPhone 5";}
//    else if ([deviceModel isEqualToString:@"iPhone5,3"])    {return @"iPhone 5C";}
//    else if ([deviceModel isEqualToString:@"iPhone5,4"])    {return @"iPhone 5C";}
    else if ([deviceModel isEqualToString:@"iPhone6,1"])    {return @"iPhone 5S";}
    else if ([deviceModel isEqualToString:@"iPhone6,2"])    {return @"iPhone 5S";}
    else if ([deviceModel isEqualToString:@"iPhone7,1"])    {return @"iPhone 6 Plus";}
    else if ([deviceModel isEqualToString:@"iPhone7,2"])    {return @"iPhone 6";}
    else if ([deviceModel isEqualToString:@"iPhone8,1"])    {return @"iPhone 6s";}
    else if ([deviceModel isEqualToString:@"iPhone8,2"])    {return @"iPhone 6s Plus";}
    else if ([deviceModel isEqualToString:@"iPhone9,1"])    {return @"iPhone 7 (CDMA)";}
    else if ([deviceModel isEqualToString:@"iPhone9,3"])    {return @"iPhone 7 (GSM)";}
    else if ([deviceModel isEqualToString:@"iPhone9,2"])    {return @"iPhone 7 Plus (CDMA)";}
    else if ([deviceModel isEqualToString:@"iPhone9,4"])    {return @"iPhone 7 Plus (GSM)";}
    else if ([deviceModel isEqualToString:@"iPhone10,1"])   {return @"iPhone 8";}
    else if ([deviceModel isEqualToString:@"iPhone10,4"])   {return @"iPhone 8";}
    else if ([deviceModel isEqualToString:@"iPhone10,2"])   {return @"IPhone 8 Plus";}
    else if ([deviceModel isEqualToString:@"iPhone10,5"])   {return @"IPhone 8 Plus";}
    else if ([deviceModel isEqualToString:@"iPhone10,3"])   {return @"IPhone X";}
    else if ([deviceModel isEqualToString:@"iPhone10,6"])   {return @"IPhone X";}
    return deviceModel;
}

+(NSString*)ipodType{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:(NSUTF8StringEncoding)];
    //iPod 系列
    if ([deviceModel isEqualToString:@"iPod1,1"])    {return @"iPod Touch 1G";}
    if ([deviceModel isEqualToString:@"iPod2,1"])    {return @"iPod Touch 2G";}
    if ([deviceModel isEqualToString:@"iPod3,1"])    {return @"iPod Touch 3G";}
    if ([deviceModel isEqualToString:@"iPod4,1"])    {return @"iPod Touch 4G";}
    if ([deviceModel isEqualToString:@"iPod5,1"])    {return @"iPod Touch 5G";}
    
    return deviceModel;
}
@end
