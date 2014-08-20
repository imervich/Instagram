//
//  Photo.h
//  Instagram
//
//  Created by Gustavo Parrado on 19/8/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

@interface Photo : PFObject<PFSubclassing>
+ (NSString *)parseClassName;

@property int photoID;
@property int userID;
@property (retain) NSString *url;
@property (retain) UIImage *image;
@property int likes;
@property (retain) PFGeoPoint *location;

@end
