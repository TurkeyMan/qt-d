/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtWidgets module of the Qt Toolkit.
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

#ifndef QABSTRACTBUTTON_H
#define QABSTRACTBUTTON_H

public import qt.QtGui.qicon;
public import qt.QtGui.qkeysequence;
public import qt.QtWidgets.qwidget;

QT_BEGIN_NAMESPACE


class QButtonGroup;
class QAbstractButtonPrivate;

class Q_WIDGETS_EXPORT QAbstractButton : public QWidget
{
    mixin Q_OBJECT;

    mixin Q_PROPERTY!(QString, "text", "READ", "text", "WRITE", "setText");
    mixin Q_PROPERTY!(QIcon, "icon", "READ", "icon", "WRITE", "setIcon");
    mixin Q_PROPERTY!(QSize, "iconSize", "READ", "iconSize", "WRITE", "setIconSize");
#ifndef QT_NO_SHORTCUT
    mixin Q_PROPERTY!(QKeySequence, "shortcut", "READ", "shortcut", "WRITE", "setShortcut");
#endif
    mixin Q_PROPERTY!(bool, "checkable", "READ", "isCheckable", "WRITE", "setCheckable");
    mixin Q_PROPERTY!(bool, "checked", "READ", "isChecked", "WRITE", "setChecked", "DESIGNABLE", "isCheckable", "NOTIFY", "toggled", "USER", "true");
    mixin Q_PROPERTY!(bool, "autoRepeat", "READ", "autoRepeat", "WRITE", "setAutoRepeat");
    mixin Q_PROPERTY!(bool, "autoExclusive", "READ", "autoExclusive", "WRITE", "setAutoExclusive");
    mixin Q_PROPERTY!(int, "autoRepeatDelay", "READ", "autoRepeatDelay", "WRITE", "setAutoRepeatDelay");
    mixin Q_PROPERTY!(int, "autoRepeatInterval", "READ", "autoRepeatInterval", "WRITE", "setAutoRepeatInterval");
    mixin Q_PROPERTY!(bool, "down", "READ", "isDown", "WRITE", "setDown", "DESIGNABLE", "false");

public:
    explicit QAbstractButton(QWidget* parent=0);
    ~QAbstractButton();

    void setText(ref const(QString) text);
    QString text() const;

    void setIcon(ref const(QIcon) icon);
    QIcon icon() const;

    QSize iconSize() const;

#ifndef QT_NO_SHORTCUT
    void setShortcut(ref const(QKeySequence) key);
    QKeySequence shortcut() const;
#endif

    void setCheckable(bool);
    bool isCheckable() const;

    bool isChecked() const;

    void setDown(bool);
    bool isDown() const;

    void setAutoRepeat(bool);
    bool autoRepeat() const;

    void setAutoRepeatDelay(int);
    int autoRepeatDelay() const;

    void setAutoRepeatInterval(int);
    int autoRepeatInterval() const;

    void setAutoExclusive(bool);
    bool autoExclusive() const;

#ifndef QT_NO_BUTTONGROUP
    QButtonGroup *group() const;
#endif

public Q_SLOTS:
    void setIconSize(ref const(QSize) size);
    void animateClick(int msec = 100);
    void click();
    void toggle();
    void setChecked(bool);

Q_SIGNALS:
    void pressed();
    void released();
    void clicked(bool checked = false);
    void toggled(bool checked);

protected:
    /+virtual+/ void paintEvent(QPaintEvent *e) = 0;
    /+virtual+/ bool hitButton(ref const(QPoint) pos) const;
    /+virtual+/ void checkStateSet();
    /+virtual+/ void nextCheckState();

    bool event(QEvent *e);
    void keyPressEvent(QKeyEvent *e);
    void keyReleaseEvent(QKeyEvent *e);
    void mousePressEvent(QMouseEvent *e);
    void mouseReleaseEvent(QMouseEvent *e);
    void mouseMoveEvent(QMouseEvent *e);
    void focusInEvent(QFocusEvent *e);
    void focusOutEvent(QFocusEvent *e);
    void changeEvent(QEvent *e);
    void timerEvent(QTimerEvent *e);


protected:
    QAbstractButton(QAbstractButtonPrivate &dd, QWidget* parent = 0);

private:
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;
    friend class QButtonGroup;
};

QT_END_NAMESPACE

#endif // QABSTRACTBUTTON_H
