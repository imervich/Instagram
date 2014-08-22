//
//  CameraViewController.m
//  Instagram
//
//  Created by Iván Mervich on 8/20/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "CameraViewController.h"
#import "Event.h"
#import "SharePhotoViewController.h"

#define showShareScreenSegue @"showShareScreenSegue"

#define TakePhotoButtonIndex 0
#define ChoosePhotoButtonIndex 1

@interface CameraViewController () <UIImagePickerControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIAlertViewDelegate>

@end

@implementation CameraViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
															 delegate:self
													cancelButtonTitle:@"Cancel"
											   destructiveButtonTitle:nil
													otherButtonTitles:@"Take Photo", @"Choose Photo", nil];

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onPhotoShared:) name:@"sharedPhoto" object:nil];

	[actionSheet showInView:self.tabBarController.view];

}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = NO;
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == TakePhotoButtonIndex) {
		NSLog(@"open camera");
		if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
			[self shouldStartCameraController];
		} else {
			UIAlertView *alertView = [UIAlertView new];
			alertView.delegate = self;
			alertView.message = @"No camera available";
			[alertView addButtonWithTitle:@"OK"];
			[alertView show];
		}
	} else if (buttonIndex == ChoosePhotoButtonIndex) {
		NSLog(@"open roll");
		if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
			[self shouldStartPhotoLibraryPickerController];
		} else {
			UIAlertView *alertView = [UIAlertView new];
			alertView.delegate = self;
			alertView.message = @"No photo roll";
			[alertView addButtonWithTitle:@"OK"];
			[alertView show];
		}
	} else {
		NSLog(@"cancel");
		self.tabBarController.selectedIndex = 0;
	}
}

#pragma mark - photo choosing options

- (BOOL)shouldStartCameraController {
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    cameraUI.allowsEditing = YES;
    cameraUI.showsCameraControls = YES;
    cameraUI.delegate = self;
    
    [self presentViewController:cameraUI animated:YES completion:nil];
    
    return YES;
}


- (BOOL)shouldStartPhotoLibraryPickerController {
    
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
        
    cameraUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    cameraUI.allowsEditing = YES;
    cameraUI.delegate = self;
    
    [self presentViewController:cameraUI animated:YES completion:nil];
    
    return YES;
}

#pragma mark - UIImagePickerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:^{
		self.tabBarController.selectedIndex = 0;
	}];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:NO completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
	[self performSegueWithIdentifier:showShareScreenSegue sender:image];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:showShareScreenSegue]) {
		SharePhotoViewController *sharePhotoVC = (SharePhotoViewController *)segue.destinationViewController;
		sharePhotoVC.image = sender;
	}
}

#pragma mark - Notifications

- (void)onPhotoShared:(NSNotification *)notification
{
	self.tabBarController.selectedIndex = 0;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	self.tabBarController.selectedIndex = 0;
}

@end
