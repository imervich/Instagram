//
//  PhotoDetailViewController.m
//  Instagram
//
//  Created by Iván Mervich on 8/20/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "PhotoDetailViewController.h"
#import "Photo.h"
#import "CommentsViewController.h"

// segue
#define showCommentsSegue @"showCommentsSegue"

@interface PhotoDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;
@property (weak, nonatomic) IBOutlet UIButton *userImageButton;

@end

@implementation PhotoDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.photo.file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {

		if (!error) {
			UIImage *image = [UIImage imageWithData:data];
			self.photoImageView.image = image;
		} else {
			NSLog(@"Error getting user photo on cell %@ %@", error, error.userInfo);
		}
	}];
    self.photoImageView.contentMode = UIViewContentModeScaleAspectFit;
	self.likesLabel.text = [NSString stringWithFormat:@"%d", self.photo.likes];
    self.usernameLabel.text = self.photo.user.username;

    PFQuery *eventQuery = [PFQuery queryWithClassName:@"Event"];
    [eventQuery whereKey:@"photo" equalTo:self.photo];
    [eventQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.likesLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)objects.count];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = NO;

	[self reload];
}

#pragma mark - IBActions
- (IBAction)onReloadButtonTapped:(UIBarButtonItem *)sender
{
	[self reload];
}

- (IBAction)onUserImageButtonTapped:(UIButton *)sender
{
	NSLog(@"load user profile");
}

- (IBAction)onLikeButtonTapped:(UIButton *)sender
{
	NSLog(@"like photo");
}

//- (IBAction)onCommentButtonTapped:(UIButton *)sender
//{
//	NSLog(@"open comments from photo details");
//}

#pragma mark - UITableView Delegate



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:showCommentsSegue]) {
		CommentsViewController *commentsVC = segue.destinationViewController;
		commentsVC.photo = self.photo;
	}
}

#pragma mark - Helper methods

- (void)reload
{
	[self.activityIndicator startAnimating];

	[self.photo.file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {

		if (!error) {
			UIImage *image = [UIImage imageWithData:data];
			self.photoImageView.image = image;
		} else {
			NSLog(@"Error getting user photo on cell %@ %@", error, error.userInfo);
		}
		[self.activityIndicator stopAnimating];
	}];

    self.photoImageView.contentMode = UIViewContentModeScaleAspectFit;
	self.likesLabel.text = [NSString stringWithFormat:@"%d", self.photo.likes];
    self.usernameLabel.text = self.photo.user.username;

	[self setUserImageViewRoundCorners];
}

- (void)setUserImageViewRoundCorners
{
	self.userImageButton.layer.cornerRadius = self.userImageButton.bounds.size.width / 2;
	self.userImageButton.layer.masksToBounds = YES;
}

@end
