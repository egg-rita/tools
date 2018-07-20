//
//  UserData.h
//  ToolDemo
//
//  Created by zhaokaile on 2018/7/4.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : NSObject
//@property(nonatomic,assign)NSInteger userId;
@property(nonatomic,copy)NSString *name;//名字
@property(nonatomic,copy)NSString* birthday;//生日
//@property(nonatomic,assign)int age;//年龄
@property(nonatomic,copy)NSString *sex;//性别
//@property(nonatomic,assign)float height;//身高
//@property(nonatomic,assign)float weight;//体重

+(void)createDataBase;
//创建表
+(void)createTable;

-(void)saveUserData;

+(void)readUserData;
@end
