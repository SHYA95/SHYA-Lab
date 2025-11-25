//
//  MoviesTableViewCell.swift
//  MovieApp
//
//  Created by Shrouk Yasser on 25/11/2025.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var movieUiImage: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    // MARK: - Properties
    static var identifier: String {
        return String(describing: self)
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDesign()
    }
    
   override func layoutSubviews() {
        super.layoutSubviews()
       contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        movieUiImage.image = nil
        movieNameLabel.text = nil
        releaseDateLabel.text = nil
        self.transform = .identity
    }
    
    // MARK: - Setup Design
    private func setupDesign() {
       self.backgroundColor = .clear
        self.selectionStyle = .gray
        
        contentView.backgroundColor = .secondarySystemGroupedBackground
        contentView.layer.cornerRadius = 16
        
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4
        
        movieUiImage.layer.cornerRadius = 12
        movieUiImage.clipsToBounds = true
       
        movieUiImage.layer.borderWidth = 0.5
        movieUiImage.layer.borderColor = UIColor.systemGray4.cgColor
        
        movieNameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        movieNameLabel.textColor = .label
        
        releaseDateLabel.font = .systemFont(ofSize: 14, weight: .medium)
        releaseDateLabel.textColor = .secondaryLabel
    }
    
    // MARK: - Configuration Method
    func configure(with movie: Movie) {
        movieNameLabel.text = movie.title
        releaseDateLabel.text = "📅 " + movie.releaseDate
        let fullPosterUrl = movie.posterURL?.absoluteString
        movieUiImage.setImage(urlStr: fullPosterUrl, placeholder: UIImage(named:  "moviePlaceholder"))
    }
    
    // MARK: - Animation
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            if highlighted {
                self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            } else {
                self.transform = .identity
            }
        })
    }
}
