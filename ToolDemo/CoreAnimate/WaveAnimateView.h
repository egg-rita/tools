//
//  WaveAnimateView.h
//  ToolDemo
//
//  Created by PC-013 on 2018/11/19.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WaveAnimateView : UIView

/**A振幅 默认 10**/
@property(nonatomic,assign)CGFloat A;

/**y轴偏移 0**/
@property(nonatomic,assign)CGFloat k;

/**角速度ω变大，则波形在X轴上收缩（波形变紧密）；角速度ω变小，则波形在X轴上延展（波形变稀疏）。不等于0**/
/**默认 0.03**/
@property(nonatomic,assign)CGFloat w;

@end

NS_ASSUME_NONNULL_END
