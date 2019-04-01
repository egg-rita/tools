//
//  NSObject+KLObjectProperty.m
//  ToolDemo
//
//  Created by PC-013 on 2018/9/19.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import "NSObject+KLObjectProperty.h"
#import <objc/message.h>
@implementation NSObject (KLObjectProperty)

/**
 获取成员变量
 */
+(NSArray*)klGetFetchIvarList{
    unsigned int count = 0;
   Ivar *ivarList = class_copyIvarList([self class], &count);
   NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i<count; i++) {
       NSMutableDictionary *mdict = [NSMutableDictionary dictionaryWithCapacity:2];
       const char *ivarName = ivar_getName(ivarList[i]);
       const char *ivarType = ivar_getTypeEncoding(ivarList[i]);
        mdict[@"type"] = [NSString stringWithUTF8String:ivarType];
        mdict[@"ivarName"] = [NSString stringWithUTF8String:ivarName];
        [mutableList addObject:mdict];
    }
    free(ivarList);
    return [NSArray arrayWithArray:mutableList];
}

/**
 获取类的属性列表，包括私有和公有属性，以及定义在Extension中的属性
 */
+(NSArray*)klGetFetchPropertyList{
    unsigned int count = 0;
   objc_property_t *propertyList = class_copyPropertyList([self class], &count);
   NSMutableArray *propertyArr = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0 ; i<count; i++) {
       const char *propertyName = property_getName(propertyList[i]);
        [propertyArr addObject:[NSString stringWithUTF8String:propertyName]];
    }
    return [NSArray arrayWithArray:propertyArr];
}

/**
 获取协议列表
 */
+(NSArray*)klGetProtocolList{
    unsigned int count = 0;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);
   NSMutableArray *protocolArr = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i<count; i++) {
       const char *protocolName = protocol_getName(protocolList[i]);
        [protocolArr addObject:[NSString stringWithUTF8String:protocolName]];
    }
    return [NSArray arrayWithArray:protocolArr];
}

/**
 获取类的实力方法列表 getter setter，对象方法等。
 */
+(NSArray*)klGetInstanceMethodList{
    unsigned int count = 0;
   Method *methodList = class_copyMethodList([self class], &count);
   NSMutableArray *methodArr = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i<count; i++) {
    SEL methodName = method_getName(methodList[i]);
        [methodArr addObject:NSStringFromSelector(methodName)];
    }
    free(methodList);
    return [NSArray arrayWithArray:methodArr];
}

@end
