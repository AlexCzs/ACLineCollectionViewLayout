//
//  ZSViewController.m
//  线性布局
//
//  Created by 陈昭燊 on 16/3/2.
//  Copyright © 2016年 陈昭燊. All rights reserved.
//

#import "ZSViewController.h"
#import "ZSLineLayout.h"
#import "ZSCollectionViewCell.h"
#import "ZSCircleLayout.h"
#import "ZSStackLayout.h"

static NSString *ID = @"collectionCellId";

@interface ZSViewController ()<UICollectionViewDataSource>
@property(nonatomic,weak)UICollectionView *collectionView;
/// 图片数组
@property(nonatomic,strong)NSMutableArray *images;
@end

@implementation ZSViewController
/// 懒加载
-(NSMutableArray *)images{
    if (_images == nil) {
        _images = [[NSMutableArray alloc]initWithCapacity:10];
        for (int i = 1; i <= 10; i++) {
            [_images addObject:[NSString stringWithFormat:@"%zd", i]];
        }
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置UI
    [self setupUI];
    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //    self.collectionView.collectionViewLayout = [[HMLineLayout alloc] init];
    if ([self.collectionView.collectionViewLayout isKindOfClass:[ZSStackLayout class]]) {
        
        [self.collectionView setCollectionViewLayout:[[ZSCircleLayout alloc] init] animated:YES];
        
    } else if ([self.collectionView.collectionViewLayout isKindOfClass:[ZSCircleLayout class]]) {
        
        [self.collectionView setCollectionViewLayout:[[ZSStackLayout alloc] init] animated:YES];
    }
}

#pragma mark 准备UI
- (void)setupUI{
    
    CGRect rect = CGRectMake(0, 100, self.view.frame.size.width, 300);
    
    UICollectionViewLayout *layout = [[ZSCircleLayout alloc]init];
    
    //创建collectionView
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:rect collectionViewLayout:layout];
    //注册cell
    [collectionView registerClass:[ZSCollectionViewCell class] forCellWithReuseIdentifier:ID];
    
    self.collectionView = collectionView;
    //    self.collectionView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.collectionView];
    self.collectionView.dataSource = self;
    
    
}


#pragma mark collectionView的数据源方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.images.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.imageName = self.images[indexPath.item];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}



@end
