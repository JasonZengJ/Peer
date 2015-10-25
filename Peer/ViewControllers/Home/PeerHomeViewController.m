//
//  PeerHomeViewController.m
//  Peer
//
//  Created by jason on 10/15/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "PeerHomeViewController.h"
#import "MomentDetailsViewController.h"

#import "HorizontalCardTableView.h"
#import "CardCollectionViewCell.h"

#import "HorizonCardFlowLayout.h"
#import "MomentsService.h"
#import "MomentModel.h"
#import "UIColor+Hex.h"
#import "UIView+Layout.h"
#import "LayoutUtil.h"

#import "HomeBottomView.h"
#import "HomeHeaderView.h"


@interface PeerHomeViewController () <UICollectionViewDataSource,UICollectionViewDelegate>

//@property(nonatomic) HorizontalCardTableView *cardTableView;
@property(nonatomic) UICollectionView *collectionView;
@property(nonatomic) MomentsService   *momentService;
@property(nonatomic) HomeHeaderView   *homeHeaderView;
@property(nonatomic) HomeBottomView   *homeBottomView;
@property(nonatomic) NSArray *momentsArray;

@end

@implementation PeerHomeViewController


- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        HorizonCardFlowLayout *cardFlowLayout = [[HorizonCardFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:cardFlowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = false;
        [_collectionView registerClass:[CardCollectionViewCell class] forCellWithReuseIdentifier:@"CardCollectionViewCell"];
    }
    return _collectionView;
    
}

- (HomeBottomView *)homeBottomView {
    if (!_homeBottomView) {
        _homeBottomView = [[HomeBottomView alloc] initWithFrame:CGRectZero];
        _homeBottomView.height = self.collectionView.height - CardHeight - self.homeHeaderView.height - CardEdge;
        _homeBottomView.width  = self.view.width;
        _homeBottomView.top    = self.view.height - _homeBottomView.height;
        
    }
    return _homeBottomView;
}

- (HomeHeaderView *)homeHeaderView {
    if (!_homeHeaderView) {
        _homeHeaderView = [[HomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 80)];
        
    }
    return _homeHeaderView;
}


- (MomentsService *)momentService {
    if (!_momentService) {
        _momentService = [[MomentsService alloc] init];
    }
    return _momentService;
}


- (void)loadView {
    
    [super loadView];
    self.view.backgroundColor = [UIColor colorWithHex:0xfafafa alpha:1.0];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.homeHeaderView];
    [self.view addSubview:self.homeBottomView];
}

-  (void)viewDidLoad {
    [super viewDidLoad];
    self.momentsArray = [NSArray array];
    
//    [self loadData];
    
    
    
    NSMutableArray *muteArray = [NSMutableArray array];
    
    for (int i = 0 ; i < 4; i++) {
        
        MomentModel *momentModel = [[MomentModel alloc] init];
        momentModel.momentDescription = @"今天把 啊duan 牵了出来溜溜，趁今天天气不错，求约妹子～";
        momentModel.momentTargetUrl   = @"http://jasonlife.oss-cn-shenzhen.aliyuncs.com/temp.png";
        momentModel.momentType        = @(1);
        [muteArray addObject:momentModel];
        
    }
    self.momentsArray = [muteArray copy];
}

- (void)loadData {
    
    PeerHomeViewController __weak *weakSelf = self;
    [self.momentService getAllMomentsWithPagination:nil callBackBlock:^(NSArray *moments) {
        PeerHomeViewController *strongSelf = weakSelf;
        strongSelf.momentsArray = moments;
        [strongSelf.collectionView reloadData];
    }];
    
}


#pragma mark - -- <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.momentsArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CardCollectionViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[CardCollectionViewCell alloc] init];
    }
    
    [cell configureWithMoments:[self.momentsArray objectAtIndex:indexPath.row]];
    return cell;
    
}

#pragma mark - -- <UICollectionViewDelegate>


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    MomentDetailsViewController *momentDetailsViewController = [[MomentDetailsViewController alloc] init];
    momentDetailsViewController.momentModel = [self.momentsArray objectAtIndex:indexPath.row];
    momentDetailsViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:momentDetailsViewController];
    
    [self presentViewController:navController animated:YES completion:^{
        
    }];
    
    
}



@end
