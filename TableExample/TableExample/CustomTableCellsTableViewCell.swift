//
//  CustomTableCellsTableViewCell.swift
//  TableExample
//
//  Created by Bharath on 08/05/24.
//

import UIKit

class CustomTableCellsTableViewCell: UITableViewCell {

    @IBOutlet weak var LabelActorRole: UILabel!
    @IBOutlet weak var LabelActorName: UILabel!
    @IBOutlet weak var ImageViewActor: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
