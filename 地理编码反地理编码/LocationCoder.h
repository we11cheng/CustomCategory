//
//  LocationCoder.h
//  gwctest
//
//  Created by apple on 7/28/16.
//  Copyright © 2016 com.dayangdata.gwc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@class LocationCoder;

#pragma mark - block
typedef void(^resultBlock_t)(NSArray *placemarks, NSError *error, LocationCoder *locationCoder);

#pragma mark - 代理
@protocol LocationCoderDelegate <NSObject>
@optional
- (void)resultForPlacemarks:(NSArray *)placemarks
                      error:(NSError *)error
              locationCoder:(LocationCoder *)locationCoder;
@end


@interface LocationCoder : NSObject

// 初始化时设定的值
@property (nonatomic, strong, readwrite) CLLocation    *location;            // 经纬度地址
@property (nonatomic, strong, readwrite) NSString      *addressString;       // 文字描述地址

// block方式取结果
@property (nonatomic, copy)              resultBlock_t  resultBlock;         // 结果的block

// 代理方式取结果
@property (nonatomic, assign)            id<LocationCoderDelegate> delegate; // 结果代理

// KVO方式取结果
@property (nonatomic, strong, readonly)  NSString      *changeFlag;          // 用于KVO
@property (nonatomic, strong, readonly)  NSArray       *placemarks;          // 结果

// 单个的结果
@property (nonatomic, assign, readonly)  CLLocationCoordinate2D  coordinate2D;      // 经纬度
@property (nonatomic, strong, readonly)  NSString               *addressLines;      // 完整的地址
@property (nonatomic, strong, readonly)  NSDictionary           *addressDictionary; // 地址字典

// 初始化
- (instancetype)initWithLocation:(CLLocation *)location;
- (instancetype)initWithAddressString:(NSString *)string;

// 开始分析
- (void)startAnalyseLocation;       // 分析经纬度地址
- (void)startAnalyseAddressString;  // 分析文字描述地址
/*
    NSString *address =@"上海市黄浦区北海路8号";
    LocationCoder *loc =[[LocationCoder alloc] initWithAddressString:address];
    [loc startAnalyseAddressString];
    loc.resultBlock=^(NSArray *placemarks, NSError *error, LocationCoder *locationCoder) {
        NSLog(@"_______::%f",locationCoder.coordinate2D.latitude);
    };
 */

/*
    CLLocation *location =[[CLLocation alloc] initWithLatitude:23.43445 longitude:117.134083];
    LocationCoder *loc =[[LocationCoder alloc] initWithLocation:location];
    [loc startAnalyseLocation];
    loc.resultBlock=^(NSArray *placemarks, NSError *error, LocationCoder *locationCoder) {
    NSLog(@"_______::%@",locationCoder.addressDictionary);
};
 */

@end
