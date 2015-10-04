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

#ifndef QQUICKWIDGET_H
#define QQUICKWIDGET_H

public import qt.QtWidgets.qwidget;
public import qt.QtQuick.qquickwindow;
public import qt.QtCore.qurl;
public import qt.QtQml.qqmldebug;
public import qt.QtQuickWidgets.qtquickwidgetsglobal;
public import qt.QtGui.qimage;

QT_BEGIN_NAMESPACE

class QQmlEngine;
class QQmlContext;
class QQmlError;
class QQuickItem;
class QQmlComponent;

class QQuickWidgetPrivate;
class Q_QUICKWIDGETS_EXPORT QQuickWidget : public QWidget
{
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(ResizeMode, "resizeMode", "READ", "resizeMode", "WRITE", "setResizeMode");
    mixin Q_PROPERTY!(Status, "status", "READ", "status", "NOTIFY", "statusChanged");
    mixin Q_PROPERTY!(QUrl, "source", "READ", "source", "WRITE", "setSource", "DESIGNABLE", "true");
    Q_ENUMS(ResizeMode Status)

public:
    explicit QQuickWidget(QWidget *parent = 0);
    QQuickWidget(QQmlEngine* engine, QWidget *parent);
    QQuickWidget(ref const(QUrl) source, QWidget *parent = 0);
    /+virtual+/ ~QQuickWidget();

    QUrl source() const;

    QQmlEngine* engine() const;
    QQmlContext* rootContext() const;

    QQuickItem *rootObject() const;

    enum ResizeMode { SizeViewToRootObject, SizeRootObjectToView };
    ResizeMode resizeMode() const;
    void setResizeMode(ResizeMode);

    enum Status { Null, Ready, Loading, Error };
    Status status() const;

    QList<QQmlError> errors() const;

    QSize sizeHint() const;
    QSize initialSize() const;

    void setFormat(ref const(QSurfaceFormat) format);
    QSurfaceFormat format() const;

    QImage grabFramebuffer() const;

    void setClearColor(ref const(QColor) color);

public Q_SLOTS:
    void setSource(ref const(QUrl));
    void setContent(ref const(QUrl) url, QQmlComponent *component, QObject *item);

Q_SIGNALS:
    void statusChanged(QQuickWidget::Status);
    void sceneGraphError(QQuickWindow::SceneGraphError error, ref const(QString) message);

private Q_SLOTS:
    void continueExecute();
    void createFramebufferObject();
    void destroyFramebufferObject();
    void triggerUpdate();

protected:
    /+virtual+/ void resizeEvent(QResizeEvent *);
    /+virtual+/ void timerEvent(QTimerEvent*);

    /+virtual+/ void keyPressEvent(QKeyEvent *);
    /+virtual+/ void keyReleaseEvent(QKeyEvent *);
    /+virtual+/ void mousePressEvent(QMouseEvent *);
    /+virtual+/ void mouseReleaseEvent(QMouseEvent *);
    /+virtual+/ void mouseMoveEvent(QMouseEvent *);
    /+virtual+/ void mouseDoubleClickEvent(QMouseEvent *);

    /+virtual+/ void showEvent(QShowEvent *);
    /+virtual+/ void hideEvent(QHideEvent *);

    /+virtual+/ void focusInEvent(QFocusEvent * event);
    /+virtual+/ void focusOutEvent(QFocusEvent * event);

#ifndef QT_NO_WHEELEVENT
    /+virtual+/ void wheelEvent(QWheelEvent *);
#endif

    bool event(QEvent *);

private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
};

QT_END_NAMESPACE

#endif // QQuickWidget_H
