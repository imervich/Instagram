//
//  ExploreViewController.m
//  Instagram
//
//  Created by Iván Mervich on 8/19/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "ExploreViewController.h"

// search scopes
#define searchScopeUsers 0
#define searchScopeHashtags 1

// cell id
#define	ExploreCell	@"ExploreCell"
#define ExploreSearchTableViewCell @"ExploreSearchTableViewCell"

// segues
#define showPhotoSegue @"showPhotoSegue"

@interface ExploreViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) UITableView *tableView;
@property (weak, nonatomic) UISearchBar *searhBar;
@property (weak, nonatomic) NSArray *results;

@property int searchScope;

@end

@implementation ExploreViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];

	self.navigationController.navigationBarHidden = NO;

	// search users first
	self.searchScope = searchScopeUsers;
}

#pragma mark - UICollectionView DataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ExploreCell forIndexPath:indexPath];

//	set collectionViewCell values

//	to access the cell's imageView
//	UIImageView *imageView = [cell viewWithTag:1];

//	to access the cell's activityIndicatorView
//	UIActivityIndicatorView *activityIndicator = [cell viewWithTag:2];

	return cell;
}

#pragma mark - UICollectionView Delegate methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	NSLog(@"show photo details");
}

// search bar table view
#pragma mark - UITableView DataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ExploreSearchTableViewCell];

	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ExploreSearchTableViewCell];
	}
    PFUser *user = (PFUser *)[self.results objectAtIndex:tableView.indexPathForSelectedRow.row];
    cell.detailTextLabel.text = user.username;
	// set search tableViewCell values

	return cell;
}

#pragma mark - UISearchBar Delegate methods

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
	// called when the searchbar is tapped
    NSLog(@"searchBarShouldBeginEditing");
	return YES;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"Typing...");
    if (searchBar.text.length >= 3) {
        PFQuery *searchQuery = [PFUser query];
        [searchQuery whereKey:@"username" hasPrefix:searchBar.text];
        [searchQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                self.results = objects;
                [self.searchDisplayController.searchResultsTableView reloadData];
            }
        }];
    }
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
	switch (selectedScope) {
		case searchScopeUsers:
			NSLog(@"Search users");
			break;
		case searchScopeHashtags:
			NSLog(@"Search hashtags");
			break;
	}
}

#pragma mark - UISearchDisplay Delegate methods


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:showPhotoSegue]) {
		
	}
}

@end
