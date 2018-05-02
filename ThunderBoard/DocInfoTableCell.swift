//
//  DocInfoTableCell.swift
//  Thunderboard
//
//  Created by Franco Reda on 4/4/18.
//  Copyright © 2018 Silicon Labs. All rights reserved.
//

import UIKit

class DocInfoTableCell : UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet var dTextField: UITextField?
    var drawSeparator: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupClearButton()
        
        // cursor color
        dTextField?.tintColor = StyleColor.terbiumGreen
        dTextField?.delegate = self
        
        log.debug("\(String(describing: dTextField?.subviews))")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if drawSeparator {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 15, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.lineWidth = 1
            
            StyleColor.lightGray.setStroke()
            path.stroke()
        }
    }
    
    fileprivate func setupClearButton() {
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
        let image = UIImage(named: "icn_settings_textfield_clear")!
        button.setImage(image, for: UIControlState())
        button.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        
        dTextField?.rightViewMode = .whileEditing
        dTextField?.rightView = button
    }
    
    func textFieldDidBeginEditing(_ dTextField: UITextField) {
        log.debug("\(dTextField.subviews)")
    }
    
    @objc func clearButtonTapped() {
        dTextField?.text = ""
    }
}
