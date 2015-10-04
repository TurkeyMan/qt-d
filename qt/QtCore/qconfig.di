module qt.QtCore.qconfig;

/* Everything */

/* License information */
enum QT_PRODUCT_LICENSEE = "Open Source";
enum QT_PRODUCT_LICENSE  = "OpenSource";


// Compiler sub-arch support
enum QT_COMPILER_SUPPORTS_SSE2 = 1;
enum QT_COMPILER_SUPPORTS_SSE3 = 1;
enum QT_COMPILER_SUPPORTS_SSSE3 = 1;
enum QT_COMPILER_SUPPORTS_SSE4_1 = 1;
enum QT_COMPILER_SUPPORTS_SSE4_2 = 1;
enum QT_COMPILER_SUPPORTS_AVX = 1;

// Compile time features
version (QT_LARGEFILE_SUPPORT) {
    version(QT_NO_LARGEFILE_SUPPORT) {
//# undef QT_LARGEFILE_SUPPORT
    }
} else {
    enum QT_LARGEFILE_SUPPORT = 64;
}

version(QT_CUPS) {
//# undef QT_NO_CUPS
} else {
    version = QT_NO_CUPS;
}

version(QT_EVDEV) {
//# undef QT_NO_EVDEV
} else {
    version = QT_NO_EVDEV;
}

version(QT_EVENTFD) {
//# undef QT_NO_EVENTFD
} else {
    version = QT_NO_EVENTFD;
}

version(QT_FONTCONFIG) {
//# undef QT_NO_FONTCONFIG
} else {
    version = QT_NO_FONTCONFIG;
}

version(QT_GLIB) {
//# undef QT_NO_GLIB
} else {
    version = QT_NO_GLIB;
}

version(QT_ICONV) {
//# undef QT_NO_ICONV
} else {
    version = QT_NO_ICONV;
}

version(QT_IMAGEFORMAT_JPEG) {
//# undef QT_NO_IMAGEFORMAT_JPEG
} else {
    version = QT_NO_IMAGEFORMAT_JPEG;
}

version(QT_INOTIFY) {
//# undef QT_NO_INOTIFY
} else {
    version = QT_NO_INOTIFY;
}

version(QT_MTDEV) {
//# undef QT_NO_MTDEV
} else {
    version = QT_NO_MTDEV;
}

version(QT_CUPS) {
//# undef QT_NO_NIS
} else {
    version = QT_NO_NIS;
}

version(QT_OPENVG) {
//# undef QT_NO_OPENVG
} else {
    version = QT_NO_OPENVG;
}

version(QT_STYLE_GTK) {
//# undef QT_NO_STYLE_GTK
} else {
    version = QT_NO_STYLE_GTK;
}

version(QT_STYLE_WINDOWSCE) {
//# undef QT_NO_STYLE_WINDOWSCE
} else {
    version = QT_NO_STYLE_WINDOWSCE;
}

version(QT_STYLE_WINDOWSMOBILE) {
//# undef QT_NO_STYLE_WINDOWSMOBILE
} else {
    version = QT_NO_STYLE_WINDOWSMOBILE;
}

enum QT_QPA_DEFAULT_PLATFORM_NAME = "windows";
