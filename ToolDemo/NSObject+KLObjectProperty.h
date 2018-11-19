//
//  NSObject+KLObjectProperty.h
//  ToolDemo
//
//  Created by PC-013 on 2018/9/19.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KLObjectProperty)
//获取指定类的所有属性
+(void)klGetObjectPropertyListWithClass:(Class)klClass;

//获取指定类的所有的类的方法
+(void)klGetObjectMethodListWithClass:(Class)klClass;
@end
