//
//  CXMLParser.m
//  CurrencyExchange
//
//  Created by Önder ÖZCAN on 14/08/2017.
//  Copyright © 2017 pixelblind. All rights reserved.
//
#pragma mark Currency XML Parser
#define currencyURL @"http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml"

#import "CXMLParser.h"

static CXMLParser *adapter;
static NSXMLParser *cParser;
static NSString *currentTag;
static NSMutableDictionary *currencyPool;

@implementation CXMLParser


+(CXMLParser *)sharedManager
{
    
    if (adapter == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            currencyPool = [[NSMutableDictionary alloc] init];
            adapter = [[CXMLParser alloc] init];
            
        });
    }
    
    return adapter;
}


-(id)init{

    
    if (self = [super init]) {
        
        if([NSURL URLWithString:currencyURL]){
            
            cParser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:currencyURL]];
            cParser.delegate = self;
            [cParser parse];
        }
    }



    return self;
}

- (void)parserDidStartDocument:(NSXMLParser *)parser{
    
    //let the user know that parser has already started to parse XML.
    NSLog(@"Adapter has started to parse XML");
    
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    
    if ( [elementName isEqualToString:@"Cube"]){
        
        NSString *attrValue=[attributeDict valueForKey:@"currency"];
        
        if([attrValue isEqualToString:@"USD"] || [attrValue isEqualToString:@"EUR"] || [attrValue isEqualToString:@"GBP"]){
            NSString *currencyValue=[attributeDict valueForKey:@"rate"];
            NSLog(@"The currency is =%@ and the value is =%@",attrValue,currencyValue);
            NSNumber *currencyExchange = (NSNumber *)currencyValue;
            
            if(currencyExchange != nil){
                //save in to Dictionary
                [currencyPool setObject:currencyExchange forKey:attrValue];
            }

        }
        return;
    }
}



- (void)parserDidEndDocument:(NSXMLParser *)parser{
    
    //Document Ends...
    if([currencyPool isKindOfClass:[NSMutableDictionary class]] && currencyPool.count >0 ){
        
        if(self.delegate){
            [self.delegate parserDidFinishParsing:self withXMLData:currencyPool];

        }
        
    }
    
}

@end
