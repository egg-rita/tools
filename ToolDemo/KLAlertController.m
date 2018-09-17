//
//  KLAlertController.m
//  ToolDemo
//
//  Created by zhaokaile on 2018/7/2.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import "KLAlertController.h"
#define kBounds [UIScreen mainScreen].bounds
#define kwidth kBounds.size.width
#define kheight kBounds.size.height
@interface KLAlertViewAnimate()<UIViewControllerAnimatedTransitioning>
@end
@implementation KLAlertViewAnimate

-(instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController{
    if (self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController]) {
        presentedViewController.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}



#pragma mark - UIViewControllerAnimatedTransitioning

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.35;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    //获取转场舞台(平台)
   UIView *containerView = [transitionContext containerView];
    
   UIViewController *fromController = [transitionContext viewControllerForKey: UITransitionContextFromViewControllerKey];
    UIViewController *toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
   UIView *fromView = fromController.view;
   UIView *toView = toController.view;
    
    //入场动效
    if (toController.isBeingPresented) {

        
        
        toView.frame = kBounds;//CGRectMake(0, kheight, kwidth, kheight);
        [containerView addSubview:toView];
        toView.alpha = 0.f;

        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            toView.frame = kBounds;
            toView.alpha = 1;
            
        } completion:^(BOOL finished) {
            BOOL wasCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!wasCancelled];

        }];
    }
    //出场动效
    if (fromController.isBeingDismissed) {

        fromView.frame = kBounds;
        [containerView addSubview:fromView];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromView.alpha = 0.f;
            
        } completion:^(BOOL finished) {
            BOOL wasCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!wasCancelled];
        }];
    }
    
}


#pragma mark - UIViewControllerTransitioningDelegate
-(UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    return self;
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    
    return self;
}


@end




@interface KLAlertController ()<UIViewControllerTransitioningDelegate>


@end

@implementation KLAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
    self.view.backgroundColor = [UIColor clearColor];
    
    
    self.bgView.frame = self.view.bounds;
    [self.view addSubview:self.bgView];

}
-(void)configContentView:(UIView*)contentView{
    if (!contentView) {
        return;
    }
    [self.view addSubview:contentView];
}


#pragma mark - getter
- (UIView *)bgView{
    if (!_bgView) {
        _bgView= [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0.4;
        
       UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissAction)];
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}

-(void)dismissAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    NSLog(@"%@控制器销毁了!!",self.view);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
