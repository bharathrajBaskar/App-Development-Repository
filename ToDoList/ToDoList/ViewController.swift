




import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    let queue = dispa
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var model = [ToDoListDb]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                title = "To Do List"
        view.addSubview(tableView)
        getAllItems()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        getAllItems() // Load items when the view loads
    }

    
    @objc func didTapAdd() {
        let alert = UIAlertController(title: "New Item", message: "Enter the new item", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { [weak self] _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
                return
            }
            self?.createItem(name: text)
        }))
        present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = model[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = item.name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item1 = model[indexPath.row]
        let sheet = UIAlertController(title: "Edit", message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "cancel", style: .cancel,handler: nil))
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive,handler: {
            _ in self.deleteItem(item: item1)
        }))
        sheet.addAction(UIAlertAction(title: "edit", style: .default,handler: {
            _ in  let alert = UIAlertController(title: "edit  ", message: "Enter ur edit item", preferredStyle: .alert)
            alert.addTextField(configurationHandler: nil)
            alert.textFields?.first?.text = item1.name
            alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { [weak self] _ in
                guard let field = alert.textFields?.first, let newName = field.text, !newName.isEmpty else {
                    return
                }
                self?.updateItem(item: item1, nameNew: newName)
            }))
            self.present(alert, animated: true)
        }))
        present(sheet, animated: true)
    }

//    func getAllItems() {
//        do {
//            model = try context.fetch(ToDoListDb.fetchRequest())
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        } catch let error {
//            print(error)
//        }
//    }
    
    func getAllItems() {
        
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
//                guard let self = self else { return }
//                do {
//                    self.model = try self.context.fetch(ToDoListDb.fetchRequest())
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
//                    }
//                } catch {
//                    print(error)
//                }
//            }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
           
            do {
                self.model = try self.context.fetch(ToDoListDb.fetchRequest())
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print(error)
            }
        }
        }
    
    
//    func createItem(name: String) {
//
//        let newItem = ToDoListDb(context: context)
//        newItem.name = name
//        newItem.createdAt = Date()
//        do {
//            try context.save()
//            getAllItems()
//        } catch let error {
//            print(error)
//        }
//    }
//
    
    func createItem(name: String) {
           DispatchQueue.global().async {
               let newItem = ToDoListDb(context: self.context)
               newItem.name = name
               newItem.createdAt = Date()
               do {
                   try self.context.save()
                   self.getAllItems()
               } catch {
                   print(error)
               }
           }
       }
    
    func deleteItem(item: ToDoListDb) {
        context.delete(item)
        do {
            try context.save()
            getAllItems()
        } catch let error {
            print(error)
        }
    }
    
    
    func updateItem(item: ToDoListDb, nameNew: String) {
        item.name = nameNew
        do {
            try context.save()
            getAllItems()
        } catch let error {
            print(error)
        }
    }
}
