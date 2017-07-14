//
//  MFMailComposeViewController+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 7/14/17.
//  Copyright © 2017 Anton Plebanovich. All rights reserved.
//

import MessageUI

//-----------------------------------------------------------------------------
// MARK: - Creation
//-----------------------------------------------------------------------------

public extension MFMailComposeViewController {
    public static func create(subject: String? = nil, to: [String]? = nil) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = vc
        if let subject = subject { vc.setSubject(subject) }
        if let to = to { vc.setToRecipients(to) }
        
        return vc
    }
}

extension MFMailComposeViewController: MFMailComposeViewControllerDelegate {
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
}
