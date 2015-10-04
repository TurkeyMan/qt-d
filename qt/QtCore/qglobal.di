/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Copyright (C) 2014 Intel Corporation.
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtCore module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL21$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and Digia. For licensing terms and
** conditions see http://qt.digia.com/licensing. For further information
** use the contact form at http://qt.digia.com/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 or version 3 as published by the Free
** Software Foundation and appearing in the file LICENSE.LGPLv21 and
** LICENSE.LGPLv3 included in the packaging of this file. Please review the
** following information to ensure the GNU Lesser General Public License
** requirements will be met: https://www.gnu.org/licenses/lgpl.html and
** http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Digia gives you certain additional
** rights. These rights are described in the Digia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** $QT_END_LICENSE$
**
****************************************************************************/

module qt.QtCore.qglobal;

enum string QT_VERSION_STR = "5.4.2";
/*
   QT_VERSION is (major << 16) + (minor << 8) + patch.
*/
enum QT_VERSION = 0x050402;
/*
   can be used like #if (QT_VERSION >= QT_VERSION_CHECK(4, 4, 0))
*/
auto QT_VERSION_CHECK(auto major, auto minor, auto patch) { return (major<<16)|(minor<<8)|(patch); }

version(QT_BUILD_QMAKE) {} else version(QT_BUILD_CONFIGURE) {} else {
    public import qt.QtCore.qconfig;
    public import qt.QtCore.qfeatures;
}

bool QT_SUPPORTS(string feature)() { mixin("version(QT_NO_" ~ feature ~ ") { return false; } else { return true; }"); }

static if(QT_VERSION >= QT_VERSION_CHECK(6,0,0))
    version = QT_NO_UNSHARABLE_CONTAINERS;

/* These two macros makes it possible to turn the builtin line expander into a
 * string literal. */
//#define QT_STRINGIFY2(x) #x
//#define QT_STRINGIFY(x) QT_STRINGIFY2(x)

public import qt.QtCore.qsystemdetection;
public import qt.QtCore.qprocessordetection;
public import qt.QtCore.qcompilerdetection;

version(__ELF__)
    version = Q_OF_ELF;
version(__MACH__) version(__APPLE__)
    version = Q_OF_MACH_O;

string QT_MANGLE_NAMESPACE(string name) { return name; }
/+
#if !defined(QT_NAMESPACE) || defined(Q_MOC_RUN) /* user namespace */

# define QT_PREPEND_NAMESPACE(name) ::name
# define QT_USE_NAMESPACE
# define QT_BEGIN_NAMESPACE
# define QT_END_NAMESPACE
# define QT_BEGIN_INCLUDE_NAMESPACE
# define QT_END_INCLUDE_NAMESPACE
#ifndef QT_BEGIN_MOC_NAMESPACE
# define QT_BEGIN_MOC_NAMESPACE
#endif
#ifndef QT_END_MOC_NAMESPACE
# define QT_END_MOC_NAMESPACE
#endif
# define QT_FORWARD_DECLARE_CLASS(name) extern(C++) class name;
# define QT_FORWARD_DECLARE_STRUCT(name) struct name;
# define QT_MANGLE_NAMESPACE(name) name

#else /* user namespace */

# define QT_PREPEND_NAMESPACE(name) ::QT_NAMESPACE::name
# define QT_USE_NAMESPACE using namespace ::QT_NAMESPACE;
# define QT_BEGIN_NAMESPACE namespace QT_NAMESPACE {
# define QT_END_NAMESPACE }
# define QT_BEGIN_INCLUDE_NAMESPACE }
# define QT_END_INCLUDE_NAMESPACE namespace QT_NAMESPACE {
#ifndef QT_BEGIN_MOC_NAMESPACE
# define QT_BEGIN_MOC_NAMESPACE QT_USE_NAMESPACE
#endif
#ifndef QT_END_MOC_NAMESPACE
# define QT_END_MOC_NAMESPACE
#endif
# define QT_FORWARD_DECLARE_CLASS(name) \
    QT_BEGIN_NAMESPACE extern(C++) class name; QT_END_NAMESPACE \
    using QT_PREPEND_NAMESPACE(name);

# define QT_FORWARD_DECLARE_STRUCT(name) \
    QT_BEGIN_NAMESPACE struct name; QT_END_NAMESPACE \
    using QT_PREPEND_NAMESPACE(name);

# define QT_MANGLE_NAMESPACE0(x) x
# define QT_MANGLE_NAMESPACE1(a, b) a##_##b
# define QT_MANGLE_NAMESPACE2(a, b) QT_MANGLE_NAMESPACE1(a,b)
# define QT_MANGLE_NAMESPACE(name) QT_MANGLE_NAMESPACE2( \
        QT_MANGLE_NAMESPACE0(name), QT_MANGLE_NAMESPACE0(QT_NAMESPACE))

namespace QT_NAMESPACE {}

# ifndef QT_BOOTSTRAPPED
# ifndef QT_NO_USING_NAMESPACE
   /*
    This expands to a "using QT_NAMESPACE" also in _header files_.
    It is the only way the feature can be used without too much
    pain, but if people _really_ do not want it they can add
    DEFINES += QT_NO_USING_NAMESPACE to their .pro files.
    */
   QT_USE_NAMESPACE
# endif
# endif

#endif /* user namespace */
+/

