/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Copyright (C) 2012 Intel Corporation.
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

public import QtCore.qbytearray;
public import QtCore.qobjectdefs;
public import QtCore.qstring;
public import QtCore.qlist;
public import QtCore.qpair;
public import QtCore.qglobal;

#ifdef Q_OS_MAC
Q_FORWARD_DECLARE_CF_TYPE(CFURL);
#  ifdef __OBJC__
Q_FORWARD_DECLARE_OBJC_CLASS(NSURL);
#  endif
#endif


extern(C++) class QUrlQuery;
extern(C++) class QUrlPrivate;
extern(C++) class QDataStream;

template <typename E1, typename E2>
extern(C++) class QUrlTwoFlags
{
    int i;
    typedef int QUrlTwoFlags:: *Zero;
public:
    /+inline+/ QUrlTwoFlags(E1 f) : i(f) {}
    /+inline+/ QUrlTwoFlags(E2 f) : i(f) {}
    /+inline+/ QUrlTwoFlags(QFlag f) : i(f) {}
    /+inline+/ QUrlTwoFlags(QFlags<E1> f) : i(f.operator int()) {}
    /+inline+/ QUrlTwoFlags(QFlags<E2> f) : i(f.operator int()) {}
    /+inline+/ QUrlTwoFlags(Zero = 0) : i(0) {}

    /+inline+/ QUrlTwoFlags &operator&=(int mask) { i &= mask; return *this; }
    /+inline+/ QUrlTwoFlags &operator&=(uint mask) { i &= mask; return *this; }
    /+inline+/ QUrlTwoFlags &operator|=(QUrlTwoFlags f) { i |= f.i; return *this; }
    /+inline+/ QUrlTwoFlags &operator|=(E1 f) { i |= f; return *this; }
    /+inline+/ QUrlTwoFlags &operator|=(E2 f) { i |= f; return *this; }
    /+inline+/ QUrlTwoFlags &operator^=(QUrlTwoFlags f) { i ^= f.i; return *this; }
    /+inline+/ QUrlTwoFlags &operator^=(E1 f) { i ^= f; return *this; }
    /+inline+/ QUrlTwoFlags &operator^=(E2 f) { i ^= f; return *this; }

    /+inline+/ operator QFlags<E1>() const { return QFlag(i); }
    /+inline+/ operator QFlags<E2>() const { return QFlag(i); }
    /+inline+/ operator int() const { return i; }
    /+inline+/ bool operator!() const { return !i; }

    /+inline+/ QUrlTwoFlags operator|(QUrlTwoFlags f) const
    { return QUrlTwoFlags(QFlag(i | f.i)); }
    /+inline+/ QUrlTwoFlags operator|(E1 f) const
    { return QUrlTwoFlags(QFlag(i | f)); }
    /+inline+/ QUrlTwoFlags operator|(E2 f) const
    { return QUrlTwoFlags(QFlag(i | f)); }
    /+inline+/ QUrlTwoFlags operator^(QUrlTwoFlags f) const
    { return QUrlTwoFlags(QFlag(i ^ f.i)); }
    /+inline+/ QUrlTwoFlags operator^(E1 f) const
    { return QUrlTwoFlags(QFlag(i ^ f)); }
    /+inline+/ QUrlTwoFlags operator^(E2 f) const
    { return QUrlTwoFlags(QFlag(i ^ f)); }
    /+inline+/ QUrlTwoFlags operator&(int mask) const
    { return QUrlTwoFlags(QFlag(i & mask)); }
    /+inline+/ QUrlTwoFlags operator&(uint mask) const
    { return QUrlTwoFlags(QFlag(i & mask)); }
    /+inline+/ QUrlTwoFlags operator&(E1 f) const
    { return QUrlTwoFlags(QFlag(i & f)); }
    /+inline+/ QUrlTwoFlags operator&(E2 f) const
    { return QUrlTwoFlags(QFlag(i & f)); }
    /+inline+/ QUrlTwoFlags operator~() const
    { return QUrlTwoFlags(QFlag(~i)); }

    /+inline+/ bool testFlag(E1 f) const { return (i & f) == f && (f != 0 || i == int(f)); }
    /+inline+/ bool testFlag(E2 f) const { return (i & f) == f && (f != 0 || i == int(f)); }
}

