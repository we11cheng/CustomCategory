//
//  NSObject+Property.h
//  gwctest
//
//  Created by apple on 7/22/16.
//  Copyright © 2016 com.dayangdata.gwc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Property)
- (NSDictionary *)getAllPropertiesAndVaules;
- (NSArray *)getAllProperties;
-(void)getAllMethods;
@end