version(Q_OS_DARWIN) {
//	&& !defined(QT_LARGEFILE_SUPPORT)
//#  define QT_LARGEFILE_SUPPORT 64
    enum QT_LARGEFILE_SUPPORT = 64;
}

/*
   Size-dependent types (architechture-dependent byte order)

   Make sure to update QMetaType when changing these typedefs
*/

alias qint8 = byte;         /* 8 bit signed */
alias quint8 = ubyte;		/* 8 bit unsigned */
alias qint16 = short;       /* 16 bit signed */
alias quint16 = ushort;		/* 16 bit unsigned */
alias qint32 = int;         /* 32 bit signed */
alias quint32 = uint;		/* 32 bit unsigned */
alias qint64 = long;        /* 64 bit signed */
alias quint64 = ulong;		/* 64 bit unsigned */
alias qlonglong = qint64;
alias qulonglong = quint64;

enum size_t QT_POINTER_SIZE = (void*).sizeof;

/*
   Useful type definitions for Qt
*/

alias uchar = ubyte;

version(QT_COORD_TYPE)
    alias qreal = QT_COORD_TYPE;
else
    alias qreal = double;
/+
#if defined(QT_NO_DEPRECATED)
#  undef QT_DEPRECATED
#  undef QT_DEPRECATED_X
#  undef QT_DEPRECATED_VARIABLE
#  undef QT_DEPRECATED_CONSTRUCTOR
#elif defined(QT_DEPRECATED_WARNINGS)
#  undef QT_DEPRECATED
#  define QT_DEPRECATED Q_DECL_DEPRECATED
#  undef QT_DEPRECATED_X
#  define QT_DEPRECATED_X(text) Q_DECL_DEPRECATED_X(text)
#  undef QT_DEPRECATED_VARIABLE
#  define QT_DEPRECATED_VARIABLE Q_DECL_VARIABLE_DEPRECATED
#  undef QT_DEPRECATED_CONSTRUCTOR
#  define QT_DEPRECATED_CONSTRUCTOR explicit Q_DECL_CONSTRUCTOR_DEPRECATED
#else
#  undef QT_DEPRECATED
#  define QT_DEPRECATED
#  undef QT_DEPRECATED_X
#  define QT_DEPRECATED_X(text)
#  undef QT_DEPRECATED_VARIABLE
#  define QT_DEPRECATED_VARIABLE
#  undef QT_DEPRECATED_CONSTRUCTOR
#  define QT_DEPRECATED_CONSTRUCTOR
#endif

#ifndef QT_DISABLE_DEPRECATED_BEFORE
#define QT_DISABLE_DEPRECATED_BEFORE QT_VERSION_CHECK(5, 0, 0)
#endif
+/
/*
    QT_DEPRECATED_SINCE(major, minor) evaluates as true if the Qt version is greater than
    the deprecation point specified.

    Use it to specify from which version of Qt a function or extern(C++) class has been deprecated

    Example:
        #if QT_DEPRECATED_SINCE(5,1)
            QT_DEPRECATED void deprecatedFunction(); //function deprecated since Qt 5.1
        #endif

*/
/+
#ifdef QT_DEPRECATED
#define QT_DEPRECATED_SINCE(major, minor) (QT_VERSION_CHECK(major, minor, 0) > QT_DISABLE_DEPRECATED_BEFORE)
#else
#define QT_DEPRECATED_SINCE(major, minor) 0
#endif
+/
/*
   The Qt modules' export macros.
   The options are:
    - defined(QT_STATIC): Qt was built or is being built in static mode
    - defined(QT_SHARED): Qt was built or is being built in shared/dynamic mode
   If neither was defined, then QT_SHARED is implied. If Qt was compiled in static
   mode, QT_STATIC is defined in qconfig.h. In shared mode, QT_STATIC is implied
   for the bootstrapped tools.
*/

version(QT_BOOTSTRAPPED) {
    version(QT_SHARED) {
        static assert(false, "QT_SHARED and QT_BOOTSTRAPPED together don't make sense. Please fix the build");
    } else version(QT_STATIC) {} else {
        version = QT_STATIC;
    }
}
/+
#if defined(QT_SHARED) || !defined(QT_STATIC)
#  ifdef QT_STATIC
#    error "Both QT_SHARED and QT_STATIC defined, please make up your mind"
#  endif
#  ifndef QT_SHARED
#    define QT_SHARED
#  endif
#  if defined(QT_BUILD_CORE_LIB)
#    define export Q_DECL_EXPORT
#  else
#    define export Q_DECL_IMPORT
#  endif
#  if defined(QT_BUILD_GUI_LIB)
#    define Q_GUI_EXPORT Q_DECL_EXPORT
#  else
#    define Q_GUI_EXPORT Q_DECL_IMPORT
#  endif
#  if defined(QT_BUILD_WIDGETS_LIB)
#    define Q_WIDGETS_EXPORT Q_DECL_EXPORT
#  else
#    define Q_WIDGETS_EXPORT Q_DECL_IMPORT
#  endif
#  if defined(QT_BUILD_NETWORK_LIB)
#    define Q_NETWORK_EXPORT Q_DECL_EXPORT
#  else
#    define Q_NETWORK_EXPORT Q_DECL_IMPORT
#  endif
#else
#  define export
#  define Q_GUI_EXPORT
#  define Q_WIDGETS_EXPORT
#  define Q_NETWORK_EXPORT
#endif
+/
mixin template Q_INIT_RESOURCE(string name)
{
    enum string mangledName = QT_MANGLE_NAMESPACE("qInitResources_" ~ name);
    mixin ("extern int " ~ mangledName ~ "();");
    mixin (mangledName ~ "();");
}
mixin template Q_CLEANUP_RESOURCE(string name)
{
    enum string mangledName = QT_MANGLE_NAMESPACE("qCleanupResources_" ~ name);
    mixin ("extern int " ~ mangledName ~ "();");
    mixin (mangledName ~ "();");
}

