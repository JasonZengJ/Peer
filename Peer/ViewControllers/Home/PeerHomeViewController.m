//
//  PeerHomeViewController.m
//  Peer
//
//  Created by jason on 10/15/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "PeerHomeViewController.h"
#import "HorizontalCardTableView.h"

#define CardCollectionViewCell @"CardCollectionViewCell"

@interface PeerHomeViewController () <UICollectionViewDataSource,UICollectionViewDelegate>

//@property(nonatomic) HorizontalCardTableView *cardTableView;
@property(nonatomic) UICollectionView *collectionView;


@end

@implementation PeerHomeViewController


- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame ];
    }
    return _collectionView;
    
}

//- (HorizontalCardTableView *)cardTableView {
//    if (!_cardTableView) {
//        _cardTableView = [[HorizontalCardTableView alloc] init];
//    }
//    return _cardTableView;
//}

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
}

-  (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}


#pragma mark - -- <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CardCollectionViewCell forIndexPath:indexPath];
    if (!cell) {
        cell = [[UICollectionViewCell alloc] init];
    }
    
    return cell;
    
}

#pragma mark - -- <UICollectionViewDelegate>



@end
