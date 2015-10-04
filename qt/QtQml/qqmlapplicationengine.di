/****************************************************************************
**
** Copyright (C) 2013 Research In Motion.
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

public import QtQml.qqmlengine;

public import QtCore.qurl;
public import QtCore.qobject;
public import QtCore.qlist;

extern(C++) class QQmlApplicationEnginePrivate;
extern(C++) class Q_QML_EXPORT QQmlApplicationEngine : QQmlEngine
{
    mixin Q_OBJECT;
public:
    QQmlApplicationEngine(QObject *parent=0);
    QQmlApplicationEngine(ref const(QUrl) url, QObject *parent=0);
    QQmlApplicationEngine(ref const(QString) filePath, QObject *parent=0);
    ~QQmlApplicationEngine();

    QList<QObject*> rootObjects();
public Q_SLOTS:
    void load(ref const(QUrl) url);
    void load(ref const(QString) filePath);
    void loadData(ref const(QByteArray) data, ref const(QUrl) url = QUrl());

Q_SIGNALS:
    void objectCreated(QObject *object, ref const(QUrl) url);

private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
    Q_PRIVATE_SLOT(d_func(), void _q_finishLoad(QObject*))
}

#endif