/*
 * If we're compiling C++ code:
 *  - and this is a non-namespace build, declare qVersion as extern "C"
 *  - and this is a namespace build, declare it as a regular function
 *    (we're already inside QT_BEGIN_NAMESPACE / QT_END_NAMESPACE)
 * If we're compiling C code, simply declare the function. If Qt was compiled
 * in a namespace, qVersion isn't callable anyway.
 */
/+
#if !defined(QT_NAMESPACE) && defined(__cplusplus) && !defined(Q_QDOC)
extern "C"
#endif
+/
version(QT_NAMESPACE) {
    export const(char)* qVersion() nothrow;
} else version(Q_QDOC) {
    export const(char)* qVersion() nothrow;
} else {
    export extern(C) const(char)* qVersion() nothrow;
}

mixin template Q_CONSTRUCTOR_FUNCTION(string AFUNC)
{
//    namespace {
    extern(C++) {
    mixin("struct " ~ AFUNC ~ "_ctor_class_ {\n" ~
          "    /+inline+/ this() { " ~ AFUNC ~ "(); }\n" ~
          "}\n" ~
          "static const " ~ AFUNC ~ "_ctor_instance_;\n");
    }
//    }
}
mixin template Q_DESTRUCTOR_FUNCTION(string AFUNC)
{
//    namespace {
    extern(C++) {
    mixin("struct " ~ AFUNC ~ "_dtor_class_ {\n" ~
          "    /+inline+/ this() { }\n" ~
          "    /+inline+/ ~this() { " ~ AFUNC ~ "(); }\n" ~
          "}\n" ~
          "static const " ~ AFUNC ~ "_dtor_instance_;\n");
    }
//    }
}

package(qt) {
extern(C++, QtPrivate) {
    struct AlignOfHelper(T)
    {
        char c;
        T type;

        this();
        ~this();
    }

    struct AlignOf_Default(T)
    {
        enum size_t Value = AlignOfHelper!T.sizeof - T.sizeof;
    }

    alias AlignOf(T) = AlignOf_Default!T;
    alias AlignOf(A = T[N], T, size_t N) = AlignOf_Default!T;
/+
    template <class T> struct AlignOf<T &> : AlignOf<T> {}
    template <size_t N, class T> struct AlignOf(size_t N, T)<T[N]> : AlignOf<T> {}

#ifdef Q_COMPILER_RVALUE_REFS
    template <class T> struct AlignOf<T &&> : AlignOf<T> {}
#endif

#if defined(Q_PROCESSOR_X86_32) && !defined(Q_OS_WIN)
    template <class T> struct AlignOf_WorkaroundForI386Abi { enum { Value = sizeof(T) } }

    // x86 ABI weirdness
    // Alignment of naked type is 8, but inside struct has alignment 4.
    template <> struct AlignOf<double>  : AlignOf_WorkaroundForI386Abi<double> {}
    template <> struct AlignOf<qint64>  : AlignOf_WorkaroundForI386Abi<qint64> {}
    template <> struct AlignOf<quint64> : AlignOf_WorkaroundForI386Abi<quint64> {}
#ifdef Q_CC_CLANG
    // GCC and Clang seem to disagree wrt to alignment of arrays
    template <size_t N> struct AlignOf<double[N]>   : AlignOf_Default<double> {}
    template <size_t N> struct AlignOf<qint64[N]>   : AlignOf_Default<qint64> {}
    template <size_t N> struct AlignOf<quint64[N]>  : AlignOf_Default<quint64> {}
#endif
#endif
+/
} // namespace QtPrivate
} // package(qt)

enum size_t QT_EMULATED_ALIGNOF(T) = AlignOf!T.Value;

version(Q_ALIGNOF) {} else {
    enum size_t Q_ALIGNOF(T) = QT_EMULATED_ALIGNOF!T;
}


/*
  quintptr and qptrdiff is guaranteed to be the same size as a pointer, i.e.

      sizeof(void *) == sizeof(quintptr)
      && sizeof(void *) == sizeof(qptrdiff)
*/
struct QIntegerForSize(size_t Size)
{
    static if(Size == 1) { alias Unsigned = quint8;  alias Signed = qint8;  }
    static if(Size == 2) { alias Unsigned = quint16; alias Signed = qint16; }
    static if(Size == 4) { alias Unsigned = quint32; alias Signed = qint32; }
    static if(Size == 8) { alias Unsigned = quint64; alias Signed = qint64; }
}
alias QIntegerForSize(T) = QIntegerForSize!(T.sizeof);

alias qregisterint = QIntegerForSize!Q_PROCESSOR_WORDSIZE.Signed;
alias qregisteruint = QIntegerForSize!Q_PROCESSOR_WORDSIZE.Unsigned;
alias quintptr = QIntegerForSizeof!(void*).Unsigned;
alias qptrdiff = QIntegerForSizeof!(void*).Signed;
alias qintptr = qptrdiff;
/+
/* moc compats (signals/slots) */
#ifndef QT_MOC_COMPAT
#  define QT_MOC_COMPAT
#else
#  undef QT_MOC_COMPAT
#  define QT_MOC_COMPAT
#endif

