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

#define showShareScreenSegue @"showShareScreenSegue"

@interface CameraViewController () <UIImagePickerControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate>

@end

@implementation CameraViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	// check if camera is available
	BOOL cameraDeviceAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    BOOL photoLibraryAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
    
    if (cameraDeviceAvailable && photoLibraryAvailable) {
        NSLog(@"camera and roll available");
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo", @"Choose Photo", nil];
        [actionSheet showInView:self.view];
    } else {
        NSLog(@"only roll available");
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo", @"Choose Photo", nil];
        [actionSheet showInView:self.navigationController.view];
        
        // if we don't have at least two options, we automatically show whichever is available (camera or roll)
    }
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = NO;
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self shouldStartCameraController];
    } else if (buttonIndex == 1) {
        [self shouldStartPhotoLibraryPickerController];
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
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:NO completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.8);
    
    Photo *newPhoto = [Photo object];
    newPhoto.file = [PFFile fileWithData:imageData];
    newPhoto.user = [PFUser currentUser];
    newPhoto.location = [PFGeoPoint geoPointWithLatitude:19.428058 longitude:-99.172136];
    [newPhoto saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    NSLog(@"Image Saved");
                }
    }];
}

@end
