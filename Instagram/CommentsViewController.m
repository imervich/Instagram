//
//  CommentsViewController.m
//  Instagram
//
//  Created by Iván Mervich on 8/20/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "CommentsViewController.h"

#define CommentCell @"CommentCell"

@interface CommentsViewController () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *fakeTextField;

@property (weak, nonatomic) IBOutlet UIView *accessoryView;
@property (weak, nonatomic) IBOutlet UITextField *commentTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


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
	// set the commentTextField as the first responder when the keyboard shows up
	[self.commentTextField becomeFirstResponder];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
	[self.commentTextField resignFirstResponder];
}

- (void)postComment
{
	NSString *comment = self.commentTextField.text;
	if (comment.length > 0) {
		NSLog(@"post comment %@",comment);
		[self.commentTextField resignFirstResponder];
		[self.fakeTextField resignFirstResponder];
	}
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	// hack to set the keyboard's accessory view
	if ([textField isEqual:self.fakeTextField]) {
		if (!self.fakeTextField.inputAccessoryView) {
			self.fakeTextField.inputAccessoryView = self.accessoryView;
		}
	}
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	// post comment on enter key pressed
	[self postComment];
	return YES;
}

#pragma mark - UITableView DataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentCell];

	UIButton *userImageButton = (UIButton *)[cell viewWithTag:1];
	[self setViewRoundCorners:userImageButton];

//	UILabel *usernameLabel =  (UILabel *)[cell viewWithTag:2];
	// TODO: set username

//	UILabel *commentLabel =  (UILabel *)[cell viewWithTag:3];
	// TODO: set comment

	return cell;
}



#pragma mark - IBActions

- (IBAction)onSendButtonTapped:(UIButton *)sender
{
	// post comment on send button tapped
	[self postComment];
}

#pragma mark - Helper methods

- (void)setViewRoundCorners:(UIView *)view
{
	view.layer.cornerRadius = view.bounds.size.width / 2;
	view.layer.masksToBounds = YES;
}


@end
