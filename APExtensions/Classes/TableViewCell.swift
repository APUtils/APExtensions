//
//  TableViewCell.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 6/15/17.
//  Copyright © 2017 Anton Plebanovich. All rights reserved.
//

import UIKit


public class TableViewCell: UITableViewCell {
    
    //-----------------------------------------------------------------------------
    // MARK: - UITableViewCell Methods
    //-----------------------------------------------------------------------------
    
    // Preventing backgroundColor change
    override public func setSelected(_ selected: Bool, animated: Bool) {
        let viewsBackgrounds: [UIView: UIColor?] = getViewsBackgrounds()
        
        super.setSelected(selected, animated: animated)
        
        if selected {
            for (view, color) in viewsBackgrounds {
                view.backgroundColor = color
            }
        }
    }
    
    // Preventing backgroundColor change
    override public func setHighlighted(_ highlighted: Bool, animated: Bool) {
        let viewsBackgrounds: [UIView: UIColor?] = getViewsBackgrounds()
        
        super.setHighlighted(highlighted, animated: animated)
        
        if highlighted {
            for (view, color) in viewsBackgrounds {
                view.backgroundColor = color
            }
        }
    }
    
    //-----------------------------------------------------------------------------
    // MARK: - Private Methods
    //-----------------------------------------------------------------------------
    
    private func getViewsBackgrounds() -> [UIView: UIColor?] {
        var viewsBackgrounds: [UIView: UIColor?] = [:]
        contentView.allSubviews.forEach({ viewsBackgrounds[$0] = $0.backgroundColor })
        
        return viewsBackgrounds
    }
}
