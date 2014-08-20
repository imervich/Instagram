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
            // move user object to a Singleton to access globally?
            
        } else {
            NSString *errorString = [error userInfo][@"error"];
            NSLog(@"%@",errorString);
        }
    }];
}

-(void)loginWithParse:(NSString*)username password:(NSString*)password
{
    [PFUser logInWithUsernameInBackground:username password:password
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // Do stuff after successful login.
                                        } else {
                                            // The login failed. Check error to see why.
                                        }
                                    }];
}

@end
