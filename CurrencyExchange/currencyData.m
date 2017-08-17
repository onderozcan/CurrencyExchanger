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
static NSMutableDictionary *currencyDict;

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
        
        currencyDict = [[NSMutableDictionary alloc] init];

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

+(float)getBalanceWithName:(NSString *)currencyName{
    
    [self getAllCurrencies];
    float balance = [[currencyDict objectForKey:currencyName] floatValue];
    return balance;
}

+(void)setCurrency:(NSString *)currency1 andBalance:(float) balance1 andCurrency2:(NSString *)currency2 andBalance2:(float)balance2{
    
    [currencyDict setValue:[NSNumber numberWithFloat:balance1] forKey:currency1];
    [currencyDict setValue:[NSNumber numberWithFloat:balance2] forKey:currency2];
    //And set the currencies
    
    if([currency1 isEqualToString:@"USD"]){
        
        [self setUSD:balance1];
    }
    
    if([currency1 isEqualToString:@"GBP"]){
        
        [self setGBP:balance1];
    }
    
    if([currency1 isEqualToString:@"EUR"]){
        
        [self setEur:balance1];
    }
    
    if([currency2 isEqualToString:@"USD"]){
        
        [self setUSD:balance2];
    }
    
    if([currency2 isEqualToString:@"GBP"]){
        
        [self setGBP:balance2];
    }
    
    if([currency2 isEqualToString:@"EUR"]){
        
        [self setEur:balance2];
    }
    
}

+(NSDictionary *)getAllCurrencies{
    NSNumber *gbp = [NSNumber numberWithFloat:[self getGBP]];
    NSNumber *eur = [NSNumber numberWithFloat:[self getEur]];
    NSNumber *usd = [NSNumber numberWithFloat:[self getUSD]];
    [currencyDict setObject:eur forKey:@"EUR"];
    [currencyDict setObject:usd forKey:@"USD"];
    [currencyDict setObject:gbp forKey:@"GBP"];
    return currencyDict;
}

@end
