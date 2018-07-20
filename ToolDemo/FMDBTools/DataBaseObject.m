//
//  DataBaseObject.m
//  ToolDemo
//
//  Created by zhaokaile on 2018/7/4.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import "DataBaseObject.h"
#import "FMDB.h"
#import <objc/runtime.h>
@interface DataBaseObject()
{
    FMDatabaseQueue *_basequeue;
}
@end
@implementation DataBaseObject
+(instancetype)sharedManager{
    static DataBaseObject *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       manager = [[self alloc]init];
    });
    return manager;
}
//创建数据库
-(void)createDataBaseWithPath:(NSString*)path{
   _basequeue = [FMDatabaseQueue databaseQueueWithPath:path];
}
//创建表
-(void)createTable:(NSString*)sqlStr{
    [_basequeue inDatabase:^(FMDatabase * _Nonnull db) {
        if (![db open]) {
            NSLog(@"数据库打开失败！！");
            return ;
        }
        BOOL result = [db executeUpdate:sqlStr];
        if (!result) {
            NSLog(@"创建表失败！！");
        }else{
            NSLog(@"创建表成功！！");
        }
        [db close];
    }];
}
-(void)updateDataBase:(NSString*)sqlStr andValues:(NSArray*)values{
    NSLog(@"%@",_basequeue);
    [_basequeue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        if (![db open]) {
            NSLog(@"数据库打开失败！！");
            return ;
        }

        BOOL result = [db executeUpdate:sqlStr withArgumentsInArray:values];

        if (!result) {
            NSLog(@"保存失败!");
        }else{
            NSLog(@"保存成功!");
        }
        [db close];
    }];
}

-(NSMutableArray*)readDataBase:(NSString*)sqlStr{
    NSMutableArray *arr = [NSMutableArray array];
    [_basequeue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        if (![db open]) {
            NSLog(@"数据库打开失败!");
            return ;
        }
        FMResultSet *set = [db executeQuery:sqlStr];
        NSLog(@"%@",set);
        while ([set next]) {
            
        }
        
        [db close];
    }];
    return arr;
}
//-(void)saveDataWithSQL:(NSString*)sqlStr andDatarr:(NSArray *)arr{
//    [_basequeue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
//        for (<#initialization#>; <#condition#>; <#increment#>) {
//            <#statements#>
//        }
//    }];
//}
@end
