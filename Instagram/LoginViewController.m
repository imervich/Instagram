//
//  LoginViewController.m
//  Instagram
//
//  Created by Iván Mervich on 8/19/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "LoginViewController.h"

#define showTabScreenSegue @"showTabScreenSegue"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = NO;
}

@end
