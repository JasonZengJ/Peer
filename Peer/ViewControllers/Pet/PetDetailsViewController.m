//
//  PetDetailsViewController.m
//  Peer
//
//  Created by jason on 10/29/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "MomentDetailsViewController.h"
#import "PetDetailsViewController.h"
#import "PetDetailsHeaderView.h"
#import "PetDetailsCollectionViewCell.h"
#import "PetsModel.h"
#import "MomentsService.h"

#import "PetDetailsHorizonCardFlowLayout.h"

@interface PetDetailsViewController () <PetDetailsHeaderViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) PetDetailsHeaderView *headerView;
@property(nonatomic,strong) MomentsService *momentService;
@property(nonatomic,strong) NSArray *momentsArray;


@end

@implementation PetDetailsViewController


- (PetDetailsHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[PetDetailsHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 0)];
        _headerView.delegate = self;
        _headerView.backgroundColor = [UIColor clearColor];
        [_headerView configureWithPetsModel:self.petsModel];
        
        
    }
    return _headerView;
}

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        PetDetailsHorizonCardFlowLayout *horizonLayout = [[PetDetailsHorizonCardFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.headerView.bottom, self.view.width, self.view.height - self.headerView.height) collectionViewLayout:horizonLayout];
        _collectionView.dataSource      = self;
        _collectionView.delegate        = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = false;
        [_collectionView registerClass:[PetDetailsCollectionViewCell class] forCellWithReuseIdentifier:@"PetDetailsCollectionViewCell"];
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
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.collectionView];
    [self.navbarBgView removeFromSuperview];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.momentsArray = [NSArray array];
    [self reloadData];
    
}

- (void)reloadData {
    
    [self.momentService getAllMomentsWithPetsId:self.petsModel.petsId callBackBlock:^(NSArray *moments) {
        
        if (moments && [moments count]) {
            self.momentsArray = [moments copy];
            [self.collectionView reloadData];
        }
        
    }];
    
}

#pragma mark - -- <PetDetailsHeaderViewDelegate>

- (void)followPet {
    
    
}

#pragma mark - -- <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.momentsArray count];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PetDetailsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PetDetailsCollectionViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[PetDetailsCollectionViewCell alloc] init];
    }
    [cell configureWithMoments:[self.momentsArray objectAtIndex:indexPath.row]];
    return cell;
    
}

#pragma mark - -- <UICollectionViewDelegate>


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MomentDetailsViewController *momentDetailsViewController = [[MomentDetailsViewController alloc] init];
    momentDetailsViewController.momentModel = [self.momentsArray objectAtIndex:indexPath.row];
    momentDetailsViewController.momentModel.pet = self.petsModel;
    momentDetailsViewController.backActionType = BackActionTypeDismiss;
    momentDetailsViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:momentDetailsViewController];
    
    [self presentViewController:navController animated:YES completion:^{
        
    }];
    
    
}


@end
