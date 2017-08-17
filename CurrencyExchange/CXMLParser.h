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

-(void)adapterHasFinishedParsingWithDictionary:(NSDictionary *)data;
@end
@interface CXMLParser : NSObject<NSXMLParserDelegate>
+(CXMLParser *)sharedManager;
-(void)parseCurrency;
@property (retain) id <CXMLParserDelegate> delegate;

@end
