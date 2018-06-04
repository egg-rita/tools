//
//  LL_AdvertScrollView.m
//  LL_AdVertScrollView
//
//  Created by zhaokaile on 2018/5/24.
//  Copyright © 2018年 zhaosi. All rights reserved.
//

#import "LL_AdvertScrollView.h"
static NSInteger const advertScrollViewMaxSections = 100;

@interface LL_AdvertScrollView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *collectinView;
@property(nonatomic,strong)UICollectionViewFlowLayout *flowLayout;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)CADisplayLink *link;
@property(nonatomic,assign)NSInteger currentIndex;//当前的索引位置
@property(nonatomic,copy)NSString *cellid;;
@end
@implementation LL_AdvertScrollView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setData];
        [self setUPUI];
    }
    return self;
}
#pragma mark - Init
-(void)setData{//初始化数据
    _currentIndex = 0;
    _timeInterval = 2.0;
    _cellid = @"";
    [self addTimer];
}
-(void)setUPUI{
    [self addSubview:self.collectinView];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.flowLayout.itemSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
    self.collectinView.frame = self.bounds;
    
    if (self.dataSource.count > 1) {
        [self defaultSelectedCell];
    }
}
-(void)defaultSelectedCell{
    [self.collectinView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}
#pragma mark - Set Timer
-(void)addTimer{
    [self removeTimer];
    self.timer = [NSTimer timerWithTimeInterval:_timeInterval target:self selector:@selector(startUpdateUI) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
-(void)removeTimer{
    [_timer invalidate];
    _timer = nil;
}

-(void)startUpdateUI{
    if (self.dataSource.count <= 0) {
        return;
    }
    //获取当前显示的位置
   NSIndexPath *currentIndexPath = [NSIndexPath indexPathForItem:_currentIndex inSection:0];
    //马上显示回最中间的位置
   NSIndexPath *resetCurrentIndexPath = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:0.5*advertScrollViewMaxSections];
    [self.collectinView scrollToItemAtIndexPath:resetCurrentIndexPath atScrollPosition:(UICollectionViewScrollPositionNone) animated:NO];
    
    _currentIndex++;
   NSInteger nextSetion = resetCurrentIndexPath.section;
    if (self.dataSource.count <= _currentIndex) {
        _currentIndex = 0;
        nextSetion++;
    }
//    NSLog(@"nextSetion-->:%ld",nextSetion);
    [self.collectinView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_currentIndex inSection:nextSetion] atScrollPosition:(UICollectionViewScrollPositionNone) animated:YES];
    
}


#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return advertScrollViewMaxSections;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_cellid forIndexPath:indexPath];
    
    if (indexPath.row%2 == 0) {
        cell.backgroundColor = [UIColor redColor];
    }else{
        cell.backgroundColor = [UIColor greenColor];
    }
    
    if (self.LL_delegate&&[self.LL_delegate respondsToSelector:@selector(LL_CollectionView:cellForItemAtIndexPath:)]) {
        [self.LL_delegate LL_CollectionView:cell cellForItemAtIndexPath:indexPath];
    }
    
    return cell;
}
//-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"前--->:%@",[NSValue valueWithCGRect:cell.frame]);
//}

//注册自定义的cell
-(void)registerCollectionViewClassCell:(Class)cellClass withcellIdentifier:(NSString*)Identifier{
    _cellid = Identifier;
    [self.collectinView registerClass:cellClass forCellWithReuseIdentifier:Identifier];
}

#pragma mark - getter
-(UICollectionView *)collectinView{
    if (!_collectinView) {
        _collectinView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
        _collectinView.backgroundColor = [UIColor whiteColor];
        _collectinView.delegate = self;
        _collectinView.dataSource = self;
        _collectinView.scrollsToTop = NO;
        _collectinView.scrollEnabled = NO;
//        _collectinView.pagingEnabled = YES;//分页
        [_collectinView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectinView;
}
-(UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.sectionInset = UIEdgeInsetsZero;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
    }
    return _flowLayout;
}
-(void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    [self.collectinView reloadData];
}
-(void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection{
    _scrollDirection = scrollDirection;
    self.flowLayout.scrollDirection = _scrollDirection;
}
-(void)setTimeInterval:(NSTimeInterval)timeInterval{
    _timeInterval = timeInterval;
    [self addTimer];
}

@end
