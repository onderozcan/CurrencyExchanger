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

- (void)parserDidFinishParsing:(CXMLParser *)parser withXMLData:(NSMutableDictionary *)data ;

@end

@interface CXMLParser : NSObject<NSXMLParserDelegate>

@property (nonatomic, weak) id<CXMLParserDelegate> delegate;


+(CXMLParser *)sharedManager;

@end
