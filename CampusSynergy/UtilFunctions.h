//
//  UtilFunctions.h
//  CampusSynergy
//
//  Created by feifan meng on 8/30/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface UtilFunctions : NSObject

+ (NSMutableString *) returnMyJSONString;
//static method to get 
+(NSString *)getEventsFromParseASJSON:(NSMutableString *)my_json_object;

@end