template<typename E1, typename E2>
extern(C++) class QTypeInfo<QUrlTwoFlags<E1, E2> > : QTypeInfoMerger<QUrlTwoFlags<E1, E2>, E1, E2> {}

extern(C++) class QUrl;
// qHash is a friend, but we can't use default arguments for friends (§8.3.6.4)
export uint qHash(ref const(QUrl) url, uint seed = 0) nothrow;

extern(C++) class export QUrl
{
public:
    enum ParsingMode {
        TolerantMode,
        StrictMode,
        DecodedMode
    }

    // encoding / toString values
    enum UrlFormattingOption {
        None = 0x0,
        RemoveScheme = 0x1,
        RemovePassword = 0x2,
        RemoveUserInfo = RemovePassword | 0x4,
        RemovePort = 0x8,
        RemoveAuthority = RemoveUserInfo | RemovePort | 0x10,
        RemovePath = 0x20,
        RemoveQuery = 0x40,
        RemoveFragment = 0x80,
        // 0x100 was a private code in Qt 4, keep unused for a while
        PreferLocalFile = 0x200,
        StripTrailingSlash = 0x400,
        RemoveFilename = 0x800,
        NormalizePathSegments = 0x1000
    }

    enum ComponentFormattingOption {
        PrettyDecoded = 0x000000,
        EncodeSpaces = 0x100000,
        EncodeUnicode = 0x200000,
        EncodeDelimiters = 0x400000 | 0x800000,
        EncodeReserved = 0x1000000,
        DecodeReserved = 0x2000000,
        // 0x4000000 used to indicate full-decode mode

        FullyEncoded = EncodeSpaces | EncodeUnicode | EncodeDelimiters | EncodeReserved,
        FullyDecoded = FullyEncoded | DecodeReserved | 0x4000000
    }
    Q_DECLARE_FLAGS(ComponentFormattingOptions, ComponentFormattingOption)
#ifdef Q_QDOC
    Q_DECLARE_FLAGS(FormattingOptions, UrlFormattingOption)
#else
    typedef QUrlTwoFlags<UrlFormattingOption, ComponentFormattingOption> FormattingOptions;
#endif

    QUrl();
    QUrl(ref const(QUrl) copy);
    QUrl &operator =(ref const(QUrl) copy);
#ifdef QT_NO_URL_CAST_FROM_STRING
    explicit QUrl(ref const(QString) url, ParsingMode mode = TolerantMode);
#else
    QUrl(ref const(QString) url, ParsingMode mode = TolerantMode);
    QUrl &operator=(ref const(QString) url);
#endif
#ifdef Q_COMPILER_RVALUE_REFS
    QUrl(QUrl &&other) : d(0)
    { qSwap(d, other.d); }
    /+inline+/ QUrl &operator=(QUrl &&other)
    { qSwap(d, other.d); return *this; }
#endif
    ~QUrl();

    /+inline+/ void swap(QUrl &other) { qSwap(d, other.d); }

    void setUrl(ref const(QString) url, ParsingMode mode = TolerantMode);
    QString url(FormattingOptions options = FormattingOptions(PrettyDecoded)) const;
    QString toString(FormattingOptions options = FormattingOptions(PrettyDecoded)) const;
    QString toDisplayString(FormattingOptions options = FormattingOptions(PrettyDecoded)) const;
    QUrl adjusted(FormattingOptions options) const;

    QByteArray toEncoded(FormattingOptions options = FullyEncoded) const;
    static QUrl fromEncoded(ref const(QByteArray) url, ParsingMode mode = TolerantMode);

    enum UserInputResolutionOption {
        DefaultResolution,
        AssumeLocalFile
    }
    Q_DECLARE_FLAGS(UserInputResolutionOptions, UserInputResolutionOption)

    static QUrl fromUserInput(ref const(QString) userInput);
    // ### Qt6 merge with fromUserInput(QString), by adding = QString()
    static QUrl fromUserInput(ref const(QString) userInput, ref const(QString) workingDirectory,
                              UserInputResolutionOptions options = DefaultResolution);

    bool isValid() const;
    QString errorString() const;

    bool isEmpty() const;
    void clear();

    void setScheme(ref const(QString) scheme);
    QString scheme() const;

    void setAuthority(ref const(QString) authority, ParsingMode mode = TolerantMode);
    QString authority(ComponentFormattingOptions options = PrettyDecoded) const;

    void setUserInfo(ref const(QString) userInfo, ParsingMode mode = TolerantMode);
    QString userInfo(ComponentFormattingOptions options = PrettyDecoded) const;

    void setUserName(ref const(QString) userName, ParsingMode mode = DecodedMode);
    QString userName(ComponentFormattingOptions options = FullyDecoded) const;

    void setPassword(ref const(QString) password, ParsingMode mode = DecodedMode);
    QString password(ComponentFormattingOptions = FullyDecoded) const;

    void setHost(ref const(QString) host, ParsingMode mode = DecodedMode);
    QString host(ComponentFormattingOptions = FullyDecoded) const;
    QString topLevelDomain(ComponentFormattingOptions options = FullyDecoded) const;

    void setPort(int port);
    int port(int defaultPort = -1) const;

    void setPath(ref const(QString) path, ParsingMode mode = DecodedMode);
    QString path(ComponentFormattingOptions options = FullyDecoded) const;
    QString fileName(ComponentFormattingOptions options = FullyDecoded) const;

    bool hasQuery() const;
    void setQuery(ref const(QString) query, ParsingMode mode = TolerantMode);
    void setQuery(ref const(QUrlQuery) query);
    QString query(ComponentFormattingOptions = PrettyDecoded) const;

    bool hasFragment() const;
    QString fragment(ComponentFormattingOptions options = PrettyDecoded) const;
    void setFragment(ref const(QString) fragment, ParsingMode mode = TolerantMode);

    QUrl resolved(ref const(QUrl) relative) const;

    bool isRelative() const;
    bool isParentOf(ref const(QUrl) url) const;

    bool isLocalFile() const;
    static QUrl fromLocalFile(ref const(QString) localfile);
    QString toLocalFile() const;

    void detach();
    bool isDetached() const;

    bool operator <(ref const(QUrl) url) const;
    bool operator ==(ref const(QUrl) url) const;
    bool operator !=(ref const(QUrl) url) const;

    bool matches(ref const(QUrl) url, FormattingOptions options) const;

    static QString fromPercentEncoding(ref const(QByteArray) );
    static QByteArray toPercentEncoding(ref const(QString) ,
                                        ref const(QByteArray) exclude = QByteArray(),
                                        ref const(QByteArray) include = QByteArray());
#if defined(Q_OS_MAC) || defined(Q_QDOC)
    static QUrl fromCFURL(CFURLRef url);
    CFURLRef toCFURL() const Q_DECL_CF_RETURNS_RETAINED;
#  if defined(__OBJC__) || defined(Q_QDOC)
    static QUrl fromNSURL(const(NSURL)* url);
    NSURL *toNSURL() const Q_DECL_NS_RETURNS_AUTORELEASED;
#  endif
#endif

#if QT_DEPRECATED_SINCE(5,0)
    QT_DEPRECATED static QString fromPunycode(ref const(QByteArray) punycode)
    { return fromAce(punycode); }
    QT_DEPRECATED static QByteArray toPunycode(ref const(QString) string)
    { return toAce(string); }

    QT_DEPRECATED /+inline+/ void setQueryItems(const QList<QPair<QString, QString> > &qry);
    QT_DEPRECATED /+inline+/ void addQueryItem(ref const(QString) key, ref const(QString) value);
    QT_DEPRECATED /+inline+/ QList<QPair<QString, QString> > queryItems() const;
    QT_DEPRECATED /+inline+/ bool hasQueryItem(ref const(QString) key) const;
    QT_DEPRECATED /+inline+/ QString queryItemValue(ref const(QString) key) const;
    QT_DEPRECATED /+inline+/ QStringList allQueryItemValues(ref const(QString) key) const;
    QT_DEPRECATED /+inline+/ void removeQueryItem(ref const(QString) key);
    QT_DEPRECATED /+inline+/ void removeAllQueryItems(ref const(QString) key);

    QT_DEPRECATED /+inline+/ void setEncodedQueryItems(const QList<QPair<QByteArray, QByteArray> > &query);
    QT_DEPRECATED /+inline+/ void addEncodedQueryItem(ref const(QByteArray) key, ref const(QByteArray) value);
    QT_DEPRECATED /+inline+/ QList<QPair<QByteArray, QByteArray> > encodedQueryItems() const;
    QT_DEPRECATED /+inline+/ bool hasEncodedQueryItem(ref const(QByteArray) key) const;
    QT_DEPRECATED /+inline+/ QByteArray encodedQueryItemValue(ref const(QByteArray) key) const;
    QT_DEPRECATED /+inline+/ QList<QByteArray> allEncodedQueryItemValues(ref const(QByteArray) key) const;
    QT_DEPRECATED /+inline+/ void removeEncodedQueryItem(ref const(QByteArray) key);
    QT_DEPRECATED /+inline+/ void removeAllEncodedQueryItems(ref const(QByteArray) key);

    QT_DEPRECATED void setEncodedUrl(ref const(QByteArray) u, ParsingMode mode = TolerantMode)
    { setUrl(fromEncodedComponent_helper(u), mode); }

    QT_DEPRECATED QByteArray encodedUserName() const
    { return userName(FullyEncoded).toLatin1(); }
    QT_DEPRECATED void setEncodedUserName(ref const(QByteArray) value)
    { setUserName(fromEncodedComponent_helper(value)); }

    QT_DEPRECATED QByteArray encodedPassword() const
    { return password(FullyEncoded).toLatin1(); }
    QT_DEPRECATED void setEncodedPassword(ref const(QByteArray) value)
    { setPassword(fromEncodedComponent_helper(value)); }

    QT_DEPRECATED QByteArray encodedHost() const
    { return host(FullyEncoded).toLatin1(); }
    QT_DEPRECATED void setEncodedHost(ref const(QByteArray) value)
    { setHost(fromEncodedComponent_helper(value)); }

    QT_DEPRECATED QByteArray encodedPath() const
    { return path(FullyEncoded).toLatin1(); }
    QT_DEPRECATED void setEncodedPath(ref const(QByteArray) value)
    { setPath(fromEncodedComponent_helper(value)); }

    QT_DEPRECATED QByteArray encodedQuery() const
    { return toLatin1_helper(query(FullyEncoded)); }
    QT_DEPRECATED void setEncodedQuery(ref const(QByteArray) value)
    { setQuery(fromEncodedComponent_helper(value)); }

    QT_DEPRECATED QByteArray encodedFragment() const
    { return toLatin1_helper(fragment(FullyEncoded)); }
    QT_DEPRECATED void setEncodedFragment(ref const(QByteArray) value)
    { setFragment(fromEncodedComponent_helper(value)); }

private:
    // helper function for the encodedQuery and encodedFragment functions
    static QByteArray toLatin1_helper(ref const(QString) string)
    {
        if (string.isEmpty())
            return string.isNull() ? QByteArray() : QByteArray("");
        return string.toLatin1();
    }
#endif
private:
    static QString fromEncodedComponent_helper(ref const(QByteArray) ba);

public:
    static QString fromAce(ref const(QByteArray) );
    static QByteArray toAce(ref const(QString) );
    static QStringList idnWhitelist();
    static QStringList toStringList(ref const(QList<QUrl>) uris, FormattingOptions options = FormattingOptions(PrettyDecoded));
    static QList<QUrl> fromStringList(ref const(QStringList) uris, ParsingMode mode = TolerantMode);

    static void setIdnWhitelist(ref const(QStringList) );
    friend export uint qHash(ref const(QUrl) url, uint seed) nothrow;

private:
    QUrlPrivate *d;
    friend extern(C++) class QUrlQuery;

public:
    typedef QUrlPrivate * DataPtr;
    /+inline+/ DataPtr &data_ptr() { return d; }
}

