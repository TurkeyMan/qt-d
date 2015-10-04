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

public import QtCore.qurl;
public import QtCore.qobject;
public import QtCore.qmap;
public import QtQml.qjsengine;
public import QtQml.qqmlerror;
public import QtQml.qqmldebug;

extern(C++) class QQmlAbstractUrlInterceptor;

extern(C++) class Q_QML_EXPORT QQmlImageProviderBase
{
public:
    enum ImageType {
        Image,
        Pixmap,
        Texture,
        Invalid
    }

    enum Flag {
        ForceAsynchronousImageLoading  = 0x01
    }
    Q_DECLARE_FLAGS(Flags, Flag)

    /+virtual+/ ~QQmlImageProviderBase();

    /+virtual+/ ImageType imageType() const = 0;
    /+virtual+/ Flags flags() const = 0;

private:
    friend extern(C++) class QQuickImageProvider;
    QQmlImageProviderBase();
}
Q_DECLARE_OPERATORS_FOR_FLAGS(QQmlImageProviderBase::Flags)

extern(C++) class QQmlComponent;
extern(C++) class QQmlEnginePrivate;
extern(C++) class QQmlImportsPrivate;
extern(C++) class QQmlExpression;
extern(C++) class QQmlContext;
extern(C++) class QQmlType;
extern(C++) class QUrl;
extern(C++) class QScriptContext;
extern(C++) class QNetworkAccessManager;
extern(C++) class QQmlNetworkAccessManagerFactory;
extern(C++) class QQmlIncubationController;
extern(C++) class Q_QML_EXPORT QQmlEngine : QJSEngine
{
    mixin Q_PROPERTY!(QString, "offlineStoragePath", "READ", "offlineStoragePath", "WRITE", "setOfflineStoragePath");
    mixin Q_OBJECT;
public:
    QQmlEngine(QObject *p = 0);
    /+virtual+/ ~QQmlEngine();

    QQmlContext *rootContext() const;

    void clearComponentCache();
    void trimComponentCache();

    QStringList importPathList() const;
    void setImportPathList(ref const(QStringList) paths);
    void addImportPath(ref const(QString) dir);

    QStringList pluginPathList() const;
    void setPluginPathList(ref const(QStringList) paths);
    void addPluginPath(ref const(QString) dir);

    bool addNamedBundle(ref const(QString) name, ref const(QString) fileName);

    bool importPlugin(ref const(QString) filePath, ref const(QString) uri, QList<QQmlError> *errors);

    void setNetworkAccessManagerFactory(QQmlNetworkAccessManagerFactory *);
    QQmlNetworkAccessManagerFactory *networkAccessManagerFactory() const;

    QNetworkAccessManager *networkAccessManager() const;

    void setUrlInterceptor(QQmlAbstractUrlInterceptor* urlInterceptor);
    QQmlAbstractUrlInterceptor* urlInterceptor() const;

    void addImageProvider(ref const(QString) id, QQmlImageProviderBase *);
    QQmlImageProviderBase *imageProvider(ref const(QString) id) const;
    void removeImageProvider(ref const(QString) id);

    void setIncubationController(QQmlIncubationController *);
    QQmlIncubationController *incubationController() const;

    void setOfflineStoragePath(ref const(QString) dir);
    QString offlineStoragePath() const;

    QUrl baseUrl() const;
    void setBaseUrl(ref const(QUrl) );

    bool outputWarningsToStandardError() const;
    void setOutputWarningsToStandardError(bool);

    static QQmlContext *contextForObject(const(QObject)* );
    static void setContextForObject(QObject *, QQmlContext *);

    enum ObjectOwnership { CppOwnership, JavaScriptOwnership }
    static void setObjectOwnership(QObject *, ObjectOwnership);
    static ObjectOwnership objectOwnership(QObject *);
protected:
    QQmlEngine(QQmlEnginePrivate &dd, QObject *p);
    /+virtual+/ bool event(QEvent *);

Q_SIGNALS:
    void quit();
    void warnings(ref const(QList<QQmlError>) warnings);

private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
}

#endif // QQMLENGINE_H
