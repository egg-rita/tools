//
//  LL_AdvertScrollView.h
//  LL_AdVertScrollView
//
//  Created by zhaokaile on 2018/5/24.
//  Copyright © 2018年 zhaosi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LL_AdvertScrollView;
@protocol LL_AdvertScrollViewDelegate<NSObject>

-(void)LL_CollectionView:(UICollectionViewCell *)cell cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface LL_AdvertScrollView : UIView

@property(nonatomic,copy)NSArray<NSString*> *dataSource;//数据源

@property(nonatomic,assign)UICollectionViewScrollDirection scrollDirection;//水平或者是垂直(默认是垂直)

@property(nonatomic,weak) id <LL_AdvertScrollViewDelegate> LL_delegate;
//设置滚动的时间间隔(默认是2秒)
@property(nonatomic,assign)NSTimeInterval timeInterval;

-(void)registerCollectionViewClassCell:(Class)cellClass withcellIdentifier:(NSString*)Identifier;
@end
