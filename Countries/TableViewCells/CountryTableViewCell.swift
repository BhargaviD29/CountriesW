//
//  CountryTableViewCell.swift
//  Country
//
//  Created by Vrushik Reddy on 2/27/25.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var nameAndRegionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with country: Country){
        capitalLabel.text = country.capital
        countryCodeLabel.text = country.code
        nameAndRegionLabel.text = country.name + "," + country.region
    }
    
}
