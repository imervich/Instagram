//
//  UserProfileViewController.m
//  Instagram
//
//  Created by Iván Mervich on 8/20/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "UserProfileViewController.h"
#import "TabBarViewController.h"
#import "PostsFeedTableViewCell.h"

#define UserPhotoCollectionViewCell @"UserPhotoCollectionViewCell"

// cell id
#define postsFeedCell @"PostsFeedCell"


@interface UserProfileViewController () <UITabBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *postsLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingLabel;
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation UserProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

	[self setUserImageViewRoundCorners];
	self.tabBar.selectedItem = self.tabBar.items[0];
	self.collectionView.hidden = NO;
	self.tableView.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = NO;
}

- (void)setUserImageViewRoundCorners
{
	self.userImageView.layer.cornerRadius = self.userImageView.bounds.size.width / 2;
	self.userImageView.layer.masksToBounds = YES;
}

- (IBAction)onLogoutButtonTap:(id)sender {
    // Logout user, this automatically clears the cache
    [PFUser logOut];
    // Return to login view controller
    [self.navigationController popToRootViewControllerAnimated:YES];

	TabBarViewController *tabBarVC = (TabBarViewController *)self.tabBarController;
	[tabBarVC checkForLoggedUser];
}

#pragma mark - UITabBar Delegate methods

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
	// item at 0 = collection view
	// item at 1 = table view

	if ([item isEqual:tabBar.items[0]]) {
		NSLog(@"0");
		self.collectionView.hidden = NO;
		self.tableView.hidden = YES;
	} else {
		NSLog(@"1");
		self.collectionView.hidden = YES;
		self.tableView.hidden = NO;
	}
}

#pragma mark - UICollectionView DataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:UserPhotoCollectionViewCell forIndexPath:indexPath];

	//	set collectionViewCell values

	//	to access the cell's imageView
	//	UIImageView *imageView = [cell viewWithTag:1];

	return cell;
}

#pragma mark - UICollectionView Delegate methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	NSLog(@"selected cell, load photo details");
}

#pragma mark - UITableView DataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	PostsFeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:postsFeedCell];

	// configure cell

	return cell;
}

@end