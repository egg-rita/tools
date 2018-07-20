//
//  KLImageBrowserView.m
//  ToolDemo
//
//  Created by zhaokaile on 2018/6/8.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import "KLImageBrowserView.h"
#import "KLImageBrowserCell.h"
#import "KLImageBrowserViewLayout.h"


static NSString * const KLImageBrowserViewCellIdentifier = @"KLImageBrowserViewCellIdentifier";

@interface KLImageBrowserView <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,KLImageBrowserCellDelegate>

@end
@implementation KLImageBrowserView
//@synthesize KL_screenOrientation = _KL_screenOrientation;
//@synthesize KL_frameOfVertical = _KL_frameOfVertical;
//@synthesize KL_frameOfHorizontal = _KL_frameOfHorizontal;
//@synthesize KL_isUpdateUICompletely = _KL_isUpdateUICompletely;
#pragma mark - life cycle
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.backgroundColor = [UIColor clearColor];
        [self registerClass:KLImageBrowserCell.class forCellWithReuseIdentifier:KLImageBrowserViewCellIdentifier];
        self.pagingEnabled = YES;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.alwaysBounceVertical = NO;
        self.delegate = self;
        self.dataSource = self;
        if (@available(iOS 11.0,*)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return self;
}

#pragma mark private
-(void)scrollToPageWithIndex:(NSInteger)index{
    if (index>[self collectionView:self numberOfItemsInSection:0]) {
        KLLOG_WARNING(@"index is invalid");
    }
    self.contentOffset = CGPointMake(self.bounds.size.width*index, 0);
}
#pragma mark YBImageBrowserScreenOrientationProtocol
-(void)kl_setFrameInfoWithSuperViewScreenOrientation:(KLImageBrowserScreenOrientation)screenOrientation superViewSize:(CGSize)size{
    BOOL isVertical = screenOrientation == KLImageBrowserScreenOrientationVertical;
    CGRect rect0 = CGRectMake(0, 0, size.width, size.height),
    rect1 = CGRectMake(0, 0, size.height, size.width);

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
