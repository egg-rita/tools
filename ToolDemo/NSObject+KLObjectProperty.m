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
+(void)klGetObjectPropertyListWithClass:(Class)klClass{
     unsigned int count;
    Ivar *varlist = class_copyIvarList([klClass class], &count);
    for (int i =0; i<count; i++) {
        Ivar ivar = varlist[i];
        
        //获取成员变量C语言的字符串
        const char *varName = ivar_getName(ivar);
//        NSLog(@"varName-->:%s",varName);
        
        //将 C语言的字符串转换成oc
        NSString *ocName = [NSString stringWithUTF8String:varName];
        NSLog(@"ocName-->%@",ocName);
    }
    free(varlist);//释放空间
    
}

+(void)klGetObjectMethodListWithClass:(Class)klClass{
    unsigned int count;
   Method *methodList = class_copyMethodList([klClass class], &count);
    for (int i = 0; i<count; i++) {
        Method method = methodList[i];
        //获取方法指针
        SEL methodSEL = method_getName(method);
        //获取C语言的方法名字
        const char *name = sel_getName(methodSEL);
//        NSLog(@"name->%s",name);
        //将 C语言的字符转换成oc
        NSString *methodname = [NSString stringWithUTF8String:name];
        NSLog(@"方法名字%@",methodname);
    }
}




@end
