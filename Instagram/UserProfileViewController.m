//
//  UserProfileViewController.m
//  Instagram
//
//  Created by Iván Mervich on 8/20/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "UserProfileViewController.h"

@interface UserProfileViewController ()
@property (weak, nonatomic) IBOutlet UIButton *userImageView;

@end

@implementation UserProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

	[self setUserImageViewRoundCorners];
}

- (void)setUserImageViewRoundCorners
{
	self.userImageView.layer.cornerRadius = self.userImageView.bounds.size.width / 2;
	self.userImageView.layer.masksToBounds = YES;
}

@end