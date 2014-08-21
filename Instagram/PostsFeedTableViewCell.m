//
//  PostsFeedTableViewCell.m
//  Instagram
//
//  Created by Iván Mervich on 8/19/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "PostsFeedTableViewCell.h"
#import "Photo.h"

@interface PostsFeedTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *userImageButton;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@end

@implementation PostsFeedTableViewCell

- (void)setCellWithPhoto:(Photo *)photo{
    self.photoImageView.image = [UIImage imageWithData:photo.file.getData];
    self.photoImageView.contentMode = UIViewContentModeScaleAspectFit;
	self.likesLabel.text = [NSString stringWithFormat:@"%d", photo.likes];
    
}

- (void)setUserImageViewRoundCorners
{
	self.userImageButton.layer.cornerRadius = self.userImageButton.bounds.size.width / 2;
	self.userImageButton.layer.masksToBounds = YES;
}

#pragma mark - IBActions

- (IBAction)onLikeButtonTapped:(UIButton *)sender
{
	[self.delegate didTapLikeButtonOnCell:self];
}

- (IBAction)onCommentButtonTapped:(UIButton *)sender
{
	[self.delegate didTapCommentButtonOnCell:self];
}

- (IBAction)onUserImageButtonTapped:(UIButton *)sender
{
	[self.delegate didTapUserImageButtonOnCell:self];
}

@end