//
//  Photo.h
//  Instagram
//
//  Created by Gustavo Parrado on 19/8/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject

@property int photoID;
@property int userID;
@property NSString *url;
@property UIImage *image;
@property int likes;
@property double latitude;
@property double longitude;

@end
