//
//  AppStoreInfoModel.h
//  safeepay-ios-new
//
//  Created by san_xu on 2017/3/30.
//  Copyright © 2017年 com.app.huakala. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppStoreInfoModel : NSObject

/**
 *  版本号
 */
@property(nonatomic,copy) NSString * version;

/**
 *  更新日志
 */
@property(nonatomic,copy)NSString *releaseNotes;

/**
 *  更新时间
 */
@property(nonatomic,copy)NSString *currentVersionReleaseDate;

/**
 *  APPId
 */
@property(nonatomic,copy)NSString *trackId;

/**
 *  bundleId
 */
@property(nonatomic,copy)NSString *bundleId;

/**
 *  AppStore地址
 */
@property(nonatomic,copy)NSString *trackViewUrl;

/**
 *  开发商
 */
@property(nonatomic,copy)NSString *sellerName;

/**
 *  文件大小
 */
@property(nonatomic,copy)NSString *fileSizeBytes;

/**
 *  展示图
 */
@property(nonatomic,strong)NSArray *screenshotUrls;

//返回的所有字段
/*
 {
   resultCount = 1;
   results = (
                 {
                     advisories = ();
                     appletvScreenshotUrls = ();
                     artistId = 1144060699;
                     artistName = "\U5b89\U987a\U5929\U6210\U4fe1\U606f\U79d1\U6280(\U82cf\U5dde)\U6709\U9650\U516c\U53f8";
                     artistViewUrl = "https://itunes.apple.com/cn/developer/%E5%AE%89%E9%A1%BA%E5%A4%A9%E6%88%90%E4%BF%A1%E6%81%AF%E7%A7%91%E6%8A%80-%E8%8B%8F%E5%B7%9E-%E6%9C%89%E9%99%90%E5%85%AC%E5%8F%B8/id1144060699?uo=4";
                     artworkUrl100 = "http://is2.mzstatic.com/image/thumb/Purple91/v4/aa/4f/0c/aa4f0cd0-a08a-aa21-4a1e-aec82b558ad2/source/100x100bb.jpg";
                     artworkUrl512 = "http://is2.mzstatic.com/image/thumb/Purple91/v4/aa/4f/0c/aa4f0cd0-a08a-aa21-4a1e-aec82b558ad2/source/512x512bb.jpg";
                     artworkUrl60 = "http://is2.mzstatic.com/image/thumb/Purple91/v4/aa/4f/0c/aa4f0cd0-a08a-aa21-4a1e-aec82b558ad2/source/60x60bb.jpg";
                     bundleId = "com.app.huakala";
                     contentAdvisoryRating = "4+";
                     currency = CNY;
                     currentVersionReleaseDate = "2017-03-21T23:10:54Z";
                     description = "\U4e3a\U4e86\U7528\U6237\U80fd\U968f\U65f6\U968f\U5730\U3001\U65b9\U4fbf\U5feb\U6377\U7684\U5b8c\U6210\U6536\U6b3e\Uff0c\U7528\U6237\U53ea\U9700\U901a\U8fc7\U5b9e\U540d\U8ba4\U8bc1\U3001\U4fe1\U7528\U5361\U8ba4\U8bc1\U548c\U6536\U6b3e\U8ba4\U8bc1\Uff0c\U5b9e\U65f6\U5230\U8d26\Uff01\n\U7279\U70b9\Uff1a\n        \U65b9\U4fbf\U5feb\U6377\Uff0c\U5b9e\U65f6\U5230\U8d26\n        \U968f\U65f6\U968f\U5730\Uff0c\U8f7b\U677e\U6536\U6b3e\n        \U7b80\U5355\U5b9e\U7528\Uff0c\U53ea\U9700\U624b\U673a\n\U529f\U80fd\Uff1a\n       1\Uff1a\U6536\U6b3e\n       2\Uff1a\U5b9e\U540d\U8ba4\U8bc1\n       3\Uff1a\U4fe1\U7528\U5361\U9274\U6743\n       4\Uff1a\U94f6\U884c\U5361\U9274\U6743\n       5\Uff1a\U5fae\U4fe1\U626b\U7801\U6536\U6b3e\n       6\Uff1a\U65e0\U5361\U6536\U6b3e\n\n\U6e29\U99a8\U63d0\U793a\Uff1a\n    \U626b\U5457\U652f\U4ed8\U5c06\U4f7f\U7528\U60a8\U7684\U4f4d\U7f6e\U4fe1\U606f";
                     features = ();
                     fileSizeBytes = 47066112;
                     formattedPrice = "\U514d\U8d39";
                     genreIds = (6000);
                     genres = ( "\U5546\U52a1");
                     ipadScreenshotUrls = ();
                     isGameCenterEnabled = 0;
                     isVppDeviceBasedLicensingEnabled = 1;
                     kind = software;
                     languageCodesISO2A = (EN);
                     minimumOsVersion = "8.0";
                     price = 0;
                     primaryGenreId = 6000;
                     primaryGenreName = Business;
                     releaseDate = "2016-09-08T14:42:01Z";
                     
                     sellerName = "Anshun Tiancheng Information Technology (Suzhou) Co.,Ltd.";
                     sellerUrl = "http://huakala.com";
                     supportedDevices = (
                                 "iPad2Wifi-iPad2Wifi",
                                 "iPad23G-iPad23G",
                                 "iPhone4S-iPhone4S",
                                 "iPadThirdGen-iPadThirdGen",
                                 "iPadThirdGen4G-iPadThirdGen4G",
                                 "iPhone5-iPhone5",
                                 "iPodTouchFifthGen-iPodTouchFifthGen",
                                 "iPadFourthGen-iPadFourthGen",
                                 "iPadFourthGen4G-iPadFourthGen4G",
                                 "iPadMini-iPadMini",
                                 "iPadMini4G-iPadMini4G",
                                 "iPhone5c-iPhone5c",
                                 "iPhone5s-iPhone5s",
                                 "iPadAir-iPadAir",
                                 "iPadAirCellular-iPadAirCellular",
                                 "iPadMiniRetina-iPadMiniRetina",
                                 "iPadMiniRetinaCellular-iPadMiniRetinaCellular",
                                 "iPhone6-iPhone6",
                                 "iPhone6Plus-iPhone6Plus",
                                 "iPadAir2-iPadAir2",
                                 "iPadAir2Cellular-iPadAir2Cellular",
                                 "iPadMini3-iPadMini3",
                                 "iPadMini3Cellular-iPadMini3Cellular",
                                 "iPodTouchSixthGen-iPodTouchSixthGen",
                                 "iPhone6s-iPhone6s",
                                 "iPhone6sPlus-iPhone6sPlus",
                                 "iPadMini4-iPadMini4",
                                 "iPadMini4Cellular-iPadMini4Cellular",
                                 "iPadPro-iPadPro",
                                 "iPadProCellular-iPadProCellular",
                                 "iPadPro97-iPadPro97",
                                 "iPadPro97Cellular-iPadPro97Cellular",
                                 "iPhoneSE-iPhoneSE",
                                 "iPhone7-iPhone7",
                                 "iPhone7Plus-iPhone7Plus",
                                 "iPad611-iPad611",
                                 "iPad612-iPad612"
                     );
                     trackCensoredName = "\U626b\U5457\U652f\U4ed8";
                     trackContentRating = "4+";
                     trackId = 1144060700;
                     trackName = "\U626b\U5457\U652f\U4ed8";
                     trackViewUrl = "https://itunes.apple.com/cn/app/%E6%89%AB%E5%91%97%E6%94%AF%E4%BB%98/id1144060700?mt=8&uo=4";
                     version = "1.0.6";
                     wrapperType = software;
                 }
            );
     }
 */

@end
