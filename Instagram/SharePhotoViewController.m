//
//  SharePhotoViewController.m
//  Instagram
//
//  Created by Iván Mervich on 8/20/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "SharePhotoViewController.h"
#import "Photo.h"

@interface SharePhotoViewController () <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *captionTextView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation SharePhotoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.imageView.image = self.image;
}

#pragma mark - IBActions

- (IBAction)onTagPeopleButtonTapped:(UIButton *)sender
{
	NSLog(@"open tag window");
}

- (IBAction)onShareButtonTapped:(UIButton *)sender
{
	NSLog(@"post photo");

	NSData *imageData = UIImageJPEGRepresentation(self.image, 0.8);

    Photo *newPhoto = [Photo object];
    newPhoto.file = [PFFile fileWithData:imageData];
    newPhoto.user = [PFUser currentUser];

	[self.activityIndicator startAnimating];

    [newPhoto saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
		if (!error) {
			NSLog(@"Image Saved");
			[self.navigationController popViewControllerAnimated:YES];
			[[NSNotificationCenter defaultCenter] postNotificationName:@"sharedPhoto" object:nil];
		} else {
			NSLog(@"error saving photo %@ %@", error, error.userInfo);
			UIAlertView *alertView = [UIAlertView new];
			alertView.delegate = self;
			alertView.message = @"Error posting photo, try again later";
			[alertView addButtonWithTitle:@"OK"];
			[alertView show];
		}
		[self.activityIndicator stopAnimating];
    }];
}

#pragma mark - UIAlertView Delegate methods

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	[self.navigationController popViewControllerAnimated:YES];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"sharedPhoto" object:nil];
}

@end
