//
//  CurrencyCell.h
//  CurrencyExchange
//
//  Created by Önder ÖZCAN on 16/08/2017.
//  Copyright © 2017 pixelblind. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrencyCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelCurrency1;
@property (weak, nonatomic) IBOutlet UILabel *labelCurrency2;

@property (weak, nonatomic) IBOutlet UITextField *fieldInput1;
@property (weak, nonatomic) IBOutlet UITextField *fieldInput2;


@property (weak, nonatomic) IBOutlet UILabel *labelBalance1;
@property (weak, nonatomic) IBOutlet UILabel *labelBalance2;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl1;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl2;


@end
