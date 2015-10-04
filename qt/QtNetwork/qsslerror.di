/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtNetwork module of the Qt Toolkit.
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


#ifndef QSSLERROR_H
#define QSSLERROR_H

public import qt.QtCore.qvariant;
public import qt.QtNetwork.qsslcertificate;

QT_BEGIN_NAMESPACE


#ifndef QT_NO_SSL

class QSslErrorPrivate;
class Q_NETWORK_EXPORT QSslError
{
public:
    enum SslError {
        NoError,
        UnableToGetIssuerCertificate,
        UnableToDecryptCertificateSignature,
        UnableToDecodeIssuerPublicKey,
        CertificateSignatureFailed,
        CertificateNotYetValid,
        CertificateExpired,
        InvalidNotBeforeField,
        InvalidNotAfterField,
        SelfSignedCertificate,
        SelfSignedCertificateInChain,
        UnableToGetLocalIssuerCertificate,
        UnableToVerifyFirstCertificate,
        CertificateRevoked,
        InvalidCaCertificate,
        PathLengthExceeded,
        InvalidPurpose,
        CertificateUntrusted,
        CertificateRejected,
        SubjectIssuerMismatch, // hostname mismatch?
        AuthorityIssuerSerialNumberMismatch,
        NoPeerCertificate,
        HostNameMismatch,
        NoSslSupport,
        CertificateBlacklisted,
        UnspecifiedError = -1
    };

    // RVCT compiler in debug build does not like about default values in const-
    // So as an workaround we define all constructor overloads here explicitly
    QSslError();
    QSslError(SslError error);
    QSslError(SslError error, ref const(QSslCertificate) certificate);

    QSslError(ref const(QSslError) other);

    /+inline+/ void swap(QSslError &other)
    { qSwap(d, other.d); }

    ~QSslError();
    QSslError &operator=(ref const(QSslError) other);
    bool operator==(ref const(QSslError) other) const;
    /+inline+/ bool operator!=(ref const(QSslError) other) const
    { return !(*this == other); }

    SslError error() const;
    QString errorString() const;
    QSslCertificate certificate() const;

private:
    QScopedPointer<QSslErrorPrivate> d;
};
Q_DECLARE_SHARED(QSslError)

Q_NETWORK_EXPORT uint qHash(ref const(QSslError) key, uint seed = 0) Q_DECL_NOTHROW;

#ifndef QT_NO_DEBUG_STREAM
class QDebug;
Q_NETWORK_EXPORT QDebug operator<<(QDebug debug, ref const(QSslError) error);
Q_NETWORK_EXPORT QDebug operator<<(QDebug debug, ref const(QSslError::SslError) error);
#endif

#endif // QT_NO_SSL

QT_END_NAMESPACE

#ifndef QT_NO_SSL
Q_DECLARE_METATYPE(QList<QSslError>)
#endif

#endif