//
//  PhotoDetailViewController.m
//  Instagram
//
//  Created by Iván Mervich on 8/20/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "PhotoDetailViewController.h"

@interface PhotoDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;

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
}

#pragma mark - IBActions
- (IBAction)onReloadButtonTapped:(UIBarButtonItem *)sender
{
	NSLog(@"reload photo data");
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
@end
