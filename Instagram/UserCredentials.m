//
//  UserSignUp.m
//  Instagram
//
//  Created by Gustavo Parrado on 19/8/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "UserCredentials.h"
#import <Parse/Parse.h>

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
            // Hooray! Let them use the app now.
        } else {
            NSString *errorString = [error userInfo][@"error"];
            NSLog(@"%@",errorString);
        }
    }];
}

@end
