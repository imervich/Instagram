//
//  PostsFeedViewController.m
//  Instagram
//
//  Created by Iván Mervich on 8/19/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "PostsFeedViewController.h"
#import "PostsFeedTableViewCell.h"

// cell id
#define postsFeedCell @"PostsFeedCell"

@interface PostsFeedViewController () <UITableViewDataSource, UITableViewDelegate, PostsFeedTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PostsFeedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = YES;
}

#pragma mark - UITableView DataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	PostsFeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:postsFeedCell];
	cell.delegate = self;

	return cell;
}

#pragma mark - PostsFeedTableViewCell Delegate methods

- (void)didTapLikeButtonOnCell:(PostsFeedTableViewCell *)cell
{
	NSLog(@"like post");
}

- (void)didTapCommentButtonOnCell:(PostsFeedTableViewCell *)cell
{
	NSLog(@"open post comments");
}

- (void)didTapUserImageButtonOnCell:(PostsFeedTableViewCell *)cell
{
	NSLog(@"go to user profile");
}

@end
