//
//  SearchScreenTableViewCell.swift
//  Bookshelf
//
//  Created by Anastasia on 06.02.2023.
//

import UIKit
import PinLayout
import AlamofireImage

class SearchScreenTableViewCell: UITableViewCell {
    
    private enum Sizes {
        static let imageSize = CGSize(width: 100, height: 150)
        static let spacing: CGFloat = 5
        static let doubleSpacing: CGFloat = 10
    }
    
    //MARK: -
    //MARK: Properties
    
    internal static let cellId = "cell"
    private var bookCover: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "noCover")
        image.contentMode = .scaleToFill
        return image
    }()
    private var bookName: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 3
        return label
    }()
    private var bookAuthor: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 6
        return label
    }()
        
    //MARK: -
    //MARK: Init
    
    override internal init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(bookCover)
        self.contentView.addSubview(bookName)
        self.contentView.addSubview(bookAuthor)
    }
   
    required internal init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -
    //MARK: Methods
    
    internal func setData(_ data: BookFound) {
        guard let url = URL(string: "https://covers.openlibrary.org/b/id/" + "\(data.coverId)" + ".jpg") else { return }
        self.bookCover.af.setImage(withURL: url,
                                   placeholderImage: UIImage(named: "loading"),
                                   imageTransition: .crossDissolve(2.0))
        self.bookName.text = data.title
        self.bookAuthor.text = data.author
    }

    override internal func prepareForReuse() {
        self.bookCover.image = nil
        self.bookName.text = nil
        self.bookAuthor.text = nil
        super.prepareForReuse()
    }
    
    override internal func layoutSubviews() {
        let width = safeAreaLayoutGuide.layoutFrame.width
        let height = safeAreaLayoutGuide.layoutFrame.height
        let nameLabelSize = CGSize(width: width - bookCover.frame.width - 20, height: (height / 3) - Sizes.doubleSpacing)
        let AuthorLabelSize = CGSize(width: width - bookCover.frame.width - 20, height: 2 * (height / 3) - Sizes.doubleSpacing)
        
        bookCover.frame.size = Sizes.imageSize
        bookName.frame.size = nameLabelSize
        bookAuthor.frame.size = AuthorLabelSize
        
        bookCover.pin
            .top(Sizes.spacing)
            .left(Sizes.spacing)
            .bottom(Sizes.spacing)
        bookName.pin
            .after(of: bookCover)
            .top(Sizes.spacing)
            .marginHorizontal(Sizes.doubleSpacing)
        bookAuthor.pin
            .after(of: bookCover)
            .below(of: bookName)
            .marginHorizontal(Sizes.doubleSpacing)
    }
}
