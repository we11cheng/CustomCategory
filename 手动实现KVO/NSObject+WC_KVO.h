//
//  NSObject+WC_KVO.h
//  TestGwc
//
//  Created by admin on 09/04/2018.
//  Copyright © 2018 guanweicheng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^WCObservingBlock)(id observedObject, NSString *observedKey, id oldValue, id newValue);

@interface NSObject (WC_KVO)

- (void)WC_addObserver:(NSObject *)observer
                forKey:(NSString *)key
             withBlock:(WCObservingBlock)block;

- (void)WC_removeObserver:(NSObject *)observer forKey:(NSString *)key;

@end
