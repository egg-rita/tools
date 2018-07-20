//
//  DataBaseObject.h
//  ToolDemo
//
//  Created by zhaokaile on 2018/7/4.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataBaseObject : NSObject
+(instancetype)sharedManager;
-(void)createDataBaseWithPath:(NSString*)path;
//创建表
-(void)createTable:(NSString*)sqlStr;
-(void)updateDataBase:(NSString*)sqlStr andValues:(NSArray*)values;
-(NSMutableArray*)readDataBase:(NSString*)sqlStr;
//批量保存数据
-(void)saveDataArr:(NSArray*)arr;
@end
