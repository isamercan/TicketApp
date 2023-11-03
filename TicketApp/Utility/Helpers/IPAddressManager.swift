//
//  IPAddressManager.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 31.10.2023.
//

import Foundation

////This class is responsible for retrieving the IP address of the device for different network interfaces, such as Wi-Fi, wired (Ethernet), and cellular connections.

//This declares a protocol named IPAddressManagerable. It specifies a single method getIPAddress() that any class conforming to this protocol must implement. The purpose of this protocol is to define a common interface for classes that can retrieve IP addresses.
protocol IPAddressManagerable {
    //Get IPAddress for wifi , wired, and cellular
    func getIPAddress() -> String
}

final class IPAddressManager: IPAddressManagerable {
    
    //// This line creates a shared (singleton) instance of the IPAddressManager class, which can be accessed globally as IPAddressManager.shared. This ensures that there's only one instance of IPAddressManager throughout the application.
    static let shared = IPAddressManager()
    
    //This method retrieves the IP address of the device for different network interfaces.
    public func getIPAddress() -> String {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }

                guard let interface = ptr?.pointee else { return "" }
                let addrFamily = interface.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {

                    // wifi = ["en0"]
                    // wired = ["en2", "en3", "en4"]
                    // cellular = ["pdp_ip0","pdp_ip1","pdp_ip2","pdp_ip3"]

                    let name: String = String(cString: (interface.ifa_name))
                    if  name == "en0" || name == "en2" || name == "en3" || name == "en4" || name == "pdp_ip0" || name == "pdp_ip1" || name == "pdp_ip2" || name == "pdp_ip3" {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface.ifa_addr, socklen_t((interface.ifa_addr.pointee.sa_len)), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        return address ?? ""
    }
}

//Example of usage
//let strIPAddress : String = IPAddressManager.shared.getIPAddress()