#ifdef QT_ASCII_CAST_WARNINGS
#  define QT_ASCII_CAST_WARN Q_DECL_DEPRECATED
#else
#  define QT_ASCII_CAST_WARN
#endif

#if defined(__i386__) || defined(_WIN32) || defined(_WIN32_WCE)
#  if defined(Q_CC_GNU)
#    define QT_FASTCALL __attribute__((regparm(3)))
#  elif defined(Q_CC_MSVC)
#    define QT_FASTCALL __fastcall
#  else
#     define QT_FASTCALL
#  endif
#else
#  define QT_FASTCALL
#endif

// enable gcc warnings for printf-style functions
#if defined(Q_CC_GNU) && !defined(__INSURE__)
#  if defined(Q_CC_MINGW) && !defined(Q_CC_CLANG)
#    define Q_ATTRIBUTE_FORMAT_PRINTF(A, B) \
         __attribute__((format(gnu_printf, (A), (B))))
#  else
#    define Q_ATTRIBUTE_FORMAT_PRINTF(A, B) \
         __attribute__((format(printf, (A), (B))))
#  endif
#else
#  define Q_ATTRIBUTE_FORMAT_PRINTF(A, B)
#endif

//defines the type for the WNDPROC on windows
//the alignment needs to be forced for sse2 to not crash with mingw
#if defined(Q_OS_WIN)
#  if defined(Q_CC_MINGW) && !defined(Q_OS_WIN64)
#    define QT_ENSURE_STACK_ALIGNED_FOR_SSE __attribute__ ((force_align_arg_pointer))
#  else
#    define QT_ENSURE_STACK_ALIGNED_FOR_SSE
#  endif
#  define QT_WIN_CALLBACK CALLBACK QT_ENSURE_STACK_ALIGNED_FOR_SSE
#endif
+/
alias QNoImplicitBoolCast = int;

/*
   Utility macros and /+inline+/ functions
*/

/+inline+/ T qAbs(T)(ref const T t) { return t >= 0 ? t : -t; }

/+inline+/ int qRound(double d) { return d >= 0.0 ? int(d + 0.5) : int(d - double(int(d-1)) + 0.5) + int(d-1); }
/+inline+/ int qRound(float d) { return d >= 0.0f ? int(d + 0.5f) : int(d - float(int(d-1)) + 0.5f) + int(d-1); }

/+inline+/ qint64 qRound64(double d) { return d >= 0.0 ? qint64(d + 0.5) : qint64(d - double(qint64(d-1)) + 0.5) + qint64(d-1); }
/+inline+/ qint64 qRound64(float d) { return d >= 0.0f ? qint64(d + 0.5f) : qint64(d - float(qint64(d-1)) + 0.5f) + qint64(d-1); }

/+inline+/ ref const T qMin(T)(ref const T a, ref const T b) { return (a < b) ? a : b; }
/+inline+/ ref const T qMax(T)(ref const T a, ref const T b) { return (a < b) ? b : a; }
/+inline+/ ref const T qBound(T)(ref const T min, ref const T val, ref const T max) { return qMax(min, qMin(max, val)); }
/+
#ifdef Q_OS_DARWIN
#  define QT_MAC_PLATFORM_SDK_EQUAL_OR_ABOVE(osx, ios) \
    ((defined(__MAC_OS_X_VERSION_MAX_ALLOWED) && osx != __MAC_NA && __MAC_OS_X_VERSION_MAX_ALLOWED >= osx) || \
     (defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && ios != __IPHONE_NA && __IPHONE_OS_VERSION_MAX_ALLOWED >= ios))

#  define QT_MAC_DEPLOYMENT_TARGET_BELOW(osx, ios) \
    ((defined(__MAC_OS_X_VERSION_MIN_REQUIRED) && osx != __MAC_NA && __MAC_OS_X_VERSION_MIN_REQUIRED < osx) || \
     (defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && ios != __IPHONE_NA && __IPHONE_OS_VERSION_MIN_REQUIRED < ios))

#  define QT_IOS_PLATFORM_SDK_EQUAL_OR_ABOVE(ios) \
      QT_MAC_PLATFORM_SDK_EQUAL_OR_ABOVE(__MAC_NA, ios)
#  define QT_OSX_PLATFORM_SDK_EQUAL_OR_ABOVE(osx) \
      QT_MAC_PLATFORM_SDK_EQUAL_OR_ABOVE(osx, __IPHONE_NA)

#  define QT_IOS_DEPLOYMENT_TARGET_BELOW(ios) \
      QT_MAC_DEPLOYMENT_TARGET_BELOW(__MAC_NA, ios)
#  define QT_OSX_DEPLOYMENT_TARGET_BELOW(osx) \
      QT_MAC_DEPLOYMENT_TARGET_BELOW(osx, __IPHONE_NA)
#endif
+/
/*
   Data stream functions are provided by many classes (defined in qdatastream.h)
*/

extern(C++) class QDataStream;

version (Q_OS_VXWORKS) {
    version = QT_NO_CRASHHANDLER;     // no popen
    version = QT_NO_PROCESS;          // no exec*, no fork
    version = QT_NO_SHAREDMEMORY;     // only POSIX, no SysV and in the end...
    version = QT_NO_SYSTEMSEMAPHORE;  // not needed at all in a flat address space
}

