//
//  PeerHomeViewController.m
//  Peer
//
//  Created by jason on 10/15/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "PeerHomeViewController.h"
#import "HorizontalCardTableView.h"
#import "CardCollectionViewCell.h"
#import "HorizonCardFlowLayout.h"
#import "MomentsService.h"
#import "MomentModel.h"
#import "UIColor+Hex.h"


@interface PeerHomeViewController () <UICollectionViewDataSource,UICollectionViewDelegate>

//@property(nonatomic) HorizontalCardTableView *cardTableView;
@property(nonatomic) UICollectionView *collectionView;
@property(nonatomic) MomentsService   *momentService;
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
        [_collectionView registerClass:[CardCollectionViewCell class] forCellWithReuseIdentifier:@"CardCollectionViewCell"];
    }
    return _collectionView;
    
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
}

-  (void)viewDidLoad {
    [super viewDidLoad];
    self.momentsArray = [NSArray array];
    
//    [self loadData];
    
    
    MomentModel *momentModel1 = [[MomentModel alloc] init];
    momentModel1.momentTitle  = @"123456";
    
    MomentModel *momentModel2 = [[MomentModel alloc] init];
    momentModel2.momentTitle  = @"123";
    
    MomentModel *momentModel3 = [[MomentModel alloc] init];
    momentModel3.momentTitle  = @"few 风";
    
    MomentModel *momentModel4 = [[MomentModel alloc] init];
    momentModel4.momentTitle  = @"nice";
    
    
    self.momentsArray = @[momentModel1,momentModel2,momentModel3,momentModel4];
    
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



@end
