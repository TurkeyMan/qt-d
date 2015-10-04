/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the Qt Assistant of the Qt Toolkit.
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

#ifndef QHELPENGINECORE_H
#define QHELPENGINECORE_H

public import qt.QtHelp.qhelp_global;

public import qt.QtCore.QUrl;
public import qt.QtCore.QMap;
public import qt.QtCore.QObject;
public import qt.QtCore.QVariant;

QT_BEGIN_NAMESPACE


class QHelpEngineCorePrivate;

class QHELP_EXPORT QHelpEngineCore : public QObject
{
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(bool, "autoSaveFilter", "READ", "autoSaveFilter", "WRITE", "setAutoSaveFilter");
    mixin Q_PROPERTY!(QString, "collectionFile", "READ", "collectionFile", "WRITE", "setCollectionFile");
    mixin Q_PROPERTY!(QString, "currentFilter", "READ", "currentFilter", "WRITE", "setCurrentFilter");

public:
    explicit QHelpEngineCore(ref const(QString) collectionFile, QObject *parent = 0);
    /+virtual+/ ~QHelpEngineCore();

    bool setupData();

    QString collectionFile() const;
    void setCollectionFile(ref const(QString) fileName);

    bool copyCollectionFile(ref const(QString) fileName);

    static QString namespaceName(ref const(QString) documentationFileName);
    bool registerDocumentation(ref const(QString) documentationFileName);
    bool unregisterDocumentation(ref const(QString) namespaceName);
    QString documentationFileName(ref const(QString) namespaceName);

    QStringList customFilters() const;
    bool removeCustomFilter(ref const(QString) filterName);
    bool addCustomFilter(ref const(QString) filterName,
        ref const(QStringList) attributes);

    QStringList filterAttributes() const;
    QStringList filterAttributes(ref const(QString) filterName) const;

    QString currentFilter() const;
    void setCurrentFilter(ref const(QString) filterName);

    QStringList registeredDocumentations() const;
    QList<QStringList> filterAttributeSets(ref const(QString) namespaceName) const;
    QList<QUrl> files(const QString namespaceName,
        ref const(QStringList) filterAttributes,
        ref const(QString) extensionFilter = QString());
    QUrl findFile(ref const(QUrl) url) const;
    QByteArray fileData(ref const(QUrl) url) const;

    QMap<QString, QUrl> linksForIdentifier(ref const(QString) id) const;

    bool removeCustomValue(ref const(QString) key);
    QVariant customValue(ref const(QString) key,
        ref const(QVariant) defaultValue = QVariant()) const;
    bool setCustomValue(ref const(QString) key, ref const(QVariant) value);

    static QVariant metaData(ref const(QString) documentationFileName,
        ref const(QString) name);

    QString error() const;

    void setAutoSaveFilter(bool save);
    bool autoSaveFilter() const;

Q_SIGNALS:
    void setupStarted();
    void setupFinished();
    void currentFilterChanged(ref const(QString) newFilter);
    void warning(ref const(QString) msg);
    void readersAboutToBeInvalidated();

protected:
    QHelpEngineCore(QHelpEngineCorePrivate *helpEngineCorePrivate,
        QObject *parent);

private:
    QHelpEngineCorePrivate *d;
    friend class QHelpEngineCorePrivate;
};

QT_END_NAMESPACE

#endif // QHELPENGINECORE_H
