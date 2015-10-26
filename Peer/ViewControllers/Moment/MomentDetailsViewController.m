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
@property(nonatomic) NSMutableArray *cellHeightArray;

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
    self.cellHeightArray      = [NSMutableArray array];
    
    UIBarButtonItem *leftBarItem = [self leftBackBarButtonItem];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    [self.headerView configureLikedUsersAvatarWithArray:@[]];
    [self loadCommentData];
}

- (void)loadCommentData {
    
#warning Test
    
    CommentModel *comment1 = [[CommentModel alloc] init];
    comment1.content = @"好漂亮的啊啦，能见它一面吗？";
    comment1.commentId = @(1);
    comment1.user = [[UserModel alloc] init];
    
    comment1.user.nickname = @"jason";
    comment1.user.avatar   = @"http://jasonlife.oss-cn-shenzhen.aliyuncs.com/test/avatar.png";
    
    CommentModel *comment2 = [[CommentModel alloc] init];
    comment2.content = @"我也想见";
    comment2.commentId = @(2);
    comment2.parentId  = @(1);
    comment2.user = [[UserModel alloc] init];
    comment2.user.nickname = @"baby";
    comment2.user.avatar   = @"http://jasonlife.oss-cn-shenzhen.aliyuncs.com/test/avatar.png";
    
    
    CommentModel *comment3 = [[CommentModel alloc] init];
    comment3.content = @"可以啊，都过来看jacky";
    comment3.commentId = @(3);
    comment3.userId    = @(6);
    comment3.user = [[UserModel alloc] init];
    comment3.user.nickname = @"duan";
    comment3.user.avatar   = @"http://jasonlife.oss-cn-shenzhen.aliyuncs.com/test/avatar.png";
    
    self.commentsDataArray = @[comment1,comment2,comment3];
    
#warning Test
    
//    [self.momentsService getCommentsWithMomentId:self.momentModel.momentId pagination:nil callBackBlock:^(NSArray *comments) {
//        
//        self.commentsDataArray = comments;
//        [self.tableView reloadData];
//        
//    }];
    
}

- (void)reloadData {
    
}

- (void)loadMoreComment {
    
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
    return [self.commentsDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MomentDetailsCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentTableViewCell];
    if (!cell) {
        cell = [[MomentDetailsCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CommentTableViewCell];
    }
    
    CGFloat height = [cell configureWithCommentModel:self.commentsDataArray[indexPath.row]];
    [self.cellHeightArray addObject:@(height)];
    
    
    return cell;
}

#pragma mark - -- <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.cellHeightArray count] > 0 ? [self.cellHeightArray[indexPath.row] floatValue] : 0;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 25;
}

@end
