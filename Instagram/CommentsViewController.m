//
//  CommentsViewController.m
//  Instagram
//
//  Created by Iván Mervich on 8/20/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "CommentsViewController.h"
#import "Event.h"
#import "Photo.h"
#import "UserProfileViewController.h"

#define CommentCell @"CommentCell"

// segue
#define showUserProfileSegue @"showUserProfileSegue"

@interface CommentsViewController () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *fakeTextField;

@property (weak, nonatomic) IBOutlet UIView *accessoryView;
@property (weak, nonatomic) IBOutlet UITextField *commentTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSArray *comments;

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
	[self performQuery];
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
	NSString *commentText = self.commentTextField.text;
	if (commentText.length > 0) {

		Event *comment = [Event object];
		comment.type = @"comment";
		comment.photo = self.photo;
		// comment text
		comment.details = commentText;
		// who is commenting
		comment.origin = [PFUser currentUser];
		// whose photo is it
		comment.destination = self.photo.user;

		[comment saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
			if (!error) {
				if (succeeded) {
					NSLog(@"post comment %@", comment);
					[self performQuery];
				}
			} else {
				NSLog(@"Error posting comment %@ %@", error, error.userInfo);
			}
		}];

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
	return self.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	Event *comment = self.comments[indexPath.row];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentCell];

	UIButton *userImageButton = (UIButton *)[cell viewWithTag:1];

	// set the user profile pic
	PFFile *file = self.photo.user[@"avatar"];
	if (file) {
		[file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {

			if (!error) {
				if (data) {
					UIImage *image = [UIImage imageWithData:data];
					userImageButton.imageView.image = image;
				}
			} else {
				NSLog(@"Error getting user profile pic on comment %@ %@", error, error.userInfo);
			}

			[self setViewRoundCorners:userImageButton];
		}];
	}

	UILabel *usernameLabel =  (UILabel *)[cell viewWithTag:2];
	usernameLabel.text = comment.origin.username;

	UILabel *commentLabel =  (UILabel *)[cell viewWithTag:3];
	commentLabel.text = comment.details;

	return cell;
}

#pragma mark - IBActions

- (IBAction)onSendButtonTapped:(UIButton *)sender
{
	// post comment on send button tapped
	[self postComment];
}

- (IBAction)onUserImageButtonTapped:(UIButton *)sender
{
	UITableViewCell *cell = (UITableViewCell *)sender.superview;
	NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
	Event *comment = self.comments[indexPath.row];
	[self performSegueWithIdentifier:showUserProfileSegue sender:comment.origin];
}

#pragma mark - Helper methods

- (void)performQuery
{
	PFQuery *commentsQuery = [PFQuery queryWithClassName:@"Event"];
	[commentsQuery whereKey:@"type" equalTo:@"comment"];
	//	[commentsQuery whereKey:@"destination" equalTo:self.photo.user];
	[commentsQuery whereKey:@"photo" equalTo:self.photo];
	[commentsQuery includeKey:@"photo"];
	[commentsQuery includeKey:@"origin"];

	[commentsQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
		if (!error) {
			self.comments = objects;
			NSLog(@"found %d comments for this photo", objects.count);
			[self.tableView reloadData];
		} else {
			NSLog(@"Error getting comments for photo %@ - %@ %@", self.photo, error, error.userInfo);
		}
	}];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(PFUser *)sender
{
	if ([segue.identifier isEqualToString:showUserProfileSegue]) {
		UserProfileViewController *userProfileVC = segue.destinationViewController;
		userProfileVC.user = sender;
		userProfileVC.hidesBottomBarWhenPushed = YES;
	}
}

- (void)setViewRoundCorners:(UIView *)view
{
	view.layer.cornerRadius = view.bounds.size.width / 2;
	view.layer.masksToBounds = YES;
}


@end
