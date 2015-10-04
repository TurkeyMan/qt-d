/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtQml module of the Qt Toolkit.
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

public import QtQml.qtqmlglobal;

extern(C++) class QUrl;
extern(C++) class QString;
extern(C++) class QObject;
extern(C++) class QQmlEngine;
extern(C++) class QQmlFilePrivate;

extern(C++) class Q_QML_EXPORT QQmlFile
{
public:
    QQmlFile();
    QQmlFile(QQmlEngine *, ref const(QUrl) );
    QQmlFile(QQmlEngine *, ref const(QString) );
    ~QQmlFile();

    enum Status { Null, Ready, Error, Loading }

    bool isNull() const;
    bool isReady() const;
    bool isError() const;
    bool isLoading() const;

    QUrl url() const;

    Status status() const;
    QString error() const;

    qint64 size() const;
    const(char)* data() const;
    QByteArray dataByteArray() const;

    QByteArray metaData(ref const(QString) ) const;

    void load(QQmlEngine *, ref const(QUrl) );
    void load(QQmlEngine *, ref const(QString) );

    void clear();
    void clear(QObject *);

    bool connectFinished(QObject *, const(char)* );
    bool connectFinished(QObject *, int);
    bool connectDownloadProgress(QObject *, const(char)* );
    bool connectDownloadProgress(QObject *, int);

    static bool isSynchronous(ref const(QString) url);
    static bool isSynchronous(ref const(QUrl) url);

    static bool isBundle(ref const(QString) url);
    static bool isBundle(ref const(QUrl) url);

    static bool isLocalFile(ref const(QString) url);
    static bool isLocalFile(ref const(QUrl) url);

    static QString urlToLocalFileOrQrc(ref const(QString) );
    static QString urlToLocalFileOrQrc(ref const(QUrl) );

    static bool bundleDirectoryExists(ref const(QString) , QQmlEngine *);
    static bool bundleDirectoryExists(ref const(QUrl) , QQmlEngine *);

    static bool bundleFileExists(ref const(QString) , QQmlEngine *);
    static bool bundleFileExists(ref const(QUrl) , QQmlEngine *);

    static QString bundleFileName(ref const(QString) , QQmlEngine *);
    static QString bundleFileName(ref const(QUrl) , QQmlEngine *);

private:
    mixin Q_DISABLE_COPY;
    QQmlFilePrivate *d;
}

#endif // QQMLFILE_H