version(Q_OS_WINRT) {
    version = QT_NO_FILESYSTEMWATCHER;
    version = QT_NO_GETADDRINFO;
    version = QT_NO_NETWORKPROXY;
    version = QT_NO_PROCESS;
    version = QT_NO_SOCKETNOTIFIER;
    version = QT_NO_SOCKS5;
}

/+inline+/ void qt_noop() {}

/* These wrap try/catch so we can switch off exceptions later.

   Beware - do not use more than one QT_CATCH per QT_TRY, and do not use
   the exception instance in the catch block.
   If you can't live with those constraints, don't use these macros.
   Use the QT_NO_EXCEPTIONS macro to protect your code instead.
*/
/+
version(QT_NO_EXCEPTIONS) {} else {
#  if defined(QT_BOOTSTRAPPED) || (defined(Q_CC_GNU) && !defined (__EXCEPTIONS) && !defined(Q_MOC_RUN))
#    define QT_NO_EXCEPTIONS
#  endif
}

#ifdef QT_NO_EXCEPTIONS
#  define QT_TRY if (true)
#  define QT_CATCH(A) else
#  define QT_THROW(A) qt_noop()
#  define QT_RETHROW qt_noop()
#  define QT_TERMINATE_ON_EXCEPTION(expr) do { expr; } while (0)
#else
#  define QT_TRY try
#  define QT_CATCH(A) catch (A)
#  define QT_THROW(A) throw A
#  define QT_RETHROW throw
Q_NORETURN export void qTerminate() nothrow;
#  ifdef Q_COMPILER_NOEXCEPT
#    define QT_TERMINATE_ON_EXCEPTION(expr) do { expr; } while (0)
#  else
#    define QT_TERMINATE_ON_EXCEPTION(expr) do { try { expr; } catch (...) { qTerminate(); } } while (0)
#  endif
#endif
+/
export extern(C++) bool qSharedBuild() nothrow;
/+
#ifndef Q_OUTOFLINE_TEMPLATE
#  define Q_OUTOFLINE_TEMPLATE
#endif
#ifndef Q_INLINE_TEMPLATE
#  define Q_INLINE_TEMPLATE inline
#endif
+/
/*
   Avoid "unused parameter" warnings
*/
/+
#if defined(Q_CC_RVCT)
/+inline+/ void qUnused(T)(ref T x) { (void)x; }
#  define Q_UNUSED(x) qUnused(x);
#else
#  define Q_UNUSED(x) (void)x;
#endif
+/
/*
   Debugging and error handling
*/

version(QT_NO_DEBUG) {} else {
//#if !defined(QT_NO_DEBUG) && !defined(QT_DEBUG)
 version = QT_DEBUG;
}
/+
#ifndef qPrintable
#  define qPrintable(string) QString(string).toLocal8Bit().constData()
#endif

#ifndef qUtf8Printable
#  define qUtf8Printable(string) QString(string).toUtf8().constData()
#endif
+/
extern(C++) class QString;
export extern(C++) QString qt_error_string(int errorCode = -1);

export extern(C++) void qt_assert(const(char)* assertion, const(char)* file, int line) nothrow;
/+
#if !defined(Q_ASSERT)
#  if defined(QT_NO_DEBUG) && !defined(QT_FORCE_ASSERTS)
#    define Q_ASSERT(cond) qt_noop()
#  else
#    define Q_ASSERT(cond) ((!(cond)) ? qt_assert(#cond,__FILE__,__LINE__) : qt_noop())
#  endif
#endif
+/
version(QT_NO_DEBUG) {
    version(QT_PAINT_DEBUG) {} else {
        version = QT_NO_PAINT_DEBUG;
    }
}

export extern(C++) void qt_assert_x(const(char)* where, const(char)* what, const(char)* file, int line) nothrow;
/+
#if !defined(Q_ASSERT_X)
#  if defined(QT_NO_DEBUG) && !defined(QT_FORCE_ASSERTS)
#    define Q_ASSERT_X(cond, where, what) qt_noop()
#  else
#    define Q_ASSERT_X(cond, where, what) ((!(cond)) ? qt_assert_x(where, what,__FILE__,__LINE__) : qt_noop())
#  endif
#endif
+/

export extern(C++) void qt_check_pointer(const(char)* , int);
export extern(C++) void qBadAlloc();

version (QT_NO_EXCEPTIONS) {
    version(QT_NO_DEBUG)
        void Q_CHECK_PTR(auto p) {}
    else
        void Q_CHECK_PTR(string file = __FILE__, size_t line = __LINE__)(p) { if(!(p)) qt_check_pointer(file, line); }
} else {
    void Q_CHECK_PTR(p) { if (!(p)) qBadAlloc(); }
}

/+inline+/ T *q_check_ptr(T)(T *p) { Q_CHECK_PTR(p); return p; }

alias QFunctionPointer = void function();

void Q_UNIMPLEMENTED(string file = __FILE__, size_t line = __LINE__)() { qWarning("%s:%d: %s: Unimplemented code.", file, line, Q_FUNC_INFO); }

static /+inline+/ bool qFuzzyCompare(double p1, double p2)
{
    return (qAbs(p1 - p2) * 1000000000000. <= qMin(qAbs(p1), qAbs(p2)));
}

