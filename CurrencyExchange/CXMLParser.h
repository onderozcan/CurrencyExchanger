//
//  CXMLParser.h
//  CurrencyExchange
//
//  Created by Önder ÖZCAN on 14/08/2017.
//  Copyright © 2017 pixelblind. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CXMLParser;

@protocol CXMLParserDelegate <NSObject>
@optional

- (void)adapterReady:(NSMutableDictionary *)currencyData;
- (void)adapterParseError:(NSString *)error;

@end

@interface CXMLParser : NSObject<NSXMLParserDelegate>

-(id)initWithURL:(NSURL *)currencyDataURL;
+(CXMLParser *)sharedManager;
@property (nonatomic, weak) id<CXMLParserDelegate> delegate;

@end
