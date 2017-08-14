//
//  testDelegate.h
//  CurrencyExchange
//
//  Created by Önder ÖZCAN on 15/08/2017.
//  Copyright © 2017 pixelblind. All rights reserved.
//

#import <Foundation/Foundation.h>

@class testDelegate;

@protocol testDelegateDelegate <NSObject>
-(void)isReady;
@end

@interface testDelegate : NSObject

@property (weak,nonatomic) id<testDelegateDelegate> delegate;

@end
