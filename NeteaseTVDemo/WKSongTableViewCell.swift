
import UIKit
import MarqueeLabel
class WKSongTableViewCell: UITableViewCell {
    
    var indexLabel = UILabel()
    private var songNameLabel = MarqueeLabel()
    private var albumLabel = MarqueeLabel()
    private var timeLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let selView = UIView()
        selView.backgroundColor = UIColor(white: 0.9, alpha: 0.1)
        self.selectedBackgroundView = selView
        
        ({(label: UILabel) in
            label.textColor = .lightGray
            label.font = .systemFont(ofSize: 30)
            self.contentView.addSubview(label)
            label.snp.makeConstraints { make in
                make.left.equalTo(self.contentView).offset(30)
                make.centerY.equalToSuperview()
                make.bottom.equalTo(self.contentView).offset(-40)
            }
        })(indexLabel)
        
        ({(label: MarqueeLabel) in
            label.textColor = .white
            self.contentView.addSubview(label)
            label.snp.makeConstraints { make in
                make.left.equalTo(self.contentView).offset(80)
                make.right.equalTo(self.contentView.snp.right).offset(-30)
                make.bottom.equalTo(self.contentView.snp.centerY).offset(-5)
            }
        })(songNameLabel)
        
        ({(label: MarqueeLabel) in
            label.textColor = .white
            label.font = .systemFont(ofSize: 30)
            self.contentView.addSubview(label)
            label.snp.makeConstraints { make in
                make.left.equalTo(self.contentView).offset(80)
                make.right.equalTo(self.contentView.snp.right).offset(-30)
                make.top.equalTo(self.contentView.snp.centerY).offset(5)
            }
        })(albumLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)
        if isFocused {
            songNameLabel.textColor = .black
            albumLabel.textColor = .black
        } else {
            songNameLabel.textColor = .white
            albumLabel.textColor = .white
        }
    }
    
    func setModel(_ model: CustomAudioModel) {
        if let tns = model.transTitle {
            self.songNameLabel.text = model.wk_sourceName! + " (\(tns))"
            let attributedString = NSMutableAttributedString(string: self.songNameLabel.text!)
            // 设置不同范围的文本颜色
            attributedString.addAttribute(.foregroundColor, value: UIColor.lightGray, range: NSRange(location: model.wk_sourceName!.count, length: tns.count + 3))
            attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 27), range: NSRange(location: model.wk_sourceName!.count, length: tns.count + 3))
            self.songNameLabel.attributedText = attributedString
        } else {
            self.songNameLabel.text = model.wk_sourceName
        }
        self.albumLabel.text = model.albumTitle
    }
    
}