//
//  DocInfoViewController.swift
//  Thunderboard
//
//  Created by Franco Reda on 4/4/18.
//  Copyright © 2018 Silicon Labs. All rights reserved.
//

import UIKit

class DocInfoViewController: UITableViewController {
    
    @IBOutlet weak var docNameLabel:  StyledLabel!
    @IBOutlet weak var docEmailLabel: StyledLabel!
    @IBOutlet weak var docPhoneLabel: StyledLabel!
    
    @IBOutlet weak var docNameTextField:   UITextField!
    @IBOutlet weak var docEmailTextField:  UITextField!
    @IBOutlet weak var docPhoneTextField:  UITextField!
    
    fileprivate let docNameText  = "DOC NAME"
    fileprivate let docEmailText = "DOC EMAIL"
    fileprivate let docPhoneText = "DOC PHONE"
    
    fileprivate let settings = ThunderboardSettings()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupNavButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        populateInputDocFields()
    }
    
    func populateInputDocFields() {
        self.docNameTextField.text  = settings.docName
        self.docPhoneTextField.text = settings.docPhone
        self.docEmailTextField.text = settings.docEmail
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let dInfoCell = cell as? DocInfoTableCell else {
            fatalError("invalid cell class")
        }
        
        dInfoCell.backgroundColor = StyleColor.white
        dInfoCell.drawSeparator = !tableView.tb_isFirstCell(indexPath)
        
        if tableView.tb_isLastCell(indexPath) {
            dInfoCell.tb_applyCommonDropShadow()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 15
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UITableViewHeaderFooterView()
        headerView.contentView.backgroundColor = StyleColor.siliconGray
        return headerView
    }
    
    func setupAppearance() {
        automaticallyAdjustsScrollViewInsets = true
        view.backgroundColor = StyleColor.lightGray
        tableView?.backgroundColor = StyleColor.lightGray
        
        docNameLabel.tb_setText(docNameText,   style: StyleText.subtitle2)
        docNameTextField.textColor = StyleText.main1.color
        docNameTextField.attributedPlaceholder = StyleText.main1.tweakColorAlpha(0.5).attributedString("Doc Name")
        
        docEmailLabel.tb_setText(docEmailText, style: StyleText.subtitle2)
        docEmailTextField.textColor = StyleText.main1.color
        docEmailTextField.attributedPlaceholder = StyleText.main1.tweakColorAlpha(0.5).attributedString("Doc Email")
        
        docPhoneLabel.tb_setText(docPhoneText, style: StyleText.subtitle2)
        docPhoneTextField.textColor = StyleText.main1.color
        docPhoneTextField.attributedPlaceholder = StyleText.main1.tweakColorAlpha(0.5).attributedString("###-###-####")
    }
    
    func setupNavButtons() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "btn_navbar_close"), style: UIBarButtonItemStyle.done, target: self, action: #selector(handleCancel))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "btn_navbar_done_active"), style: UIBarButtonItemStyle.done, target: self, action: #selector(handleSave))
    }
    
    //MARK: Action Handlers
    func handleCancel() {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    func handleSave() {
        settings.docName      = self.docNameTextField.text
        settings.docPhone     = self.docPhoneTextField.text
        settings.docEmail     = self.docEmailTextField.text
        
        let _ = self.navigationController?.popViewController(animated: true)
    }
}
