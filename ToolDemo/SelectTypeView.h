//
//  SelectTypeView.h
//  ToolDemo
//
//  Created by zhaokaile on 2018/7/18.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectTypeView : UIView
@property(nonatomic,copy)NSString *title;//标题
@property(nonatomic,copy)NSArray<NSString*> *btnTitleArr;
@property(nonatomic,copy)void (^cancleBlock)();
@end
