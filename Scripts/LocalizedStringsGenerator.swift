import Foundation

@main
public struct LocalizedStringsGenerator {
    static func main() {
        createLocalizedStringsFile(filePath: CommandLine.arguments[1], stringsFileName: CommandLine.arguments[2])
    }

    private static func createLocalizedStringsFile(filePath: String, stringsFileName: String) {
        let fileContentString =
        """
        //
        // Auto-generated code. Do not modify this file manually.
        //

        \(imports)

        \(localizableProtocol(stringsFileName))

        \(stringExtension)

        \(localizedStringsEnum(stringsFileName))
        
        """

        do {
            try fileContentString.write(toFile: filePath, atomically: true, encoding: .utf8)
            print("LocalizedStrings file successfully generated:\n \(filePath)\n")
        } catch {
            print(error)
        }
    }

    private static func localizedStringsEnum(_ stringsFileName: String) -> String {
        guard let localizableStringsFileURL = findPath(for: stringsFileName) else { return "" }
        do {
            let data = try String(contentsOfFile: localizableStringsFileURL.path, encoding: .utf8)
            let stringsLine = data.components(separatedBy: .newlines).filter { $0.contains(";") && $0.contains("=") }
            let stringsKeys = stringsLine
                .compactMap { $0.split(separator: "=").first }
                .map { $0?.replacingOccurrences(of: " ", with: "") }
                .map { $0?.replacingOccurrences(of: "\"", with: "") }
            let enumCases = stringsKeys.compactMap { $0 }.map { "case \($0)" }
            return """
                enum LocalizedStrings: String, Localizable {
                    \(enumCases.joined(separator: "\n\t"))
                }
                """
        } catch {
            print("Error: \(error)")
        }
        return ""
    }

    private static func findPath(for stringsFileName: String) -> URL? {
        let url = URL(fileURLWithPath: Bundle.main.bundlePath)
        var files = [URL]()
        guard let enumerator = FileManager.default.enumerator(at: url, includingPropertiesForKeys: [.isRegularFileKey], options: [.skipsHiddenFiles, .skipsPackageDescendants]) else {
            return nil
        }
        for case let fileURL as URL in enumerator {
            do {
                let fileAttributes = try fileURL.resourceValues(forKeys: [.isRegularFileKey])
                if fileAttributes.isRegularFile == true, fileURL.lastPathComponent.contains(stringsFileName) {
                    files.append(fileURL)
                }
            } catch { print(error, fileURL) }
        }
        return files.first
    }

    // MARK: - Utils

    static let imports =
    """
    import Foundation
    """

    static func localizableProtocol(_ stringsFileName: String) -> String {
        """
        protocol Localizable {
            var tableName: String { get }
        }

        extension Localizable where Self: RawRepresentable, Self.RawValue == String {
            var tableName: String {
                "\(stringsFileName)"
            }

            func callAsFunction() -> String {
                rawValue.localized(tableName: tableName)
            }
        }
        """
    }

    static let stringExtension: String =
        """
        private extension String {
            func localized(bundle: Bundle = .main,
                           tableName: String,
                           comment: String = "") -> String {
                NSLocalizedString(self, tableName: tableName, value: self, comment: comment)
            }
        }
        """
}
