//
//  baseTabBarViewController.m
//  tabbarAnimation
//
//  Created by chuck on 15-7-11.
//  Copyright (c) 2015年 ZK. All rights reserved.
//

#import "baseTabBarViewController.h"


@interface baseTabBarViewController () <UITabBarDelegate>{
    NSInteger currentIndex;
}
@property(nonatomic,strong)NSMutableDictionary * itemsStstus;
@property(nonatomic,weak)UIView * moveView;
@end

@implementation baseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView * moveView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, self.view.frame.size.height)];
    moveView.backgroundColor = [UIColor redColor];
    self.moveView = moveView;
    [self.tabBar addSubview:moveView];
}

- (void)setupChildViewControllerWithArray:(NSArray *)controllers{
    self.itemsStstus = [[NSMutableDictionary alloc] init];
    for (int i = 0; i < controllers.count; i++) {
        self.itemsStstus[[controllers[i] title]] = @(i);
        [self setupChileViewController:controllers[i] title:[controllers[i] title]];
    }
}

- (void)setupChileViewController:(UIViewController *)childVC title:(NSString *)title{
    childVC.title = title;
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:nav];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    CGFloat width = [UIScreen mainScreen].bounds.size.width/self.viewControllers.count;
    static NSInteger lastIndex=0;
    currentIndex = [self.itemsStstus[item.title] intValue];
    if (currentIndex != lastIndex) {
        CGFloat lastPosX = width * lastIndex + width/2;
        CGFloat nextPosX = width * [self.itemsStstus[item.title] intValue] + width/2;
        CAKeyframeAnimation * keyAnimation = [CAKeyframeAnimation animation];
        keyAnimation.keyPath = @"position.x";
        if (currentIndex > lastIndex) {
            keyAnimation.values = @[@(lastPosX),@(nextPosX + 20),@(nextPosX)];
        }else{
            keyAnimation.values = @[@(lastPosX),@(nextPosX - 20),@(nextPosX)];
        }
        keyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        CGFloat red = arc4random()/(CGFloat)INT_MAX;
        CGFloat green = arc4random()/(CGFloat)INT_MAX;
        CGFloat blue = arc4random()/(CGFloat)INT_MAX;
        
        UIColor * color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
        CABasicAnimation * basicAnimation = [CABasicAnimation animation];
        basicAnimation.keyPath = @"backgroundColor";
        basicAnimation.toValue = (__bridge_transfer id)color.CGColor;
        
        CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
        animationGroup.animations = @[keyAnimation,basicAnimation];
        animationGroup.duration = 0.5;
        animationGroup.removedOnCompletion = NO;
        animationGroup.fillMode = kCAFillModeForwards;
        [self.moveView.layer addAnimation:animationGroup forKey:nil];
        lastIndex = currentIndex;
    }
}


@end
