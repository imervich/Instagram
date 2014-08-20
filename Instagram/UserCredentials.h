//
//  UserSignUp.h
//  Instagram
//
//  Created by Gustavo Parrado on 19/8/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol userCredentialsDelegate <NSObject>

-(id)userLoggedIn;

@end

@interface UserCredentials : NSObject



-(void)signUp:(NSString*)username email:(NSString*)email password:(NSString*)password;
-(void)loginWithParse:(NSString*)username password:(NSString*)password;
@end