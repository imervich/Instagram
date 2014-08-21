//
//  PhotoDetailViewController.m
//  Instagram
//
//  Created by Iván Mervich on 8/20/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "PhotoDetailViewController.h"
#import "Photo.h"

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

- (IBAction)onCommentButtonTapped:(UIButton *)sender
{
	NSLog(@"open comments");
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
