//
//  MainViewController.h
//  CaltureEquitySystem
//
//  Created by mac on 14-9-4.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LeveyTabBarController;
@interface MainViewController : UITabBarController<UINavigationControllerDelegate>
{
    LeveyTabBarController *leveyTabBarController;
}

@property (nonatomic, strong) IBOutlet LeveyTabBarController *leveyTabBarController;

@end
