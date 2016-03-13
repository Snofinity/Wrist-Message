
import Foundation
import WatchKit
import WatchConnectivity

public var recieverNumber = ""
public var recieverName = ""
public var message = ""
public var whichKeyboard = "caps"
public var countArray = [Double]()
public var removedArray = [Double]()

class Messenger: WKInterfaceController, WCSessionDelegate {
    
    // Sends the composed message to the messages app
    @IBAction func send() {
        let newNumber = recieverNumber.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet).joinWithSeparator("")
        let escapedString = message.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
        WKExtension.sharedExtension().openSystemURL(NSURL(string: "sms:&recipients=\(newNumber)&body=\(escapedString)")!)
        
        recieverNumber = ""
        recieverName = ""
        message = ""
        whichKeyboard = "caps"
        countArray = [Double]()
        removedArray = [Double]()
        dismissController()
    }
    
    // Back to contacts
    @IBAction func contacts() {
        recieverNumber = ""
        recieverName = ""
        message = ""
        whichKeyboard = "caps"
        countArray = [Double]()
        removedArray = [Double]()
        dismissController()
    }
    
    // Outlets
    @IBOutlet var shiftOutlet: WKInterfaceButton!
    @IBOutlet var spaceOutlet: WKInterfaceButton!
    @IBOutlet var deleteOutlet: WKInterfaceButton!
    @IBOutlet var altOutlet: WKInterfaceButton!
    @IBOutlet var aOutlet: WKInterfaceButton!
    @IBOutlet var bOutlet: WKInterfaceButton!
    @IBOutlet var cOutlet: WKInterfaceButton!
    @IBOutlet var dOutlet: WKInterfaceButton!
    @IBOutlet var eOutlet: WKInterfaceButton!
    @IBOutlet var fOutlet: WKInterfaceButton!
    @IBOutlet var gOutlet: WKInterfaceButton!
    @IBOutlet var hOutlet: WKInterfaceButton!
    @IBOutlet var iOutlet: WKInterfaceButton!
    @IBOutlet var jOutlet: WKInterfaceButton!
    @IBOutlet var kOutlet: WKInterfaceButton!
    @IBOutlet var lOutlet: WKInterfaceButton!
    @IBOutlet var mOutlet: WKInterfaceButton!
    @IBOutlet var nOutlet: WKInterfaceButton!
    @IBOutlet var oOutlet: WKInterfaceButton!
    @IBOutlet var pOutlet: WKInterfaceButton!
    @IBOutlet var qOutlet: WKInterfaceButton!
    @IBOutlet var rOutlet: WKInterfaceButton!
    @IBOutlet var sOutlet: WKInterfaceButton!
    @IBOutlet var tOutlet: WKInterfaceButton!
    @IBOutlet var uOutlet: WKInterfaceButton!
    @IBOutlet var vOutlet: WKInterfaceButton!
    @IBOutlet var wOutlet: WKInterfaceButton!
    @IBOutlet var xOutlet: WKInterfaceButton!
    @IBOutlet var yOutlet: WKInterfaceButton!
    @IBOutlet var zOutlet: WKInterfaceButton!
    
    
    @IBAction func shift() {
        WKInterfaceDevice.currentDevice().playHaptic(WKHapticType.Start)
        if whichKeyboard == "capsLock" {
            keysLetters()
            whichKeyboard = "letter"
        }
        else if whichKeyboard == "caps" {
            shiftOutlet.setBackgroundImageNamed("CapsLockIcon")
            whichKeyboard = "capsLock"
        }
        else {
            shiftOutlet.setBackgroundImageNamed("CapsIcon")
            keysCaps()
            whichKeyboard = "caps"
        }
    }
    
    @IBAction func alt() {
        WKInterfaceDevice.currentDevice().playHaptic(WKHapticType.Start)
        if whichKeyboard == "letter" || whichKeyboard == "caps" || whichKeyboard == "capsLock" {
            keysAlternates()
            whichKeyboard = "alternate"
        }
        else if whichKeyboard == "alternate" {
            keysEmojis()
            whichKeyboard = "emoji"
        }
        else {
            keysLetters()
            whichKeyboard = "letter"
        }
    }
    
    @IBAction func delete() {
        WKInterfaceDevice.currentDevice().playHaptic(WKHapticType.Start)
        if message.isEmpty == false {
            message.removeAtIndex(message.endIndex.predecessor())
        }
        updateMessageLabel(-1)
    }
    
    func pressedLetter(letter: String, count: Double) {
        WKInterfaceDevice.currentDevice().playHaptic(WKHapticType.Start)
        message += letter
        updateMessageLabel(count)
    }
    func pressedAlternate(alternate: String, count: Double) {
        WKInterfaceDevice.currentDevice().playHaptic(WKHapticType.Start)
        message += alternate
        updateMessageLabel(count)
    }
    func pressedEmoji(emoji: String, count: Double) {
        WKInterfaceDevice.currentDevice().playHaptic(WKHapticType.Start)
        message += emoji
        updateMessageLabel(count)
    }
    func pressedCaps(caps: String, count: Double) {
        WKInterfaceDevice.currentDevice().playHaptic(WKHapticType.Start)
        message += caps
        updateMessageLabel(count)
    }
    
    func keysLetters() {
        shiftOutlet.setBackgroundImageNamed("ShiftIcon")
        aOutlet.setTitle("a")
        bOutlet.setTitle("b")
        cOutlet.setTitle("c")
        dOutlet.setTitle("d")
        eOutlet.setTitle("e")
        fOutlet.setTitle("f")
        gOutlet.setTitle("g")
        hOutlet.setTitle("h")
        iOutlet.setTitle("i")
        jOutlet.setTitle("j")
        kOutlet.setTitle("k")
        lOutlet.setTitle("l")
        mOutlet.setTitle("m")
        nOutlet.setTitle("n")
        oOutlet.setTitle("o")
        pOutlet.setTitle("p")
        qOutlet.setTitle("q")
        rOutlet.setTitle("r")
        sOutlet.setTitle("s")
        tOutlet.setTitle("t")
        uOutlet.setTitle("u")
        vOutlet.setTitle("v")
        wOutlet.setTitle("w")
        xOutlet.setTitle("x")
        yOutlet.setTitle("y")
        zOutlet.setTitle("z")
    }
    
    func keysAlternates() {
        shiftOutlet.setBackgroundImageNamed("ShiftIcon")
        aOutlet.setTitle("0")
        bOutlet.setTitle("1")
        cOutlet.setTitle("2")
        dOutlet.setTitle("3")
        eOutlet.setTitle("4")
        fOutlet.setTitle("5")
        gOutlet.setTitle("6")
        hOutlet.setTitle("7")
        iOutlet.setTitle("8")
        jOutlet.setTitle("9")
        kOutlet.setTitle("*")
        lOutlet.setTitle("/")
        mOutlet.setTitle("+")
        nOutlet.setTitle("-")
        oOutlet.setTitle("=")
        pOutlet.setTitle("@")
        qOutlet.setTitle("#")
        rOutlet.setTitle("$")
        sOutlet.setTitle("%")
        tOutlet.setTitle(":")
        uOutlet.setTitle("'")
        vOutlet.setTitle(",")
        wOutlet.setTitle(".")
        xOutlet.setTitle("!")
        yOutlet.setTitle("?")
        zOutlet.setTitle("\"")
    }
    
    func keysEmojis() {
        shiftOutlet.setBackgroundImageNamed("ShiftIcon")
        aOutlet.setTitle("❤️")
        bOutlet.setTitle("💕")
        cOutlet.setTitle("😍")
        dOutlet.setTitle("😘")
        eOutlet.setTitle("😊")
        fOutlet.setTitle("😱")
        gOutlet.setTitle("😭")
        hOutlet.setTitle("😂")
        iOutlet.setTitle("😩")
        jOutlet.setTitle("😔")
        kOutlet.setTitle("🙌")
        lOutlet.setTitle("😎")
        mOutlet.setTitle("😜")
        nOutlet.setTitle("☺️")
        oOutlet.setTitle("😒")
        pOutlet.setTitle("😉")
        qOutlet.setTitle("😌")
        rOutlet.setTitle("😳")
        sOutlet.setTitle("😁")
        tOutlet.setTitle("😏")
        uOutlet.setTitle("🎈")
        vOutlet.setTitle("🙈")
        wOutlet.setTitle("👍")
        xOutlet.setTitle("👌")
        yOutlet.setTitle("🙏")
        zOutlet.setTitle("✌️")
    }
    
    func keysCaps() {
        aOutlet.setTitle("A")
        bOutlet.setTitle("B")
        cOutlet.setTitle("C")
        dOutlet.setTitle("D")
        eOutlet.setTitle("E")
        fOutlet.setTitle("F")
        gOutlet.setTitle("G")
        hOutlet.setTitle("H")
        iOutlet.setTitle("I")
        jOutlet.setTitle("J")
        kOutlet.setTitle("K")
        lOutlet.setTitle("L")
        mOutlet.setTitle("M")
        nOutlet.setTitle("N")
        oOutlet.setTitle("O")
        pOutlet.setTitle("P")
        qOutlet.setTitle("Q")
        rOutlet.setTitle("R")
        sOutlet.setTitle("S")
        tOutlet.setTitle("T")
        uOutlet.setTitle("U")
        vOutlet.setTitle("V")
        wOutlet.setTitle("W")
        xOutlet.setTitle("X")
        yOutlet.setTitle("Y")
        zOutlet.setTitle("Z")
    }
    
    
    // Actions
    @IBAction func space() {
        if whichKeyboard == "letter" {pressedLetter           (" ", count: 0.0278)}
        else if whichKeyboard == "alternate" {pressedAlternate(" ", count: 0.0278)}
        else if whichKeyboard == "emoji" {pressedEmoji        (" ", count: 0.0278)}
        else {pressedCaps                                     (" ", count: 0.0278)}
    }
    @IBAction func a() {
        if whichKeyboard == "letter" {pressedLetter           ("a", count: 0.0667)}
        else if whichKeyboard == "alternate" {pressedAlternate("0", count: 0.0769)}
        else if whichKeyboard == "emoji" {pressedEmoji        ("❤️", count: 0.1429)}
        else if whichKeyboard == "caps" {pressedCaps          ("A", count: 0.0769);keysLetters();whichKeyboard = "letter"}
        else {pressedCaps                                     ("A", count: 0.0769)}
    }
    @IBAction func b() {
        if whichKeyboard == "letter" {pressedLetter           ("b", count: 0.0714)}
        else if whichKeyboard == "alternate" {pressedAlternate("1", count: 0.0556)}
        else if whichKeyboard == "emoji" {pressedEmoji        ("💕", count: 0.1429)}
        else if whichKeyboard == "caps" {pressedCaps          ("B", count: 0.0769);keysLetters();whichKeyboard = "letter"}
        else {pressedCaps                                     ("B", count: 0.0769)}
    }
    @IBAction func c() {
        if whichKeyboard == "letter" {pressedLetter           ("c", count: 0.0667)}
        else if whichKeyboard == "alternate" {pressedAlternate("2", count: 0.0714)}
        else if whichKeyboard == "emoji" {pressedEmoji        ("😍", count: 0.1429)}
        else if whichKeyboard == "caps" {pressedCaps          ("C", count: 0.0769);keysLetters();whichKeyboard = "letter"}
        else {pressedCaps                                     ("C", count: 0.0769)}
    }
    @IBAction func d() {
        if whichKeyboard == "letter" {pressedLetter           ("d", count: 0.0714)}
        else if whichKeyboard == "alternate" {pressedAlternate("3", count: 0.0714)}
        else if whichKeyboard == "emoji" {pressedEmoji        ("😘", count: 0.1429)}
        else if whichKeyboard == "caps" {pressedCaps          ("D", count: 0.0833);keysLetters();whichKeyboard = "letter"}
        else {pressedCaps                                     ("D", count: 0.0833)}
    }
    @IBAction func e() {
        if whichKeyboard == "letter" {pressedLetter           ("e", count: 0.0667)}
        else if whichKeyboard == "alternate" {pressedAlternate("4", count: 0.0714)}
        else if whichKeyboard == "emoji" {pressedEmoji        ("😊", count: 0.1429)}
        else if whichKeyboard == "caps" {pressedCaps          ("E", count: 0.0714);keysLetters();whichKeyboard = "letter"}
        else {pressedCaps                                     ("E", count: 0.0714)}
    }
    @IBAction func f() {
        if whichKeyboard == "letter" {pressedLetter           ("f", count: 0.0476)}
        else if whichKeyboard == "alternate" {pressedAlternate("5", count: 0.0714)}
        else if whichKeyboard == "emoji" {pressedEmoji        ("😱", count: 0.1429)}
        else if whichKeyboard == "caps" {pressedCaps          ("F", count: 0.0667);keysLetters();whichKeyboard = "letter"}
        else {pressedCaps                                     ("F", count: 0.0667)}
    }
    @IBAction func g() {
        if whichKeyboard == "letter" {pressedLetter           ("g", count: 0.0714)}
        else if whichKeyboard == "alternate" {pressedAlternate("6", count: 0.0714)}
        else if whichKeyboard == "emoji" {pressedEmoji        ("😭", count: 0.1429)}
        else if whichKeyboard == "caps" {pressedCaps          ("G", count: 0.0833);keysLetters();whichKeyboard = "letter"}
        else {pressedCaps                                     ("G", count: 0.0833)}
    }
    @IBAction func h() {
        if whichKeyboard == "letter" {pressedLetter           ("h", count: 0.0714)}
        else if whichKeyboard == "alternate" {pressedAlternate("7", count: 0.0667)}
        else if whichKeyboard == "emoji" {pressedEmoji        ("😂", count: 0.1429)}
        else if whichKeyboard == "caps" {pressedCaps          ("H", count: 0.0833);keysLetters();whichKeyboard = "letter"}
        else {pressedCaps                                     ("H", count: 0.0833)}
    }
    @IBAction func i() {
        if whichKeyboard == "letter" {pressedLetter           ("i", count: 0.0345)}
        else if whichKeyboard == "alternate" {pressedAlternate("8", count: 0.0714)}
        else if whichKeyboard == "emoji" {pressedEmoji        ("😩", count: 0.1429)}
        else if whichKeyboard == "caps" {pressedCaps          ("I", count: 0.0333);keysLetters();whichKeyboard = "letter"}
        else {pressedCaps                                     ("I", count: 0.0333)}
    }
    @IBAction func j() {
        if whichKeyboard == "letter" {pressedLetter           ("j", count: 0.0345)}
        else if whichKeyboard == "alternate" {pressedAlternate("9", count: 0.0714)}
        else if whichKeyboard == "emoji" {pressedEmoji        ("😔", count: 0.1429)}
        else if whichKeyboard == "caps" {pressedCaps          ("J", count: 0.0625);keysLetters();whichKeyboard = "letter"}
        else {pressedCaps                                     ("J", count: 0.0625)}
    }
    @IBAction func k() {
        if whichKeyboard == "letter" {pressedLetter           ("k", count: 0.0625)}
        else if whichKeyboard == "alternate" {pressedAlternate("*", count: 0.0588)}
        else if whichKeyboard == "emoji" {pressedEmoji        ("🙌", count: 0.1429)}
        else if whichKeyboard == "caps" {pressedCaps          ("K", count: 0.0769);keysLetters();whichKeyboard = "letter"}
        else {pressedCaps                                     ("K", count: 0.0769)}
    }
    @IBAction func l() {
        if whichKeyboard == "letter" {pressedLetter           ("l", count: 0.0323)}
        else if whichKeyboard == "alternate" {pressedAlternate("/", count: 0.0455)}
        else if whichKeyboard == "emoji" {pressedEmoji        ("😎", count: 0.1429)}
        else if whichKeyboard == "caps" {pressedCaps          ("L", count: 0.0625);keysLetters();whichKeyboard = "letter"}
        else {pressedCaps                                     ("L", count: 0.0625)}
    }
    @IBAction func m() {
        if whichKeyboard == "letter" {pressedLetter           ("m", count: 0.1111)}
        else if whichKeyboard == "alternate" {pressedAlternate("+", count: 0.0667)}
        else if whichKeyboard == "emoji" {pressedEmoji        ("😜", count: 0.1429)}
        else if whichKeyboard == "caps" {pressedCaps          ("M", count: 0.1);keysLetters();whichKeyboard = "letter"}
        else {pressedCaps                                     ("M", count: 0.1)}
    }
    @IBAction func n() {
        if whichKeyboard == "letter" {pressedLetter           ("n", count: 0.0714)}
        else if whichKeyboard == "alternate" {pressedAlternate("-", count: 0.05)}
        else if whichKeyboard == "emoji" {pressedEmoji        ("☺️", count: 0.1429)}
        else if whichKeyboard == "caps" {pressedCaps          ("N", count: 0.0833);keysLetters();whichKeyboard = "letter"}
        else {pressedCaps                                     ("N", count: 0.0833)}
    }
    @IBAction func o() {
        if whichKeyboard == "letter" {pressedLetter           ("o", count: 0.0714)}
        else if whichKeyboard == "alternate" {pressedAlternate("=", count: 0.0667)}
        else if whichKeyboard == "emoji" {pressedEmoji        ("😒", count: 0.1429)}
        else if whichKeyboard == "caps" {pressedCaps          ("O", count: 0.0833);keysLetters();whichKeyboard = "letter"}
        else {pressedCaps                                     ("O", count: 0.0833)}
    }
    @IBAction func p() {
        if whichKeyboard == "letter" {pressedLetter           ("p", count: 0.0714)}
        else if whichKeyboard == "alternate" {pressedAlternate("@", count: 0.1111)}
        else if whichKeyboard == "emoji" {pressedEmoji        ("😉", count: 0.1429)}
        else if whichKeyboard == "caps" {pressedCaps          ("P", count: 0.0714);keysLetters();whichKeyboard = "letter"}
        else {pressedCaps                                     ("P", count: 0.0714)}
    }
    @IBAction func q() {
        if whichKeyboard == "letter" {pressedLetter           ("q", count: 0.0714)}
        else if whichKeyboard == "alternate" {pressedAlternate("#", count: 0.0769)}
        else if whichKeyboard == "emoji" {pressedEmoji        ("😌", count: 0.1429)}
        else if whichKeyboard == "caps" {pressedCaps          ("Q", count: 0.0833);keysLetters();whichKeyboard = "letter"}
        else {pressedCaps                                     ("Q", count: 0.0833)}
    }
    @IBAction func r() {
        if whichKeyboard == "letter" {pressedLetter           ("r", count: 0.0476)}
        else if whichKeyboard == "alternate" {pressedAlternate("$", count: 0.0667)}
        else if whichKeyboard == "emoji" {pressedEmoji        ("😳", count: 0.1429)}
        else if whichKeyboard == "caps" {pressedCaps          ("R", count: 0.0769);keysLetters();whichKeyboard = "letter"}
        else {pressedCaps                                     ("R", count: 0.0769)}
    }
    @IBAction func s() {
        if whichKeyboard == "letter" {pressedLetter           ("s", count: 0.0625)}
        else if whichKeyboard == "alternate" {pressedAlternate("%", count: 0.0909)}
        else if whichKeyboard == "emoji" {pressedEmoji        ("😁", count: 0.1429)}
        else if whichKeyboard == "caps" {pressedCaps          ("S", count: 0.0714);keysLetters();whichKeyboard = "letter"}
        else {pressedCaps                                     ("S", count: 0.0714)}
    }
    @IBAction func t() {
        if whichKeyboard == "letter" {pressedLetter           ("t", count: 0.0455)}
        else if whichKeyboard == "alternate" {pressedAlternate(":", count: 0.0385)}
        else if whichKeyboard == "emoji" {pressedEmoji        ("😏", count: 0.1429)}
        else if whichKeyboard == "caps" {pressedCaps          ("T", count: 0.0667);keysLetters();whichKeyboard = "letter"}
        else {pressedCaps                                     ("T", count: 0.0667)}
    }
    @IBAction func u() {
        if whichKeyboard == "letter" {pressedLetter           ("u", count: 0.0714)}
        else if whichKeyboard == "alternate" {pressedAlternate("'", count: 0.0278)}
        else if whichKeyboard == "emoji" {pressedEmoji        ("🎈", count: 0.1429)}
        else if whichKeyboard == "caps" {pressedCaps          ("U", count: 0.0833);keysLetters();whichKeyboard = "letter"}
        else {pressedCaps                                     ("U", count: 0.0833)}
    }
    @IBAction func v() {
        if whichKeyboard == "letter" {pressedLetter           ("v", count: 0.0625)}
        else if whichKeyboard == "alternate" {pressedAlternate(",", count: 0.0303)}
        else if whichKeyboard == "emoji" {pressedEmoji        ("🙈", count: 0.1429)}
        else if whichKeyboard == "caps" {pressedCaps          ("V", count: 0.0769);keysLetters();whichKeyboard = "letter"}
        else {pressedCaps                                     ("V", count: 0.0769)}
    }
    @IBAction func w() {
        if whichKeyboard == "letter" {pressedLetter           ("w", count: 0.0909)}
        else if whichKeyboard == "alternate" {pressedAlternate(".", count: 0.0357)}
        else if whichKeyboard == "emoji" {pressedEmoji        ("👍", count: 0.1429)}
        else if whichKeyboard == "caps" {pressedCaps          ("W", count: 0.1111);keysLetters();whichKeyboard = "letter"}
        else {pressedCaps                                     ("W", count: 0.1111)}
    }
    @IBAction func x() {
        if whichKeyboard == "letter" {pressedLetter           ("x", count: 0.0667)}
        else if whichKeyboard == "alternate" {pressedAlternate("!", count: 0.0345)}
        else if whichKeyboard == "emoji" {pressedEmoji        ("👌", count: 0.1429)}
        else if whichKeyboard == "caps" {pressedCaps          ("X", count: 0.0714);keysLetters();whichKeyboard = "letter"}
        else {pressedCaps                                     ("X", count: 0.0714)}
    }
    @IBAction func y() {
        if whichKeyboard == "letter" {pressedLetter           ("y", count: 0.0667)}
        else if whichKeyboard == "alternate" {pressedAlternate("?", count: 0.0588)}
        else if whichKeyboard == "emoji" {pressedEmoji        ("🙏", count: 0.1429)}
        else if whichKeyboard == "caps" {pressedCaps          ("Y", count: 0.0714);keysLetters();whichKeyboard = "letter"}
        else {pressedCaps                                     ("Y", count: 0.0714)}
    }
    @IBAction func z() {
        if whichKeyboard == "letter" {pressedLetter           ("z", count: 0.0625)}
        else if whichKeyboard == "alternate" {pressedAlternate("\"", count: 0.05)}
        else if whichKeyboard == "emoji" {pressedEmoji        ("✌️", count: 0.1429)}
        else if whichKeyboard == "caps" {pressedCaps          ("Z", count: 0.0714);keysLetters();whichKeyboard = "letter"}
        else {pressedCaps                                     ("Z", count: 0.0714)}
    }
    
    
    // Updates the message label the user sees
    var scrolledString = ""
    func calcSum() -> Double {
        var sum = 0.0
        for var i = 0; i < countArray.count; i++ {
            sum += countArray[i]
        }
        return sum
    }
    func updateMessageLabel(count: Double) {
        scrolledString = message
        if count == -1 {
            if message.characters.count > 0 {
                countArray.removeLast()
                while calcSum() < 0.95 && removedArray.count > 0 {
                    countArray.insert(removedArray.last!, atIndex: 0)
                    removedArray.removeLast()
                }
            }
            else {
                countArray.removeAll()
                removedArray.removeAll()
            }
        }
        else {countArray.append(count)}
        while calcSum() > 0.95 {
            removedArray.append(countArray[0])
            countArray.removeFirst()
        }
        for var i = 0; i < removedArray.count; i++ {
            scrolledString.removeAtIndex(scrolledString.startIndex)
        }
        setTitle(scrolledString + "_")
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if whichKeyboard == "caps" {
            shiftOutlet.setBackgroundImageNamed("CapsIcon")
            keysCaps()
        }
        else if whichKeyboard == "capsLock" {
            shiftOutlet.setBackgroundImageNamed("CapsLockIcon")
            keysCaps()
        }
        else {
            shiftOutlet.setBackgroundImageNamed("ShiftIcon")
            if whichKeyboard == "letter" {keysLetters()}
            else if whichKeyboard == "alternate" {keysAlternates()}
            else {keysEmojis()}
        }
        altOutlet.setBackgroundImageNamed("AltIcon")
        deleteOutlet.setBackgroundImageNamed("DeleteIcon")
        message += " "
        updateMessageLabel(0.0278)
        message.removeAtIndex(message.endIndex.predecessor())
        updateMessageLabel(-1)
        recieverName = context![0] as! String
        recieverNumber = context![1] as! String
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
}