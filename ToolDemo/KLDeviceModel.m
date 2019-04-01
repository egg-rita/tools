//
//  KLDeviceModel.m
//  ToolDemo
//
//  Created by zhaokaile on 2018/6/13.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import "KLDeviceModel.h"
#import <sys/utsname.h>
#import <AdSupport/AdSupport.h>

//获取mac地址需要导入的头文件
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

#include <sys/sockio.h>
#include <sys/ioctl.h>
#import <arpa/inet.h>

//获取ip需要的头文件
#import <ifaddrs.h>

//获取cpu信息所需要的头文件
#import <mach/mach.h>

@implementation KLDeviceModel
+(void)load{
    NSLog(@"--model load--");
}

+(instancetype)defaultSharedManager{
   static KLDeviceModel *_deviceManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _deviceManager = [[KLDeviceModel alloc]init];
    });
    return _deviceManager;
}
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
    else if ([deviceModel isEqualToString:@"iPhone8,4"])    {return @"iPhone SE";}
    else if ([deviceModel isEqualToString:@"iPhone9,1"])    {return @"iPhone 7 (CDMA)";}
    else if ([deviceModel isEqualToString:@"iPhone9,2"])    {return @"iPhone 7 Plus (CDMA)";}
    else if ([deviceModel isEqualToString:@"iPhone9,3"])    {return @"iPhone 7 (GSM)";}
    else if ([deviceModel isEqualToString:@"iPhone9,4"])    {return @"iPhone 7 Plus (GSM)";}
    else if ([deviceModel isEqualToString:@"iPhone10,1"])   {return @"iPhone 8";}
    else if ([deviceModel isEqualToString:@"iPhone10,4"])   {return @"iPhone 8";}
    else if ([deviceModel isEqualToString:@"iPhone10,2"])   {return @"IPhone 8 Plus";}
    else if ([deviceModel isEqualToString:@"iPhone10,5"])   {return @"IPhone 8 Plus";}
    else if ([deviceModel isEqualToString:@"iPhone10,3"])   {return @"IPhone X";}
    else if ([deviceModel isEqualToString:@"iPhone10,6"])   {return @"IPhone X";}
    else if ([deviceModel isEqualToString:@"iPhone11,2"])   {return @"iPhone XS";}
    else if ([deviceModel isEqualToString:@"iPhone11,4"])   {return @"iPhone XS Max";}
    else if ([deviceModel isEqualToString:@"iPhone11,6"])   {return @"iPhone XS Max";}
    else if ([deviceModel isEqualToString:@"iPhone11,8"])   {return @"iPhone XR";}
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
#pragma mark - IP 地址
+(NSString*)klGetDeviceIpAddress{
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    
    NSMutableArray *ips = [NSMutableArray array];
    
    int BUFFERSIZE = 4096;
    
    struct ifconf ifc;
    
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    
    struct ifreq *ifr, ifrcopy;
    
    ifc.ifc_len = BUFFERSIZE;
    ifc.ifc_buf = buffer;
    
    if (ioctl(sockfd, SIOCGIFCONF, &ifc) >= 0) {
        for (ptr = buffer; ptr<buffer+ifc.ifc_len;) {
            ifr = (struct ifreq*)ptr;
            int len = sizeof(struct sockaddr);
            
            if (ifr -> ifr_addr.sa_len>len) {
                len  = ifr->ifr_addr.sa_len;
            }
            
            ptr+=sizeof(ifr->ifr_name)+len;
            if (ifr->ifr_addr.sa_family != AF_INET) {continue;}
            if ((cptr = (char*)strchr(ifr->ifr_name, ':')) != NULL) {*cptr = 0;}
            if (strncmp(lastname, ifr->ifr_name, IFNAMSIZ) == 0) {continue;}
            
            memcpy(lastname, ifr->ifr_name, IFNAMSIZ);
            ifrcopy = *ifr;
            ioctl(sockfd, SIOCGIFFLAGS ,&ifrcopy);
            
            if ((ifrcopy.ifr_flags & IFF_UP) == 0) {continue;}
            
            NSString *ip = [NSString stringWithFormat:@"%s",inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            [ips addObject:ip];
        }
    }
    
    close(sockfd);
    NSString *deviceIP = @"";
    
    for (int i = 0; i<ips.count; i++) {
        if (ips.count>0) {
            deviceIP = [NSString stringWithFormat:@"%@",ips.lastObject];
        }
    }
    return deviceIP;
}
#pragma mark - CPU 信息
// CPU总数目
+ (NSUInteger)klGetCPUCount {
    return [NSProcessInfo processInfo].activeProcessorCount;
}
// 已使用的CPU比例
+ (float)klGetCPUUsage {
    float cpu = 0;
    NSArray *cpus = [self klGetPerCPUUsage];
    if (cpus.count == 0) {return -1;}
    for (NSNumber *n in cpus) {
        cpu += n.floatValue;
    }
    return cpu;
}
// 获取每个cpu的使用比例
+ (NSArray *)klGetPerCPUUsage{
    processor_info_array_t _cpuInfo, _prevCPUInfo = nil;
    mach_msg_type_number_t _numCPUInfo, _numPrevCPUInfo = 0;
    unsigned _numCPUs;
    NSLock *_cpuUsageLock;
    
    int _mib[2U] = { CTL_HW, HW_NCPU };
    size_t _sizeOfNumCPUs = sizeof(_numCPUs);
    int _status = sysctl(_mib, 2U, &_numCPUs, &_sizeOfNumCPUs, NULL, 0U);
    if (_status)
        _numCPUs = 1;
    
    _cpuUsageLock = [[NSLock alloc] init];
    
    natural_t _numCPUsU = 0U;
    kern_return_t err = host_processor_info(mach_host_self(), PROCESSOR_CPU_LOAD_INFO, &_numCPUsU, &_cpuInfo, &_numCPUInfo);
    if (err == KERN_SUCCESS) {
        [_cpuUsageLock lock];
        
        NSMutableArray *cpus = [NSMutableArray new];
        for (unsigned i = 0U; i < _numCPUs; ++i) {
            Float32 _inUse, _total;
            if (_prevCPUInfo) {
                _inUse = (
                          (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER]   - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER])
                          + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM])
                          + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE]   - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE])
                          );
                _total = _inUse + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE] - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE]);
            } else {
                _inUse = _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER] + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE];
                _total = _inUse + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE];
            }
            [cpus addObject:@(_inUse / _total)];
        }
        
        [_cpuUsageLock unlock];
        if (_prevCPUInfo) {
            size_t prevCpuInfoSize = sizeof(integer_t) * _numPrevCPUInfo;
            vm_deallocate(mach_task_self(), (vm_address_t)_prevCPUInfo, prevCpuInfoSize);
        }
        return cpus;
    } else {
        return @[];
    }
}



@end