static /+inline+/ bool qFuzzyCompare(float p1, float p2)
{
    return (qAbs(p1 - p2) * 100000.f <= qMin(qAbs(p1), qAbs(p2)));
}

/*!
  \internal
*/
static /+inline+/ bool qFuzzyIsNull(double d)
{
    return qAbs(d) <= 0.000000000001;
}

/*!
  \internal
*/
static /+inline+/ bool qFuzzyIsNull(float f)
{
    return qAbs(f) <= 0.00001f;
}

/*
   This function tests a double for a null value. It doesn't
   check whether the actual value is 0 or close to 0, but whether
   it is binary 0, disregarding sign.
*/
static /+inline+/ bool qIsNull(double d)
{
    union U {
        double d;
        quint64 u;
    }
    U val;
    val.d = d;
    return (val.u & Q_UINT64_C(0x7fffffffffffffff)) == 0;
}

/*
   This function tests a float for a null value. It doesn't
   check whether the actual value is 0 or close to 0, but whether
   it is binary 0, disregarding sign.
*/
static /+inline+/ bool qIsNull(float f)
{
    union U {
        float f;
        quint32 u;
    }
    U val;
    val.f = f;
    return (val.u & 0x7fffffff) == 0;
}

/*
   Compilers which follow outdated template instantiation rules
   require a extern(C++) class to have a comparison operator to exist when
   a QList of this type is instantiated. It's not actually
   used in the list, though. Hence the dummy implementation.
   Just in case other code relies on it we better trigger a warning
   mandating a real implementation.
*/

version(Q_FULL_TEMPLATE_INSTANTIATION) {
    mixin template Q_DUMMY_COMPARISON_OPERATOR(string C)
    {
        mixin("bool opEquals(ref const "~C~") const {\n" ~
              "    qWarning(\""~C~".opEquals(ref const "~C~") was called\");\n" ~
              "    return false;\n"
              "}");
    }
} else {
    mixin template Q_DUMMY_COMPARISON_OPERATOR(string C) {}
}

/+inline+/ void qSwap(T)(ref T value1, ref T value2)
{
    import std.algorithm: swap;
    swap(value1, value2);
}

static if(QT_DEPRECATED_SINCE(5, 0))
{
    deprecated {
//        export void *qMalloc(size_t size) Q_ALLOC_SIZE(1);
        export void *qMalloc(size_t size) ;
        export void qFree(void *ptr);
//        export void *qRealloc(void *ptr, size_t size) Q_ALLOC_SIZE(2);
        export void *qRealloc(void *ptr, size_t size);
        export void *qMemCopy(void *dest, const(void)* src, size_t n);
        export void *qMemSet(void *dest, int c, size_t n);
    }
}
//export void *qMallocAligned(size_t size, size_t alignment) Q_ALLOC_SIZE(1);
export void *qMallocAligned(size_t size, size_t alignment);
//export void *qReallocAligned(void *ptr, size_t size, size_t oldsize, size_t alignment) Q_ALLOC_SIZE(2);
export void *qReallocAligned(void *ptr, size_t size, size_t oldsize, size_t alignment);
export void qFreeAligned(void *ptr);


/*
   Avoid some particularly useless warnings from some stupid compilers.
   To get ALL C++ compiler warnings, define QT_CC_WARNINGS or comment out
   the line "#define QT_NO_WARNINGS".
*/
/+
#if !defined(QT_CC_WARNINGS)
#  define QT_NO_WARNINGS
#endif
#if defined(QT_NO_WARNINGS)
#  if defined(Q_CC_MSVC)
#    pragma warning(disable: 4251) /* extern(C++) class 'type' needs to have dll-interface to be used by clients of extern(C++) class 'type2' */
#    pragma warning(disable: 4244) /* conversion from 'type1' to 'type2', possible loss of data */
#    pragma warning(disable: 4275) /* non - DLL-interface classkey 'identifier' used as base for DLL-interface classkey 'identifier' */
#    pragma warning(disable: 4514) /* unreferenced /+inline+/ function has been removed */
#    pragma warning(disable: 4800) /* 'type' : forcing value to bool 'true' or 'false' (performance warning) */
#    pragma warning(disable: 4097) /* typedef-name 'identifier1' used as synonym for class-name 'identifier2' */
#    pragma warning(disable: 4706) /* assignment within conditional expression */
#    if _MSC_VER <= 1310 // MSVC 2003
#      pragma warning(disable: 4786) /* 'identifier' : identifier was truncated to 'number' characters in the debug information */
#    endif
#    pragma warning(disable: 4355) /* 'this' : used in base member initializer list */
#    if _MSC_VER < 1800 // MSVC 2013
#      pragma warning(disable: 4231) /* nonstandard extension used : 'identifier' before template explicit instantiation */
#    endif
#    pragma warning(disable: 4710) /* function not inlined */
#    pragma warning(disable: 4530) /* C++ exception handler used, but unwind semantics are not enabled. Specify /EHsc */
#  elif defined(Q_CC_BOR)
#    pragma option -w-inl
#    pragma option -w-aus
#    pragma warn -inl
#    pragma warn -pia
#    pragma warn -ccc
#    pragma warn -rch
#    pragma warn -sig
#  endif
#endif
+/
/+
#if defined(Q_COMPILER_DECLTYPE) || (defined(Q_CC_GNU) && !defined(Q_CC_RVCT))
/* make use of decltype or GCC's __typeof__ extension */
extern(C++) class QForeachContainer(T) {
    ref QForeachContainer operator=(ref const(QForeachContainer) ) Q_DECL_EQ_DELETE;
public:
    /+inline+/ QForeachContainer(ref const(T) t) : c(t), i(c.begin()), e(c.end()), control(1) { }
    const T c;
    typename T::const_iterator i, e;
    int control;
}

