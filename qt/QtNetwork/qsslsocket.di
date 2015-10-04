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


#ifndef QSSLSOCKET_H
#define QSSLSOCKET_H

public import qt.QtCore.qlist;
public import qt.QtCore.qregexp;
#ifndef QT_NO_SSL
public import qt.QtNetwork.qtcpsocket;
public import qt.QtNetwork.qsslerror;
#endif

QT_BEGIN_NAMESPACE


#ifndef QT_NO_SSL

class QDir;
class QSslCipher;
class QSslCertificate;
class QSslConfiguration;

class QSslSocketPrivate;
class Q_NETWORK_EXPORT QSslSocket : public QTcpSocket
{
    mixin Q_OBJECT;
public:
    enum SslMode {
        UnencryptedMode,
        SslClientMode,
        SslServerMode
    };

    enum PeerVerifyMode {
        VerifyNone,
        QueryPeer,
        VerifyPeer,
        AutoVerifyPeer
    };

    explicit QSslSocket(QObject *parent = 0);
    ~QSslSocket();
    void resume(); // to continue after proxy authentication required, SSL errors etc.

    // Autostarting the SSL client handshake.
    void connectToHostEncrypted(ref const(QString) hostName, quint16 port, OpenMode mode = ReadWrite, NetworkLayerProtocol protocol = AnyIPProtocol);
    void connectToHostEncrypted(ref const(QString) hostName, quint16 port, ref const(QString) sslPeerName, OpenMode mode = ReadWrite, NetworkLayerProtocol protocol = AnyIPProtocol);
    bool setSocketDescriptor(qintptr socketDescriptor, SocketState state = ConnectedState,
                             OpenMode openMode = ReadWrite);

    using QAbstractSocket::connectToHost;
    void connectToHost(ref const(QString) hostName, quint16 port, OpenMode openMode = ReadWrite, NetworkLayerProtocol protocol = AnyIPProtocol);
    void disconnectFromHost();

    /+virtual+/ void setSocketOption(QAbstractSocket::SocketOption option, ref const(QVariant) value);
    /+virtual+/ QVariant socketOption(QAbstractSocket::SocketOption option);

    SslMode mode() const;
    bool isEncrypted() const;

    QSsl::SslProtocol protocol() const;
    void setProtocol(QSsl::SslProtocol protocol);

    QSslSocket::PeerVerifyMode peerVerifyMode() const;
    void setPeerVerifyMode(QSslSocket::PeerVerifyMode mode);

    int peerVerifyDepth() const;
    void setPeerVerifyDepth(int depth);

    QString peerVerifyName() const;
    void setPeerVerifyName(ref const(QString) hostName);

    // From QIODevice
    qint64 bytesAvailable() const;
    qint64 bytesToWrite() const;
    bool canReadLine() const;
    void close();
    bool atEnd() const;
    bool flush();
    void abort();

    // From QAbstractSocket:
    void setReadBufferSize(qint64 size);

    // Similar to QIODevice's:
    qint64 encryptedBytesAvailable() const;
    qint64 encryptedBytesToWrite() const;

    // SSL configuration
    QSslConfiguration sslConfiguration() const;
    void setSslConfiguration(ref const(QSslConfiguration) config);

    // Certificate & cipher accessors.
    void setLocalCertificateChain(ref const(QList<QSslCertificate>) localChain);
    QList<QSslCertificate> localCertificateChain() const;

    void setLocalCertificate(ref const(QSslCertificate) certificate);
    void setLocalCertificate(ref const(QString) fileName, QSsl::EncodingFormat format = QSsl::Pem);
    QSslCertificate localCertificate() const;
    QSslCertificate peerCertificate() const;
    QList<QSslCertificate> peerCertificateChain() const;
    QSslCipher sessionCipher() const;
    QSsl::SslProtocol sessionProtocol() const;

    // Private keys, for server sockets.
    void setPrivateKey(ref const(QSslKey) key);
    void setPrivateKey(ref const(QString) fileName, QSsl::KeyAlgorithm algorithm = QSsl::Rsa,
                       QSsl::EncodingFormat format = QSsl::Pem,
                       ref const(QByteArray) passPhrase = QByteArray());
    QSslKey privateKey() const;

