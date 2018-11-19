//
//  KLNetWorking.h
//  ToolDemo
//
//  Created by PC-013 on 2018/10/22.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KLNetWorking : NSObject
@property(nonatomic,strong)NSMutableArray *dataTaskArr;//正在请求的任务数组
@property(nonatomic,strong)NSMutableArray *uploadDataTaskArr;//正在上传的任务数组
@end
