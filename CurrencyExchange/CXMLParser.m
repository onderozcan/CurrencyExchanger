//
//  CXMLParser.m
//  CurrencyExchange
//
//  Created by Önder ÖZCAN on 14/08/2017.
//  Copyright © 2017 pixelblind. All rights reserved.
//
#pragma mark Currency XML Parser
#import "CXMLParser.h"
static NSXMLParser *cParser;
static CXMLParser *adapter;
static NSString *currentTag;
static NSMutableDictionary *currencyPool;

@implementation CXMLParser
@synthesize delegate;


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


-(id)initWithURL:(NSURL *)currencyDataURL{

    cParser = [[NSXMLParser alloc] initWithContentsOfURL:currencyDataURL];
    cParser.delegate = self;
    [cParser parse];
    return self;
}

- (void)parserDidStartDocument:(NSXMLParser *)parser{
    
    //Document Starts...
    
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

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    // if current tag is Name
    if([currentTag isEqualToString:@"currency"]){
        NSString *text = string;
        NSLog(@"Currency Value =%@",text);
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"Name"]){
        NSLog(@"Name end");
        // Do what's necessary..
    }
    // set current tag as nil
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    
    //Document Ends...
    if([currencyPool isKindOfClass:[NSMutableDictionary class]] && currencyPool.count >0 ){
    
        [self.delegate adapterReady:currencyPool];
        
    } else {
        
        [delegate adapterParseError:@"Adapter could not find any currency object. Please check your XML url and try again."];
    }
    
}

@end
