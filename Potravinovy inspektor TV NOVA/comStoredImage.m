//
//  comSotedImage.m
//  Potravinovy inspektor TV NOVA
//
//  Created by Jan Damek on 07.04.13.
//  Copyright (c) 2013 Asseco Solutions, a.s. All rights reserved.
//

#import "comStoredImage.h"
#import "comAppDelegate.h"

@implementation comStoredImage

@synthesize image, key, thumbnails;

+ (NSString *)GetUUID
{
    NSString * result;
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    
    result =[NSString stringWithFormat:@"%@", string];
    assert(result != nil);
    
    //NSLog(@"%@",result);
    return result;
}

+ (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

-(NSString*)keyFileName{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    
    return [basePath stringByAppendingPathComponent:[NSString stringWithFormat:@"i_%@.png",self.key]];
}
-(void)storeToFile:(UIImage*)_image{
    comAppDelegate *d = [[UIApplication sharedApplication]delegate];
    [d addAnimationIndicator];
    
    NSData *img = UIImagePNGRepresentation([comStoredImage imageWithImage:_image scaledToSize:CGSizeMake(_image.size.width*0.75, _image.size.width*0.75)]);
    [img writeToFile:[self keyFileName] atomically:YES];
    
    [d removeAnimationIndicator];
}
-(id)initWithImage:(UIImage *)_image forKey:(NSString *)_key{
    comAppDelegate *d = [[UIApplication sharedApplication]delegate];
    [d addAnimationIndicator];

    self = [super init];
    if (self){
        if (![_key isEqualToString:@""]){
            key = _key;
        }else
            key = [comStoredImage GetUUID];
        
        thumbnails = [comStoredImage imageWithImage:_image scaledToSize:CGSizeMake(165, 165)];

        [self performSelectorInBackground:@selector(storeToFile:) withObject:_image];
    }
    [d removeAnimationIndicator];

    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self= [super init];
    if (self){
        
        NSData *img = [aDecoder decodeObjectForKey:@"thumbnails"];
        thumbnails = [UIImage imageWithData:img];
        
        key = [aDecoder decodeObjectForKey:@"key"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    NSData *img = UIImagePNGRepresentation(self.thumbnails);
    [aCoder encodeObject:img forKey:@"thumbnails"];
    
    [aCoder encodeObject:self.key forKey:@"key"];
}

-(UIImage*)image{
    comAppDelegate *d = [[UIApplication sharedApplication]delegate];
    [d addAnimationIndicator];

    NSData *img = [[NSData alloc]initWithContentsOfFile:[self keyFileName]];
    
    [d removeAnimationIndicator];

    return [UIImage imageWithData:img];
}

-(id)copyWithZone:(NSZone *)zone{
    comStoredImage *c = [[comStoredImage allocWithZone:zone]initWithImage:self.image forKey:self.key];
    return c;
}

-(void)removeImage{
    [[NSFileManager defaultManager]removeItemAtPath:[self keyFileName] error:nil];
}

@end


@implementation NSMutableArray (imageStored)

-(void)removeImageAtIndex:(NSUInteger)index{
    NSObject *o = [self objectAtIndex:index];
    if ([o isKindOfClass:[comStoredImage class]]){
        [(comStoredImage*)o removeImage];
    }
    [self removeObjectAtIndex:index];
}

@end