// We need to use __typeof__ if we don't have decltype or if the compiler
// hasn't been updated to the fix of Core Language Defect Report 382
// (http://www.open-std.org/jtc1/sc22/wg21/docs/cwg_defects.html#382).
// GCC 4.3 and 4.4 have support for decltype, but are affected by DR 382.
#  if defined(Q_COMPILER_DECLTYPE) && \
    (defined(Q_CC_CLANG) || defined(Q_CC_INTEL) || !defined(Q_CC_GNU) || Q_CC_GNU >= 405)
#    define QT_FOREACH_DECLTYPE(x) typename QtPrivate::remove_reference<decltype(x)>::type
#  else
#    define QT_FOREACH_DECLTYPE(x) __typeof__((x))
#  endif

// Explanation of the control word:
//  - it's initialized to 1
//  - that means both the inner and outer loops start
//  - if there were no breaks, at the end of the inner loop, it's set to 0, which
//    causes it to exit (the inner loop is run exactly once)
//  - at the end of the outer loop, it's inverted, so it becomes 1 again, allowing
//    the outer loop to continue executing
//  - if there was a break inside the inner loop, it will exit with control still
//    set to 1; in that case, the outer loop will invert it to 0 and will exit too
#  define Q_FOREACH(variable, container)                                \
for (QForeachContainer<QT_FOREACH_DECLTYPE(container)> _container_((container)); \
     _container_.control && _container_.i != _container_.e;         \
     ++_container_.i, _container_.control ^= 1)                     \
    for (variable = *_container_.i; _container_.control; _container_.control = 0)

#else

struct QForeachContainerBase {}

template <typename T>
extern(C++) class QForeachContainer : QForeachContainerBase {
    QForeachContainer &operator=(ref const(QForeachContainer) ) Q_DECL_EQ_DELETE;
public:
    /+inline+/ QForeachContainer(ref const(T) t): c(t), brk(0), i(c.begin()), e(c.end()){}
    QForeachContainer(ref const(QForeachContainer) other)
        : c(other.c), brk(other.brk), i(other.i), e(other.e) {}
    const T c;
    mutable int brk;
    mutable typename T::const_iterator i, e;
    /+inline+/ bool condition() const { return (!brk++ && i != e); }
}

/+inline+/ T *qForeachPointer(T)(ref const(T) ) { return 0; }

/+inline+/ QForeachContainer<T> qForeachContainerNew(T)(ref const(T) t)
{ return QForeachContainer<T>(t); }

/+inline+/ const QForeachContainer<T> *qForeachContainer(T)(const(QForeachContainerBase)* base, const(T)* )
{ return static_cast<const QForeachContainer<T> *>(base); }

#if defined(Q_CC_DIAB)
// VxWorks DIAB generates unresolvable symbols, if container is a function call
#  define Q_FOREACH(variable,container)                                                             \
    if(0){}else                                                                                     \
    for (ref const(QForeachContainerBase) _container_ = qForeachContainerNew(container);                \
         qForeachContainer(&_container_, (__typeof__(container) *) 0)->condition();       \
         ++qForeachContainer(&_container_, (__typeof__(container) *) 0)->i)               \
        for (variable = *qForeachContainer(&_container_, (__typeof__(container) *) 0)->i; \
             qForeachContainer(&_container_, (__typeof__(container) *) 0)->brk;           \
             --qForeachContainer(&_container_, (__typeof__(container) *) 0)->brk)

#else
#  define Q_FOREACH(variable, container) \
    for (ref const(QForeachContainerBase) _container_ = qForeachContainerNew(container); \
         qForeachContainer(&_container_, true ? 0 : qForeachPointer(container))->condition();       \
         ++qForeachContainer(&_container_, true ? 0 : qForeachPointer(container))->i)               \
        for (variable = *qForeachContainer(&_container_, true ? 0 : qForeachPointer(container))->i; \
             qForeachContainer(&_container_, true ? 0 : qForeachPointer(container))->brk;           \
             --qForeachContainer(&_container_, true ? 0 : qForeachPointer(container))->brk)
#endif // MSVC6 || MIPSpro

#endif
+/

static /+inline+/ T* qGetPtrHelper(T)(T* ptr) { return ptr; }
static /+inline+/ Wrapper.pointer qGetPtrHelper(Wrapper)(ref const Wrapper p) { return p.data(); }

mixin template Q_DECLARE_PRIVATE(string Class)
{
    mixin("/+inline+/ "~Class~"Private* d_func() { return cast("~Class~"Private*)qGetPtrHelper(d_ptr); }\n" ~
          "/+inline+/ const "~Class~"Private* d_func() const { return cast(const "~Class~"Private*)qGetPtrHelper(d_ptr); }\n");
}
mixin template Q_DECLARE_PRIVATE_D(string Class)
{
    mixin("/+inline+/ "~Class~"Private* d_func() { return cast("~Class~"Private*)Dptr; }\n" ~
          "/+inline+/ const "~Class~"Private* d_func() const { return cast(const "~Class~"Private*)Dptr; }\n");
}
mixin template Q_DECLARE_PUBLIC(string Class)
{
    mixin("/+inline+/ "~Class~"* q_func() { return cast("~Class~"*)q_ptr; }\n" ~
          "/+inline+/ const "~Class~"* q_func() const { return cast(const "~Class~"*)q_ptr; }\n");
}

