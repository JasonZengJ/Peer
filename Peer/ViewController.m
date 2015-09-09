//
//  ViewController.m
//  Peer
//
//  Created by jason on 8/15/15.
//  Copyright (c) 2015 goodpeer. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>


@interface ViewController ()

@property(nonatomic,strong)UIView *myView;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self.navigationController pushViewController:<#(UIViewController *)#> animated:<#(BOOL)#>]
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 150, 150)];
    view.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:view];
    self.myView = view;
    
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, 60, 80, 20)];
    [button setTitle:@"旋转测试" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(testFrame) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
//    [UIView];

    
    
    
    [view addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    DLog(@"%@",change);
}

- (void)testFrame
{
//    CGPoint point = [self.myView convertPoint:CGPointMake(20, 20) fromView:self.view];
//    DLog("%",point);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(150, 150, 100, 100)];
    view.backgroundColor = [UIColor yellowColor];
    CABasicAnimation *animation;
    [self.view.layer addSublayer:view.layer];
    
    CABasicAnimation*    layerAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    layerAnimation.duration = 2.0;
    layerAnimation.beginTime = 0; //CACurrentMediaTime() + 1;
    layerAnimation.valueFunction = [CAValueFunction functionWithName:kCAValueFunctionRotateZ];
    layerAnimation.timingFunction = [CAMediaTimingFunction
                                     functionWithName:kCAMediaTimingFunctionLinear];
    layerAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    layerAnimation.toValue = [NSNumber numberWithFloat:M_PI / 4];
//    layerAnimation.byValue = [NSNumber numberWithFloat:M_PI / 4];
    [view.layer addAnimation:layerAnimation forKey:@"layerAnimation"];
    UISplitViewController *splitViewController = [[UISplitViewController alloc] init];
    
    UINavigationController *nav = nil;
    
//    [self presen];
    
    //
//    DLog(@"%@",self.view.subviews);
//    [UIView transitionFromView:self.myView toView:view duration:0.8 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
//        DLog(@"%@",self.view.subviews);
//    }];
//    DLog(@"%@",self.myView);
    [UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionAutoreverse animations:^{
//        [UIView setAnimationRepeatCount:];
        self.myView.transform = CGAffineTransformMakeRotation(M_PI / 4);
//        float centerX = self.myView.bounds.size.width/2;
//        float centerY = self.myView.bounds.size.height/2;
//        float x = self.myView.bounds.size.width;
//        float y = self.myView.bounds.size.height;
//        
//        CGAffineTransform trans = GetCGAffineTransformRotateAroundPoint(centerX,centerY,x,y ,180.0/180.0*M_PI);
//        self.myView.transform = CGAffineTransformIdentity;
//        self.myView.transform = trans;
//        self.myView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.myView.transform = CGAffineTransformIdentity;
    }];
 
}

- (void)dynamicTest
{
    NSLog(@"test");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
