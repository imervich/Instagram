//
//  UserSignUp.h
//  Instagram
//
//  Created by Gustavo Parrado on 19/8/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol userCredentialsDelegate <NSObject>
@required
-(void)userLoggedIn;
-(void)userIsNew;
@optional
-(void)requestGotError:(NSString*)error;

@end

@interface UserCredentials : NSObject

@property id<userCredentialsDelegate>delegate;

-(void)signUp:(NSString*)username email:(NSString*)email password:(NSString*)password;
-(void)loginWithParse:(NSString*)username password:(NSString*)password;
-(void)loginWithFacebook;

@end