mixin template Q_D(string Class) { mixin(Class~"Private* const d = d_func();"); }
mixin template Q_Q(string Class) { mixin(Class~"* const q = q_func();"); }
/+
#define QT_TR_NOOP(x) x
#define QT_TR_NOOP_UTF8(x) x
#define QT_TRANSLATE_NOOP(scope, x) x
#define QT_TRANSLATE_NOOP_UTF8(scope, x) x
#define QT_TRANSLATE_NOOP3(scope, x, comment) {x, comment}
#define QT_TRANSLATE_NOOP3_UTF8(scope, x, comment) {x, comment}
+/
version(QT_NO_TRANSLATION) {} else { // ### This should enclose the NOOPs above
// Defined in qcoreapplication.cpp
// The better name qTrId() is reserved for an upcoming function which would
// return a much more powerful QStringFormatter instead of a QString.
export extern(C++) QString qtTrId(const(char)* id, int n = -1);

/+
#define QT_TRID_NOOP(id) id
+/
}

//#define QDOC_PROPERTY(text)

/*
   When RTTI is not available, define this macro to force any uses of
   dynamic_cast to cause a compile failure.
*/
/+
#if defined(QT_NO_DYNAMIC_CAST) && !defined(dynamic_cast)
#  define dynamic_cast QT_PREPEND_NAMESPACE(qt_dynamic_cast_check)

  T qt_dynamic_cast_check(T, X)(X, T* = 0)
  { return T::dynamic_cast_will_always_fail_because_rtti_is_disabled; }
#endif
+/
/*
   Some classes do not permit copies to be made of an object. These
   classes contains a private copy constructor and assignment
   operator to disable copying (the compiler gives an error message).
*/

mixin template Q_DISABLE_COPY(Class)
{
    @disable this(this);
    @disable typeof(this) opAssign(ref const typeof(this));
//    Class &operator=(ref const(Class) ) Q_DECL_EQ_DELETE;
}

extern(C++) class QByteArray;
export extern(C++) QByteArray qgetenv(const(char)* varName);
export extern(C++) bool qputenv(const(char)* varName, ref const QByteArray value);
export extern(C++) bool qunsetenv(const(char)* varName);

export extern(C++) bool qEnvironmentVariableIsEmpty(const(char)* varName) nothrow;
export extern(C++) bool qEnvironmentVariableIsSet(const(char)* varName) nothrow;

/+inline+/ int qIntCast(double f) { return cast(int)f; }
/+inline+/ int qIntCast(float f) { return cast(int)f; }

/*
  Reentrant versions of basic rand() functions for random number generation
*/
export extern(C++) void qsrand(uint seed);
export extern(C++) int qrand();

//#define QT_MODULE(x)

version(Q_OS_QNX)
{
// QNX doesn't have SYSV style shared memory. Multiprocess QWS apps,
// shared fonts and QSystemSemaphore + QSharedMemory are not available
  version = QT_NO_SYSTEMSEMAPHORE;
  version = QT_NO_SHAREDMEMORY;
}
/+
#if !defined(QT_BOOTSTRAPPED) && defined(QT_REDUCE_RELOCATIONS) && defined(__ELF__) && \
    (!defined(__PIC__) || (defined(__PIE__) && defined(Q_CC_GNU) && Q_CC_GNU >= 500))
#  error "You must build your code with position independent code if Qt was built with -reduce-relocations. "\
         "Compile your code with -fPIC (-fPIE is not enough)."
#endif
+/
package(qt) {
//like std::enable_if
/+
template <bool B, typename T = void> struct QEnableIf;
template <typename T> struct QEnableIf<true, T> { alias Type = T; }

template <bool B, typename T, typename F> struct QConditional { alias Type = T; }
template <typename T, typename F> struct QConditional<false, T, F> { alias Type = F; }
+/
}
/+
#ifndef Q_FORWARD_DECLARE_OBJC_CLASS
#  ifdef __OBJC__
#    define Q_FORWARD_DECLARE_OBJC_CLASS(classname) @class classname
#  else
#    define Q_FORWARD_DECLARE_OBJC_CLASS(classname) typedef struct objc_object classname
#  endif
#endif
#ifndef Q_FORWARD_DECLARE_CF_TYPE
#  define Q_FORWARD_DECLARE_CF_TYPE(type) typedef const struct __ ## type * type ## Ref
#endif
#ifndef Q_FORWARD_DECLARE_MUTABLE_CF_TYPE
#  define Q_FORWARD_DECLARE_MUTABLE_CF_TYPE(type) typedef struct __ ## type * type ## Ref
#endif
+/
// We need to keep QTypeInfo, QSysInfo, QFlags, qDebug & family in qglobal.h for compatibility with Qt 4.
// Be careful when changing the order of these files.
public import qt.QtCore.qtypeinfo;
public import qt.QtCore.qsysinfo;
public import qt.QtCore.qlogging;

public import qt.QtCore.qflags;

public import qt.QtCore.qatomic;
public import qt.QtCore.qglobalstatic;
public import qt.QtCore.qnumeric;
