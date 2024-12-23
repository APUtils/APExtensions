//
//  MFMailComposeViewController+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 7/14/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import MessageUI

// ******************************* MARK: - Creation

public extension MFMailComposeViewController {
    /// Creates controller and simplifies its dismissal
    static func create(to: [String]) -> MFMailComposeViewController? {
        guard MFMailComposeViewController.canSendMail() else { return nil }
            
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = vc
        vc.setToRecipients(to)
        
        return vc
    }
}

extension MFMailComposeViewController: @retroactive MFMailComposeViewControllerDelegate {
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
}
