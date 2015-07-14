//
//  ViewController.m
//  tabbarAnimation
//
//  Created by chuck on 15-7-11.
//  Copyright (c) 2015年 ZK. All rights reserved.
//

#import "ViewController.h"

#define BOUNDS  [UIScreen mainScreen].bounds

@interface ViewController (){
    NSInteger currentIndex;
    NSInteger lastIndex;
    NSArray * btnArray;
}
@property(nonatomic,strong)UIButton * oneBtn;
@property(nonatomic,strong)UIButton * twoBtn;
@property(nonatomic,strong)UIButton * threeBtn;
@property(nonatomic,strong)UIButton * forthBtn;

@property(nonatomic,strong)UIView * moveView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 100,BOUNDS.size.width, 80)];
    [self.view addSubview:backView];
    
    UIView * moveView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    moveView.backgroundColor = [UIColor yellowColor];
    self.moveView = moveView;
    [backView addSubview:moveView];
    
    self.oneBtn = [self addBtn:CGRectMake(0, 0, 80, 80) title:@"one" tag:0];
    self.twoBtn = [self addBtn:CGRectMake(80, 0, 80, 80) title:@"tow" tag:1];
    self.threeBtn = [self addBtn:CGRectMake(160, 0, 80, 80) title:@"three" tag:2];
    self.forthBtn = [self addBtn:CGRectMake(240, 0, 80, 80) title:@"forth" tag:3];
    
    [backView addSubview:self.oneBtn];
    [backView addSubview:self.twoBtn];
    [backView addSubview:self.threeBtn];
    [backView addSubview:self.forthBtn];
    
    btnArray = @[self.oneBtn,self.twoBtn,self.threeBtn,self.forthBtn];
}

- (UIButton *)addBtn:(CGRect)rect title:(NSString *)title tag:(NSInteger)tag{
    UIButton * btn = [[UIButton alloc] initWithFrame:rect];
    [btn setTitle:title forState:(UIControlStateNormal)];
    btn.tag = tag;
    [btn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(clickBtnEvent:) forControlEvents:(UIControlEventTouchUpInside)];
    return btn;
}

- (void)clickBtnEvent:(UIButton *)btn{
    currentIndex = btn.tag;
    if (currentIndex != lastIndex) {
        CGPoint lastPos = [btnArray[lastIndex] layer].position;
        CGPoint nextPos = [btnArray[currentIndex] layer].position;
        CAKeyframeAnimation * animation = [CAKeyframeAnimation animation];
        animation.keyPath = @"position.x";
        if (currentIndex > lastIndex){
            animation.values = @[@(lastPos.x),@(nextPos.x + 20),@(nextPos.x)];
        }else{
            animation.values = @[@(lastPos.x),@(nextPos.x - 20),@(nextPos.x)];
        }
        animation.timingFunction =  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
      //  animation.duration = 0.3;
      //  animation.removedOnCompletion = NO;
      //  animation.fillMode = kCAFillModeForwards;
      //  [self.moveView.layer addAnimation:animation forKey:nil];
        
        CGFloat red = arc4random()/(CGFloat)INT_MAX;
        CGFloat green = arc4random()/(CGFloat)INT_MAX;
        CGFloat blue = arc4random()/(CGFloat)INT_MAX;
        
        UIColor * color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
        
        CABasicAnimation * colorAnimation = [CABasicAnimation animation];
        colorAnimation.keyPath = @"backgroundColor";
        colorAnimation.toValue = (__bridge id)color.CGColor;
      //  colorAnimation.duration = 0.3;
      //  colorAnimation.removedOnCompletion = NO;
      //  colorAnimation.fillMode = kCAFillModeForwards;
      //  [self.moveView.layer addAnimation:colorAnimation forKey:nil];
        

        
        CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
        animationGroup.animations =  @[animation,colorAnimation];
        animationGroup.duration = 0.5;
        animationGroup.removedOnCompletion = NO;
        animationGroup.fillMode = kCAFillModeForwards;
        [self.moveView.layer addAnimation:animationGroup forKey:nil];
        lastIndex = currentIndex;
    }
}

@end
