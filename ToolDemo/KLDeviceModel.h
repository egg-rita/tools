//
//  KLDeviceModel.h
//  ToolDemo
//
//  Created by zhaokaile on 2018/6/13.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KLDeviceModel : NSObject

+(instancetype)defaultSharedManager;

//苹果手机检测
+(NSString*)iphoneType;

/*获取设备的IP地址*/
+(NSString*)klGetDeviceIpAddress;

#pragma mark - CPU 信息
// CPU总数目
+ (NSUInteger)klGetCPUCount;
// 已使用的CPU比例
+ (float)klGetCPUUsage;
// 获取每个cpu的使用比例
+(NSArray *)klGetPerCPUUsage;

@end
