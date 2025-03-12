import UIKit
import Foundation

class CountryListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    
    let tableCellIdentifier = "CountryTableViewCell"
    let searchController = UISearchController(searchResultsController: nil)
    private var filteredCountries: [Country] = []
    private var countries = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: tableCellIdentifier, bundle: nil), forCellReuseIdentifier: tableCellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        setupSearchController()
        fetchCountriesList()
    }
    
    func fetchCountriesList(){
        guard let url = URL(string: APIEndpoint.countriesURL) else {
            print("invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){data, response, error in
            if let error = error {
                print("No data received")
                return
            }
            do {
                let countries = try JSONDecoder().decode([Country].self, from: data!)
                DispatchQueue.main.async {
                    self.countries = countries
                    self.filteredCountries = countries
                    self.tableView.reloadData()
                }
            } catch {
                print("Unable to decode JSON")
            }
            
        }
        task.resume()
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Search Countries"
        definesPresentationContext = true
    }
}

extension CountryListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellIdentifier, for: indexPath) as! CountryTableViewCell
        
        cell.configure(with: filteredCountries[indexPath.row])
        return cell
    }
}

extension CountryListViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            filteredCountries = countries
            tableView.reloadData()
            return
        }
        filteredCountries = countries.filter { country in
            return country.name.lowercased().contains(searchText.lowercased()) ||
                   country.capital.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
}
