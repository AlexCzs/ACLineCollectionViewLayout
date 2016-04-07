//
//  ZSCollectionViewCell.m
//  线性布局
//
//  Created by 陈昭燊 on 16/3/2.
//  Copyright © 2016年 陈昭燊. All rights reserved.
//

#import "ZSCollectionViewCell.h"
#import "Masonry.h"

@interface ZSCollectionViewCell()
@property(nonatomic,strong)UIImageView *imageV;
@end
@implementation ZSCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame{
    
        self = [super initWithFrame:frame];
    [self setupImageUI];

    return self;
}

-(UIImageView *)imageV{
    if (_imageV == nil) {

        self.imageV = [[UIImageView alloc]init];
    }
    return _imageV;
}

-(void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    self.imageV.image = [UIImage imageNamed:imageName];

}

-(void)setupImageUI{
    
    //    [self.imageView setValue:@5 forKeyPath:@"layer.borderWidth"];
    [self.contentView addSubview:self.imageV];
    [self.imageV makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self);
    }];
    
    
    self.imageV.layer.borderWidth = 3;
    self.imageV.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageV.layer.cornerRadius = 5;
    self.imageV.layer.masksToBounds = YES;
    
    
}

@end
