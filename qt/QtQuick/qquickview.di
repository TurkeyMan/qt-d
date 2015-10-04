/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtQuick module of the Qt Toolkit.
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

public import QtQuick.qquickwindow;
public import QtCore.qurl;
public import QtQml.qqmldebug;

extern(C++) class QQmlEngine;
extern(C++) class QQmlContext;
extern(C++) class QQmlError;
extern(C++) class QQuickItem;
extern(C++) class QQmlComponent;

extern(C++) class QQuickViewPrivate;
extern(C++) class Q_QUICK_EXPORT QQuickView : QQuickWindow
{
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(ResizeMode, "resizeMode", "READ", "resizeMode", "WRITE", "setResizeMode");
    mixin Q_PROPERTY!(Status, "status", "READ", "status", "NOTIFY", "statusChanged");
    mixin Q_PROPERTY!(QUrl, "source", "READ", "source", "WRITE", "setSource", "DESIGNABLE", "true");
    Q_ENUMS(ResizeMode Status)
public:
    explicit QQuickView(QWindow *parent = 0);
    QQuickView(QQmlEngine* engine, QWindow *parent);
    QQuickView(ref const(QUrl) source, QWindow *parent = 0);
    /+virtual+/ ~QQuickView();

    QUrl source() const;

    QQmlEngine* engine() const;
    QQmlContext* rootContext() const;

    QQuickItem *rootObject() const;

    enum ResizeMode { SizeViewToRootObject, SizeRootObjectToView }
    ResizeMode resizeMode() const;
    void setResizeMode(ResizeMode);

    enum Status { Null, Ready, Loading, Error }
    Status status() const;

    QList<QQmlError> errors() const;

    QSize sizeHint() const;
    QSize initialSize() const;

public Q_SLOTS:
    void setSource(ref const(QUrl));
    void setContent(ref const(QUrl) url, QQmlComponent *component, QObject *item);

Q_SIGNALS:
    void statusChanged(QQuickView::Status);

private Q_SLOTS:
    void continueExecute();

protected:
    /+virtual+/ void resizeEvent(QResizeEvent *);
    /+virtual+/ void timerEvent(QTimerEvent*);

    /+virtual+/ void keyPressEvent(QKeyEvent *);
    /+virtual+/ void keyReleaseEvent(QKeyEvent *);
    /+virtual+/ void mousePressEvent(QMouseEvent *);
    /+virtual+/ void mouseReleaseEvent(QMouseEvent *);
    /+virtual+/ void mouseMoveEvent(QMouseEvent *);
private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
}

#endif // QQUICKVIEW_H
