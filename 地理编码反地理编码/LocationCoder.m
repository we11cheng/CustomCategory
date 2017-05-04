//
//  LocationCoder.m
//  gwctest
//
//  Created by apple on 7/28/16.
//  Copyright © 2016 com.dayangdata.gwc. All rights reserved.
//

#import "LocationCoder.h"

@interface LocationCoder ()

@property (nonatomic, strong) CLGeocoder *geocoder;     // 解析器
@property (nonatomic, strong) NSArray    *placemarks;
@property (nonatomic, strong) NSString   *changeFlag;   // 用于KVO

@property (nonatomic, strong) NSString                *addressLines;      // 完整的地址
@property (nonatomic, assign) CLLocationCoordinate2D   coordinate2D;      // 经纬度
@property (nonatomic, strong) NSDictionary            *addressDictionary; // 地址字典

@end

@implementation LocationCoder

- (instancetype)init
{
    return [self initWithLocation:nil];
}

- (instancetype)initWithLocation:(CLLocation *)location
{
    self = [super init];
    if (self)
    {
        _location   = location;
        _geocoder   = [[CLGeocoder alloc] init];
        _changeFlag = @"YES";
    }
    
    return self;
}

- (instancetype)initWithAddressString:(NSString *)string
{
    self = [super init];
    if (self)
    {
        _addressString = string;
        _geocoder      = [[CLGeocoder alloc] init];
        _changeFlag    = @"YES";
    }
    
    return self;
}

- (void)startAnalyseLocation
{
    if (_location)
    {
        [_geocoder reverseGeocodeLocation:_location
                        completionHandler:^(NSArray *placemarks, NSError *error)
         {
             // KVO(只有使用了setter方法才能够通知KVO)
             if (error == nil)
             {
                 self.placemarks = placemarks;
                 
                 CLPlacemark *placemark = [placemarks objectAtIndex:0];
                 
                 // 获取地址字典
                 self.addressDictionary = placemark.addressDictionary;
                 
                 // 获取详细地址
                 self.addressLines = \
                 [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
                 
                 // 获取2D坐标信息
                 self.coordinate2D = placemark.location.coordinate;
                 
                 // 通知KVO
                 self.changeFlag = @"RIGHT DATA";
             }
             else
             {
                 self.placemarks = nil;
                 self.changeFlag = @"ERROR DATA";
             }
             
             // block
             if (_resultBlock)
             {
                 _resultBlock(placemarks, error, self);
             }
             
             // 代理
             if (_delegate)
             {
                 [_delegate resultForPlacemarks:placemarks
                                          error:error
                                  locationCoder:self];
             }
         }];
    }
}

- (void)startAnalyseAddressString
{
    if (_addressString)
    {
        [_geocoder geocodeAddressString:_addressString
                      completionHandler:^(NSArray *placemarks, NSError *error) {
                          // KVO(只有使用了setter方法才能够通知KVO)
                          if (error == nil)
                          {
                              self.placemarks = placemarks;
                              
                              CLPlacemark *placemark = [placemarks objectAtIndex:0];
                              
                              // 获取地址字典
                              self.addressDictionary = placemark.addressDictionary;
                              
                              // 获取详细地址
                              self.addressLines = \
                              [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
                              
                              // 获取2D坐标信息
                              self.coordinate2D = placemark.location.coordinate;
                              
                              // 通知KVO
                              self.changeFlag = @"RIGHT DATA";
                          }
                          else
                          {
                              self.placemarks = nil;
                              self.changeFlag = @"ERROR DATA";
                          }
                          
                          // block
                          if (_resultBlock)
                          {
                              _resultBlock(placemarks, error, self);
                          }
                          
                          // 代理
                          if (_delegate)
                          {
                              [_delegate resultForPlacemarks:placemarks
                                                       error:error
                                               locationCoder:self];
                          }
                      }];
    }
}

@end
