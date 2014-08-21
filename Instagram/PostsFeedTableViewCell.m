//
//  PostsFeedTableViewCell.m
//  Instagram
//
//  Created by Iván Mervich on 8/19/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "PostsFeedTableViewCell.h"

@interface PostsFeedTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *userImageButton;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation PostsFeedTableViewCell

- (id)initWithPhoto:(Photo *)photo{
    self = [super init];

    self.userImageButton.imageView.image = photo.image;
    return self;
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