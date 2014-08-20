//
//  User.h
//  Instagram
//
//  Created by Gustavo Parrado on 19/8/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property NSString *name;
@property NSString *username;
@property NSString *email;
@property NSNumber *userID;
@property BOOL verified;
@property int followers;
@property int following;
@property int posts;
@property UIImage *avatar;

@end
