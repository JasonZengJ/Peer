//
//  MineViewController.m
//  Peer
//
//  Created by jason on 1/12/16.
//  Copyright © 2016 peers. All rights reserved.
//

#import "MineViewController.h"
#import "MineCardCollectionViewCell.h"
#import "MineCollectionViewFlowLayout.h"
#import "MineInfoCollectionHeaderView.h"
#import "MineCollectionFooterView.h"

#import "LoginService.h"
#import "PetsService.h"

#import "AddPeerViewController.h"

@interface MineViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UIVisualEffectView *mainView;
@property(nonatomic,strong)UICollectionView   *collectionView;
@property(nonatomic,strong)NSArray *petsArray;
@property(nonatomic,strong)PetsService *petsService;

@end

@implementation MineViewController

- (UIVisualEffectView *)mainView {
    if (!_mainView) {
        _mainView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        _mainView.frame = self.view.frame;
    }
    return _mainView;
}

- (PetsService *)petsService {
    if (!_petsService) {
        _petsService = [[PetsService alloc] init];
    }
    return _petsService;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64.0f, ScreenWidth, ScreenHeight - 64.0f) collectionViewLayout:[[MineCollectionViewFlowLayout alloc] init]];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[MineCardCollectionViewCell class] forCellWithReuseIdentifier:@"MineCardCollectionViewCell"];
        [_collectionView registerClass:[MineInfoCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MineInfoCollectionHeaderView"];
        [_collectionView registerClass:[MineCollectionFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"MineCollectionFooterView"];
    }
    return _collectionView;
}

- (void)loadView {
    [super loadView];
    [self.view addSubview:self.mainView];
    [self.view addSubview:self.collectionView];
    [self.view insertSubview:[[UIImageView alloc] initWithImage:self.homePageCaptureImage] belowSubview:self.mainView];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self reloadData];
    self.title = @"我";
    
    
}

- (void)reloadData {
    
    __weak typeof(self)weakSelf = self;
    [self.petsService getAllPetsWithCallBackBlock:^(NSArray *allPets) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.petsArray = allPets;
        [strongSelf.collectionView reloadData];
    }];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (UIBarButtonItem *)rightBarButtonItem {
    
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    aButton.titleEdgeInsets = UIEdgeInsetsMake(1, 0, 0, 0);
    aButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    UIImage *backImage = [UIImage imageNamed:@"MineSettings"];
    aButton.frame= CGRectMake(-2, 0.0f,ConvertiPhone5Or6pSize(25), ConvertiPhone5Or6pSize(25));
    [aButton setImage:backImage forState:UIControlStateNormal];
    [aButton addTarget:self action:@selector(rightNavbarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [aButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, -18.0)];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:aButton];
    
    
    return barButton;
    
}

- (void)rightNavbarButtonAction:(UIButton *)sender {
    
}


#pragma mark - -- <UICollectionViewDelegateFlowLayout>

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (section > 0) {
        return CGSizeZero;
    }
    return CGSizeMake(ScreenWidth, 100.0f);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    if (section > 0) {
        return CGSizeZero;
    }
    
    return CGSizeMake(ScreenWidth - 20, 50.0f);
}

#pragma mark - -- <UICollectionViewDataSource>


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    
    NSInteger sectionNum = (self.petsArray.count + 1) / 2;
    
    if (!sectionNum) {
        return 1;
    }
    
    if ((self.petsArray.count + 1 - sectionNum) == 1) {
        return sectionNum + 1;
    } else {
        return sectionNum;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
 
    if (!self.petsArray || !self.petsArray.count) {
        return 0;
    }
    
    if (section > self.petsArray.count / 2) {
        return 1;
    } else {
        return 2;
    }
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section > 0) {
        return nil;
    }
    
    UICollectionReusableView *view = nil;
    if ( kind == UICollectionElementKindSectionHeader) {
        view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"MineInfoCollectionHeaderView" forIndexPath:indexPath];
        [(MineInfoCollectionHeaderView *)view configureWithUserModel:[LoginService currentUser]];
        [view addTapGestureWithTarget:self action:@selector(tapEditMineInfo)];
 
    } else if ((!self.petsArray || ![self.petsArray count]) && kind == UICollectionElementKindSectionFooter) {
        view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"MineCollectionFooterView" forIndexPath:indexPath];
        [view addTapGestureWithTarget:self action:@selector(tapAddPeer)];
    }
    
    
    return view;
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MineCardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MineCardCollectionViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[MineCardCollectionViewCell alloc] init];
    }
    
    
    
    return cell;
    
}


#pragma mark - -- <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - -- action

- (void)tapAddPeer {
    
    AddPeerViewController *addPeerViewController = [[AddPeerViewController alloc] init];
    [self.navigationController pushViewController:addPeerViewController animated:YES];
    
}

- (void)tapEditMineInfo {
    
}

@end











