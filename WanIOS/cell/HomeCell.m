//
//  HomeCell.m
//  WanIOS
//
//  Created by zhenfei ren on 2022/3/26.
//

#import "HomeCell.h"
#import "NSString+StringUtils.h"

@interface HomeCell()

@property(nonatomic,strong) UILabel *isNew;
@property(nonatomic,strong) UILabel *author;
@property(nonatomic,strong) UILabel *time;
@property(nonatomic,strong) UILabel *title;
@property(nonatomic,strong) UILabel *isTop;
@property(nonatomic,strong) UILabel *category;

@end

@implementation HomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (void)setData:(ArticleDetail*)article{
    self.author.text = [article.author isEmpty] ? article.shareUser : article.author ;
    self.time.text = article.niceDate;
    self.title.text = article.title;
    self.isTop.hidden = !article.isTop;
    self.category.text = article.superChapterName;
    self.isNew.hidden = !article.fresh;
    if (!article.isTop) {
        [self.category mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.title);
            make.top.equalTo(self.title.mas_bottom).offset(5);
            make.bottom.equalTo(self.contentView).offset(-10);
        }];
    }else{
        [self.category mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.isTop.mas_right).offset(5);
            make.top.equalTo(self.title.mas_bottom).offset(5);
            make.bottom.equalTo(self.contentView).offset(-10);
        }];
    }
    if (!article.fresh) {
        [self.author mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.isNew);
            make.left.equalTo(self.contentView).offset(15);
        }];
    }else{
        [self.author mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(10);
            make.left.equalTo(self.isNew.mas_right).offset(15);
        }];
    }
    
}

- (void)setup{
    self.isNew = [[UILabel alloc] init];
    self.isNew.text = @"新";
    self.isNew.font = [UIFont systemFontOfSize:13];
    self.isNew.textColor = RGB_COLOR(@"#2b4490",1);
    [self.contentView addSubview:self.isNew];
    [self.isNew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.contentView).offset(15);
    }];
    self.author = [[UILabel alloc] init];
    self.author.font = [UIFont systemFontOfSize:13];
    self.author.textColor = RGB_COLOR(@"#cccccc", 1);
    [self.contentView addSubview:self.author];
    [self.author mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(5);
        make.left.equalTo(self.isNew.mas_right).offset(5);
    }];
    self.time = [[UILabel alloc] init];
    self.time.font = [UIFont systemFontOfSize:13];
    self.time.textColor = RGB_COLOR(@"#cccccc", 1);
    [self.contentView addSubview:self.time];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.author);
    }];
    
    self.title = [[UILabel alloc] init];
    self.title.numberOfLines = 0;
    self.title.textColor = RGB_COLOR(@"#333333", 1);
    self.title.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.author.mas_bottom).offset(6);
        make.right.equalTo(self.contentView).offset(-15);
        make.left.equalTo(self.contentView).offset(15);
    }];
    
    self.isTop = [[UILabel alloc] init];
    self.isTop.font = [UIFont systemFontOfSize:13];
    self.isTop.textColor = RGB_COLOR(@"#f47920", 1);
    self.isTop.text = @"置顶";
    [self.contentView addSubview:self.isTop];
    [self.isTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(6);
        make.left.equalTo(self.title);
    }];
    
    self.category = [[UILabel alloc] init];
    self.category.font = [UIFont systemFontOfSize:13];
    self.category.textColor = RGB_COLOR(@"#cccccc", 1);
    [self.contentView addSubview:self.category];
    [self.category mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.isTop.mas_right).offset(5);
        make.top.equalTo(self.isTop);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
}

@end
