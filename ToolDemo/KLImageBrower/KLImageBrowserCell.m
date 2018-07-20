//
//  KLImageBrowserCell.m
//  ToolDemo
//
//  Created by zhaokaile on 2018/7/18.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import "KLImageBrowserCell.h"
@interface KLImageBrowserCell()

@property (nonatomic, strong) UIImageView *animateImageView;

@end
@implementation KLImageBrowserCell
#pragma mark - getter
- (UIImageView *)animateImageView {
    if (!_animateImageView) {
        _animateImageView = [UIImageView new];
        _animateImageView.contentMode = UIViewContentModeScaleAspectFill;
        _animateImageView.layer.masksToBounds = YES;
    }
    return _animateImageView;
}
@end
