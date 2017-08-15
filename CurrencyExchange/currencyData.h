//
//  currencyData.h
//  CurrencyExchange
//
//  Created by Önder ÖZCAN on 15/08/2017.
//  Copyright © 2017 pixelblind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface currencyData : NSObject

+(currencyData *)sharedManager;

+(float)getUSD;
+(void)setUSD:(float)amount;


+(float)getEur;
+(void)setEur:(float)amount;

+(float)getGBP;
+(void)setGBP:(float)amount;

@end
