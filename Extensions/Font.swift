////
////  Font.swift
////  Speedreader
////
////  Created by Herman Christiansen on 23/01/2022.
////
//
//import SwiftUI
//
//extension Font {
//
// /// Create a font with the large title text style.
// public static var customLargeTitle: Font {
//     return Font.custom("JosefinSans-Regular", size: UIFont.preferredFont(forTextStyle: .largeTitle).pointSize)
// }
//
// /// Create a font with the title text style.
// public static var customTitleBold: Font {
//     return Font.custom("BalsamiqSans-Bold", size: UIFont.preferredFont(forTextStyle: .title1).pointSize)
// }
//
//    public static var customTitle: Font {
//        return Font.custom("BalsamiqSans-Regular", size: UIFont.preferredFont(forTextStyle: .title1).pointSize)
//    }
//
// /// Create a font with the headline text style.
// public static var customHeadline: Font {
//     return Font.custom("BalsamiqSans-Regular", size: UIFont.preferredFont(forTextStyle: .headline).pointSize)
// }
//
// /// Create a font with the subheadline text style.
// public static var customSubheadline: Font {
//     return Font.custom("BalsamiqSans-Light", size: UIFont.preferredFont(forTextStyle: .subheadline).pointSize)
// }
//
// /// Create a font with the body text style.
// public static var customBody: Font {
//        return Font.custom("BalsamiqSans-Regular", size: UIFont.preferredFont(forTextStyle: .body).pointSize)
//    }
//
// /// Create a font with the callout text style.
// public static var customCallout: Font {
//        return Font.custom("BalsamiqSans-Regular", size: UIFont.preferredFont(forTextStyle: .callout).pointSize)
//    }
//
// /// Create a font with the footnote text style.
// public static var customFootnote: Font {
//        return Font.custom("BalsamiqSans-Regular", size: UIFont.preferredFont(forTextStyle: .footnote).pointSize)
//    }
//
// /// Create a font with the caption text style.
// public static var customCaption: Font {
//        return Font.custom("BalsamiqSans-Regular", size: UIFont.preferredFont(forTextStyle: .caption1).pointSize)
//    }
//
// public static func customsystem(size: CGFloat, weight: Font.Weight = .regular, design: Font.Design = .default) -> Font {
//     var font = "BalsamicSans-Regular"
//     switch weight {
//     case .bold: font = "BalsamicSans-Bold"
////     case .heavy: font = "OpenSans-ExtraBold"
////     case .light: font = "OpenSans-Light"
////     case .medium: font = "OpenSans-Regular"
////     case .semibold: font = "OpenSans-SemiBold"
////     case .thin: font = "OpenSans-Light"
////     case .ultraLight: font = "OpenSans-Light"
//     default: break
//     }
//     return Font.custom(font, size: size)
// }
//}
