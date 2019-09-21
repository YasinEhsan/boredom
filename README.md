# Boredom
<!-- Description here -->

- **Feature**

- **Stack**

- **Takeaway**
    - [most clutch custom tvc setup](https://www.youtube.com/watch?v=FtO5QT2D_H8)
    - var and let types can only be a class. i.e. cannot be type "bool"
    - after iOS8 we need bottom contraints for auto-layout for dynamic height  
    
    - delegate methods from swift 2 and 5 have subtle changes to method signature
    - subtitle for LocationTVC huge DEBUG

###  create dummy objects using extensions in Model
```Swift

//dummy varaibles
extension Bools {
static let bool1 = Bools(suggester: "Yasin", time: "7:30", likes: 7)
static let bool2 = Bools(suggester: "Zukl", time: "4:30", likes: 10)
static let bool3 = Bools(suggester: "Becky", time: "12:30", likes: 2)
}
```

### code for showing alert and notifications
```Swift

//run project ones and then copy the NS... to .plist file

import UserNotifications

viewdidload(){
 UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in } //bootstrapped odee
}

//MARK: - notifications and alert
func showAlert(_ title: String, _ message: String){
let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
let action = UIAlertAction(title: "OK", style: .default, handler: nil)
alert.addAction(action)
present(alert, animated: true, completion: nil)
}

func showNotifications(_ title: String, _ message: String){
let content = UNMutableNotificationContent()
content.title = title
content.body = message
content.badge = 2 //the red notification icon
content.sound = .default

let request = UNNotificationRequest(identifier: "noti", content: content, trigger: nil)
UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
}


```
    
### code for accessing contacts
```Swift 

    //obv import contacts and update .plist
    func fetchContacts() {
    print("fetching contacts")
    
    store.requestAccess(for: .contacts) { (granted, err) in
    if let err = err {
    print("failed to req acess", err)
    return//this is completion handeling. prolly more bootstrap way of doing this too
    }
    
    if granted {
    print("acess granted")
    
    let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
    let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
    do{
    try store.enumerateContacts(with: request, usingBlock: {(contact, stopPointerIfYouWantStopEnumerating) in
    
    print(contact.givenName)
    print(contact.givenName)
    print(contact.phoneNumbers.first?.value.stringValue ?? "conatct got no number")

    } catch let err{
    print("enumeration fail", err)
    }
    
    }
    else {
    print("acess denied")
    }
    }
    }
```

### code for custom table view
```Swift 

// also need custom cell class, custom object class, and array obj setup in tbc, and object setup in custom cell

extension ContactsViewController: UITableViewDataSource, UITableViewDelegate{

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
return 1
}

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
return contactList.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
let currContact = contactList[indexPath.row]

guard let cell = tableView.dequeueReusableCell(withIdentifier: "contactCellID", for: indexPath) as? ContactTableViewCell else{
print("cellforrowat dont work")
fatalError()
}

cell.setContact(contact: currContact)

return cell
}

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//do this when tapped on cell

}

}

```
    

![Walkthrough]()
<!-- [Visit Project]() -->

