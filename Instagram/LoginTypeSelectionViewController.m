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

#pragma mark - IBActions

- (IBAction)onFacebookLoginButtonTapped:(UIButton *)sender
{
	NSLog(@"login with facebook");
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        //[_activityIndicator stopAnimating]; // Hide loading indicator
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:@"Uh oh. The user cancelled the Facebook login." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:[error description] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            }
        } else if (user.isNew) {
            NSLog(@"User with facebook signed up and logged in!");
            [self performSegueWithIdentifier:showTabScreenSegue sender:self];
        } else {
            NSLog(@"User with facebook logged in!");
            [self performSegueWithIdentifier:showTabScreenSegue sender:self];
        }
    }];
    //[_activityIndicator startAnimating];

}

@end
