//
//  UserData.m
//  ToolDemo
//
//  Created by zhaokaile on 2018/7/4.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import "UserData.h"
#import "DataBaseObject.h"
#import <objc/runtime.h>
@implementation UserData
+(void)createDataBase{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [docPath stringByAppendingString:@"/user.sqlite"];
    NSLog(@"数据库地址-->%@",filePath);
    [[DataBaseObject sharedManager] createDataBaseWithPath:filePath];
}
+(void)createTable{
    NSString *sqlStr = @"CREATE TABLE IF NOT EXISTS user(name TEXT NOT NULL ,birthday TEXT NOT NULL ,sex TEXT NOT NULL);";
    
    [[DataBaseObject sharedManager] createTable:sqlStr];
}
-(void)saveUserData{

    NSString *sqlStr =[NSString stringWithFormat:@"INSERT INTO user (name, birthday, sex) VALUES (?,?,?);"];

    [[DataBaseObject sharedManager]updateDataBase:sqlStr andValues:@[self.name,self.birthday,self.sex]];
}

+(void)readUserData{
    NSString *sqlStr=@"SELECT * FORM t_user";
    NSMutableArray *arr = [[DataBaseObject sharedManager] readDataBase:sqlStr];
    NSLog(@"%@",arr);
}

@end
