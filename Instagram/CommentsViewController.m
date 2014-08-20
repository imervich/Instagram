//
//  CommentsViewController.m
//  Instagram
//
//  Created by Iván Mervich on 8/20/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "CommentsViewController.h"

@interface CommentsViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *fakeTextField;

@property (weak, nonatomic) IBOutlet UIView *accessoryView;
@property (weak, nonatomic) IBOutlet UITextField *commentTextField;

@end

@implementation CommentsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];


	[self.fakeTextField becomeFirstResponder];
	// observe keyboard hide and show notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];

	[[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
	NSLog(@"will show");
	[self.commentTextField becomeFirstResponder];

}
//
- (void)keyboardWillHide:(NSNotification *)notification
{
	[self.commentTextField resignFirstResponder];
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if ([textField isEqual:self.fakeTextField]) {

		if (!self.fakeTextField.inputAccessoryView) {
			self.fakeTextField.inputAccessoryView = self.accessoryView;
		}
	}
	return YES;
}
@end
