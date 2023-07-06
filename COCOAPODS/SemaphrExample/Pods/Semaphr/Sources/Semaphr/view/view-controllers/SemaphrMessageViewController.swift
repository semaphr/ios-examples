//
//  SoftUpdateViewController.swift
//  Semaphr
//
//  Created by Semaphr Team on 18.07.2022.
//

import UIKit

class SemaphrMessageViewController: UIViewController {
    
    private struct Constants {
        static let appStorePath = "itms-apps://"
        static let appStoreAppIDPath = "itms-apps://apple.com/app/id"
    }
    
    private var status: SemaphrStatus!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var updateLoadingIndicator: UIActivityIndicatorView!
    
    private let itunesService = ITunesService()
    
    // MARK: Lifecycle
    
    init(status: SemaphrStatus) {
        super.init(nibName: "SemaphrMessageViewController", bundle: Bundle.framework)
        self.status = status
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let closeImage = UIImage.frameworkImage(named: "close-image.png")
        closeButton.setImage(closeImage, for: .normal)

        populate()
    }
    
    // MARK: Actions

    @IBAction func close(_ sender: Any) {
        removeShownWindow()
    }
    
    @IBAction func update(_ sender: Any) {
        setUpdateLoading(true)
        itunesService.getAppleAppID(details: AppDetailsHelper.getAppDetails()) { appID in
            self.setUpdateLoading(false)
            var link = Constants.appStorePath

            if let appID = appID {
                link = Constants.appStoreAppIDPath + appID
            }
            
            if let url = URL(string: link) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    // MARK: Private methods
    
    private func setUpdateLoading(_ loading: Bool) {
        if loading {
            updateLoadingIndicator.isHidden = false
            updateButton.setTitle(nil, for: .normal)
            updateButton.isUserInteractionEnabled = false
            
        } else {
            updateLoadingIndicator.isHidden = true
            updateButton.setTitle("Update", for: .normal)
            updateButton.isUserInteractionEnabled = false
        }
    }
    
    private func populate() {
        var imageName = ""
        var shownTitle: String?
        var shownMessage: String?
        var imageLinkToShow: String?
        
        switch status {
        case .block(_, let title, let message, let imageLink):
            shownTitle = title
            shownMessage = message
            imageLinkToShow = imageLink
            imageName = "block.png"
            closeButton.isHidden = true
            updateButton.isHidden = false
            
        case .notify(_, let title, let message, let dismissable, let imageLink):
            shownTitle = title
            shownMessage = message
            imageLinkToShow = imageLink
            imageName = "notify.png"
            closeButton.isHidden = !dismissable
            updateButton.isHidden = true
            
        case .update(_, let title, let message, let dismissable, let imageLink):
            shownTitle = title
            shownMessage = message
            imageLinkToShow = imageLink
            imageName = "update.png"
            closeButton.isHidden = !dismissable
            updateButton.isHidden = false
            
        case .none:
            break
        }
        
        let image = UIImage.frameworkImage(named: imageName)
        
        // Show the image from link, if there's one
        if let imageLinkToShow = imageLinkToShow {
            imageView.setImageFromURL(urlString: imageLinkToShow)
        } else {
            imageView.image = image
        }
        
        titleLabel.text = shownTitle
        messageTextView.text = shownMessage
    }
}
