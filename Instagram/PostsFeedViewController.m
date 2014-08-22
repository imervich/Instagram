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
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = NO;
    [self loadRecentPictures];
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
    [cell setCellWithPhoto:photo];
    [cell setUserImageViewRoundCorners];
	cell.delegate = self;
	return cell;
}

#pragma mark - PostsFeedTableViewCell Delegate methods

- (void)didTapLikeButtonOnCell:(PostsFeedTableViewCell *)cell
{
    PFQuery *likeQuery = [PFQuery queryWithClassName:@"Event"];
    [likeQuery whereKey:@"photo" equalTo:cell.photo];
    [likeQuery whereKey:@"origin" equalTo:[PFUser currentUser]];
    [likeQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error && objects.count == 0) {
            PFObject *newEvent = [PFObject objectWithClassName:@"Event"];
            [newEvent setObject:[PFUser currentUser] forKey:@"origin"];
            [newEvent setObject:cell.photo.user forKey:@"destination"];
            [newEvent setObject:@"like" forKey:@"type"];
            [newEvent setObject:cell.photo forKey:@"photo"];
            [newEvent setObject:@"" forKey:@"details"];

            [newEvent saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
					cell.photo.likes ++;
					[cell.photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
						if (!error) {
							if (succeeded) {
								NSLog(@"like added to photo");
								NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
								[self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
							}
						} else {
							NSLog(@"error setting photo likes %@ %@", error, error.userInfo);
						}
					}];
                } else {
                    NSLog(@"Error: %@", error.userInfo);
                }
            }];
        }
    }];
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
