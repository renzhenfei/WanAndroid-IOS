//
//  AskAnswerCell.m
//  WanIOS
//
//  Created by zhenfei ren on 2022/3/29.
//

#import "AskAnswerCell.h"
#import "UILableWithPadding.h"

@interface AskAnswerCell ()

@property(nonatomic,strong) UILabel *author;

@property(nonatomic,strong) UILabel *source;

@property(nonatomic,strong) UILabel *time;

@property(nonatomic,strong) UILabel *title;

@property(nonatomic,strong) UILabel *desc;

@property(nonatomic,strong) UILabel *tagName;

@end

@implementation AskAnswerCell

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
    self.author.textColor = UIColor.grayColor;
    self.author.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.author];
    [self.author mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(12);
    }];
    self.source = [[UILableWithPadding alloc] initWithInsets:UIEdgeInsetsMake(2, 4, 2, 4)];
    self.source.clipsToBounds = YES;
    self.source.textColor = RGB_COLOR(@"#2b4490", 1);
    self.source.font = [UIFont systemFontOfSize:12];
    self.source.layer.cornerRadius = 5;
    self.source.layer.borderWidth = 1;
    self.source.textAlignment = NSTextAlignmentCenter;
    self.source.layer.borderColor = [RGB_COLOR(@"#2b4490", 1) CGColor];
    [self.contentView addSubview:self.source];
    [self.source mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.author.mas_right).offset(5);
        make.top.centerY.equalTo(self.author);
    }];
    self.time = [[UILabel alloc] init];
    self.time.font = [UIFont systemFontOfSize:14];
    self.time.textColor = RGB_COLOR(@"#cccccc", 1);
    [self.contentView addSubview:self.time];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.author);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    
    self.title = [[UILabel alloc] init];
    self.title.textColor = RGB_COLOR(@"#333333", 1);
    self.title.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.author.mas_bottom).offset(10);
        make.left.equalTo(self.author);
        make.right.equalTo(self.time);
    }];
    
    self.desc = [[UILabel alloc] init];
    self.desc.font = [UIFont systemFontOfSize:15];
    self.desc.textColor = RGB_COLOR(@"#555555", 1);
    self.desc.numberOfLines = 3;
    [self.contentView addSubview:self.desc];
    [self.desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(5);
        make.left.equalTo(self.author);
        make.right.equalTo(self.time);
    }];
    
    self.tagName = [[UILabel alloc] init];
    self.tagName.font = [UIFont systemFontOfSize:14];
    self.tagName.textColor = RGB_COLOR(@"#cccccc", 1);
    [self.contentView addSubview:self.tagName];
    [self.tagName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.desc.mas_bottom).offset(8);
        make.left.equalTo(self.title);
        make.bottom.equalTo(self.contentView).offset(-12);
    }];
}

- (void)setData:(AskAnswerItemModel *)model{
    self.author.text = model.author;
    self.title.text = model.title;
//    NSAttributedString *attrDesc = [[NSAttributedString alloc] initWithData:[model.desc dataUsingEncoding:NSUTF8StringEncoding] options:@{
//            NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
//            NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)
//    } documentAttributes:nil error:nil];
//    self.desc.attributedText = attrDesc;
    self.desc.text = [self removeHtmlWithString:model.desc];
    self.time.text = model.niceDate;
    self.tagName.text = [model allTag];
    self.source.text = [NSString stringWithFormat:@"%@·%@",model.superChapterName,model.chapterName];
}

-(NSString *)removeHtmlWithString:(NSString *)htmlString{
    NSRegularExpression * regularExpretion=[NSRegularExpression regularExpressionWithPattern:@"<[^>]*>|\n|\r" options:0 error:nil];
    htmlString = [regularExpretion stringByReplacingMatchesInString:htmlString options:NSMatchingReportProgress range:NSMakeRange(0, htmlString.length) withTemplate:@""];
    return htmlString;
 }

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
