//
//  ChecklistTableViewCell.swift
//  Checklist
//
//  Created by Christian de Barrio Arribas on 06/03/2020.
//  Copyright © 2020 Cabify. All rights reserved.
//

import UIKit

class ChecklistTableViewCell: UITableViewCell {

  
  @IBOutlet weak var checkmarkLabel: UILabel!
  @IBOutlet weak var todoTextLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
