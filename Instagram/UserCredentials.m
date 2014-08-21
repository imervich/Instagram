//
//  UserSignUp.m
//  Instagram
//
//  Created by Gustavo Parrado on 19/8/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "UserCredentials.h"

@implementation UserCredentials


-(void)signUp:(NSString*)username email:(NSString*)email password:(NSString*)password
{
    PFUser *user = [PFUser user];
    user.username = username;
    user.password = password;
    user.email = email;
    
    // other fields can be set if you want to save more information
    //user[@"device"] = @"moto-x";
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [self.delegate userIsNew];
        } else {
            NSString *errorString = [error userInfo][@"error"];
            [self.delegate requestGotError:errorString];
        }
    }];
}

-(void)loginWithParse:(NSString*)username password:(NSString*)password
{
    [PFUser logInWithUsernameInBackground:username password:password
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            [self.delegate userLoggedIn];
                                        } else {
                                            NSString *errorString = [error userInfo][@"error"];
                                            [self.delegate requestGotError:errorString];
                                        }
                                    }];
}

-(void)loginWithFacebook
{
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        if (!user) {
            if (!error) {
                [self.delegate requestGotError:@"Uh oh. The user cancelled the Facebook login."];
            } else {
                NSString *errorString = [error userInfo][@"error"];
                [self.delegate requestGotError:errorString];
            }
        } else if (user.isNew) {
            NSLog(@"User with facebook signed up and logged in!");
            [self.delegate userIsNew];
        } else {
            NSLog(@"User with facebook logged in!");
            [self.delegate userLoggedIn];
		}
    }];
}

@end