    // Cipher settings.
    QList<QSslCipher> ciphers() const;
    void setCiphers(ref const(QList<QSslCipher>) ciphers);
    void setCiphers(ref const(QString) ciphers);
    static void setDefaultCiphers(ref const(QList<QSslCipher>) ciphers);
    static QList<QSslCipher> defaultCiphers();
    static QList<QSslCipher> supportedCiphers();

    // CA settings.
    bool addCaCertificates(ref const(QString) path, QSsl::EncodingFormat format = QSsl::Pem,
                           QRegExp::PatternSyntax syntax = QRegExp::FixedString);
    void addCaCertificate(ref const(QSslCertificate) certificate);
    void addCaCertificates(ref const(QList<QSslCertificate>) certificates);
    void setCaCertificates(ref const(QList<QSslCertificate>) certificates);
    QList<QSslCertificate> caCertificates() const;
    static bool addDefaultCaCertificates(ref const(QString) path, QSsl::EncodingFormat format = QSsl::Pem,
                                         QRegExp::PatternSyntax syntax = QRegExp::FixedString);
    static void addDefaultCaCertificate(ref const(QSslCertificate) certificate);
    static void addDefaultCaCertificates(ref const(QList<QSslCertificate>) certificates);
    static void setDefaultCaCertificates(ref const(QList<QSslCertificate>) certificates);
    static QList<QSslCertificate> defaultCaCertificates();
    static QList<QSslCertificate> systemCaCertificates();

    bool waitForConnected(int msecs = 30000);
    bool waitForEncrypted(int msecs = 30000);
    bool waitForReadyRead(int msecs = 30000);
    bool waitForBytesWritten(int msecs = 30000);
    bool waitForDisconnected(int msecs = 30000);

    QList<QSslError> sslErrors() const;

    static bool supportsSsl();
    static long sslLibraryVersionNumber();
    static QString sslLibraryVersionString();
    static long sslLibraryBuildVersionNumber();
    static QString sslLibraryBuildVersionString();

    void ignoreSslErrors(ref const(QList<QSslError>) errors);

public Q_SLOTS:
    void startClientEncryption();
    void startServerEncryption();
    void ignoreSslErrors();

Q_SIGNALS:
    void encrypted();
    void peerVerifyError(ref const(QSslError) error);
    void sslErrors(ref const(QList<QSslError>) errors);
    void modeChanged(QSslSocket::SslMode newMode);
    void encryptedBytesWritten(qint64 totalBytes);

protected:
    qint64 readData(char *data, qint64 maxlen);
    qint64 writeData(const(char)* data, qint64 len);

private:
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;
    Q_PRIVATE_SLOT(d_func(), void _q_connectedSlot())
    Q_PRIVATE_SLOT(d_func(), void _q_hostFoundSlot())
    Q_PRIVATE_SLOT(d_func(), void _q_disconnectedSlot())
    Q_PRIVATE_SLOT(d_func(), void _q_stateChangedSlot(QAbstractSocket::SocketState))
    Q_PRIVATE_SLOT(d_func(), void _q_errorSlot(QAbstractSocket::SocketError))
    Q_PRIVATE_SLOT(d_func(), void _q_readyReadSlot())
    Q_PRIVATE_SLOT(d_func(), void _q_bytesWrittenSlot(qint64))
    Q_PRIVATE_SLOT(d_func(), void _q_flushWriteBuffer())
    Q_PRIVATE_SLOT(d_func(), void _q_flushReadBuffer())
    Q_PRIVATE_SLOT(d_func(), void _q_resumeImplementation())
#if defined(Q_OS_WIN) && !defined(Q_OS_WINRT)
    Q_PRIVATE_SLOT(d_func(), void _q_caRootLoaded(QSslCertificate,QSslCertificate))
#endif
    friend class QSslSocketBackendPrivate;
};

#endif // QT_NO_SSL

QT_END_NAMESPACE

#endif
