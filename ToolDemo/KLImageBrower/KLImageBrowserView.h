//
//  KLImageBrowserView.h
//  ToolDemo
//
//  Created by zhaokaile on 2018/6/8.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLImageBrowserUtilities.h"
#import "KLImageBrowserModel.h"
#import "KLImageBrowserScreenOrientationProtocol.h"
@class KLImageBrowserView;
@protocol KLImageBrowserViewDelegate <NSObject>

- (void)KLImageBrowserView:(KLImageBrowserView *)imageBrowserView didScrollToIndex:(NSUInteger)index;

- (void)KLImageBrowserView:(KLImageBrowserView *)imageBrowserView longPressBegin:(UILongPressGestureRecognizer *)gesture;

- (void)applyForHiddenByKLImageBrowserView:(KLImageBrowserView *)imageBrowserView;

@end

@protocol KLImageBrowserViewDataSource <NSObject>

- (NSInteger)numberInKLImageBrowserView:(KLImageBrowserView *)imageBrowserView;

- (KLImageBrowserModel *)KLImageBrowserView:(KLImageBrowserView *)imageBrowserView modelForCellAtIndex:(NSInteger)index;

@end



@interface KLImageBrowserView : UICollectionView<KLImageBrowserScreenOrientationProtocol>

@property (nonatomic, weak) id <KLImageBrowserViewDelegate> kl_delegate;
@property (nonatomic, weak) id <KLImageBrowserViewDataSource> kl_dataSource;

@property (nonatomic, assign) NSUInteger currentIndex;

@property (nonatomic, assign) KLImageBrowserImageViewFillType verticalScreenImageViewFillType;
@property (nonatomic, assign) KLImageBrowserImageViewFillType horizontalScreenImageViewFillType;

@property (nonatomic, strong) NSString *loadFailedText;
@property (nonatomic, strong) NSString *isScaleImageText;
@property (nonatomic, assign) BOOL cancelDragImageViewAnimation;
@property (nonatomic, assign) CGFloat outScaleOfDragImageViewAnimation;
@property (nonatomic, assign) BOOL autoCountMaximumZoomScale;

- (void)scrollToPageWithIndex:(NSInteger)index;

@end
