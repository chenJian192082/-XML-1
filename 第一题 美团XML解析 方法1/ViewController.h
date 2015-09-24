//
//  ViewController.h
//  第一题 美团XML解析 方法1
//
//  Created by 陈建的appple on 15/9/8.
//  Copyright (c) 2015年 陈建的app. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<NSXMLParserDelegate,UITableViewDataSource,UITableViewDelegate>
//可变数组存放所有城市的信息
@property(strong,nonatomic)NSMutableArray *arrInfo;

//可变字典存放某个城市的信息
@property(strong,nonatomic)NSMutableDictionary *dicInfo;

//传值的文本
@property(strong,nonatomic)NSString  *text;

@property(strong,nonatomic)UITableView *myTableview;
@end

