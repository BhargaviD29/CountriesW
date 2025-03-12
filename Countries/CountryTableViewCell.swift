
import Foundation
import UIKit
class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!

    func configure(with country: Country) {
        nameLabel.text = country.name
        regionLabel.text = country.region
        codeLabel.text = country.code
        capitalLabel.text = country.capital
    }
}
