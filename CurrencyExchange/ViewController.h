//
//  ViewController.h
//  CurrencyExchange
//
//  Created by Önder ÖZCAN on 14/08/2017.
//  Copyright © 2017 pixelblind. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController




@property (weak, nonatomic) IBOutlet UITextField *fieldCurrency1;
@property (weak, nonatomic) IBOutlet UITextField *fieldCurrency2;

@property (weak, nonatomic) IBOutlet UIButton *buttonCurrency1;
@property (weak, nonatomic) IBOutlet UIButton *buttonCurrency2;

@property (weak, nonatomic) IBOutlet UIButton *buttonExchange;
@property (weak, nonatomic) IBOutlet UILabel *labelExchangeRate;

@end
