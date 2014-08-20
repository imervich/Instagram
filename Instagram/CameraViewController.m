//
//  CameraViewController.m
//  Instagram
//
//  Created by Iván Mervich on 8/20/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController ()

@end

@implementation CameraViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	// check if camera is available
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
		// open imagePickercontroller with camera
		NSLog(@"show camera");
	} else {
		NSLog(@"show camera roll");
	}
}

@end
