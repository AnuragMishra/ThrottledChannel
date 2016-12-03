import Foundation

/**
 Provides values sent to the channel to a consumer at a rate throttled based on the processing capabilities of the consumer.
 */
public class ThrottledChannel<T> {
    private var value: T?
    private let source: DispatchSourceUserDataAdd
    
    /**
     Initializes the channel with a reader block that will get values published to the channel. The block is
     invoked with the latest value published to the channel, and is not guaranteed to receive all values.
     
     Should be used for non-essential data where the consumer is interested in knowing the latest value at a
     rate it is comfortable processing at.
     
     - Parameter readLatest: A block that is invoked with the latest available value
     */
    public init(readLatest: @escaping (T) -> ()) {
        source = DispatchSource.makeUserDataAddSource()
        
        source.setEventHandler { [weak self] in
            if let strongSelf = self, let value = strongSelf.value {
                readLatest(value)
            }
        }
        
        source.resume()
    }
    
    /**
     Publishes a value to the channel
     
     - Parameter value: Value to publish
     */
    public func send(_ value: T) {
        self.value = value
        
        source.add(data: 1)
    }
}
