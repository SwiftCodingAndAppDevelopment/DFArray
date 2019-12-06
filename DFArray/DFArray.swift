/// A simple protocol to extend the Swift native types to work with data structure arrays.
public protocol SimplyInitializable {
    /// Require init so `DFArray` can allocate addresses properly.
    init()
}


// Add requirement for native types to by `SimplyInitializable`.
extension Int: SimplyInitializable { }
extension String: SimplyInitializable { }
extension Double: SimplyInitializable { }
extension Bool: SimplyInitializable { }

/// A collection type that behaves like data structure arrays rather than Swift Arrays.
///
/// - Author: Sam Smith.10439
///
/// - Date: 12/6/2019
public struct DFArray<T: SimplyInitializable> {
    private var data: [T]
    private var numberOfElements: Int
    private var currentCapacity: Int
    
    /// The number of elements the array currently has stored.
    public var count: Int {
        get {
            return self.numberOfElements
        }
    }
    
    /// The current maximum capacity of the array.
    ///
    /// - Note: The empty space in an array can be found by subtracting `count` from `capacity`.
    public var capacity: Int {
        get {
            return self.currentCapacity
        }
    }
    
    /// Creates a new DFArray that can hold `size` elements.
    ///
    /// - Parameter size: The number of elements the array can hold.
    ///
    /// - Returns: An empty DFArray of `size`
    public init(_ size: Int) {
        self.data = []
        self.numberOfElements = 0
        self.currentCapacity = size
        self.data.reserveCapacity(self.currentCapacity)
        
        for _ in 0..<self.currentCapacity {
            data.append(T.init())
        }
    }
    
    /// Returns the element of the array at `index`.
    ///
    /// - Parameter index: The index of the element to retrieve or modify.
    ///
    /// - Requires: `index` > 0 && `index` < `capacity`
    public subscript(index: Int) -> T {
        get {
            guard index < self.currentCapacity else {
                fatalError("Index \(index) is out of range (0 - \(self.currentCapacity - 1))")
            }
            
            return data[index]
        }
        
        set(newValue) {
            guard index < self.currentCapacity else {
                fatalError("Index \(index) is out of range (0 - \(self.currentCapacity - 1))")
            }
            
            data[index] = newValue
        }
    }
}
