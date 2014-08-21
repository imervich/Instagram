//
//  TabBarViewController.m
//  Instagram
//
//  Created by Iván Mervich on 8/19/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "TabBarViewController.h"

#define showLoginOptionsScreenSegue @"showLoginOptionsScreenSegue"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];

	[self checkForLoggedUser];
}

- (void)checkForLoggedUser
{
    NSLog(@"check for user");
	// check if user is logged in, if not, perform segue showLoginOptionsScreenSegue
	if (![PFUser currentUser] ) {
		[self performSegueWithIdentifier:showLoginOptionsScreenSegue sender:self];
    }
}

@end