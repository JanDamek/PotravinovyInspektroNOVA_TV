//
//  comSotedImage.h
//  Potravinovy inspektor TV NOVA
//
//  Created by Jan Damek on 07.04.13.
//  Copyright (c) 2013 Asseco Solutions, a.s. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface comStoredImage : NSObject <NSCoding, NSCopying>

@property (readonly, getter = image) UIImage *image;
@property (strong, nonatomic, readonly) UIImage *thumbnails;
@property (strong, nonatomic, readonly) NSString *key;

+(NSString *)GetUUID;
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
-(id)initWithImage:(UIImage*)image forKey:(NSString*)key;
-(void)removeImage;

@end

@interface NSMutableArray (imageStored)

-(void)removeImageAtIndex:(NSUInteger)index;

@end
