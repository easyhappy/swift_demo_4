//
//  ViewController.m
//  TableVIew-01
//
//  Created by Apple-JF on 14-12-9.
//  Copyright (c) 2014年 Apple-JF. All rights reserved.
//

#import "ViewController.h"
#import "CarNameEntity.h"

@interface ViewController () <UITableViewDataSource>

@property (nonatomic ,strong) UITableView    *tableView;
@property (nonatomic ,strong) NSArray        *carList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建tableView
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    
    //tableView准备数据
    self.tableView.dataSource = self;
}

#pragma mark -隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark -设置节数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.carList.count;
}

#pragma mark -设置节列表数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CarNameEntity *carName = self.carList[section];
    return  carName.cars.count;
}

#pragma mark -设置单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID         = @"cell";
    UITableViewCell *cell       = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    CarNameEntity *carName = self.carList[indexPath.section];
    cell.textLabel.text    = carName.cars[indexPath.row];
    //附加在单元格后端的样式
    cell.accessoryType     = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark -节title描述
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    CarNameEntity *carName = self.carList[section];
    return  carName.title;
}

#pragma mark -节结尾描述
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    CarNameEntity *carName = self.carList[section];
    NSString      *desc    = [NSString stringWithString:carName.desc];
    return  desc;
}

#pragma mark -数据懒加载
- (NSArray *) carList
{
    if (!_carList) {
        NSString        *path         = [[NSBundle mainBundle] pathForResource:@"cars_simple" ofType:@"plist"];
        NSArray         *array        = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray  *muTableArray = [NSMutableArray array];
        
        for (NSDictionary * dic in array)
        {
            CarNameEntity *carName = [CarNameEntity carWithDictionary:dic];
            [muTableArray addObject:carName];
        }
         _carList = muTableArray;
    }
    return _carList;
}

@end













