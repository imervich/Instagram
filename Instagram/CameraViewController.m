//
//  CameraViewController.m
//  Instagram
//
//  Created by Iván Mervich on 8/20/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "CameraViewController.h"

#define showShareScreenSegue @"showShareScreenSegue"

@interface CameraViewController ()

@end

@implementation CameraViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	// check if camera is available
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
		//camera is available, so show an alert to let the user choose
		NSLog(@"show camera");
        UIAlertView *sourceChooser = [[UIAlertView alloc] initWithTitle:@"Choose Picture Source" message:@"Do you want to take a picture or select one from the gallery?" delegate:self cancelButtonTitle:@"Camera" otherButtonTitles:@"Gallery", nil];
        [sourceChooser show];
	} else {
        //there is no camera available, so only camera roll
		NSLog(@"show camera roll");
        
	}
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = NO;
}

@end
