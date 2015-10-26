//
//  MomentDetailsViewController.m
//  Peer
//
//  Created by jason on 10/22/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "MomentDetailsViewController.h"
#import "MomentDetailsCommentTableViewCell.h"
#import "MomentDetailsHeaderView.h"

#import "MomentModel.h"
#import "CommentModel.h"
#import "Pagination.h"

#import "MomentsService.h"

@interface MomentDetailsViewController () <UITableViewDataSource,UITableViewDelegate>

@property(nonatomic) UITableView *tableView;
@property(nonatomic) MomentDetailsHeaderView *headerView;
@property(nonatomic) MomentsService *momentsService;
@property(nonatomic) NSArray *commentsDataArray;

@end

@implementation MomentDetailsViewController


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height )];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.headerView;
        _tableView.backgroundColor = [UIColor colorWithHex:0xfafafa alpha:1.0];
        
    }
    return _tableView;
}

- (MomentDetailsHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[MomentDetailsHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64.0)];
        _headerView.backgroundColor = [UIColor whiteColor];
        [_headerView configureWithMomentModel:self.momentModel];
    }
    return _headerView;
}

- (MomentsService *)momentsService {
    if (!_momentsService) {
        _momentsService = [[MomentsService alloc] init];
    }
    return _momentsService;
}

- (void)loadView {
    [super loadView];
    
    [self.view addSubview:self.tableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"浏览详细";
    
    self.view.backgroundColor = [UIColor colorWithHex:0xfdfdfd alpha:1.0];
    
    UIBarButtonItem *leftBarItem = [self leftBackBarButtonItem];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    [self.headerView configureLikedUsersAvatarWithArray:@[]];
    [self loadCommentData];
}

- (void)loadCommentData {
    
    
//    [self.momentsService getCommentsWithMomentId:self.momentModel.momentId pagination:nil callBackBlock:^(NSArray *comments) {
//        
//        self.commentsDataArray = comments;
//        [self.tableView reloadData];
//        
//    }];
    
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

- (void)backButtonAction:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}


#pragma mark - -- <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MomentDetailsCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentTableViewCell];
    if (!cell) {
        cell = [[MomentDetailsCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CommentTableViewCell];
    }
    
    
    
    return cell;
}

#pragma mark - -- <UITableViewDelegate>

@end
