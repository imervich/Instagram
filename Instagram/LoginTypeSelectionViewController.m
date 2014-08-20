//
//  ViewController.m
//  Instagram
//
//  Created by Iván Mervich on 8/19/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "LoginTypeSelectionViewController.h"
#import <Parse/Parse.h>

#define showTabScreenSegue @"showTabScreenSegue"

@interface LoginTypeSelectionViewController ()

@end

@implementation LoginTypeSelectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    PFUser *user = [PFUser user];
    user.username = @"Gustavo";
    user.password = @"my pass";
    user.email = @"gus@example.com";
    
    // other fields can be set if you want to save more information
    user[@"device"] = @"moto-x";
    user[@"prefered_os"] = @"android";
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hooray! Let them use the app now.
        } else {
            NSString *errorString = [error userInfo][@"error"];
            NSLog(@"%@",errorString);
        }
    }];
	// TODO:
	// if user is not logged in, perform segue showTabScreenSegue
//	BOOL loggedIn = YES;
//	if (loggedIn) {
//		[self performSegueWithIdentifier:showTabScreenSegue sender:self];
//	}
	
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = YES;
}

@end
