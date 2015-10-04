/*
    Copyright (C) 2008 Nokia Corporation and/or its subsidiary(-ies)

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Library General Public
    License as published by the Free Software Foundation; either
    version 2 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Library General Public License for more details.

    You should have received a copy of the GNU Library General Public License
    along with this library; see the file COPYING.LIB.  If not, write to
    the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
    Boston, MA 02110-1301, USA.
*/

#ifndef _WEBSECURITYORIGIN_H_
#define _WEBSECURITYORIGIN_H_

public import qt.QtCore.qurl;
public import qt.QtCore.qshareddata;

public import qt.qwebkitglobal;

namespace WebCore {
    class SecurityOrigin;
    class ChromeClientQt;
}

class QWebSecurityOriginPrivate;
class QWebDatabase;
class QWebFrame;

class QWEBKIT_EXPORT QWebSecurityOrigin {
public:
    enum SubdomainSetting {
        AllowSubdomains,
        DisallowSubdomains
    };
    
    static QList<QWebSecurityOrigin> allOrigins();
    static void addLocalScheme(ref const(QString) scheme);
    static void removeLocalScheme(ref const(QString) scheme);
    static QStringList localSchemes();

    void addAccessWhitelistEntry(ref const(QString) scheme, ref const(QString) host, SubdomainSetting subdomainSetting);
    void removeAccessWhitelistEntry(ref const(QString) scheme, ref const(QString) host, SubdomainSetting subdomainSetting);

    explicit QWebSecurityOrigin(ref const(QUrl) url);
    ~QWebSecurityOrigin();

    QString scheme() const;
    QString host() const;
    int port() const;

    qint64 databaseUsage() const;
    qint64 databaseQuota() const;

    void setDatabaseQuota(qint64 quota);
    void setApplicationCacheQuota(qint64 quota);

    QList<QWebDatabase> databases() const;

    QWebSecurityOrigin(ref const(QWebSecurityOrigin) other);
    QWebSecurityOrigin &operator=(ref const(QWebSecurityOrigin) other);
private:
    friend class QWebDatabase;
    friend class QWebFrameAdapter;
    friend class WebCore::ChromeClientQt;
    QWebSecurityOrigin(QWebSecurityOriginPrivate* priv);

private:
    QExplicitlySharedDataPointer<QWebSecurityOriginPrivate> d;
};

#endif
