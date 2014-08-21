//
//  SharePhotoViewController.m
//  Instagram
//
//  Created by Iván Mervich on 8/20/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "SharePhotoViewController.h"

@interface SharePhotoViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *captionTextView;

@end

@implementation SharePhotoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - IBActions

- (IBAction)onTagPeopleButtonTapped:(UIButton *)sender
{
	NSLog(@"open tag window");
}

- (IBAction)onShareButtonTapped:(UIButton *)sender
{
	NSLog(@"post photo");
}

@end
