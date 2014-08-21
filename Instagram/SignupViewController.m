//
//  SignupViewController.m
//  Instagram
//
//  Created by Iván Mervich on 8/19/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "SignupViewController.h"

@interface SignupViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation SignupViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = NO;
}

-(void)alertWithText:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Retry", nil];
    [alert show];
}

#pragma mark - UITextField Delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];

    if ([self.usernameTextField.text isEqualToString:@""])
    {
        [self alertWithText:@"Username field can't be empty"];
    } else if ([self.emailTextField.text isEqualToString:@""])
    {
        [self alertWithText:@"E-Mail field can't be empty"];
    } else if ([self.passwordTextField.text isEqualToString:@""])
    {
        [self alertWithText:@"Password field can't be empty"];
    } else
    {
        [self.model signUp:self.usernameTextField.text email:self.emailTextField.text password:self.passwordTextField.text];
    }
	return YES;
}

@end
