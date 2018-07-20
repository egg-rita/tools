//
//  KLImageBrowserCell.h
//  ToolDemo
//
//  Created by zhaokaile on 2018/7/18.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLImageBrowserModel.h"
#import "KLImageBrowserScreenOrientationProtocol.h"
@class KLImageBrowserCell;
@protocol  KLImageBrowserCellDelegate <NSObject>

- (void)KLImageBrowserCell:(KLImageBrowserCell *)imageBrowserCell longPressBegin:(UILongPressGestureRecognizer *)gesture;

- (void)applyForHiddenByKLImageBrowserCell:(KLImageBrowserCell *)imageBrowserCell;
@end


@interface KLImageBrowserCell : UICollectionViewCell<KLImageBrowserScreenOrientationProtocol>
@property (nonatomic, strong) KLImageBrowserModel *model;
@property (nonatomic, strong, readonly) UIImageView *animateImageView;

+ (void)countWithContainerSize:(CGSize)containerSize image:(id)image screenOrientation:(KLImageBrowserScreenOrientation)screenOrientation verticalFillType:(KLImageBrowserImageViewFillType)verticalFillType horizontalFillType:(KLImageBrowserImageViewFillType)horizontalFillType completed:(void(^)(CGRect imageFrame, CGSize contentSize, CGFloat minimumZoomScale, CGFloat maximumZoomScale))completed;

@end
