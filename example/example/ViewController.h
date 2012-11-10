//
//  ViewController.h
//  example
//
//  Created by HungChun on 12/11/10.
//  Copyright (c) 2012年 HungChun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCGridVIew.h"
@interface ViewController : UIViewController <HCGridViewDelegate>
{
  HCGridView *_gridView;
}
@end
