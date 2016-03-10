//
//  Header.h
//  Car
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 麻静. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define Width CGRectGetWidth([UIScreen mainScreen].bounds)
#define Height CGRectGetHeight([UIScreen mainScreen].bounds)

#define informationUrl @"http://sitemap.chexun.com/chexun/getDataIntoJson.do?category=%ld&page=%d_%d"
#define chaiDataUrl @"http://sitemap.chexun.com/m/ccfnewsjson.do?count=10&page=%d"
#define chaiVideoDataUrl @"http://sitemap.chexun.com/m/ccvideojson.do?count=6&page=%d"
#define chaiVideoUrl @"http://sitemap.chexun.com/m/videonewsjson.do?id=%@"

#define picUrlString @"http://m.chexun.com/coopdata/www_content4.inc"


#pragma mark --- SYH

#define MorocleUrl @"http://api.tool.chexun.com/mobile/downBrandInfo.do"

#define MscleUrl @"http://api.tool.chexun.com/mobile/downSeriesInfo.do?brandId=%ld"

#define girlPictureUrl @"http://api.tool.chexun.com/mobile/downEventAlbumList.do?type=3"
#define carPictureUrl @"http://api.tool.chexun.com/mobile/downEventAlbumList.do?type=0"

#define detailUrl @"http://api.tool.chexun.com/mobile/downEventAlbumPhotoList.do?albumId=%ld"



#endif /* Header_h */
