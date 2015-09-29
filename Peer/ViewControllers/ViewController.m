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
    
    
  
//    [UIView];

    
 
    
    [view addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    DLog(@"%@",change);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
