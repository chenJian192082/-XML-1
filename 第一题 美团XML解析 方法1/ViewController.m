//
//  ViewController.m
//  第一题 美团XML解析 方法1
//
//  Created by 陈建的appple on 15/9/8.
//  Copyright (c) 2015年 陈建的app. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    解析XML文件
    [self getInfo];
    [self getTabelView];
    
    
}
-(void)getTabelView
{
    self.myTableview=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.myTableview.delegate=self;
    self.myTableview.dataSource=self;
    [self.myTableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.myTableview];
}
-(void)getInfo
{
//    指定路径，将路径下的文件转换成data数据
    NSString *path=[[NSBundle mainBundle] pathForResource:@"File" ofType:@"xml"];
    NSData *data=[NSData dataWithContentsOfFile:path];
//    通过NSXMLParser解析数据
    NSXMLParser *parser=[[NSXMLParser alloc] initWithData:data];
    parser.delegate=self;
    BOOL bol=[parser parse];
    NSLog(@"%d",bol);
}
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    self.arrInfo=[NSMutableArray arrayWithCapacity:0];
}
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"%@",self.arrInfo);
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"division"])
    {
        self.dicInfo=[NSMutableDictionary dictionary];
    }
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    self.text=string;
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"id"])
    {
        [self.dicInfo setObject:self.text forKey:@"id"];
    }
    else if ([elementName isEqualToString:@"name"])
    {
        [self.dicInfo setObject:self.text forKey:@"name"];
    }
    else if ([elementName isEqualToString:@"timezone"])
    {
        [self.dicInfo setObject:self.text forKey:@"timezone"];
    }
    else if ([elementName isEqualToString:@"timezone_offset_gmt"])
    {
        [self.dicInfo setObject:self.text forKey:@"timezone_offset_gmt"];
    }
    else if ([elementName isEqualToString:@"latitude"])
    {
        [self.dicInfo setObject:self.text forKey:@"latitude"];
    }
    else if ([elementName isEqualToString:@"longitude"])
    {
        [self.dicInfo setObject:self.text forKey:@"longitude"];
    }
    else if ([elementName isEqualToString:@"division"])
    {
        [self.arrInfo addObject:self.dicInfo];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arrInfo.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dicInfo.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSMutableDictionary *dic=self.arrInfo[indexPath.section];
    NSArray *arr=[dic allValues];
    cell.textLabel.text=arr[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *dic=self.arrInfo[section];
    NSString *title=[dic objectForKey:@"id"];
    return title;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
