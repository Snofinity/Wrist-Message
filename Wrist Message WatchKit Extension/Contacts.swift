
import Foundation
import WatchKit
import WatchConnectivity

class Contacts: WKInterfaceController, WCSessionDelegate {
    
    @IBOutlet var instructionLabel: WKInterfaceLabel!
    var listOfContacts = [[String]]()
    
    // Set up Watch Connectivity
    var session : WCSession!
    override init() {
        super.init()
        if (WCSession.isSupported()) {
            session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
    }
    
    @IBAction func syncBtnAction() {
        syncContacts()
    }
    
    // Sending an instruction to the iPhone to sync Contacts
    func syncContacts() {
        if WCSession.defaultSession().reachable == true {
            let requestValues = ["instruction":"getContacts"]
            let session = WCSession.defaultSession()
            
            session.sendMessage(requestValues, replyHandler: { reply in
                self.showContacts((reply["allowContacts"] as? String)!,
                    firstNames: (reply["firstNames"] as? NSArray)!,
                    lastNames: (reply["lastNames"] as? NSArray)!,
                    phoneNumbers: (reply["phoneNumbers"] as? NSArray)!)
                }, errorHandler: { error in
                    self.contactsFailedToReach()
            })
        }
        else {
            contactsFailedToReach()
        }
    }
    
    // Gets called when the Contacts fail to sync because of a bad connection
    func contactsFailedToReach() {
        self.contactsTable.setHidden(true)
        self.instructionLabel.setText("Contacts are unreachable. Make sure your iPhone is nearby and paired with your Apple Watch.")
        self.instructionLabel.setHidden(false)
    }
    
    // Gets called in reply from iPhone
    func showContacts(allowContacts: String, firstNames: NSArray, lastNames: NSArray, phoneNumbers: NSArray) {
        self.contactsTable.setHidden(true)
        listOfContacts.removeAll()
        if allowContacts == "denied" {
            self.instructionLabel.setText("Please allow Wrist Message to access your Contacts through the Settings.")
            self.instructionLabel.setHidden(false)
        }
        else {
            self.instructionLabel.setText("Syncing...")
            self.instructionLabel.setHidden(false)
            for var i = 0; i < firstNames.count; i++ {
                self.listOfContacts.append(["\(firstNames[i]) \(lastNames[i])", "\(phoneNumbers[i])"])
            }
            self.contactsTable.setNumberOfRows(self.listOfContacts.count, withRowType: "ContactsRow")
            for var i = 0; i < self.listOfContacts.count; ++i {
                if let row = self.contactsTable.rowControllerAtIndex(i) as? ContactsRow {
                    row.contactLabel1.setText(self.listOfContacts[i][0])
                }
            }
            self.instructionLabel.setHidden(true)
            self.contactsTable.setHidden(false)
        }
    }
    
    @IBOutlet var contactsTable: WKInterfaceTable!
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        let passInArray = [listOfContacts[rowIndex][0], listOfContacts[rowIndex][1]]
        presentControllerWithName("Messenger", context: passInArray)
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        syncContacts()
    }
    
    override func willActivate() {
        if message != "" {
            presentControllerWithName("Messenger", context: [recieverName, recieverNumber])
        }
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
}
