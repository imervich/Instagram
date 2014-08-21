//
//  Photo.h
//  Instagram
//
//  Created by Gustavo Parrado on 19/8/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

@interface Photo : PFObject<PFSubclassing>
+ (NSString *)parseClassName;

@property (retain) UIImage *image;
@property int likes;
@property (retain) PFGeoPoint *location;
@property (retain) PFUser *user;
@property (retain) PFFile *file;

@end
