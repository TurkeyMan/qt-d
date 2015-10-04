/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtDeclarative module of the Qt Toolkit.
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

#ifndef QDECLARATIVEENGINE_H
#define QDECLARATIVEENGINE_H

public import qt.QtCore.qurl;
public import qt.QtCore.qobject;
public import qt.QtCore.qmap;
public import qt.QtScript.qscriptvalue;
public import qt.QtDeclarative.qdeclarativeerror;
public import qt.QtDeclarative.qdeclarativedebug;

QT_BEGIN_NAMESPACE

QT_MODULE(Declarative)

class QDeclarativeComponent;
class QDeclarativeEnginePrivate;
class QDeclarativeImportsPrivate;
class QDeclarativeExpression;
class QDeclarativeContext;
class QDeclarativeType;
class QUrl;
class QScriptEngine;
class QScriptContext;
class QDeclarativeImageProvider;
class QNetworkAccessManager;
class QDeclarativeNetworkAccessManagerFactory;
class Q_DECLARATIVE_EXPORT QDeclarativeEngine : public QObject
{
    mixin Q_PROPERTY!(QString, "offlineStoragePath", "READ", "offlineStoragePath", "WRITE", "setOfflineStoragePath");
    mixin Q_OBJECT;
public:
    QDeclarativeEngine(QObject *p = 0);
    /+virtual+/ ~QDeclarativeEngine();

    QDeclarativeContext *rootContext() const;

    void clearComponentCache();

    QStringList importPathList() const;
    void setImportPathList(ref const(QStringList) paths);
    void addImportPath(ref const(QString) dir);

    QStringList pluginPathList() const;
    void setPluginPathList(ref const(QStringList) paths);
    void addPluginPath(ref const(QString) dir);

    bool importPlugin(ref const(QString) filePath, ref const(QString) uri, QString *errorString);

    void setNetworkAccessManagerFactory(QDeclarativeNetworkAccessManagerFactory *);
    QDeclarativeNetworkAccessManagerFactory *networkAccessManagerFactory() const;

    QNetworkAccessManager *networkAccessManager() const;

    void addImageProvider(ref const(QString) id, QDeclarativeImageProvider *);
    QDeclarativeImageProvider *imageProvider(ref const(QString) id) const;
    void removeImageProvider(ref const(QString) id);

    void setOfflineStoragePath(ref const(QString) dir);
    QString offlineStoragePath() const;

    QUrl baseUrl() const;
    void setBaseUrl(ref const(QUrl) );

    bool outputWarningsToStandardError() const;
    void setOutputWarningsToStandardError(bool);

    static QDeclarativeContext *contextForObject(const(QObject)* );
    static void setContextForObject(QObject *, QDeclarativeContext *);

    enum ObjectOwnership { CppOwnership, JavaScriptOwnership };
    static void setObjectOwnership(QObject *, ObjectOwnership);
    static ObjectOwnership objectOwnership(QObject *);

Q_SIGNALS:
    void quit();
    void warnings(ref const(QList<QDeclarativeError>) warnings);

private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
};

QT_END_NAMESPACE

#endif // QDECLARATIVEENGINE_H
