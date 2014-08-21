//
//  PostsFeedViewController.m
//  Instagram
//
//  Created by Iván Mervich on 8/19/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "PostsFeedViewController.h"
#import "PostsFeedTableViewCell.h"
#import "Photo.h"
#import "CommentsViewController.h"

// cell id
#define postsFeedCell @"PostsFeedCell"

// segue
#define showCommentsSegue @"showCommentsSegue"

@interface PostsFeedViewController () <UITableViewDataSource, UITableViewDelegate, PostsFeedTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *photos;

@end

@implementation PostsFeedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    UIImage *photo = [UIImage imageNamed:@"unicorn"];
//    for (int i = 0; i < 10; i++) {
//        PFObject *newPhoto = [PFObject objectWithClassName:@"Photo"];
//        [newPhoto setObject:[PFFile fileWithData:UIImagePNGRepresentation(photo)]  forKey:@"file"];
//        [newPhoto setObject:[PFUser currentUser] forKey:@"user"];
//        [newPhoto setObject:[PFGeoPoint geoPointWithLatitude:19.428058 longitude:-99.172136] forKey:@"location"];
//
//        [newPhoto saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//            if (!error) {
//                NSLog(@"Image Saved");
//            }
//        }];
//    }
    self.photos = [NSMutableArray new];
    [self loadRecentPictures];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = NO;
}

- (void)loadRecentPictures {
    PFQuery *photoQuery = [PFQuery queryWithClassName:@"Photo"];
    NSDate *fiveDaysAgo = [[NSDate date] dateByAddingTimeInterval:-5*24*60*60];
    //retrieve photos within 5 days from actual date
    [photoQuery whereKey:@"updatedAt" greaterThan:fiveDaysAgo];
    [photoQuery includeKey:@"user"];
    [photoQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
//                Photo *photo = (Photo*)object;
                [self.photos addObject:object];
            }

            [self.tableView reloadData];
        }
    }];
}

#pragma mark - UITableView DataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.photos.count;
}

- (PostsFeedTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	PostsFeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:postsFeedCell];
    Photo *photo = [self.photos objectAtIndex:indexPath.row];
//    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:photo.file.getData]];
    [cell setCellWithPhoto:photo];
	cell.delegate = self;
	[cell setUserImageViewRoundCorners];
	return cell;
}

#pragma mark - PostsFeedTableViewCell Delegate methods

- (void)didTapLikeButtonOnCell:(PostsFeedTableViewCell *)cell
{
	NSLog(@"like post");
}

- (void)didTapCommentButtonOnCell:(PostsFeedTableViewCell *)cell
{
	NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
	Photo *photo = self.photos[indexPath.row];
	[self performSegueWithIdentifier:showCommentsSegue sender:photo];
}

- (void)didTapUserImageButtonOnCell:(PostsFeedTableViewCell *)cell
{
	NSLog(@"go to user profile");
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:showCommentsSegue]) {
		CommentsViewController *commentsVC = segue.destinationViewController;
		commentsVC.photo = sender;
	}
}

@end
