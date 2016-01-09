//
//  RootNavViewController.m
//  Peer
//
//  Created by jason on 10/25/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "RootNavViewController.h"

/**
 *  自定义控制器的pop转场动画
 */

@interface PopAnimation : NSObject <UIViewControllerAnimatedTransitioning>

@end

@implementation PopAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIViewController *toViewController   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
    toViewController.view.transform = CGAffineTransformMakeTranslation(- ScreenWidth / 3, 0);
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        fromViewController.view.transform = CGAffineTransformMakeTranslation(ScreenWidth, 0);
        toViewController.view.transform   = CGAffineTransformMakeTranslation(0, 0);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
    
    
}


@end

@interface RootNavViewController () <UINavigationControllerDelegate>


@property(nonatomic) UIPercentDrivenInteractiveTransition *interactivePopTransition;

@end

@implementation RootNavViewController

- (UIView *)navbarBgView {
    if (!_navbarBgView) {
        _navbarBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 64.0f)];
        _navbarBgView.backgroundColor = [UIColor colorWithHex:0xfafafa alpha:1.0];
    }
    return _navbarBgView;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backActionType = BackActionTypePop;
    }
    return self;
}

- (void)loadView {
    [super loadView];
    self.navigationItem.leftBarButtonItem  = [self leftBackBarButtonItem];
    self.navigationItem.rightBarButtonItem = [self rightBarButtonItem];
    self.view.backgroundColor = [UIColor colorWithHex:0xfafafa alpha:1.0];
    [self setTitleTextAttributes];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleControllerPop:)];
//    pan.maximumNumberOfTouches  = 1;
//    [self.view addGestureRecognizer:pan];
}

- (UIBarButtonItem *)rightBarButtonItem {
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    aButton.titleEdgeInsets = UIEdgeInsetsMake(1, 0, 0, 0);
    aButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    UIImage *backImage = [UIImage imageNamed:@"MomentDetailsMoreOption"];
    aButton.frame= CGRectMake(-2, 0.0f,ConvertiPhone5Or6pSize(25), ConvertiPhone5Or6pSize(25));
    [aButton setImage:backImage forState:UIControlStateNormal];
    [aButton addTarget:self action:@selector(rightNavbarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:aButton];
    return barButton;
}

- (UIBarButtonItem *)leftBackBarButtonItem {
    
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    aButton.titleEdgeInsets = UIEdgeInsetsMake(1, 0, 0, 0);
    aButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    UIImage *backImage = [UIImage imageNamed:@"MomentDetailsLeftArrow"];
    aButton.frame= CGRectMake(-2, 0.0f,ConvertiPhone5Or6pSize(25), ConvertiPhone5Or6pSize(25));
    [aButton setImage:backImage forState:UIControlStateNormal];
    [aButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:aButton];
    return barButton;
}

- (void)setTitleTextAttributes {
    
    NSDictionary * dict = @{
                            NSForegroundColorAttributeName:[UIColor colorWithHex:0x4c4c4c],
                            NSFontAttributeName:[UIFont systemFontOfSize:17.0f]
                            };
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
}


- (void)backButtonAction:(UIButton *)sender {
    
    if (self.backActionType == BackActionTypeDismiss) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if (self.backActionType == BackActionTypePop)  {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)rightNavbarButtonAction:(UIButton *)sender {
    
}

- (void)handleControllerPop:(UIPanGestureRecognizer *)recognizer {
    
    CGFloat progress = [recognizer translationInView:self.view].x / self.view.width;
    
    
    progress = MIN(1.0, MAX(0.0, progress));
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        [self.interactivePopTransition updateInteractiveTransition:progress];
        
    } else if (recognizer.state == UIGestureRecognizerStateCancelled || recognizer.state == UIGestureRecognizerStateEnded ) {
        
        if (progress > 0.5) {
            [self.interactivePopTransition finishInteractiveTransition];
        } else {
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        
        self.interactivePopTransition = nil;
        
    }
    
}


#pragma mark - -- <UINavigationControllerDelegate>

//- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
//    
//    if (operation == UINavigationControllerOperationPop) {
//        return [[PopAnimation alloc] init];
//    }
//    
//    return nil;
//}
//
//
//- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
// 
//    if ([animationController isKindOfClass:[PopAnimation class]]) {
//        return self.interactivePopTransition;
//    }
//    
//    return nil;
//}


@end















