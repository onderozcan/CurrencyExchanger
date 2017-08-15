//
//  currencyData.m
//  CurrencyExchange
//
//  Created by Önder ÖZCAN on 15/08/2017.
//  Copyright © 2017 pixelblind. All rights reserved.
//

#import "currencyData.h"
static float amountUSD;
static float amountEuro;
static float amountGBP;
static currencyData *cData;


@implementation currencyData

+(currencyData *)sharedManager
{
    
    if (cData == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            cData = [[currencyData alloc] init];
            
        });
    }
    
    return cData;
}


-(id)init{
    
    if (self = [super init]) {
        

    }
    
    return self;
}

+(void)setUSD:(float)amount{
    
    amountUSD = amount;
}

+(float)getUSD{
    
    return amountUSD;
}

+(void)setEur:(float)amount{
    
    amountEuro = amount;
}

+(float)getEur{
    
    return amountEuro;
}

+(void)setGBP:(float)amount{
    
    amountGBP = amount;
}

+(float)getGBP{
    
    return amountGBP;
}

@end