Q_DECLARE_SHARED(QUrl)
Q_DECLARE_OPERATORS_FOR_FLAGS(QUrl::ComponentFormattingOptions)
//Q_DECLARE_OPERATORS_FOR_FLAGS(QUrl::FormattingOptions)

/+inline+/ QUrl::FormattingOptions operator|(QUrl::UrlFormattingOption f1, QUrl::UrlFormattingOption f2)
{ return QUrl::FormattingOptions(f1) | f2; }
/+inline+/ QUrl::FormattingOptions operator|(QUrl::UrlFormattingOption f1, QUrl::FormattingOptions f2)
{ return f2 | f1; }
/+inline+/ QIncompatibleFlag operator|(QUrl::UrlFormattingOption f1, int f2)
{ return QIncompatibleFlag(int(f1) | f2); }

// add operators for OR'ing the two types of flags
/+inline+/ QUrl::FormattingOptions &operator|=(QUrl::FormattingOptions &i, QUrl::ComponentFormattingOptions f)
{ i |= QUrl::UrlFormattingOption(int(f)); return i; }
/+inline+/ QUrl::FormattingOptions operator|(QUrl::UrlFormattingOption i, QUrl::ComponentFormattingOption f)
{ return i | QUrl::UrlFormattingOption(int(f)); }
/+inline+/ QUrl::FormattingOptions operator|(QUrl::UrlFormattingOption i, QUrl::ComponentFormattingOptions f)
{ return i | QUrl::UrlFormattingOption(int(f)); }
/+inline+/ QUrl::FormattingOptions operator|(QUrl::ComponentFormattingOption f, QUrl::UrlFormattingOption i)
{ return i | QUrl::UrlFormattingOption(int(f)); }
/+inline+/ QUrl::FormattingOptions operator|(QUrl::ComponentFormattingOptions f, QUrl::UrlFormattingOption i)
{ return i | QUrl::UrlFormattingOption(int(f)); }
/+inline+/ QUrl::FormattingOptions operator|(QUrl::FormattingOptions i, QUrl::ComponentFormattingOptions f)
{ return i | QUrl::UrlFormattingOption(int(f)); }
/+inline+/ QUrl::FormattingOptions operator|(QUrl::ComponentFormattingOption f, QUrl::FormattingOptions i)
{ return i | QUrl::UrlFormattingOption(int(f)); }
/+inline+/ QUrl::FormattingOptions operator|(QUrl::ComponentFormattingOptions f, QUrl::FormattingOptions i)
{ return i | QUrl::UrlFormattingOption(int(f)); }

///+inline+/ QUrl::UrlFormattingOption &operator=(ref const(QUrl::UrlFormattingOption) i, QUrl::ComponentFormattingOptions f)
//{ i = int(f); f; }

#ifndef QT_NO_DATASTREAM
export QDataStream &operator<<(QDataStream &, ref const(QUrl) );
export QDataStream &operator>>(QDataStream &, QUrl &);
#endif

#ifndef QT_NO_DEBUG_STREAM
export QDebug operator<<(QDebug, ref const(QUrl) );
#endif

#if QT_DEPRECATED_SINCE(5,0)
public import qt.QtCore.qurlquery;
#endif

#endif // QURL_H
