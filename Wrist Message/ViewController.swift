
import UIKit
import WatchConnectivity
import Contacts

class ViewController: UIViewController, WCSessionDelegate {
    
    var session : WCSession!
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        var replyValues = Dictionary<String, AnyObject>()
        if message["instruction"] as! String == "getContacts" {
            var allowContacts = "denied"
            var firstNames = [String]()
            var lastNames = [String]()
            var phoneNumbers = [String]()
            AppDelegate.getAppDelegate().requestForAccess { (accessGranted) -> Void in
                if accessGranted == true {
                    let request = CNContactFetchRequest(keysToFetch: [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey])
                    request.predicate = nil
                    request.unifyResults = true
                    var contacts = [CNContact]()
                    
                    let contactsStore = AppDelegate.getAppDelegate().contactStore
                    do {
                        try contactsStore.enumerateContactsWithFetchRequest(request, usingBlock: { (contact, _) -> Void in
                            contacts.append(contact)
                        })
                        
                        for contact in contacts {
                            if (contact.isKeyAvailable(CNContactGivenNameKey)) {
                                firstNames.append(contact.givenName)
                            } else {
                                firstNames.append("")
                            }
                            if (contact.isKeyAvailable(CNContactFamilyNameKey)) {
                                lastNames.append(contact.familyName)
                            } else {
                                lastNames.append("")
                            }
                            if (contact.isKeyAvailable(CNContactPhoneNumbersKey)) {
                                var numberStr = ""
                                for phoneNumber:CNLabeledValue in contact.phoneNumbers {
                                    let number = phoneNumber.value as! CNPhoneNumber
                                    numberStr += "\(number.stringValue)"
                                    break
                                }
                                phoneNumbers.append(numberStr)
                            } else {
                                phoneNumbers.append("")
                            }
                        }
                        
                        allowContacts = "authorized"
                    }
                    catch {}
                }
            }
            
            replyValues["allowContacts"] = allowContacts
            replyValues["firstNames"] = firstNames
            replyValues["lastNames"] = lastNames
            replyValues["phoneNumbers"] = phoneNumbers
        }
        replyHandler(replyValues)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up Watch Connectivity
        if (WCSession.isSupported()) {
            session = WCSession.defaultSession()
            session.delegate = self;
            session.activateSession()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

