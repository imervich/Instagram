//
//  ViewController.m
//  Instagram
//
//  Created by Iván Mervich on 8/19/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "LoginTypeSelectionViewController.h"

#define showTabScreenSegue @"showTabScreenSegue"

@interface LoginTypeSelectionViewController ()

@end

@implementation LoginTypeSelectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

	// TODO:
	// if user is not logged in, perform segue showTabScreenSegue
	BOOL loggedIn = YES;
	if (loggedIn) {
		[self performSegueWithIdentifier:showTabScreenSegue sender:self];
	}
	
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = YES;
}

@end
