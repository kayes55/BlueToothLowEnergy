//
//  Created by Imrul Kayes on 1/23/20.
//  Copyright © 2020 Imrul Kayes. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController, CBCentralManagerDelegate {
    
    @IBOutlet weak var peripheralName: UILabel!
    @IBOutlet weak var connectableDeviceCount: UILabel!
    
    
    var centralManager: CBCentralManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            central.scanForPeripherals(withServices: nil, options: nil)
            print("scanning...")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        print("Peripheralname: \(peripheral.name ?? "No Name")")
        self.peripheralName.text = peripheral.name ?? "No Name"
        print("Connectable Device count: \(String(describing: advertisementData["kCBAdvDataIsConnectable"]))")
        connectableDeviceCount.text = "Connectable Device: \(advertisementData["kCBAdvDataIsConnectable"] ?? 0)"
        centralManager.stopScan()
    }
}

