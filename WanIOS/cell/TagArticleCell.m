//
//  TagArticleCell.m
//  WanIOS
//
//  Created by zhenfei ren on 2022/3/31.
//

#import "TagArticleCell.h"
#import "NSString+StringUtils.h"

@interface TagArticleCell ()

@property(nonatomic,strong) UILabel *author;

@property(nonatomic,strong) UILabel *time;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UILabel *tags;

@end

@implementation TagArticleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    self.author = [[UILabel alloc] init];
    self.author.font = [UIFont systemFontOfSize:15];
    self.author.textColor = RGB_COLOR(@"#999999", 1);
    [self.contentView addSubview:self.author];
    [self.author mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(12);
    }];
    
    self.time = [[UILabel alloc] init];
    self.time.textColor = RGB_COLOR(@"#999999", 1);
    self.time.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.time];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.author);
        make.right.equalTo(self.contentView).offset(-12);
    }];
    
    self.title = [[UILabel alloc] init];
    self.title.numberOfLines = 0;
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.author.mas_bottom).offset(8);
        make.left.equalTo(self.author);
        make.right.equalTo(self.contentView);
    }];
    
    self.tags = [[UILabel alloc] init];
    self.tags.textColor = RGB_COLOR(@"#999999", 1);
    self.tags.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.tags];
    [self.tags mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(8);
        make.left.equalTo(self.author);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
}

- (void)setData:(AskAnswerItemModel *)article{
    self.author.text = [article.author isEmpty] ? article.shareUser : article.author ;;
    self.time.text = article.niceDate;
    self.title.text = article.title;
    self.tags.text = [NSString stringWithFormat:@"%@·%@",article.superChapterName,article.chapterName];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
