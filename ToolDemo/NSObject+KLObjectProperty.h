//
//  NSObject+KLObjectProperty.h
//  ToolDemo
//
//  Created by PC-013 on 2018/9/19.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KLObjectProperty)
/**
 获取成员变量
 */
+(NSArray*)klGetFetchIvarList;

/**
 获取类的属性列表，包括私有和公有属性，以及定义在Extension中的属性
 */
+(NSArray*)klGetFetchPropertyList;

/**
 获取协议列表
 */
+(NSArray*)klGetProtocolList;

/**
 获取类的实力方法列表 getter setter，对象方法等。
 */
+(NSArray*)klGetInstanceMethodList;
@end
