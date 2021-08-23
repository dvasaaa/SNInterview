//
//  UIView+Additions.swift
//  SNInterview
//
//  Copyright © 2019 ServiceNow. All rights reserved.
//

import UIKit

extension UIView {
    class func fromNib() -> UIView {
        let bundle = Bundle(for: self)
        let name = String(describing: self)
        guard let objects = bundle.loadNibNamed(name, owner: self, options: nil) as? [UIView],
            let loadedView = objects.last else {
            fatalError(SNConstants.ErrorStrings.viewNotExist)
        }
        return loadedView
    }
}

extension UITableView {
    func registerCell<T: UITableViewCell>(a: T.Type, bundle: Bundle = Bundle.main) {
        self.register(UINib(nibName: String(describing: a), bundle: bundle), forCellReuseIdentifier: String(describing: a))
    }
}

protocol LoadingView {
    func showLoadingView()
    func hideLoadingView()
}

extension LoadingView where Self: UIViewController {
    func showLoadingView() {
        let activityView = UIActivityIndicatorView(style: .gray)
        activityView.center = view.center
        activityView.startAnimating()
        view.addSubview(activityView)
        view.bringSubviewToFront(activityView)
    }
    
    func hideLoadingView() {
        if let activityView = view.subviews.compactMap({ $0 as? UIActivityIndicatorView }).first {
            activityView.stopAnimating()
            activityView.removeFromSuperview()
        }
    }
}
