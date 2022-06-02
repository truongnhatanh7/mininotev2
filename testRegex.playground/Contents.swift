import UIKit







func listMatches(for pattern: String, inString string: String) -> [String] {
    guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
        return []
    }
    
    let range = NSRange(string.startIndex..., in: string)
    let matches = regex.matches(in: string, range: range)
    
    return matches.map { match in
        let range = Range(match.range, in: string)!
        return String(string[range])
    }

}

var str = "The quick brown fox jumps over the lazy dog"
listMatches(for: "\\w+(\\s\\w+)*", inString: str)
